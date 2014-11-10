<h1>{$page->title}</h1>
<p>
	Make a category inactive to remove it from the menu. This does not prevent binaries being matched into an appropriate category. Disable preview prevents ffmpeg being used for releases in the category.
</p>
{literal}
<script type="text/javascript">
$(document).ready(function () {
            var url = "ajax_categories.php?action=list";
            var nZEDbGridModel = function () {
                this.items = ko.observableArray();
				var me = this;
				$.ajax({
					datatype: 'json',
					url: url
				}).done(function (data) {
					var jsonData = $.parseJSON(data);
					me.items(jsonData);
				});
                this.addItem = function () {
                    if (this.items().length < 20) {

                    }
                };
                this.removeItem = function () {
                    var element = "#nZEDbGrid";
                    var cell = $(element).jqxGrid('getselectedcell');
                    if (cell != null && cell != "") {
                        var selectedrowindex = cell.rowindex;
                        var rowscount = $(element).jqxGrid('getdatainformation').rowscount;
                        if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
                            var id = $(element).jqxGrid('getrowid', selectedrowindex);
                            try {
                                this.items.splice(selectedrowindex, 1);
                            }
                            catch (e) {
								console.log(e);
                            }
                        }
                    }
                };
                this.updateItem = function () {

                };
            };
            var model = new nZEDbGridModel();
            var source = {
                localdata: model.items,
                datatype: 'observablearray'
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#nZEDbGrid").jqxGrid({
                autoheight: true,
                source: dataAdapter,
				width: '100%',
				columnsresize: true,
                sortable: true,
                editable: true,
				theme: theme,
                selectionmode: 'singlerow',
                columns: [
                    { text: 'ID', dataField: 'id' },
                    { text: 'Title', dataField: 'title' },
					{ text: 'Parent ID', dataField: 'parentid' },
                    { text: 'Status', dataField: 'status' },
					{ text: 'Description', dataField: 'description' },
					{ text: 'Disable Preview', dataField: 'disablepreview' },
					{ text: 'Minimum Size', dataField: 'minsize' }
                ]
            });
            ko.applyBindings(model);
        });
    </script>
    <div id='data'>
        <div style="margin-bottom: 10px;">
            <input id="addButton" type="button" data-bind="click: addItem, jqxButton: {}" value="Add Item" />
            <input id="removeButton" type="button" data-bind="click: removeItem, jqxButton: {}" value="Remove Item" />
            <input id="updateButton" type="button" data-bind="click: updateItem, jqxButton: {}" value="Update Item" />
        </div>
        <div data-bind="jqxGrid: {}" id="nZEDbGrid">
        </div>
    </div>

{/literal}
