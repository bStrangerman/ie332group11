<?php

	// database and user authentication includes
	include "db.php";
	require_once 'PhpRbac/src/PhpRbac/Rbac.php';
	$rbac = new \PhpRbac\Rbac();

	// variable declaration
	$username = "";
	$email    = "";
	$errors = array();
	$_SESSION['success'] = "";
	$_SESSION['UserID'] = "";

	// connect to database
	$db = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

	// REGISTER USER
	if (isset($_POST['reg_user'])) {
		// receive all input values from the form
		$username = mysqli_real_escape_string($db, $_POST['username']);
		$email = mysqli_real_escape_string($db, $_POST['email']);
		$psswd = mysqli_real_escape_string($db, $_POST['password']);

		// form validation: ensure that the form is correctly filled
		if (empty($username)) { array_push($errors, "Username is required"); }
		if (empty($email)) { array_push($errors, "Email is required"); }
		if (empty($psswd)) { array_push($errors, "Password is required"); }

		// register user if there are no errors in the form
		if (count($errors) == 0) {
			$psswd_insert = md5($psswd);//encrypt the password before saving in the database
			$query = "INSERT INTO phprbac_users (username, email, password)
					  VALUES('$username', '$email', '$psswd_insert')";

			// get the User ID from the newest user
			if(mysqli_query($db, $query)){
			  $_SESSION['UserID'] = mysqli_insert_id($db);
			};

			// assign temporary role to new users
			$rbac->Users->assign('need_setup', $UserID = $_SESSION['UserID']);

			// sets the user information into the session
			$_SESSION['username'] = $username;
			$_SESSION['email'] = $email;
			$_SESSION['success'] = "You are now logged in"	;
			header('location: account_setup.php');  // redirects to the account setup page
		}
	}

	// LOGIN USER
	if (isset($_POST['login_user'])) {
		$username = mysqli_real_escape_string($db, $_POST['username']);
		$password = mysqli_real_escape_string($db, $_POST['password']);

		// validates the user information is provided
		if (empty($username)) {
			array_push($errors, "Username is required");
		}
		if (empty($password)) {
			array_push($errors, "Password is required");
		}

		// validates the user is in the database and logs in the user
		if (count($errors) == 0) {
			$password = md5($password);
			$query = "SELECT * FROM phprbac_users WHERE username='$username' AND password='$password'";
			$results = mysqli_query($db, $query);


			if (mysqli_num_rows($results) == 1) {
				$_SESSION['username'] = $username;
				while($rows = $results -> fetch_assoc()){
					$_SESSION['UserID'] = $rows['UserID'];
					$_SESSION['email'] = $rows['email'];
				}
				$_SESSION['success'] = "You are now logged in";
				header('location: index.php');
			}
			else {
				array_push($errors, "Wrong username/password combination");
			}
		}
	}
?>
