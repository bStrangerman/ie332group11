<?php
// Include the main files needed for most pages.
require_once "db.php";
require_once 'PhpRbac/src/PhpRbac/Rbac.php';

include_once "timeago.php";
// Configure Role Based Access Control
$rbac = new \PhpRbac\Rbac();
// Setup Timezone
date_default_timezone_set('America/New_York');
// if the user is loggged in
if(isset($_SESSION['username'])){
  // if the cookie is set
  if(isset($_COOKIE['username'])){
    // is the username identical to the cookie
    if($_COOKIE['username'] != md5($_SESSION['username'])){
      // Set the cookie to be md5 hashed for security
      setcookie("username", md5($_SESSION['username']), time() + (86400), "/"); // 86400 = 1 day
    }
  }
}
include_once 'sanitize.php';
include_once "rankingFunctions.php";
include_once "contracts.php";
include_once "notifications.php";
require_once "server.php";
?>
