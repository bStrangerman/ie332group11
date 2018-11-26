<?php
include "db.php";
require_once 'PhpRbac/src/PhpRbac/Rbac.php';
include_once 'sanitize.php';
include "rankingFunctions.php";
include_once "contracts.php";

$rbac = new \PhpRbac\Rbac();
date_default_timezone_set('America/New_York');

if(isset($_SESSION['username']) && isset($_COOKIE['username'])){
  if($_COOKIE['username'] != md5($_SESSION['username']))
    setcookie("username", md5($_SESSION['username']), time() + (86400 * 30), "/"); // 86400 = 1 day
}
?>
<script>

window.onload = getLocation;

var geo = navigator.geolocation;     /*     Here we will check if the browser supports the Geolocation API; if exists, then we will display the location     */

function getLocation() {
  if( geo ) {
    geo.getCurrentPosition( displayLocation );
  }
  else  { alert( "Oops, Geolocation API is not supported");
}
}

/*     This function gets the latitude and longitude when the browser has a location.     */
function displayLocation( position ) {
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  <?php if(!isset($_COOKIE['Latitude'])){ ?>
    document.cookie = "Latitude=" + latitude;
  <?php }
  if(!isset($_COOKIE['Longitude'])) {?>
    document.cookie = "Longitude=" + longitude;
    <?php } ?>
}
</script>


<?php

?>
