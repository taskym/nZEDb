<h1>{$page->title}</h1>
<p>
	Binaries can be prevented from being added to the index at all if they match a regex provided in the blacklist. They can also be included only if they match a regex (whitelist).
	<br>CLICK EDIT OR ON THE BLACKLIST TO ENABLE/DISABLE.
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
				{ name: 'msgcol', type: 'string' },
				{ name: 'optype', type: 'number' },
				{ name: 'status', type: 'number' },
				{ name: 'description', type: 'string' }
			],
			url: 'ajax_binaryblacklist-list.php?action=list',
			updaterow: function (rowid, rowdata, commit) {
				commit(true);
			}
		};
		$("#groupname").jqxInput({theme: theme, width: 300});
		$("#regex").jqxInput({theme: theme, height: 150, width: 300});
		$("#msgcol").jqxInput({theme: theme, width: 300});
		$("#description").jqxInput({theme: theme, width: 300});
		$("#optype").jqxInput({theme: theme});
		$("#active0").jqxRadioButton({theme: theme});
		$("#active1").jqxRadioButton({theme: theme});
		var editrow = -1;
		var dataAdapter = new $.jqx.dataAdapter(source);
		$("#jqxgrid").jqxGrid(
			{
				width: '100%',
				source: dataAdapter,
				theme: theme,
				columnsresize: true,
				autoheight: true,
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
						var offset = $("#jqxgrid").offset();
						$("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) +
							60, y: parseInt(offset.top) + 60 } });
						var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
						$("#binaryid").val(dataRecord.id);
						$("#groupname").val(dataRecord.groupname);
						$("#regex").val(dataRecord.regex);
						$("#msgcol").val(dataRecord.msgcol);
						$("#description").val(dataRecord.description);
						$("#optype").val(dataRecord.optype);
						if (dataRecord.status == 1) {
						$("#active1").jqxRadioButton({ checked: true });
						} else {
						$("#active0").jqxRadioButton({ checked: true });
						}


						$("#popupWindow").jqxWindow('open');
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
				var row = { id: $("#binaryid").val(), groupname: $("#groupname").val(), regex: $("#regex").val(), msgcol: $("#msgcol").val(),
					optype: $("#optype").val(), status: active, description: $("#description").val()
				};
				var rowID = $('#jqxgrid').jqxGrid('getrowid', editrow);
				$('#jqxgrid').jqxGrid('updaterow', rowID, row);
				$("#popupWindow").jqxWindow('hide');
			}
		});
		$("#jqxgrid").jqxGrid('autoresizecolumns');
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
						<td align="left"><input id="description"></td>
					</tr>
                    <tr>
                        <td align="right">Message Field:</td>
                        <td align="left"><input id="msgcol"></td>
                    </tr>
					<tr>
                        <td align="right">Type:</td>
                        <td align="left"><input id="optype"></td>
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
