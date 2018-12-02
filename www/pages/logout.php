<?php
session_start();
// logs the user out and destroys all the session data
unset($_SESSION['UserID']);
// remove all session variables
session_unset();
session_destroy();

header("location: index.php");
?>
