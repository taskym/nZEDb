<div>
<table border="0" width="100%">
	<tr>
		<td><h1>{$page->title}</h1></td>
		<td></td>
		<td align="right" id="top-nav">
			<div id="jumpbox"></div>
				<select id="select">
					<option value="#">Quick Jump</option>
					<option value="tmux_backfill">Backfill</option>
					<option value="tmux_commentsharing">Comment Sharing</option>
					<option value="tmux_decrypthashes">Decrypt Hashes</option>
					<option value="tmux_fixreleasenames">Fix Release Names</option>
					<option value="tmux_importnzbs">Import Nzbs</option>
					<option value="tmux_misc">Miscellaneous</option>
					<option value="tmux_monitor">Monitor</option>
					<option value="tmux_postprocessing">Postprocessing</option>
					<option value="tmux_ircscraper">PreDb IRC Scraper</option>
					<option value="tmux_removecrapreleases">Remove Crap Releases</option>
					<option value="tmux_sequential">Sequential</option>
					<option value="tmux_servermonitors">Server Monitors</option>
					<option value="tmux_updatebinaries">Update Binaries</option>
					<option value="tmux_updatereleases">Update Releases</option>
					<option value="tmux_updatetvtheater">Update TV/Theater</option>
				</select>
		</td>
	</tr>
</table>
</div>
{if $error != ''}
	<div class="error">{$error}</div>
{/if}
	{literal}
		<script type="text/javascript">
			$(document).ready(function () {
				$('#tmuxlist').jqxListMenu({theme: theme, showBackButton: true});
			});
		</script>
	{/literal}
<ul id="tmuxlist" data-role="listmenu">
<li>
	<div>Tmux How It Works</div>
	<ul data-role="listmenu">
	<li>
	<div style="padding: 5px;" data-role="content">
	<table>
		<tr>
			<td><label for="explaination">Information:</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</td>
			<td>
				Tmux is a screen multiplexer and at least version 1.6 is required. It is used
					here to allow multiple windows per session and multiple panes per window.<br/><br/>
					Each script is run in its own shell environment. It is not looped, but allowed to run once and then
					exit. This notifies tmux that the pane is dead and can then be respawned with another iteration of
					the script in a new shell environment. <br/>
					This allows for scripts that crash to be restarted without user intervention.<br/><br/>
					You can run multiple tmux sessions, but they all must have an associated tmux.conf file and all
					sessions must use the same tmux.conf file.
					<br/><br/>
					<h3><b>NOTICE:</b></h3> If "Save Tmux Settings" is the last thing you did on this page or if it is
					the active element and if you have this page set to autorefresh or you refresh instead of following
					a link to this page, you will set the db with the settings currently on this page, not reload from
					db. This could cause tmux scripts to start while optimize or patch the database is running.
			</td>
		</tr>
	</table>
	</div>
	</li>
	</ul>
	</li>
	</ul>
