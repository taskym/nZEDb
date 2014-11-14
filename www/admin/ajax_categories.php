<?php
require_once './config.php';

$page = new AdminPage();
$category = new Category(['Settings' => $page->settings]);
$id = 0;

// Set the current action.
$action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'list';

switch($action) {
	case 'list':
		$returnData = json_encode($category->getFlat());
	break;
	case 'edit':
		$status = $_POST['status'] == "true" ? 1 : 0;
		$disablepreview = $_POST['disablepreview'] == "true" ? 1 : 0;
		$ret = $category->update($_POST["id"], $status, $_POST["description"], $disablepreview, $_POST["minsize"]);
		$returnData = json_encode(["success" => true, "message" => "Category Saved.."]);
	break;
}
print($returnData);
