<?php
// logs the user out and destroys all the session data
session_destroy();
unset($_SESSION['username']);
unset($_SESSION['UserID']);
unset($_SESSION['email']);
header("location: login.php");
?>
