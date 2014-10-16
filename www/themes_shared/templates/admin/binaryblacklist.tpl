<h1>{$page->title}</h1>
<p>
	Binaries can be prevented from being added to the index at all if they match a regex provided in
	the blacklist. They can also be included only if they match a regex (whitelist).
	<br>Select a row, click edit or double click the row to change.
</p>
<div id="message"></div>

{literal}
	<script type="text/javascript">
	$(document).ready(function () {
		var message = '<div align="center" class="jqx-widget-header-' + theme + '">';
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
				$.ajax({
					dataType: 'json',
					url: 'ajax_binaryblacklist.php?action=add&rowid=' + rowid,
					data: rowdata,
					type: 'post',
					success: function (data, status, xhr) {
						$("#message").html(message + 'Added Row: ' + data.id + '</div>');
						commit(true);
						$('#jqxgrid').jqxGrid('setcellvaluebyid', data.rowid, 'id', data.id);
						$('#jqxgrid').jqxGrid('ensurerowvisible', data.rowid);

					},
					error: function (error, responseText, errorThrown) {
						$("#message").html(message + 'Error: ' + responseText);
						commit(false);
					}
				});
			},
			deleterow: function (rowid, commit) {
				var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', rowid);
				var databaseid = dataRecord.id;
				$.ajax({
					dataType: 'json',
					url: 'ajax_binaryblacklist.php?action=delete&id=' + databaseid,
					success: function (data, status, xhr) {
						commit(true);
						$("#message").html(message + 'Deleted ID: ' + data.id + '</div>');

					},
					error: function (error, responseText, errorThrown) {
						$("#message").html(message + 'Error: ' + responseText);
						commit(false);
					}
				});
			},
			updaterow: function (rowid, rowdata, commit) {
				$.ajax({
					dataType: 'json',
					url: 'ajax_binaryblacklist.php?action=update',
					data: rowdata,
					type: 'post',
					success: function (data, status, xhr) {
						if (data) {
							commit(true);
						}
					}
				});
			}
		};
		var optyperender = function (row, columnfield, value, defaulthtml, columnproperties) {
			if (value == 2) {
				return '<span style="margin: 4px; float: ' + columnproperties.cellsalign +
					';">White</span>';
			}
			if (value == 1) {
				return '<span style = "margin: 4px; float: ' + columnproperties.cellsalign +
					';">Black</span>';
			}
		};
		var statusrender = function (row, columnfield, value, defaulthtml, columnproperties) {
			if (value == 1) {
				return '<span style = "margin: 4px; float: ' + columnproperties.cellsalign +
					';">Active</span>';
			} else {
				return '<span style = "margin: 4px; float: ' + columnproperties.cellsalign +
					';">Disabled</span>';
			}
		};
		var msgcolrender = function (row, columnfield, value, defaulthtml, columnproperties) {
			if (value == 1) {
				return '<span style = "margin: 4px; float: ' + columnproperties.cellsalign +
					';">Subject</span>';
			} else {
				if (value == 2) {
					return '<span style = "margin: 4px; float: ' + columnproperties.cellsalign +
						';">Poster</span>';
				} else {
					return '<span style = "margin: 4px; float: ' + columnproperties.cellsalign +
						';">MessageID</span>';
				}
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
					var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
					var addrowrowbutton = $("<div id='addrowbutton' style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../themes_shared/images/layout/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Add</span></div>");
					var deleterowbutton=$("<div id='deleterowbutton' style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../themes_shared/images/layout/close.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Delete</span></div>");
					container.append(addrowrowbutton);
					container.append(deleterowbutton);
					toolbar.append(container);
					addrowrowbutton.jqxButton({theme: theme});
					deleterowbutton.jqxButton({theme: theme});
					addrowrowbutton.click(function (row) {
						openEditWindow(-1, 'new');
					});
					deleterowbutton.click(function () {
						var selectedrowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
						var id = $("#jqxgrid").jqxGrid('getrowid', selectedrowindex);
						var commit = $("#jqxgrid").jqxGrid('deleterow', id);
					});
				},
				columns: [
					{ text: 'ID', datafield: 'id', width: '120px' },
					{ text: 'Group', datafield: 'groupname' },
					{ text: 'Regex', datafield: 'regex' },
					{ text: 'Message Field', datafield: 'msgcol', width: '120px', cellsrenderer: msgcolrender },
					{ text: 'Type', datafield: 'optype', width: '120px', cellsrenderer: optyperender },
					{ text: 'Description', datafield: 'description' },
					{ text: 'Status', datafield: 'status', width: '120px', cellsrenderer: statusrender }
				]
			});
		$('#jqxgrid').on('rowdoubleclick', function (){
			var selectedrowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
			var id = $("#jqxgrid").jqxGrid('getrowid', selectedrowindex);
		openEditWindow(id, 'old');
		});

		$("#popupWindow").jqxWindow({
			width: $("#contentPanel").width() -
				200, isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01
		});
		$("#popupWindow").on('open', function () {
			$("#groupname").jqxInput('selectAll');
		});

		$("#Cancel").jqxButton({ theme: theme });
		$("#Save").jqxButton({ theme: theme });
		$("#Save").click(function () {
			var binaryid = $('#binaryid').val();
			var active = 0;
			if ($('#active1').jqxRadioButton('checked')) {
				active = 1;
			}
			var type = 1;
			if ($('#typewhite').jqxRadioButton('checked')) {
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
			if (binaryid != "") {
				$('#message').html('<div align="center" class="jqx-widget-header-' + theme + '">Updated ID: ' + $("#binaryid").val() + '</div><br />');
				$('#jqxgrid').jqxGrid('updaterow', rowID, row);
			} else {
				$('#jqxgrid').jqxGrid('addrow', rowID, row);
			}
			$("#popupWindow").jqxWindow('hide');
		});
		$("#jqxgrid").jqxGrid('autoresizecolumns');
		function openEditWindow(editrow, neworold) {
			$("#active1").jqxRadioButton({ checked: true });
			$("#typeblack").jqxRadioButton({ checked: true });
			$("#fieldsubject").jqxRadioButton({ checked: true });
			if (neworold == "old") {
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
				} else {
					if (dataRecord.msgcol == 2) {
						$("#fieldposter").jqxRadioButton({ checked: true });
					} else {
						$("#fieldmessageid").jqxRadioButton({ checked: true });
					}
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
				<div class="hint">The full name of a valid newsgroup. (Wildcard in the format
								  'alt.binaries.*')
				</div>
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
