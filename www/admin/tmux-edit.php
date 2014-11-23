<?php
require_once './config.php';

$page = new AdminPage();
$tmux = new Tmux();
$id = 0;

// Set the current action.
$action = $_REQUEST['action'];

switch($action) {
	case 'submit':
		//$ret = $tmux->update(json_decode($_POST));
		print (json_encode(array("success" => true, "message" => "Tmux Settings Saved")));
		break;
	case 'view':
		$settings = $tmux->get();
		print (json_encode($settings));
		break;
	default:
		$page->title = "Tmux Settings Edit";
		$page->smarty->assign('yesno_ids', array(1, 0));
$page->smarty->assign('yesno_names', array('yes', 'no'));
$page->smarty->assign('backfill_ids', array(0,4,2,1));
$page->smarty->assign('backfill_names', array('Disabled', 'Safe', 'Group', 'All'));
$page->smarty->assign('backfill_days', array('Days per Group', 'Safe Backfill day'));
$page->smarty->assign('backfill_days_ids', array(1,2));
$page->smarty->assign('dehash_ids', array(0,1,2,3));
$page->smarty->assign('dehash_names', array('Disabled', 'Decrypt Hashes', 'Predb', 'All'));
$page->smarty->assign('import_ids', array(0,1,2));
$page->smarty->assign('import_names', array('Disabled', 'Import - Do Not Use Filenames', 'Import - Use Filenames'));
$page->smarty->assign('releases_ids', array(0,1,2));
$page->smarty->assign('releases_names', array('Disabled', 'Update Releases', 'Update Releases Threaded'));
$page->smarty->assign('post_ids', array(0,1,2,3));
$page->smarty->assign('post_names', array('Disabled', 'PostProcess Additional', 'PostProcess NFOs', 'All'));
$page->smarty->assign('fix_crap_radio_ids', array('Disabled', 'All', 'Custom'));
$page->smarty->assign('fix_crap_radio_names', array('Disabled', 'All', 'Custom'));
$page->smarty->assign('fix_crap_check_ids', array('blacklist', 'blfiles', 'executable', 'gibberish', 'hashed', 'installbin', 'passworded', 'passwordurl', 'sample', 'scr', 'short', 'size', 'huge', 'codec'));
$page->smarty->assign('fix_crap_check_names', array('blacklist', 'blfiles', 'executable', 'gibberish', 'hashed', 'installbin', 'passworded', 'passwordurl', 'sample', 'scr', 'short', 'size', 'huge', 'codec'));
$page->smarty->assign('sequential_ids', array(0,1,2));
$page->smarty->assign('sequential_names', array('Disabled', 'Basic Sequential', 'Complete Sequential'));
$page->smarty->assign('binaries_ids', array(0,1,2));
$page->smarty->assign('binaries_names', array('Disabled', 'Simple Threaded Update', 'Complete Threaded Update'));
$page->smarty->assign('post_non_ids', array(0,1,2));
$page->smarty->assign('post_non_names', array('Disabled', 'All Available Releases', 'Properly Renamed Releases'));

$page->content = $page->smarty->fetch('tmux-edit.tpl');

		$page->render();
		//$page->smarty->assign('ftmux', $settings);
}
