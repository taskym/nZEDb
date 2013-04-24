<?php
require_once(WWW_DIR."/lib/books.php");
require_once(WWW_DIR."/lib/category.php");

$book = new Books;
$cat = new Category;

if (!$users->isLoggedIn())
	$page->show403();


$boocats = $cat->getChildren(Category::CAT_PARENT_BOOKS);
$btmp = array();
foreach($boocats as $bcat) {
	$btmp[$bcat['ID']] = $bcat;
}
$category = Category::CAT_PARENT_BOOKS;
if (isset($_REQUEST["t"]) && array_key_exists($_REQUEST['t'], $btmp))
	$category = $_REQUEST["t"] + 0;
	
$catarray = array();
$catarray[] = $category;	

$page->smarty->assign('catlist', $btmp);
$page->smarty->assign('category', $category);

$browsecount = $book->getBookCount($catarray, -1, $page->userdata["categoryexclusions"]);

$offset = (isset($_REQUEST["offset"]) && ctype_digit($_REQUEST['offset'])) ? $_REQUEST["offset"] : 0;
$ordering = $book->getBookOrdering();
$orderby = isset($_REQUEST["ob"]) && in_array($_REQUEST['ob'], $ordering) ? $_REQUEST["ob"] : '';

$results = $books = array();
$results = $book->getBookRange($catarray, $offset, ITEMS_PER_PAGE, $orderby, -1, $page->userdata["categoryexclusions"]);

$maxwords = 50;
foreach($results as $result) {	
	if (!empty($result['review'])) {
		$words = explode(' ', $result['review']);
		if (sizeof($words) > $maxwords) {
			$newwords = array_slice($words, 0, $maxwords);
			$result['review'] = implode(' ', $newwords).'...';	
		}
	}
	$books[] = $result;
}

$author = (isset($_REQUEST['author']) && !empty($_REQUEST['author'])) ? stripslashes($_REQUEST['author']) : '';
$page->smarty->assign('author', $author);

$title = (isset($_REQUEST['title']) && !empty($_REQUEST['title'])) ? stripslashes($_REQUEST['title']) : '';
$page->smarty->assign('title', $title);

$browseby_link = '&amp;title='.$title.'&amp;author='.$author;

$page->smarty->assign('pagertotalitems',$browsecount);
$page->smarty->assign('pageroffset',$offset);
$page->smarty->assign('pageritemsperpage',ITEMS_PER_PAGE);
$page->smarty->assign('pagerquerybase', WWW_TOP."/books?t=".$category.$browseby_link."&amp;ob=".$orderby."&amp;offset=");
$page->smarty->assign('pagerquerysuffix', "#results");

$pager = $page->smarty->fetch($page->getCommonTemplate("pager.tpl"));
$page->smarty->assign('pager', $pager);

if ($category == -1)
	$page->smarty->assign("catname","All");			
else
{
	$cat = new Category();
	$cdata = $cat->getById($category);
	if ($cdata)
		$page->smarty->assign('catname',$cdata["title"]);			
	else
		$page->show404();
}

foreach($ordering as $ordertype) 
	$page->smarty->assign('orderby'.$ordertype, WWW_TOP."/books?t=".$category.$browseby_link."&amp;ob=".$ordertype."&amp;offset=0");

$page->smarty->assign('results',$books);		

$page->meta_title = "Browse Books";
$page->meta_keywords = "browse,nzb,books,description,details";
$page->meta_description = "Browse for Books";
	
$page->content = $page->smarty->fetch('books.tpl');
$page->render();

?>
