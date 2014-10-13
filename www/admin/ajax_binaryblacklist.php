<?php
require_once './config.php';

// Login Check
$admin = new AdminPage;
$bin = new Binaries(['Settings' => $admin->settings]);
if (isset($_GET['action'])) {
	switch ($_GET['action']) {
		case "list":
			echo json_encode($bin->getBlacklist(false));
			break;
		case "delete":
			$id = (int)$_GET['id'];
			$bin->deleteBlacklist($id);
			$returnData = json_encode(array("success" => true, "id" => $id));
			print ($returnData);
			break;
		case "update":
			$id = (int)$_GET['id'];
			$ret = $bin->updateBlacklist($_POST);
			break;
		case "add":
			$id = $bin->addBlacklist($_POST);
			$gridRowID = $_GET['rowid'];
			$returnData = json_encode(array("id" => $id, "rowid" => $gridRowID));
			print ($returnData);
			break;
		default:
			print "Error: No Command Given";
	}
}
