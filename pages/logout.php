<?php
// logs the user out and destroys all the session data
session_destroy();

unset($_SESSION['UserID']);
// remove all session variables
session_unset();

header("location: index.php");
?>
