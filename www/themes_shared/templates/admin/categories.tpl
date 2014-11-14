<h1>{$page->title}</h1>
<p>
	Make a category inactive to remove it from the menu. This does not prevent binaries being
	matched into an appropriate category. Disable preview prevents ffmpeg being used for releases in
	the category.
</p>
{literal}
	<script type="text/javascript">
		$(document).ready(function () {
			var gridelement = "#nZEDbGrid";
			var url = "ajax_categories.php";
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
		<span id="message"></span>
		</div>
		<div data-bind="jqxGrid: {disabled: disabled}" id="nZEDbGrid">
		</div>
	</div>
{/literal}
