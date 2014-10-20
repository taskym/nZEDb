<h1>{$page->title}</h1>
<p>
Select a row, click edit or double click the row to change.
</p>
<div>
	<span id="message"></span>
</div>
{literal}
	<script type="text/javascript">
	$(document).ready(function () {
		var editrow = -1;
		var rowID = -1;
		var message = '<div align="center" class="jqx-widget-header-' + theme + '">';
		var source =
		{
			datatype: "json",
			datafields: [
				{ name: 'id', type: 'number' },
				{ name: 'title', type: 'string' },
				{ name: 'tagline', type: 'string' },
				{ name: 'plot', type: 'string' },
				{ name: 'genre', type: 'string' },
				{ name: 'director', type: 'string' },
				{ name: 'actors', type: 'string' },
				{ name: 'extras', type: 'string' },
				{ name: 'productinfo', type: 'string' },
				{ name: 'trailers', type: 'string' },
				{ name: 'directurl', type: 'string' },
				{ name: 'classused', type: 'string' },
				{ name: 'cover', type: 'number' },
				{ name: 'backdrop', type: 'number' },
				{ name: 'createddate', type: 'string' },
				{ name: 'updateddate', type: 'string' },

			],
			url: 'ajax_xxx.php?action=list',
			addrow: function (rowid, rowdata, position, commit) {
				$.ajax({
					dataType: 'json',
					url: 'ajax_xxx.php?action=add&rowid=' + rowid,
					cache: false,
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
					url: 'ajax_xxx.php?action=delete&id=' + databaseid,
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
					url: 'ajax_xxx.php?action=update',
					data: rowdata,
					type: 'post',
					success: function (data, status, xhr) {
							commit(true);
							$('#message').html('<div align="center" class="jqx-widget-header-' + theme +
								'">Updated ID: ' + $("#binaryid").val() + '</div><br />');
					},
					error: function (error, responseText, errorThrown) {
						$("#message").html(message + 'Error: ' + responseText);
						commit(false);
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

		var initrowdetails = function (index, parentElement, gridElement, datarecord) {
			var tabsdiv = null;
			var information = null;
			var notes = null;
			tabsdiv = $($(parentElement).children()[0]);
			if (tabsdiv != null) {
				information = tabsdiv.find('.information');
				notes = tabsdiv.find('.notes');
				var title = tabsdiv.find('.title');
				title.text(datarecord.title);
				var container = $('<div style="margin: 5px;"></div>');
				container.appendTo($(information));
				var photocolumn = $('<div style="float: left; width: 15%;"></div>');
				var leftcolumn = $('<div style="float: left; width: 45%;"></div>');
				var rightcolumn = $('<div style="float: left; width: 40%;"></div>');
				container.append(photocolumn);
				container.append(leftcolumn);
				container.append(rightcolumn);
				var photo = $("<div class='jqx-rc-all' style='margin: 10px;'><b>Photos:</b></div>");
				var image = $("<div style='margin-top: 10px;'></div>");
				var coverurl = '../../covers/xxx/' + datarecord.id + '-cover.jpg';
				var cover = $('<img height="60" src="' + coverurl + '"/>');
				var backdropurl = '../../covers/xxx/' + datarecord.id + '-backdrop.jpg';
				var backdrop = $('<img height="60" src="' + backdropurl + '"/>');
				image.append(cover);
				image.append(backdrop);
				image.appendTo(photo);
				photocolumn.append(photo);
				var title = "<div style='margin: 10px;'><b>Title:</b> " +
					datarecord.title + "</div>";
				$(leftcolumn).append(title);
				var postalcode = "<div style='margin: 10px;'><b>Postal Code:</b> " +
					datarecord.postalcode + "</div>";
				var city = "<div style='margin: 10px;'><b>City:</b> " + datarecord.city + "</div>";
				var phone = "<div style='margin: 10px;'><b>Phone:</b> " + datarecord.homephone +
					"</div>";
				var hiredate = "<div style='margin: 10px;'><b>Hire Date:</b> " +
					datarecord.hiredate + "</div>";
				$(rightcolumn).append(postalcode);
				$(rightcolumn).append(city);
				$(rightcolumn).append(phone);
				$(rightcolumn).append(hiredate);
				var notescontainer = $('<div style="white-space: normal; margin: 5px;"><span>' +
					datarecord.notes + '</span></div>');
				$(notes).append(notescontainer);
				$(tabsdiv).jqxTabs({ width: 750, height: 170});
			}
		};

		var dataAdapter = new $.jqx.dataAdapter(source);
		$("#jqxgrid").jqxGrid(
			{
				width: '100%',
				source: dataAdapter,
				rowdetails: true,
                rowdetailstemplate: { rowdetails: "<div style='margin: 10px;'><ul style='margin-left: 30px;'><li class='title'></li><li>Notes</li></ul><div class='information'></div><div class='notes'></div></div>", rowdetailsheight: 200 },
                initrowdetails: initrowdetails,
				theme: theme,
				columnsresize: true,
				autoheight: true,
				showtoolbar: true,
				pageable: true,
				rendertoolbar: function (toolbar) {
					var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
					var addrowbutton = $("<div id='addrowbutton' style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../themes_shared/images/layout/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Add</span></div>");
					var editrowbutton = $("<div id='editrowbutton' style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../themes_shared/images/layout/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Edit</span></div>");
					var deleterowbutton = $("<div id='deleterowbutton' style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../themes_shared/images/layout/close.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Delete</span></div>");
					container.append(addrowbutton);
					container.append(editrowbutton);
					container.append(deleterowbutton);
					toolbar.append(container);
					addrowbutton.jqxButton({theme: theme});
					editrowbutton.jqxButton({theme: theme});
					deleterowbutton.jqxButton({theme: theme});
					addrowbutton.click(function () {
						openEditWindow('new');
					});
					editrowbutton.click(function () {
						openEditWindow('old');
					});
					deleterowbutton.click(function () {
						var selectedrowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
						var id = $("#jqxgrid").jqxGrid('getrowid', selectedrowindex);
						var commit = $("#jqxgrid").jqxGrid('deleterow', id);
					});
				},
				columns: [
					{ text: 'ID', datafield: 'id', width: '120px' },
					{ text: 'Title', datafield: 'title' },
					{ text: 'Tagline', datafield: 'tagline' },
					{ text: 'Plot', datafield: 'plot', width: '120px' },
					{ text: 'Genre', datafield: 'genre', width: '120px' },
					{ text: 'Director', datafield: 'director' },
					{ text: 'Actors', datafield: 'actors', width: '120px' }
				]
			});
		$('#jqxgrid').on('rowdoubleclick', function () {
			openEditWindow('old');
		});

		$("#popupWindow").jqxWindow({
			width: $("#contentPanel").width() - 200, isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01
		});

		$("#Cancel").jqxButton({ theme: theme });
		$("#Save").jqxButton({ theme: theme });
		$("#Save").click(function () {
			$('#newbinary').jqxValidator('validate');
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
			if (binaryid == ""){
			binaryid = null;
			}
			var row = { id: binaryid, groupname: $("#groupname").val(), regex: $("#regex").val(), msgcol: fieldmessage,
				optype: type, status: active, description: $("#description").val()
			};
			if (binaryid != null) {
				var selectedrowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
				var rowscount = $("#jqxgrid").jqxGrid('getdatainformation').rowscount;
				if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
					var id = $("#jqxgrid").jqxGrid('getrowid', selectedrowindex);
					var commit = $("#jqxgrid").jqxGrid('updaterow', id, row);
					$("#jqxgrid").jqxGrid('ensurerowvisible', selectedrowindex);
				}
			} else {
				var commit = $('#jqxgrid').jqxGrid('addrow', null, row);
			}
			$("#popupWindow").jqxWindow('close');
		});
		$("#jqxgrid").jqxGrid('autoresizecolumns');
		function openEditWindow(neworold) {
			resetEditWindow();
			if (neworold == "old") {
				var selectedrowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
				editrow = $("#jqxgrid").jqxGrid('getrowid', selectedrowindex);
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

		function resetEditWindow() {
			$("#binaryid").val("");
			$("#message").html("");
			$("#active1").jqxRadioButton({ checked: true });
			$("#typeblack").jqxRadioButton({ checked: true });
			$("#fieldsubject").jqxRadioButton({ checked: true });
			$("#groupname").val("");
			$("#regex").val("");
			$("#description").val("");
		}

		$('#newbinary').jqxValidator({
			hintType: 'label',
			animationDuration: 0,
			rules: [
				{ input: '#groupname', message: 'A Group Name is required!', action: 'keyup, blur', rule: 'required' }
				],
			theme: theme
		});
	});
	</script>
{/literal}
<div id="jqxgrid"></div>
<div id="popupWindow">
	<div>Edit</div>
	<div style="overflow: hidden;">
		<form id="newbinary" action="./">
		<table>
			<tr>
				<input type="hidden" id="binaryid" />
				The full name of a valid newsgroup. (Wildcard in the format 'alt.binaries.*')
				<td align="right">Group:</td>
				<td align="left"><input id="groupname" /></td>
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
		</form>
	</div>
</div>
