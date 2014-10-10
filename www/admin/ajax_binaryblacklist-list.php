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
			$id = (int)$_GET['bin_id'];
			$bin->deleteBlacklist($id);
			print "Blacklist $id deleted.";
			break;
		default:
			return "error";
	}
}
