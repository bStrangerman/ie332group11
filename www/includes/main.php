<?php
// Include the main files needed for most pages.
require_once "db.php";
require_once 'PhpRbac/src/PhpRbac/Rbac.php';
include_once "timeago.php";

// Configure Role Based Access Control
$rbac = new \PhpRbac\Rbac();
// Setup Timezone
date_default_timezone_set('America/New_York');

include_once 'sanitize.php';
include_once "rankingFunctions.php";
include_once "contracts.php";
include_once "notifications.php";
require_once "server.php";
?>
