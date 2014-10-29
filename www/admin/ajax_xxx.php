<?php
require_once './config.php';

$page = new AdminPage();
$xxx = new XXX(['Settings' => $page->settings]);
if (isset($_GET['action'])) {
	switch ($_GET['action']) {
		case "list":
			$xxxcount = $xxx->getCount();
			$offset = isset($_REQUEST["offset"]) ? $_REQUEST["offset"] : 0;
			$xxxmovielist = $xxx->getRange($offset, ITEMS_PER_PAGE);
			foreach ($xxxmovielist as $key => $mov) {
				$xxxmovielist[$key]['hastrailer'] = (!empty($mov['trailers'])) ? 1 : 0;
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
				'totalrows' => (int)$xxxcount,
				'results' => $xxxmovielist
			);
			$returnData = json_encode($data);
			print($returnData);
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
}

