<?php
require_once './config.php';

$page = new AdminPage();
$xxx = new XXX(['Settings' => $page->settings]);
if (isset($_GET['action'])) {
	switch ($_GET['action']) {
		case "list":
			$xxxcount = $xxx->getCount();
			$offset = $_REQUEST["pagenum"] * $_REQUEST["pagesize"];
			if ($offset == 0) {
				$offset = 10;
			}
			$pagesize = isset($_REQUEST["pagesize"]) ? $_REQUEST["pagesize"] : ITEMS_PER_PAGE;
			$xxxmovielist = $xxx->getRange($offset, $pagesize);
			foreach ($xxxmovielist as $key => $mov) {
				$xxxmovielist[$key]['hastrailer'] = (!empty($mov['trailers'])) ? 1 : 0;
				$xxxmovielist[$key]['trailer'] = (!empty($mov['trailers'])) ? unserialize($mov['trailers']) : 0;
				if ($xxxmovielist[$key]['hastrailer'] == 1) {
					$xxxmovielist[$key]['trailers'] = $xxxmovielist[$key]['trailer']['url'];
				}
				if (stristr($mov['genre'], ",")) {
					$arr = explode(",", $mov['genre']);
					foreach ($arr as $k => $value) {
						$tmp = $xxx->getGenres(true, $value);
						$ret[$key] = array('id' => $value, 'title' => $tmp['title']);
					}
					$xxxmovielist[$key]['genre'] = $ret;
				} else if (!empty($mov['genre'])) {
					$tmp = $xxx->getGenres(true, $value);
					$xxxmovielist[$key]['genre'] = array('id' => $value, 'title' => $tmp['title']);
				} else {
					$xxxmovielist[$key]['genre'] = "Unknown";
				}

				if (stristr($mov['actors'], ",")) {
					$xxxmovielist[$key]['actors'] = explode(",", $mov['actors']);
				}
			}
			$data[] = array(
				'TotalRows' => $xxxcount,
				'results' => $xxxmovielist
			);
			echo json_encode($data);
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
			$returnData = json_encode(array("success" => true, "id" => $id));
			print($returnData);
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
	exit;
}

