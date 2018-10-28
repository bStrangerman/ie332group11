<?php session_start();

$dbhost = "localhost"; // this will ususally be 'localhost', but can sometimes differ
$dbname = "ie332group11"; // the name of the database that you are going to use for this project
$dbuser = "root"; // the username that you created, or were given, to access your database
$dbpass = ""; // the password that you created, or were given, to access your database

$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

mysqli_connect($dbhost, $dbuser, $dbpass) or die("MySQL Error: " . mysqli_error());
mysqli_select_db($conn, $dbname) or die("MySQL Error: " . mysqli_error());
?>
