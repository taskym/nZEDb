
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
<div ng-controller="tmuxController">
<form id="tmuxform">
<jqx-navigation-bar>
		<div><span>Tmux How It Works</span></div>
				<div>
					<table>
						<tr>
							<td>
								Information:<br />
							</td>
							<td>
								Tmux is a screen multiplexer and at least version 1.6 is required.
								It is used
								here to allow multiple windows per session and multiple panes per
								window.<br /><br />
								Each script is run in its own shell environment. It is not looped,
								but allowed to run once and then
								exit. This notifies tmux that the pane is dead and can then be
								respawned with another iteration of
								the script in a new shell environment. <br />
								This allows for scripts that crash to be restarted without user
								intervention.<br /><br />
								You can run multiple tmux sessions, but they all must have an
								associated tmux.conf file and all
								sessions must use the same tmux.conf file.
								<br /><br />

								<h3><b>NOTICE:</b></h3> If "Save Tmux Settings" is the last thing
								you did on this page or if it is
								the active element and if you have this page set to autorefresh or
								you refresh instead of following
								a link to this page, you will set the db with the settings currently
								on this page, not reload from
								db. This could cause tmux scripts to start while optimize or patch
								the database is running.
							</td>
						</tr>
					</table>
				</div>
	<div>Monitor</div>
	<div>
		<table class="input">
			<tr>
				<td style="width:180px;"><label for="running">Tmux Scripts Running:</label></td>
				<td>
					<jqx-radio-button jqx-create="createWidget" jqx-group-name="'running'" value="1" ng-model="tmuxsettings.running">Yes</jqx-radio-button>
            		<jqx-radio-button jqx-create="createWidget" jqx-group-name="'running'" value="0" ng-model="tmuxsettings.running">No</jqx-radio-button>
					<div class="hint">This is the shutdown, true/on, it runs, false/off and all
									  scripts are terminated. This
									  will start/stop all panes without terminating the monitor
									  pane. This is not instant, it does not
									  kill any panes, it simply does not allow any pane to restart
									  if set to false.
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:180px;"><label for="monitor_delay">Monitor Loop Timer:</label></td>
				<td>
					<jqx-input jqx-create="createWidget" jqx-source="tmuxsettings" name="monitor_delay" ng-model="tmuxsettings.monitor_delay"></jqx-input>

					<div class="hint">The time between query refreshes of monitor information, in
									  seconds. This has no
									  effect on any other pane, except in regards to the kill
									  switches. The other panes are checked every
									  10 seconds. The lower the number, the more often it queries
									  the database for numbers.<br />
						<b>As the database gets larger in size, the longer this set of queries takes
						   to process.</b><br />
									  this has been mitigated by using memcache on the count
									  queries. The will stay in cache for whatever
									  you have set in config.ini, default is 900 seconds.
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:180px;"><label for="tmux_session">Tmux Session:</label></td>
				<td>
					<jqx-input jqx-create="createWidget" name="tmux_session" ng-model="tmuxsettings.tmux_session"></jqx-input>

					<div class="hint">Enter the session name to be used by tmux, no spaces allowed
									  in the name, this can't
									  be changed after scripts start. If you are running multiple
									  servers, you could put your hostname
									  here
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:180px;"><label for="monitor_path">Monitor a Ramdisk:</label></td>
				<td>
					<jqx-input jqx-create="createWidget" name="monitor_path" ng-model="tmuxsettings.monitor_path"></jqx-input> <br />
					<jqx-input jqx-create="createWidget" name="monitor_path_a" ng-model="tmuxsettings.monitor_path_a"></jqx-input> <br />
					<jqx-input jqx-create="createWidget" name="monitor_path_b" ng-model="tmuxsettings.monitor_path_b"></jqx-input> <br />

					<div class="hint">Enter a path here to have Monitor monitor its usage and free
									  space. Must be a valid
									  path.<br />To use this example, add to fstab and edit path,
									  gid and uid, then mount as user not root:<br />tmpfs
									  /var/www/nZEDb/resources/tmp/unrar tmpfs
									  user,uid=1000,gid=33,nodev,nodiratime,nosuid,size=1G,mode=777
									  0 0<br />
									  gid == group id == /etc/groups, uid == user id == /etc/passwd
					</div>
				</td>
			</tr>
			<tr>
				<td style="width:180px;"><label for="explaination">Information:</label></td>
				<td>
					<div class="explanation" id="explaination">
						Monitor is the name of the script that monitors all of the tmux panes and
						windows. It stops/stops
						scripts based on user settings. It queries the database to provide stats
						from your nZEDb
						database.<br /><br />
						There are 2 columns of numbers, 'In Process' and 'In Database'. The 'In
						Process' is all releases
						that need to be postprocessed. The 'In Database' is the number of releases
						matching that
						category.<br /><br />
						The 'In Process' column has 2 sets of numbers, the total for each category
						that needs to be
						postprocessed and inside the parenthesis is the difference from when the
						script started to what it
						is now.<br /><br />
						The 'In Database' column also has 2 sets of numbers, the total releases for
						each category and inside
						the parenthesis is the percentage that category is to the total number of
						releases.<br /><br />
						The Misc row means something different in both columns. The 'In Process'
						column is all releases that
						have not had 'Additional' run on them. This includes 100% of all releases,
						not just the Misc
						Category.<br /><br />
						The 'In Database' Misc means the number of releases that have not been
						categorized in any other
						category.<br />
						The counts for parts, binaries and predb totals are estimates and can vary
						wildly between queries.
						It is too slow to query the db for real counts, when using InnoDB. All of
						the other counts are
						actual counts.<br /><br />
						The 'In Process' predb is the total unmatched predb and inside the
						parenthesis is the 'matched'
						changed since the script started. The 'In Database' is the total matched
						predb's you have and the
						number inside the parenthesis is the percentage of total releases that you
						have matched to a predb
						release.<br /><br />
						The 'In Process' NZBs are total nzbs, inside the parenthesis is distinct
						nzbs and 'In Database' are
						nzbs that have all parts available and will be processed on next
						run.<br /><br />
						The 'In Process' requestID is the number waiting to be processed and inside
						the parenthesis is the
						number changed since the script started. The 'In Database' is the total
						matches of releases to
						requestIDs and inside the parenthesis is percentage of total releases that
						you have matched to a
						requestID.<br /><br />
						The 'In Process' rows PC and Pron are simply subsets of the 'In Process' row
						Misc. There is no
						postprocessing specifically for these categories. The 'In Database' is the
						actual count for the
						category.
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><jqx-button jqx-on-click="SaveClick(event)" ng-disabled="savedisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
			</tr>
		</table>
	</div>
			<div>Sequential</div>
		<div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="sequential">Run Sequential:</label></td>
					<td>
						{html_options style="width:180px;" class="siteeditstyle" id="sequential" name='sequential' values=$sequential_ids output=$sequential_names selected=$ftmux->sequential}
						<div class="hint">Basic Sequential runs update_binaries, backfill and update
										  releases_sequentially.<br />Complete
										  Sequential runs threaded.sh(copied to user_threaded.sh),
										  this still runs import in its own pane.
										  This will allow you to reorder the script in any order you
										  like. The idea is to get each individual
										  script to run at or near your desired load level.<br />Changing
										  requires restart.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="seq_timer">Sequential Sleep Timer:</label>
					</td>
					<td>
						<jqx-input jqx-create="createWidget" id="seq_timer"
							name="seq_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.seq_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="explain">Information:</label></td>
					<td>
						<div class="explanation">I recommend using Sequential, if you are also
												 grabbing nzbs.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Update Binaries</div>
