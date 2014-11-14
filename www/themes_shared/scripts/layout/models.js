$(document).ready(function () {
	var nZEDbGridModel = function () {
		this.items = ko.observableArray();
		this.disabled = ko.observable(false);
		var me = this;
		$.ajax({
			datatype: 'json',
			url: url + '?action=list'
		}).done(function (data) {
			var jsonData = $.parseJSON(data);
			me.items(jsonData);
		});
		this.checkbox = function (value) {
			if (this.value == 0 || 1) {

			}
		};
		this.addItem = function () {
			if (this.items().length < 20) {

			}
		};
		this.removeItem = function () {
			var cell = $(gridelement).jqxGrid('getselectedcell');
			if (cell != null && cell != "") {
				var selectedrowindex = cell.rowindex;
				var rowscount = $(gridelement).jqxGrid('getdatainformation').rowscount;
				if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
					var id = $(gridelement).jqxGrid('getrowid', selectedrowindex);
					try {
						$.ajax({
							datatype: 'json',
							url: url + "?action=edit"
						}).done(function (data) {
							if (data['success'] == true) {
								$("#message").html(data['message']);
							}
						});
					}
					catch (e) {
						console.log(e);
					}
				}
			}
		};
		this.updateItem = function (rowid, rowdata) {
			$(gridelement).jqxGrid({disabled: true});
			if (rowid != null && rowid != "") {
				var rowscount = $(gridelement).jqxGrid('getdatainformation').rowscount;
				if (rowid >= 0 && rowid < rowscount) {
					try {
						$.ajax({
							datatype: 'json',
							url: url + "?action=edit",
							data: rowdata,
							type: 'POST'
						}).done(function (data) {
							if (data.success) {
								$("#message").html(data.message);
								$(gridelement).jqxGrid('updatebounddata');
							}
						});
					}
					catch (e) {
						console.log(e);
					}
				}
			}

			$(gridelement).jqxGrid({disabled: false});
		};
	};
});
