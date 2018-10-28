<?php include('server.php');
require_once 'PhpRbac/src/PhpRbac/Rbac.php';
$rbac = new \PhpRbac\Rbac();

if(isset($_SESSION['UserID'])){
  if($rbac->Users->roleCount($UserID = $_SESSION['UserID'])){
    if($rbac->Users->hasRole('need_setup', $UserID = $_SESSION['UserID'])){
      header('Location: account_setup.php');
    }
    else{
      header('Location: index.php');
    }
  }
}

?>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="css/login.css">
  <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
  <script src="js/login.js"></script>
</head>
<body>

<!-- https://codepen.io/Gibbu/pen/mxGKjP -->
<!-- JQUERY AND NORMALIZED CSS INSTALLED
View settings for more info. -->

<div id="formContainer">
	<div id="form">
		<div id="formLeft" class="f">
			<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/At_sign.svg/768px-At_sign.svg.png" alt="Avatar Picture">
			<h2>@Capacity</h2>
		</div>
		<div id="formRight">
			<form id="forgot" class="contentArea otherForm">
				<!-- <div class="formHead">
					<h1>Forgot Password?</h1>
					<p>Looks like you forgot your password</p>
				</div>
				<label class="formDiv">
					<input type="email" placeholder=" " required>
					<p>Type your Email</p>
					<span class="border"></span>
				</label>
				<div class="formDiv">
					<input type="submit" value="Send">
				</div> -->
        <div class="formDiv">
          <h1>This feature is<br> Work in Progress</h1>
        </div>
        <footer>
					<p class="forgotBtn">Back to Login</p>
				</footer>
			</form>
			<form id="register" class="contentArea otherForm" method="post" action="login.php">
        <?php include('errors.php'); ?>
				<div class="formHead">
					<h1>Join</h1>
					<p>Register now</p>
				</div>
				<label class="formDiv">
					<input type="text" placeholder=" " value="<?php echo $username; ?>" name="username">
					<p>Username</p>
					<span class="border"></span>
				</label>
				<label class="formDiv">
					<input type="email" placeholder=" " value="<?php echo $email; ?>" name="email">
					<p>Email</p>
					<span class="border"></span>
				</label>
				<label class="formDiv">
					<input type="password" placeholder=" " name="password">
					<p>Password</p>
					<span class="border"></span>
				</label>
				<div class="formDiv">
					<input type="submit" name="reg_user" value="Register">
				</div>
				<footer>
					<p class="registerBtn">Back to login</p>
				</footer>
			</form>
			<form class="contentArea" id="login" method="post" action="login.php">
        <div class="formHead">
					<h1>WELCOME BACK</h1>
					<p>Login to continue</p>
				</div>
        <?php include('errors.php'); ?>
				<label class="formDiv">
					<input type="text" placeholder=" " name="username" required>
					<p>Username</p>
					<span class="border"></span>
				</label>
				<label class="formDiv">
					<input type="password" placeholder=" " name="password" required>
					<p>Password</p>
					<span class="border"></span>
				</label>
				<div class="formDiv">
					<input type="submit" name="login_user" value="Login">
				</div>
				<footer>
					<p class="forgotBtn">Forgot password</p>
					<p class="registerBtn">Need an Account?</p>
				</footer>
			</form>
		</div>
	</div>
</div>
</body>
</html>
