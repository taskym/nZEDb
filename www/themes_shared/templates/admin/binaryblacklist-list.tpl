<h1>{$page->title}</h1>
<p>
	Binaries can be prevented from being added to the index at all if they match a regex provided in the blacklist. They can also be included only if they match a regex (whitelist).
	<br>CLICK EDIT TO ENABLE/DISABLE.
</p>
<div id="message"></div>

{literal}
<script type="text/javascript">
	$(document).ready(function () {
		var source =
		{
			datatype: "json",
			datafields: [
				{ name: 'id', type: 'number' },
				{ name: 'groupname', type: 'string' },
				{ name: 'regex', type: 'string' },
				{ name: 'msgcol', type: 'number' },
				{ name: 'optype', type: 'number' },
				{ name: 'status', type: 'number' },
				{ name: 'description', type: 'string' }
			],
			url: 'ajax_binaryblacklist.php?action=list',
			addrow: function (rowid, rowdata, position, commit) {
				commit(true);
			},
			deleterow: function (rowid, commit) {
				var data = "action=delete&id=" + rowid;
				$.ajax({
					dataType: 'json',
					url: 'ajax_binaryblacklist.php',
					data: data,
					success: function (data, status, xhr) {
						commit(true);
					}
				});
			},
			updaterow: function (rowid, rowdata, commit) {
				var data = rowdata;
				$.ajax({
					dataType: 'json',
					url: 'ajax_binaryblacklist.php?action=update&id=' + rowid,
					data: data,
					success: function (data, status, xhr) {
						commit(true);
					}
				});
			}
		};
		$("#groupname").jqxInput({theme: theme, width: 300});
		$("#regex").jqxInput({theme: theme, height: 150, width: 300});
		$("#description").jqxInput({theme: theme, width: 300});
		$("#active0").jqxRadioButton({groupName: 'status', height: 25, theme: theme});
		$("#active1").jqxRadioButton({groupName: 'status', height: 25, theme: theme});
		$("#fieldsubject").jqxRadioButton({groupName: 'msgcol', height: 25, theme: theme});
		$("#fieldposter").jqxRadioButton({groupName: 'msgcol', height: 25, theme: theme});
		$("#fieldmessageid").jqxRadioButton({groupName: 'msgcol', height: 25, theme: theme});
		$("#typewhite").jqxRadioButton({groupName: 'optype', height: 25, theme: theme});
		$("#typeblack").jqxRadioButton({groupName: 'optype', height: 25, theme: theme});
		var editrow = -1;
		var dataAdapter = new $.jqx.dataAdapter(source);
		$("#jqxgrid").jqxGrid(
			{
				width: '100%',
				source: dataAdapter,
				theme: theme,
				columnsresize: true,
				autoheight: true,
				showtoolbar: true,
				pageable: true,
				rendertoolbar: function (toolbar) {
					var me = this;
					var container = $("<div style='margin: 5px;'></div>");
					toolbar.append(container);
					container.append('<input id="addrowbutton" type="button" value="Add New Row" />');
					container.append('<input style="margin-left: 5px;" id="deleterowbutton" type="button" value="Delete Selected Row" />');
					$("#addrowbutton").jqxButton({theme:theme});
					$("#deleterowbutton").jqxButton({theme:theme});
					$("#addrowbutton").on('click', function (rowid) {
						var commit = $("#jqxgrid").jqxGrid('addrow', rowid, {});

					});
					$("#deleterowbutton").on('click', function () {
						var selectedrowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
						var rowscount = $("#jqxgrid").jqxGrid('getdatainformation').rowscount;
						if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
							var id = $("#jqxgrid").jqxGrid('getrowid', selectedrowindex);
							var commit = $("#jqxgrid").jqxGrid('deleterow', id);
						}
					});
				},
				columns: [
					{ text: 'ID', datafield: 'id', width: '120px' },
					{ text: 'Group', datafield: 'groupname' },
					{ text: 'Regex', datafield: 'regex' },
					{ text: 'Message Field', datafield: 'msgcol', width: '120px' },
					{ text: 'Type', datafield: 'optype', width: '120px'},
					{ text: 'Description', datafield: 'description' },
					{ text: 'Status', datafield: 'status', width: '120px' },
					{ text: 'Actions', datafield: 'Edit', resizable: false, width: '120px', columntype: 'button', cellsrenderer: function () {
						return "Edit";
					}, buttonclick: function (row) {
						editrow = row;
						$('#message').text("");
						var offset = $("#jqxgrid").offset();
						$("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) +
							60, y: parseInt(offset.top) + 60 } });
						openEditWindow(editrow, 'old');
					}
					}
				]
			});

		$("#popupWindow").jqxWindow({
			width: $("#contentPanel").width() - 200, isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01
		});
		$("#popupWindow").on('open', function () {
			$("#groupname").jqxInput('selectAll');
		});

		$("#Cancel").jqxButton({ theme: theme });
		$("#Save").jqxButton({ theme: theme });
		$("#Save").click(function () {
			if (editrow >= 0) {
				var active = 0;
				if ($('#active1').jqxRadioButton('checked')) {
				active = 1;
				}
				var type = 1;
				if ($('#typewhite').jqxRadioButton('checked')){
				type = 2;
				}
				var fieldmessage = 1;
				if ($('#fieldposter').jqxRadioButton('checked')) {
				fieldmessage = 2;
				}
				if ($('#fieldmessageid').jqxRadioButton('checked')) {
				fieldmessage = 3;
				}
				var row = { id: $("#binaryid").val(), groupname: $("#groupname").val(), regex: $("#regex").val(), msgcol: fieldmessage,
					optype: type, status: active, description: $("#description").val()
				};
				var rowID = $('#jqxgrid').jqxGrid('getrowid', editrow);
				$('#message').html('<div align="center" class="jqx-widget-header-' + theme + '">Updated ID: ' + $("#binaryid").val() + '</div><br />');
				$('#jqxgrid').jqxGrid('updaterow', rowID, row);
				$("#popupWindow").jqxWindow('hide');
			}
		});
		$("#jqxgrid").jqxGrid('autoresizecolumns');
		function openEditWindow(editrow, neworold){
			if ( neworold == "old") {
			var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
			$("#binaryid").val(dataRecord.id);
			$("#groupname").val(dataRecord.groupname);
			$("#regex").val(dataRecord.regex);
			$("#description").val(dataRecord.description);
			if (dataRecord.status == 1) {
				$("#active1").jqxRadioButton({ checked: true });
			} else {
				$("#active0").jqxRadioButton({ checked: true });
			}
			if (dataRecord.optype == 1) {
				$("#typeblack").jqxRadioButton({ checked: true });
			} else {
				$("#typewhite").jqxRadioButton({ checked: true });
			}
			if (dataRecord.msgcol == 1) {
				$("#fieldsubject").jqxRadioButton({ checked: true });
			} else
				if (dataRecord.msgcol == 2) {
					$("#fieldposter").jqxRadioButton({ checked: true });
				} else {
					$("#fieldmessageid").jqxRadioButton({ checked: true });
				}
			}
			$("#popupWindow").jqxWindow('open');
		}
	});
