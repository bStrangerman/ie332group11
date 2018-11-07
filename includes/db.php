<?php session_start();

// set the credentials for MySQL
<<<<<<< HEAD
$dbhost = "localhost"; // this will ususally be 'localhost', but can sometimes differ
$dbname = "new11"; // the name of the database that you are going to use for this project
$dbuser = "root"; // the username that you created, or were given, to access your database
$dbpass = ""; // the password that you created, or were given, to access your database
=======
$dbhost = "mydb.itap.purdue.edu"; // this will ususally be 'localhost', but can sometimes differ
$dbname = "bhaberma"; // the name of the database that you are going to use for this project
$dbuser = "bhaberma"; // the username that you created, or were given, to access your database
$dbpass = "Haberman2o!8"; // the password that you created, or were given, to access your database
>>>>>>> d7633af48edaa5fe35b3dca91cbb5c4b9c6d2844

// creates the connection to the database
$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

// connects to the database or prints connection error
mysqli_connect($dbhost, $dbuser, $dbpass) or die("MySQL Error: " . mysqli_error());
mysqli_select_db($conn, $dbname) or die("MySQL Error: " . mysqli_error());
?>
