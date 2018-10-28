<?php
session_destroy();
unset($_SESSION['username']);
unset($_SESSION['UserID']);
header("location: login.php");
?>
