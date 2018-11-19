<?php
include "db.php";
require_once 'PhpRbac/src/PhpRbac/Rbac.php';
include_once 'sanitize.php';
$rbac = new \PhpRbac\Rbac();
date_default_timezone_set('America/New_York');

?>
