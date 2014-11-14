<h1>{$page->title}</h1>
<p>
	Make a category inactive to remove it from the menu. This does not prevent binaries being
	matched into an appropriate category. Disable preview prevents ffmpeg being used for releases in
	the category.
</p>
<div><span id="message"></span></div>
{literal}
	<script type="text/javascript">
		$(document).ready(function () {
			var gridelement = "#nZEDbGrid";
			var url = "ajax_categories.php";
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
								}).done(function(data){
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
								}).done(function(data){
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
			var model = new nZEDbGridModel();
			var source = {
				localdata: model.items,
				updaterow: function (rowid, rowdata, commit) {
					model.updateItem(rowid, rowdata);
				},
				datatype : 'observablearray'
			};
			var dataAdapter = new $.jqx.dataAdapter(source);
			$(gridelement).jqxGrid({
				autoheight: true,
				source: dataAdapter,
				width: '100%',
				columnsresize: true,
				sortable: true,
				editable: true,
				theme: theme,
				selectionmode: 'singlerow',
				columns: [
					{ text: 'Title', dataField: 'title', columntype: 'disabled', cellbeginedit: function (row, datafield) {
					return false;
					}
					},
					{ text: 'Parent ID', dataField: 'parentid', width: 120, cellbeginedit: function (row, datafield) {
					return false;}
					},
					{ text: 'Status', dataField: 'status', columntype: 'checkbox', width: 70 },
					{ text: 'Description', dataField: 'description' },
					{ text: 'Disable Preview', dataField: 'disablepreview', columntype: 'checkbox', width: 120 },
					{ text: 'Minimum Size', dataField: 'minsize', width: 120 }
				]
			});
			ko.applyBindings(model, document.getElementById('nZEDbGrid'));
		});
	</script>
	<div id='data'>
		<div style="margin-bottom: 10px;">
			<input id="updateButton"
				type="button"
				data-bind="click: updateItem, jqxButton: {}"
				value="Update Item" />
		</div>
		<div data-bind="jqxGrid: {disabled: disabled}" id="nZEDbGrid">
		</div>
	</div>
{/literal}
