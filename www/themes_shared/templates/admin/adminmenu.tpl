<div id="adminMenu">
	<ul>
		<li>Home</li>
		<li><a href="{$smarty.const.WWW_TOP}/">Admin Home</a></li>
		<li>Main Settings
			<ul>
				<li><a href="{$smarty.const.WWW_TOP}/binaryblacklist.php">Blacklists</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/content-list.php">Content Page(s)</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/category-list.php?action=add">Categories</li>
				<li><a href="{$smarty.const.WWW_TOP}/site-edit.php">Site Settings</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/group-list.php">Groups</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/menu-list.php"> Menu</a>
				<li><a href="{$smarty.const.WWW_TOP}/tmux-edit.php">Tmux Settings</a></li>
			</ul>
		</li>
		<li>Release Lists
			<ul>
				<li><a href="{$smarty.const.WWW_TOP}/movie-list.php?action=list">Movies</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/rage-list.php">TV</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/anidb-list.php?action=add">AniDB</li>
				<li><a href="{$smarty.const.WWW_TOP}/console-list.php">Consoles</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/game-list.php">Games</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/music-list.php">Music</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/xxx.php">XXX</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/release-list.php?action=list">Releases</a></li>
			</ul>
		</li>
		<li>Users
			<ul>
				<li><a href="{$smarty.const.WWW_TOP}/user-list.php?action=list">Users</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/role-list.php?action=list">User Roles</a></li>
			</ul>
		</li>
		<li>Misc
			<ul>
				<li><a href="{$smarty.const.WWW_TOP}/delete-releases.php">Delete Releases</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/nzb-import.php">Import NZBs</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/nzb-export.php">Export NZBs</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/opcachestats.php">Opcache Statistics</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/db-optimise.php">Optimize Database</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/sharing.php">Sharing</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/site-stats.php">Site Statistics</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/comments-list.php">Release Comments</a></li>
				<li><a href="{$smarty.const.WWW_TOP}/view-logs.php">View Logs</a></li>
			</ul>
		</li>
		<li>
			<div id="themelist"></div>
		</li>
	</ul>
</div>
