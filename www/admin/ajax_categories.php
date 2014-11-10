<?php
require_once './config.php';

$page = new AdminPage();
$category = new Category(['Settings' => $page->settings]);
$id = 0;

// Set the current action.
$action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'list';

switch($action) {
	case 'list':
	$returnData = $category->getFlat();
	print (json_encode($returnData));
	break;
	case 'submit':
		$ret = $category->update($_POST["id"], $_POST["status"], $_POST["description"], $_POST["disablepreview"], $_POST["minsize"]);
		break;

	case 'view':
	default:
		if (isset($_GET["id"])) {
			$page->title = "Category Edit";
			$id = $_GET["id"];
			$cat = $category->getByID($id);
			$page->smarty->assign('category', $cat);
		}
		break;
}
