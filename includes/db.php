<?php session_start();

// set the credentials for MySQL
$dbhost = "mydb.itap.purdue.edu"; // this will ususally be 'localhost', but can sometimes differ
$dbname = "bhaberma"; // the name of the database that you are going to use for this project
$dbuser = "bhaberma"; // the username that you created, or were given, to access your database
$dbpass = "Haberman2o!8"; // the password that you created, or were given, to access your database

// creates the connection to the database
$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

// connects to the database or prints connection error
mysqli_connect($dbhost, $dbuser, $dbpass) or die("MySQL Error: " . mysqli_error());
mysqli_select_db($conn, $dbname) or die("MySQL Error: " . mysqli_error());
?>