<div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="binaries">Update Binaries:</label></td>
					<td>
						{html_options style="width:180px;" class="siteeditstyle" id="binaries" name='binaries' values=$binaries_ids output=$binaries_names selected=$ftmux->binaries}
						<div class="hint">Choose to run update_binaries. Update binaries gets from
										  your last_record to now.<br />Simple
										  Threaded Update runs 1 group per thread.<br />Complete
										  Threaded Update splits all work across
										  multiple threads(binaries_safe_threaded.py).
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="bins_timer">Update Binaries Sleep
																	 Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="bins_timer"
							name="bins_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.bins_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Backfill</div>
<div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="backfill">Backfill:</label></td>
					<td>
<jqx-drop-down-list jqx-ng-model jqx-settings="backfillGroupSettings"></jqx-drop-down-list>
						{html_options id="backfill" name='backfill' values=$backfill_ids output=$backfill_names selected=$ftmux->backfill}
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{html_options style="width:180px;" class="siteeditstyle" id="backfill_order" name='backfill_order' values=$backfill_group_ids output=$backfill_group selected=$ftmux->backfill_order}
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{html_options style="width:180px;" class="siteeditstyle" id="backfill_days" name='backfill_days' values=$backfill_days_ids output=$backfill_days selected=$ftmux->backfill_days}
						<div class="hint">Choose to run backfill type. Backfill gets from your
										  first_record back.<br />
										  Disabled - Disables backfill from running.<br />
										  Safe - Backfills 1 group by backfill days (set in
										  admin-view groups), using the number of threads
										  set in admin. This downloads Backfill Quantity times the
										  Backfill Threads, each
										  loop(backfill_safe_threaded.py). <br \>
										  example: you have Backfill Threads = 10, Backfill Quantity
										  = 20k, Max Messages = 5k: you will run 10
										  threads, queue of 40 and download 200k headers.<br />
										  All - Backfills all enabled groups using the
										  multiprocessing script by the number of articles (set in
										  tmux)</br>
										  Group - Backfills the number of groups (set in tmux), by
										  Backfill Quantity (set in tmux), up to
										  backfill days (set in admin-view groups)<br />
										  These settings are all per loop and does not use backfill
										  date. Approximately every 80 minutes,
										  every activated backfill group will be backfilled (5k
										  headers). This is to allow incomplete
										  collections to be completed and/or the 2 hour delay reset
										  if the collection is still active. This
										  extra step is not necessary and is not used when using
										  Sequential.<br />
										  Newest - Sorts the group selection with the least backfill
										  days backfilled, first.<br />
										  Oldest - Sorts the group selection with the most backfill
										  days backfilled, first.<br />
										  Alphabetical - Sorts the group selection from a to
										  z.<br />
										  Alphabetical Reverse - Sorts the group selection from z to
										  a.<br /a>
										  Most Posts - Sorts the group selection by the highest
										  number of posts, first.<br /a>
										  Fewest Posts - Sorts the group selection by the lowest
										  number of posts, first.<br />
										  Backfill days - Days per Group from admin->view group or
										  the Safe Backfill Date from admin->edit
										  site.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="backfill_qty">Backfill Quantity:</label>
					</td>
					<td>
						<jqx-input jqx-create="createWidget" id="backfill_qty"
							name="backfill_qty"
							class="short"
							type="text"
							ng-model="tmuxsettings.backfill_qty"></jqx-input>

						<div class="hint">When not running backfill intervals, you select the number
										  of headers per group per
										  thread to download.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="backfill_groups">Backfill Groups:</label>
					</td>
					<td>
						<jqx-input jqx-create="createWidget" id="backfill_groups" name="backfill_groups" class="short" type="text"
							ng-model="tmuxsettings.backfill_groups"></jqx-input>

						<div class="hint">When running backfill the groups are sorted by the
										  backfill method chosen above.
										  Select the number of groups to backfill per loop.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="back_timer">Backfill Sleep Timer:</label>
					</td>
					<td>
						<jqx-input jqx-create="createWidget" id="back_timer"
							name="back_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.back_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="progressive">Variable Sleep Timer:</label>
					</td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'progressive'"
							value="1"
							ng-model="tmuxsettings.progressive">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'progressive'"
							value="0"
							ng-model="tmuxsettings.progressive">No
						</jqx-radio-button>
						<div class="hint">This will vary the backfill sleep depending on how many
										  collections you have.<br />ie
										  50k collections would make sleep timer 100 seconds and 20k
										  releases would make sleep timer 40
										  seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Import nzbs</div>
