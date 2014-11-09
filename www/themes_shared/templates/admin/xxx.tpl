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
		var nzedbgrid = $("#jqxgrid");
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
				{ name: 'updateddate', type: 'string' }

			],
			root: 'results',
			cache: false,
			beforeprocessing: function (data) {
				source.totalrecords = data[0].TotalRows;
			},
			url: 'ajax_xxx.php?action=list',
			updaterow: function (rowid, rowdata, commit) {
				$.ajax({
					dataType: 'json',
					url: 'ajax_xxx.php?action=update',
					data: rowdata,
					type: 'POST',
					success: function (data, status, xhr) {
						commit(true);
						$('#message').html('<div align="center" class="jqx-widget-header-' + theme +
							'">Updated ID: ' + $("#xxxid").val() + '</div><br />');
					},
					error: function (error, responseText, errorThrown) {
						$("#message").html(message + 'Error: ' + responseText);
						commit(false);
					}
				});
			}
		};
		$("#title").jqxInput({theme: theme, width: 400});
		$("#tagline").jqxInput({theme: theme, width: 400});
		$("#plot").jqxInput({theme: theme, height: 150, width: 400});
		$("#director").jqxInput({theme: theme});
		$("#actors").jqxInput({theme: theme, width: 400});
		$("#trailers").jqxInput({theme: theme, width: 400});
		$("#directurl").jqxInput({theme: theme, width: 400});
		var initrowdetails = function (index, parentElement, gridElement, datarecord) {
			var tabsdiv = null;
			var information = null;
			var trailer = null;
			var photos = null;
			tabsdiv = $($(parentElement).children()[0]);
			if (tabsdiv != null) {
				information = tabsdiv.find('.information');
				trailer = tabsdiv.find('.trailer');
				photos = tabsdiv.find('.photos');
				var title = tabsdiv.find('.title');
				title.text(datarecord.title);
				var container = $('<div style="margin: 5px;"></div>');
				container.appendTo($(information));
				var leftcolumn = $('<div style="float: left; width: 50%;"></div>');
				var rightcolumn = $('<div style="float: left; width: 50%;"></div>');
				container.append(leftcolumn);
				container.append(rightcolumn);
				var title = "<div style='margin: 10px;'><b>Title:</b> " + datarecord.title +
					"</div>";
				var director = "<div style='margin: 10px;'><b>Director:</b> " +
					datarecord.director + "</div>";
				var createddate = "<div style='margin: 10px;'><b>Created Date:</b> " +
					datarecord.createddate + "</div>";
				var updateddate = "<div style='margin: 10px;'><b>Updated Date:</b> " +
					datarecord.updateddate + "</div>";
				$(leftcolumn).append(title);
				$(leftcolumn).append(director);
				$(leftcolumn).append(createddate);
				$(leftcolumn).append(updateddate);
				var genre = "<div style='margin: 10px;'><b>Genres: </b><div id='Genrelist'></div></div>";
				var actors = "<div style='margin: 10px;'><b>Actors:</b><div id='Actorlist'></div></div>";
				$(rightcolumn).append(genre);
				$(rightcolumn).append(actors);
				var photo = $("<div class='jqx-rc-all' style='margin: 10px;'><b>Photos:</b></div>");
				var image = $("<div style='margin-top: 10px;'></div>");
				var coverurl = '../../covers/xxx/' + datarecord.id + '-cover.jpg';
				var cover = $('<img width="160" height="228" src="' + coverurl + '"/>');
				var backdropurl = '../../covers/xxx/' + datarecord.id + '-backdrop.jpg';
				var backdrop = $('<img width="160" height="228" src="' + backdropurl + '"/>');
				image.append(cover);
				image.append(backdrop);
				image.appendTo(photo);
				$(photos).append(photo);
				if (datarecord.hastrailer == 1) {
					var trailercontainer = $('<div style="white-space: normal; margin: 5px;"><span>' +
						datarecord.trailers + '</span></div>');
					$(trailer).append(trailercontainer);
				} else {
					$(tabsdiv).jqxTabs('disableAt', $(trailer));
				}
				createdropdownbox('#Genrelist', null, null, datarecord.genre, 'title', 'id');
				createdropdownbox('#Actorlist', null, null, datarecord.actors);
				$(tabsdiv).jqxTabs({ width: $('#jqxgrid').width - 200, height: 320});
			}
		};

		var dataAdapter = new $.jqx.dataAdapter(source);
		nzedbgrid.jqxGrid(
			{
				width: '100%',
				source: dataAdapter,
				rowdetails: true,
				rowdetailstemplate: { rowdetails: "<div style='margin: 10px;'><ul style='margin-left: 30px;'><li class='title'></li><li>Photos</li><li>Trailers</li></ul><div class='information'></div><div class='photos'></div><div class='trailer'></div></div>", rowdetailsheight: 350 },
				initrowdetails: initrowdetails,
				theme: theme,
				columnsresize: true,
				autoheight: true,
				showtoolbar: true,
				pageable: true,
				virtualmode: true,
				rendergridrows: function () {
					return dataAdapter.records;
				},
				rendertoolbar: function (toolbar) {
					var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
					var editrowbutton = $("<div id='editrowbutton' style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../themes_shared/images/layout/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Edit</span></div>");
					container.append(editrowbutton);
					toolbar.append(container);
					editrowbutton.jqxButton({theme: theme});
					editrowbutton.click(function () {
						openEditWindow();
					});
				},
				columns: [
					{ text: 'Database ID', datafield: 'id', width: '120px' },
					{ text: 'Title', datafield: 'title' },
					{ text: 'Tagline', datafield: 'tagline' },
					{ text: 'Plot', datafield: 'plot' },
					{ text: 'Director', datafield: 'director' }
				]
			});
		$('#jqxgrid').on('rowdoubleclick', function () {
			openEditWindow();
		});

		$("#popupWindow").jqxWindow({
			maxWidth: $("#contentPanel").width() -
				50, isModal: true, autoOpen: false, resizable: true, cancelButton: $("#Cancel"), modalOpacity: 0.01
		});

		$("#Cancel").jqxButton({ theme: theme });
		$("#Save").jqxButton({ theme: theme });
		$("#Save").click(function () {
			$('#xxxedit').jqxValidator('validate');
			var xxxid = $('#xxxid').val();
			var row = { id: xxxid, title: $("#title").val(), tagline: $("#tagline").val(), director: $("#director").val(),
				actors: $("#actors").val(), directurl: $("#directurl").val(), trailers: $("#trailers").val(), plot: $("#plot").val()
			};
			if (xxxid != null) {
				var selectedrowindex = nzedbgrid.jqxGrid('getselectedrowindex');
				var rowscount = nzedbgrid.jqxGrid('getdatainformation').rowscount;
				if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
					var id = nzedbgrid.jqxGrid('getrowid', selectedrowindex);
					var commit = nzedbgrid.jqxGrid('updaterow', id, row);
					nzedbgrid.jqxGrid('ensurerowvisible', selectedrowindex);
				}
			}

			nzedbgrid.jqxGrid('updatebounddata');
			$("#popupWindow").jqxWindow('close');
		});
		nzedbgrid.jqxGrid('autoresizecolumns');
		function openEditWindow() {
			var selectedrowindex = nzedbgrid.jqxGrid('getselectedrowindex');
			var rowscount = nzedbgrid.jqxGrid('getdatainformation').rowscount;
			if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
				var id = nzedbgrid.jqxGrid('getrowid', selectedrowindex);
				var dataRecord = nzedbgrid.jqxGrid('getrowdata', id);
				console.log(selectedrowindex);
				console.log(id);
				console.log(dataRecord);
				$("#xxxid").val(dataRecord.id);
				$("#title").val(dataRecord.title);
				$("#tagline").val(dataRecord.tagline);
				$("#plot").val(dataRecord.plot);
				$("#director").val(dataRecord.director);
				$("#actors").val(dataRecord.actors);
				$("#directurl").val(dataRecord.directurl);
				$("#trailers").val(dataRecord.trailers);
			}
			$("#popupWindow").jqxWindow('open');
		}

		function resetEditWindow() {
			$("#xxxid").val("");
			$("#message").html("");
			$("#title").val("");
			$("#tagline").val("");
			$("#plot").val("");
			$("#director").val("");
			$("#actors").val("");
			$("#directurl").val("");
			$("#trailers").val("");
			$("#plot").val("");
		}

		function createdropdownbox(element, url, datafields, dadapter, displaymember, valuemember, xwidth, yheight) {
			xwidth = xwidth || 200;
			yheight = yheight || 25;
			if (url != null && datafields != null) {
				var source =
				{
					datatype: "json",
					datafields: datafields,
					id: 'id',
					url: url
				};
				var dadapter = new $.jqx.dataAdapter(source);
			}
			$(element).jqxDropDownList({ selectedIndex: 0, source: dadapter, displayMember: displaymember, valueMember: valuemember, width: xwidth, height: yheight});
			$(element).on('select', function (event) {
				if (event.args) {
					var item = event.args.item;
					if (item) {
						return item;
					}
				}
			});
		}

		$('#xxxedit').jqxValidator({
			hintType: 'label',
			animationDuration: 0,
			rules: [
				{ input: '#title', message: 'A title is required', action: 'keyup, blur', rule: 'required' }
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
		<form id="xxxedit" action="./">
					<input type="hidden" id="xxxid" />
			<table>
				<tr>
					<td align="right">Title:</td>
					<td align="left"><input id="title" /></td>
				</tr>
				<tr>
					<td align="right">Tagline:</td>
					<td align="left"><textarea id="tagline"></textarea></td>
				</tr>
				<tr>
					<td align="right">Plot:</td>
					<td align="left"><textarea id="plot"></textarea></td>
				</tr>
				<tr>
					<td align="right">Director:</td>
					<td align="left"><input id="director" /></td>
				</tr>
				<tr>
					<td align="right">Actors:</td>
					<td align="left"><input id="actors" /></td>
				</tr>
				<tr>
					<td align="right">Direct Url:</td>
					<td align="left"><input id="directurl" /></td>
				</tr>
				<tr>
					<td align="right">Trailer Url:</td>
					<td align="left"><input id="trailers" /></td>
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
