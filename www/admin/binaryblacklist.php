<?php
require_once './config.php';

$page = new AdminPage();

$page->title = "Binary Black/Whitelist List";

$page->content = $page->smarty->fetch('binaryblacklist.tpl');
$page->render();