<div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="import">Import nzbs:</label></td>
					<td>
						{html_options style="width:180px;" class="siteeditstyle" id="import" name='import' values=$import_ids output=$import_names selected=$ftmux->import}
						<div class="hint">Choose to run import nzb script true/false. This can point
										  to a single folder with
										  multiple subfolders on just the one folder. If you run
										  this threaded, it will run 1 folder per
										  thread.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="nzbs">Nzbs:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="nzbs"
							class="long"
							name="nzbs"
							type="text"
							ng-model="tmuxsettings.nzbs"></jqx-input>

						<div class="hint">Set the path to the nzb dump you downloaded from torrents,
										  this is the path to bulk
										  files folder of nzbs. This is by default, recursive and
										  threaded. You set the threads in edit site,
										  Advanced Settings.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="import_timer">Import nzbs Sleep
																	   Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="import_timer"
							name="import_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.import_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="explain">Information:</label></td>
					<td>
						<div class="explanation">This will import all nzbs in the given path. If in
												 your path you have nzbs in
												 the root folder and subfolders(regardless of nzbs
												 inside), threaded scripts will ignore all nzbs in
												 the root path. Then each subfolder is threaded.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
			</div>
			<div>Update Releases</div>
<div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="releases">Update Releases:</label></td>
					<td>
						{html_options style="width:180px;" class="siteeditstyle" id="releases" name='releases' values=$releases_ids output=$releases_names selected=$ftmux->releases}
						<div class="hint">Create releases, this is really only necessary to turn off
										  when you only want to post
										  process. This runs "Categorizes releases in misc sections
										  using the search name" on first loop and
										  has 33% chance of running on any other loop. Then runs
										  update_releases.php 1 false to create new
										  releases.<br />Threaded is only used with tablepergroup
										  and is required if using tpg.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="rel_timer">Update Releases Sleep
																	Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="rel_timer"
							name="rel_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.rel_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Postprocessing</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="post">Postprocess Additional:</label></td>
					<td>
						{html_options style="width:180px;" class="siteeditstyle" id="post" name='post' values=$post_ids output=$post_names selected=$ftmux->post}
						<div class="hint">Choose to do deep rar inspection, preview and sample
										  creation and/or nfo processing.
										  true/false
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="post_timer">Postprocess Additional Sleep
																	 Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="post_timer"
							name="post_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.post_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="post_kill_timer">Postprocess Kill
																		  Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="post_kill_timer" name="post_kill_timer" class="short" type="text"
							ng-model="tmuxsettings.post_kill_timer"></jqx-input>

						<div class="hint">The time postprocess is allowed to run with no updates to
										  the screen. Activity is
										  detected when the history for the pane changes. The clock
										  is restarted every time activity is
										  detected.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="post_amazon">Postprocess Amazon:</label>
					</td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'post_amazon'"
							value="1"
							ng-model="tmuxsettings.post_amazon">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'post_amazon'"
							value="0"
							ng-model="tmuxsettings.post_amazon">No
						</jqx-radio-button>
						<div class="hint">Choose to do books, music and games lookups true/false
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="post_timer_amazon">Postprocess Amazon Sleep
																			Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="post_timer_amazon"
							name="post_timer_amazon"
							class="short"
							type="text"
							ng-model="tmuxsettings.post_timer_amazon"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="post_non">Postprocess Non-Amazon:</label>
					</td>
					<td>
						{html_options style="width:180px;" class="siteeditstyle" id="post_non" name='post_non' values=$post_non_ids output=$post_non_names selected=$ftmux->post_non}
						<div class="hint">Choose to do movies, anime and tv lookups. true/false
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="post_timer">Postprocess Non-Amazon Sleep
																	 Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="post_timer_non" name="post_timer_non" class="short" type="text"
							ng-model="tmuxsettings.post_timer_non"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Comment Sharing</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="run_sharing">Comment Sharing :</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'run_sharing'"
							value="1"
							ng-model="tmuxsettings.run_sharing">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'run_sharing'"
							value="0"
							ng-model="tmuxsettings.run_sharing">No
						</jqx-radio-button>
						<div class="hint">Run Comment Sharing from within tmux if you have it
										  enabled in Admin->Sharing
										  Settings.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="sharing_timer">Comments Sharing
																		Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" class="short" id="sharing_timer" name="sharing_timer" type="text"
							ng-model="tmuxsettings.sharing_timer"></jqx-input>

						<div class="hint">Set the sleep time between updates</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Fix Release Names</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="fix_names">Fix Release Names:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'fix_names'"
							value="1"
							ng-model="tmuxsettings.fix_names">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'fix_names'"
							value="0"
							ng-model="tmuxsettings.fix_names">No
						</jqx-radio-button>
						<div class="hint">Choose to try to fix Releases Names using NFOs, par2
										  files, filenames, md5 and misc
										  sorter. true/false
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="fix_timer">Fix Release Names Sleep
																	Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="fix_timer"
							name="fix_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.fix_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Remove Crap Releases</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="fix_crap">Remove Crap Releases:</label>
					</td>
					<td>
						{html_radios id="fix_crap_opt" name='fix_crap_opt' onchange="enableFixCrapCustom()" values=$fix_crap_radio_ids output=$fix_crap_radio_names selected=$ftmux->fix_crap_opt separator='<br />'}
						<br>

						<div class="checkbox-grid">
							{if $ftmux->fix_crap_opt == "Custom"}
								{html_checkboxes id="fix_crap" name='fix_crap' values=$fix_crap_check_ids output=$fix_crap_check_names selected=explode(', ', $ftmux->fix_crap)}
							{else}
								{html_checkboxes id="fix_crap" name='fix_crap' disabled="true" readonly="true" values=$fix_crap_check_ids output=$fix_crap_check_names selected=explode(', ', $ftmux->fix_crap)}
							{/if}
						</div>
						<div class="hint">Choose to run Remove Crap Releases. You can all or some.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="crap_timer">Remove Crap Releases Sleep
																	 Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="crap_timer"
							name="crap_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.crap_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Decrypt Hashes</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="dehash">Decrypt Hash Based Release
																 Names:</label></td>
					<td>
						{html_options style="width:180px;" class="siteeditstyle" id="dehash" name='dehash' values=$dehash_ids output=$dehash_names selected=$ftmux->dehash}
						<div class="hint">Choose to run Decrypt Hashes true/false</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="dehash_timer">Decrypt Hashes Sleep
																	   Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="dehash_timer"
							name="dehash_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.dehash_timer"></jqx-input>

						<div class="hint">The time to sleep from the time the loop ends until it is
										  restarted, in seconds.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="explain">Information:</label></td>
					<td>
						<div class="explanation">Decrypt hashes works by matching a hashed release
												 to the md5 of a release in
												 the predb.<br />
												 Included in the same pane is Update Predb. This
												 scrapes several predb sites and then tries to match
												 against releases.<br />
												 This should be run along with fixReleasenames.php,
												 this is faster, but only looks at releases.names.
												 fixReleasenames.php goes further and looks at
												 release_files.name.
						</div>
					</td>
				</tr>
			</table>
		</div>
			<div>Update TV/Theater</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="update_tv">Update TV and Theater
																	Schedules:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'update_tv'"
							value="1"
							ng-model="tmuxsettings.update_tv">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'update_tv'"
							value="0"
							ng-model="tmuxsettings.update_tv">No
						</jqx-radio-button>
						<div class="hint">Choose to run Update TV and Theater Schedules true/false
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="tv_timer">Update TV and Theater Start
																   Timer:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="tv_timer"
							name="tv_timer"
							class="short"
							type="text"
							ng-model="tmuxsettings.tv_timer"></jqx-input>

						<div class="hint">This is a start timer. The default is 12 hours. This means
										  that if enabled, is will
										  start/run every 12 hours, no matter how long it runs for.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>PreDb IRC Scraper</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="run_ircscraper">Enable IRCScraper:</label>
					</td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'run_ircscraper'"
							value="1"
							ng-model="tmuxsettings.run_ircscraper">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'run_ircscraper'"
							value="0"
							ng-model="tmuxsettings.run_ircscraper">No
						</jqx-radio-button>
						<div class="hint">Enable IRCScraper. The pane for this can not be created
										  after tmux starts.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="explain">Information:</label></td>
					<td>
						<div class="explanation">IRC Scraper will scrape nZEDb's own pre channel on
												 synIRC for pre info.<br />
												 Copy settings_example.php to settings.php in
												 /misc/testing/IRCScraper and change the
												 settings.<br />
												 As a minimum you should set the username and make
												 sure it is unique.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Miscellaneous</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="niceness">Niceness:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="niceness"
							name="niceness"
							class="short"
							type="text"
							ng-model="tmuxsettings.niceness"></jqx-input>

						<div class="hint">This sets the 'nice'ness of each script, default is 19,
										  the lowest, the highest is -20
										  anything between -1 and -20 require root/sudo to run
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="collections_kill">Maximum
																		   Collections:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="collections_kill"
							name="collections_kill"
							class="short"
							type="text"
							ng-model="tmuxsettings.collections_kill"></jqx-input>

						<div class="hint">Set this to any number above 0 and when it is exceeded,
										  backfill and update binaries
										  will be terminated. 0 disables.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="postprocess_kill">Maximum
																		   Postprocess:</label></td>
					<td>
						<jqx-input jqx-create="createWidget" id="postprocess_kill"
							name="postprocess_kill"
							class="short"
							type="text"
							ng-model="tmuxsettings.postprocess_kill"></jqx-input>

						<div class="hint">Set this to any number above 0 and when it is exceeded,
										  import, backfill and update
										  binaries will be terminated. 0 disables.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="write_logs">Logging:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'write_logs'"
							value="1"
							ng-model="tmuxsettings.write_logs">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'write_logs'"
							value="0"
							ng-model="tmuxsettings.write_logs">No
						</jqx-radio-button>
						<div class="hint">Set this to write each panes output to a per pane per day
										  log file. This adds GMT date
										  to the filename.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="powerline">Powerline Status Bar:</label>
					</td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'powerline'"
							value="1"
							ng-model="tmuxsettings.powerline">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'powerline'"
							value="0"
							ng-model="tmuxsettings.powerline">No
						</jqx-radio-button>
						<div class="hint">Choose to use the Powerline tmux status bar. To make this
										  pretty, you need to install
										  a patched font. This can be found on
							<a href="https://github.com/jonnyboy/powerline-fonts">my
																				  fork</a> or <a
								href="https://github.com/Lokaltog/powerline-fonts">the original
																				   git</a><br \>You
										  will need to copy the default theme located at
										  powerline/powerline/themes/default.sh to
										  powerline/powerline/themes/tmux.sh and edit that file for
										  what is displayed, colors, etc.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" ng-disabled="saveDisabled" jqx-data="buttonData" jqx-settings="buttonsettings"><span>{{data.text}}</span></jqx-button></td>
				</tr>
			</table>
		</div>
			<div>Server Monitors</div><div>
			<table class="input">
				<tr>
					<td style="width:180px;"><label for="showquery">Display Query Times:</label>
					</td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'showquery'"
							value="1"
							ng-model="tmuxsettings.showquery">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'showquery'"
							value="0"
							ng-model="tmuxsettings.showquery">No
						</jqx-radio-button>
						<div class="hint">Choose to display the query times for each set of queries.
										  true/false.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="htop">htop:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'htop'"
							value="1"
							ng-model="tmuxsettings.htop">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'htop'"
							value="0"
							ng-model="tmuxsettings.htop">No
						</jqx-radio-button>
						<div class="hint">htop - an interactive process viewer for Linux. The pane
										  for this can not be created
										  after tmux starts.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="nmon">nmon:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'nmon'"
							value="1"
							ng-model="tmuxsettings.nmon">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'nmon'"
							value="0"
							ng-model="tmuxsettings.nmon">No
						</jqx-radio-button>
						<div class="hint">nmon is short for Nigel's performance Monitor for Linux.
										  The pane for this can not be
										  created after tmux starts.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="vnstat">vnstat:</label></td>
					<td>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'vnstat'"
							value="1"
							ng-model="tmuxsettings.vnstat">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'vnstat'"
							value="0"
							ng-model="tmuxsettings.vnstat">No
						</jqx-radio-button>
						<jqx-input jqx-create="createWidget" id="vnstat_ARGS"
							name="vnstat_ARGS"
							class="text"
							type="text"
							ng-model="tmuxsettings.vnstat_ARGS"></jqx-input>

						<div class="hint">vnStat is a console-based network traffic monitor for
										  Linux and BSD that keeps a log
										  of network traffic for the selected interface(s). Any
										  additional arguments should be placed in the
										  text box. The pane for this can not be created after tmux
										  starts.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="tcptrack">tcptrack:</label></td>
					<td>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'tcptrack'"
							value="1"
							ng-model="tmuxsettings.tcptrack">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'tcptrack'"
							value="0"
							ng-model="tmuxsettings.tcptrack">No
						</jqx-radio-button><jqx-input jqx-create="createWidget" id="tcptrack_args" name="tcptrack_args" class="text" type="text"
							ng-model="tmuxsettings.tcptrack_args"></jqx-input>

						<div class="hint">tcptrack displays the status of TCP connections that it
										  sees on a given network
										  interface. tcptrack monitors their state and displays
										  information such as state, source/destination
										  addresses and bandwidth usage in a sorted, updated list
										  very much like the top(1) command. <br />Any
										  additional arguments should be placed in the text box.
							<br />You may need to run "sudo setcap
										  cap_net_raw+ep /usr/bin/tcptrack", to be able to run as
										  user. The pane for this can not be created
										  after tmux starts.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="bwmng">bwm-ng:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'bwmng'"
							value="1"
							ng-model="tmuxsettings.bwmng">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'bwmng'"
							value="0"
							ng-model="tmuxsettings.bwmng">No
						</jqx-radio-button>
						<div class="hint">bwm-ng can be used to monitor the current bandwidth of all
										  or some specific network
										  interfaces or disks (or partitions). The pane for this can
										  not be created after tmux starts.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="mytop">mytop:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'mytop'"
							value="1"
							ng-model="tmuxsettings.mytop">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'mytop'"
							value="0"
							ng-model="tmuxsettings.mytop">No
						</jqx-radio-button>
						<div class="hint">mytop - display MySQL server performance info like `top'.
							<br />You will need to create
										  ~/.mytop, an example can be found in 'perldoc mytop'. The
										  pane for this can not be created after
										  tmux starts.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="showprocesslist">Show Process List:</label>
					</td>
					<td>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'showprocesslist'"
							value="1"
							ng-model="tmuxsettings.showprocesslist">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'showprocesslist'"
							value="0"
							ng-model="tmuxsettings.showprocesslist">No
						</jqx-radio-button>
						<jqx-input jqx-create="createWidget" id="processupdate" name="processupdate" class="short" type="text"
							ng-model="tmuxsettings.processupdate"></jqx-input>

						<div class="hint">This runs the watch command in its own pane. This could be
										  used for a live 'slow query
										  monitor'. Just set the time above and only the queries
										  that exceed it will be displayed.<br />mysql
										  -e "SELECT time, state, rows_examined, info FROM
										  information_schema.processlist WHERE command !=
										  \"Sleep\" AND time >= .5 ORDER BY time DESC \G"<br />This
										  shows a grid like layout with the full test
										  of the running queries.<br />You will need to create a
										  ~/.my.cnf for this to work properlly. The pane
										  for this can not be created after tmux starts and
										  modifying the time above will have no effect until
										  a restart occurs.
						</div>
					</td>
				</tr>
				<tr>
					<td style="width:180px;"><label for="console">Console:</label></td>
					<td>

						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'console'"
							value="1"
							ng-model="tmuxsettings.console">Yes
						</jqx-radio-button>
						<jqx-radio-button jqx-create="createWidget"
							jqx-group-name="'console'"
							value="0"
							ng-model="tmuxsettings.console">No
						</jqx-radio-button>
						<div class="hint">Open an empty bash shell. The pane for this can not be
										  created after tmux starts.
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jqx-button jqx-on-click="saveTmux(event)" jqx-data="buttonData" jqx-settings="buttonsettings"></jqx-button></td>
				</tr>
			</table>
		</div>
</jqx-navigation-bar>
</form>
</div>
	<script type="text/javascript">

		var url = "tmux-edit.php";

		adminApp.controller("tmuxController", function ($scope, $http) {

			$scope.createWidget = false;
			$http.get(url + '?action=view').
				success(function (response) {
					$scope.tmuxsettings = response;

					$scope.backfillGroups = [
						{
							id: 1,
							name: 'Newest'
						},
						{
							id: 2,
							name: 'Oldest'
						},
						{
							id: 3,
							name: 'Alphabetical'

						},
						{
							id: 4,
							name: 'Alphabetical - Reverse'
						},
						{
							id: 5,
							name: 'Most Posts'
						},
						{
							id: 6,
							name: 'Fewest Posts'
						}
					];

					$scope.backfillGroupSettings =
					{
						width: 200,
						height: 30,
						autoDropDownHeight: true,
						displayMember: "name",
						valueMember: "id",
						source: $scope.backfillGroups,
						selectedIndex: $scope.tmuxsettings.backfill_order - 1
					};

					$scope.buttonsettings = {
						width: 150,
						height: 30
					};

					$scope.buttonData = {
						text: "Save"
					};
					$scope.saveDisabled = false;
					$scope.saveTmux = function (event) {
						$scope.buttonData.text = "Saved";
						$scope.saveDisabled = true;
					};
					$scope.createWidget = true;

				}).
				error(function (data, status, headers, config) {
					console.log(data);
					alert(data);
				});
			console.log($scope);
		});
	</script>
{/literal}
