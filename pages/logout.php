<?php
// logs the user out and destroys all the session data
session_destroy();
// remove all session variables
session_unset(); 

header("location: contractList.php");
?>
