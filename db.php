<?php session_start();

$dbhost = "mydb.itap.purdue.edu"; // this will ususally be 'localhost', but can sometimes differ
$dbname = "g1090432"; // the name of the database that you are going to use for this project
$dbuser = "g1090432"; // the username that you created, or were given, to access your database
$dbpass = "@Capacity332"; // the password that you created, or were given, to access your database

$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

mysqli_connect($dbhost, $dbuser, $dbpass) or die("MySQL Error: " . mysqli_error());
mysqli_select_db($conn, $dbname) or die("MySQL Error: " . mysqli_error());
?>
