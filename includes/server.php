<?php

	// database and user authentication includes
require_once "main.php";

// variable declaration
	$register_Errors = array();

	// connect to database
	$db = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);

	// REGISTER USER
	if (isset($_POST['reg_user'])) {
		// receive all input values from the form
		$username = clean($_POST['username']);
		$email = clean($_POST['email']);
		$psswd = clean($_POST['password']);

		// form validation: ensure that the form is correctly filled
		if (empty($username)) { array_push($register_Errors, "Username is required"); }
		if (empty($email)) { array_push($register_Errors, "Email is required"); }
		if (empty($psswd)) { array_push($register_Errors, "Password is required"); }

		// Check if Username and email is taken
		$countOfUsername = "SELECT COUNT(*) AS count
							FROM phprbac_users
							WHERE username = '$username'";

		$countOfEmail = "SELECT COUNT(*) AS count
							FROM phprbac_users
							WHERE email = '$email'";

		$countUsernameResult = ($conn -> query($countOfUsername)) -> fetch_assoc();

		$countEmailResult = ($conn -> query($countOfEmail)) -> fetch_assoc();
		if ($countUsernameResult['count'] > 0) { array_push($register_Errors, "Username is taken"); }
		if ($countEmailResult['count'] > 0) { array_push($register_Errors, "Email is already being used"); }

		// register user if there are no errors in the form
		if (count($register_Errors) == 0) {
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
		$username = clean($_POST['username']);
		$password = clean($_POST['password']);

		$login_Errors = array();

		// double validates the user information is provided
		if (empty($username)) {
			array_push($login_Errors, "Username is required");
		}
		if (empty($password)) {
			array_push($login_Errors, "Password is required");
		}

		// validates the user is in the database and logs in the user
		if (count($login_Errors) == 0) {
			$password = md5($password);
			$query = "SELECT * FROM phprbac_users WHERE Username='$username' AND Password='$password'";
			$result = $conn -> query($query);

			if ($result->num_rows == 1) {
				$_SESSION['username'] = $username;
				while($row = $result -> fetch_assoc()){
					$UserID = $row['UserID'];
					$_SESSION['UserID'] = $UserID;
					setcookie("username", $username, time() + 60 * 60 * 24);
					setcookie("UserID", $UserID, time() + 60 * 60 * 24);
					$_SESSION['email'] = $row['Email'];
				}
				$_SESSION['success'] = "You are now logged in";
				header("Location: login.php");
			}
			else {
				array_push($login_Errors, "Wrong username/password combination");
			}
		}
	}
?>
