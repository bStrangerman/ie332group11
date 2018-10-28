<?php
	// session_start();
	include "db.php";

	require_once 'PhpRbac/src/PhpRbac/Rbac.php';
	$rbac = new \PhpRbac\Rbac();

	if (!isset($_SESSION['username'])) {
		$_SESSION['msg'] = "You must log in first";
		header('location: login.php');
	}

	if (isset($_GET['logout'])) {
		session_destroy();
		unset($_SESSION['username']);
		header("location: login.php");
	}

?>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<div class="header">
		<h2>Home Page</h2>
		<?php echo $_SESSION['UserID']; ?>
	</div>
	<div class="content">

		<!-- notification message -->
		<?php
		if (isset($_SESSION['success'])) : ?>
			<div class="error success" >
				<h3>
					<?php
						echo $_SESSION['success'];
						unset($_SESSION['success']);
					?>
				</h3>
			</div>
		<?php endif ?>

		<!-- logged in user information -->
		<?php  if (isset($_SESSION['username'])) : ?>
			<p>Welcome <strong><?php echo $_SESSION['username']; ?></strong></p>
			<?php
			$allroles = $rbac->Users->allRoles($UserID = $_SESSION['UserID']);
			$i = 0;
			echo "<h2>You have the following roles: </h2>";
			while($i < count($allroles)){
			  echo "<h3>" . $allroles[$i]['ID'] . "</h3>";
			  $i++;
			}
			?>
			<p> <a href="index.php?logout='1'" style="color: red;">logout</a> </p>
		<?php endif ?>
	</div>

</body>
</html>
