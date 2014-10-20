<?php
require_once './config.php';

$page = new AdminPage();
$xxxmovie = new XXX(['Settings' => $page->settings]);

$page->title = "XXX Movie List";
$page->content = $page->smarty->fetch('xxx.tpl');
$page->render();
