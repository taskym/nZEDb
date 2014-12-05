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
		$settings = (array)$settings;
		$newsettings = explode(",", $settings['fix_crap']);
		$newsettings = array_map('trim', $newsettings);
		foreach ($newsettings as $key => $value) {
		$tempsettings[$key]['name'] = $value;
		$tempsettings[$key]['checked'] = true;
		};
		$settings['fix_crap'] = $tempsettings;
		print (json_encode($settings));
		break;
	default:
		$page->title = "Tmux Settings Edit";
		$page->content = $page->smarty->fetch('tmux-edit.tpl');
		$page->render();
}