</script>
{/literal}
<div id="jqxgrid"></div>
        <div style="margin-top: 30px;">
            <div id="cellbegineditevent"></div>
            <div style="margin-top: 10px;" id="cellendeditevent"></div>
       </div>
       <div id="popupWindow">
            <div>Edit</div>
            <div style="overflow: hidden;">
                <table>
                    <tr>
                        <input type="hidden" id="binaryid" />
                        <td align="right">Group:</td>
                        <td align="left"><input id="groupname" /></td>
						<div class="hint">The full name of a valid newsgroup. (Wildcard in the format 'alt.binaries.*')</div>
					</tr>
                    <tr>
                        <td align="right">Regex:</td>
                        <td align="left"><textarea id="regex"></textarea></td>
                    </tr>
					<tr>
						<td align="right">Description:</td>
						<td align="left"><textarea id="description"></textarea></td>
					</tr>
                    <tr>
                        <td align="right">Message Field:</td>
                        <td align="left">
							<div id="fieldsubject">Subject</div>
							<div id="fieldposter">Poster</div>
							<div id="fieldmessageid">MessageId</div>
						</td>
                    </tr>
					<tr>
                        <td align="right">Type:</td>
                        <td align="left">
							<div id="typeblack">Black</div>
							<div id="typewhite">White</div>
						</td>
                    </tr>
					<tr>
						<td align="right">Active:</td>
						<td align="left">
							<div id="active1">Yes</div>
							<div id="active0">No</div>
						</td>
					</tr>
                    <tr>
                        <td align="right"></td>
                        <td style="padding-top: 10px;" align="right">
						<input style="margin-right: 5px;" type="button" id="Save" value="Save" />
						<input id="Cancel" type="button" value="Cancel" /></td>
                    </tr>
                </table>
            </div>
       </div>
