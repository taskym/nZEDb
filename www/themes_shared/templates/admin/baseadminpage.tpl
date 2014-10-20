<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>{$page->meta_title}{if $site->metatitle != ""} - {$site->metatitle}{/if}</title>
		<meta name="keywords" content="{$page->meta_keywords}{if $site->metakeywords != ""},{$site->metakeywords}{/if}">
		<meta name="description" content="{$page->meta_description}{if $site->metadescription != ""} - {$site->metadescription}{/if}">
		<meta name="application-name" content="nZEDb-v{$site->version}">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="{$smarty.const.WWW_TOP}/../themes_shared/images/favicon.ico">
		<link rel="stylesheet" href="{$smarty.const.WWW_TOP}/../themes_shared/styles/layout/jqx.base.css" type="text/css" />
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/jquery-2.0.2.min.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/themestyles.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqxcore.js"></script>
		<script type="text/javascript" src="{$smarty.const.WWW_TOP}/../themes_shared/scripts/layout/jqx-all.js"></script>
		{literal}
			<style type="text/css">
			html, body {
					height: 100%;
					width: 100%;
					margin: 0px;
					padding: 0px;
				}
			</style>
		{/literal}
	{$page->head}
	</head>

	<body class="default">
		<div style="position: fixed; width: 100%; height: 30px;">
				{$admin_menu}
		</div>
			<div style='margin: 3px; width: 100%; height: 100%; padding-top: 30px;' id="contentPanel">
			{$page->content}
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
			$(document).ready(function () {
				initthemes("/admin/../themes_shared/styles/layout/jqx.");
				$("#adminMenu").jqxMenu({ theme: theme, showTopLevelArrows: true, width: '100%', height: '30px'});
                $("#adminMenu").css('visibility', 'visible');
				$("#adminMenu").css('position', 'absolute');
				$('.top-nav').on('select').bind('change', function () {
					$("html, body").animate({scrollTop: $('#' + $(this).val()).offset().top}, "slow");
				});
			});
		/*
		$('#themelist').jqxDropDownList({ selectedIndex: 0, width: 'auto', height: '30px', theme: theme });
		 */
		</script>
		{/literal}
	</body>
</html>
