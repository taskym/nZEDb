<?php
require_once './config.php';

$page = new AdminPage();
$category = new Category(['Settings' => $page->settings]);

$page->title = "Category List";

$page->content = $page->smarty->fetch('categories.tpl');
$page->render();
