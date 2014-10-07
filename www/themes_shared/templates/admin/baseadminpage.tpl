<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>{$page->meta_title}{if $site->metatitle != ""} - {$site->metatitle}{/if}</title>
		<meta name="keywords" content="{$page->meta_keywords}{if $site->metakeywords != ""},{$site->metakeywords}{/if}">
		<meta name="description" content="{$page->meta_description}{if $site->metadescription != ""} - {$site->metadescription}{/if}">
		<meta name="application-name" content="nZEDb-v{$site->version}">
		<meta name="viewport" content="width=device-width">
		<link rel="stylesheet" href="{$smarty.const.WWW_TOP}/../themes_shared/styles/admin.base.css" type="text/css" />
		<link rel="stylesheet" href="{$smarty.const.WWW_TOP}/../themes_shared/styles/admin.black.css" type="text/css" />
		<link rel="shortcut icon" href="{$smarty.const.WWW_TOP}/../themes_shared/images/favicon.ico">
		<style type="text/css">.jqx-splitter { border: none; }</style>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/jquery-1.11.1.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxcore.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxbuttons.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxscrollbar.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxpanel.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxtree.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxexpander.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxsplitter.js"></script>
		{literal}
			<script type="text/javascript">
				$(document).ready(function () {
					var window_width = $(window).width() - 10;
					var window_height = $(window).height() - 10;
					$("#adminviewport").jqxSplitter({ theme: 'black', width: window_width, height: window_height, panels:
						[
							{ size: "10%", min: "5%"},
							{ size: '90%', min: "40%"}
						] });
					$('#adminTree').jqxTree({ theme: 'black', height: '100%', width: '100%' });
					$('#adminTree').on('select', function (event) {
						console.log(event);
						$('#contentPanel').html("<div style='margin: 10px;'>" +	event.args.element.id + "</div>");
					});
				});
			</script>
		{/literal}
	{$page->head}
	</head>

	<body class="black">
	<div id="content">

	<div id="adminviewport">
		<div id="sidebar">
			{$admin_menu}
		</div>
		<div style='margin: 10px;' id="contentPanel">{$page->content}</div>
	</div>
	</div>
		{if $site->google_analytics_acc != ''}
			{literal}
				<script>
				/* <![CDATA[ */
				  var _gaq = _gaq || [];
				  _gaq.push(['_setAccount', '{/literal}{$site->google_analytics_acc}{literal}']);
				  _gaq.push(['_trackPageview']);
				  _gaq.push(['_trackPageLoadTime']);

				  (function() {
					var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
					ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
					var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
				  })();
				/* ]]> */
				</script>
			{/literal}
		{/if}
		{literal}
		<script type="text/javascript">
			var WWW_TOP = "{$smarty.const.WWW_TOP}/..";
			$('.top-nav').children().children('select').bind('change', function () {
				$("html, body").animate({scrollTop: $('#' + $(this).val()).offset().top}, "slow");
			});
		</script>
		{/literal}
	</body>
</html>
