<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="login.css">
  <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
  <script src="login.js"></script>
</head>
<body>

<!-- https://codepen.io/Gibbu/pen/mxGKjP -->
<!-- JQUERY AND NORMALIZED CSS INSTALLED
View settings for more info. -->

<div id="formContainer">
	<div id="form">
		<div id="formLeft" class="f">
			<img src="https://pbs.twimg.com/profile_images/1044222938474397696/TtNO9cun_400x400.jpg" alt="Avatar Picture">
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
			<form id="register" class="contentArea otherForm">
				<div class="formHead">
					<h1>Join</h1>
					<p>Register now</p>
				</div>
				<label class="formDiv">
					<input type="text" placeholder=" ">
					<p>Username</p>
					<span class="border"></span>
				</label>
				<label class="formDiv">
					<input type="email" placeholder=" ">
					<p>Email</p>
					<span class="border"></span>
				</label>
				<label class="formDiv">
					<input type="password" placeholder=" ">
					<p>Password</p>
					<span class="border"></span>
				</label>
				<div class="formDiv">
					<input type="submit" value="Register">
				</div>
				<footer>
					<p class="registerBtn">Back to login</p>
				</footer>
			</form>
			<form class="contentArea" id="login">
				<div class="formHead">
					<h1>WELCOME BACK</h1>
					<p>Login to continue</p>
				</div>
				<label class="formDiv">
					<input type="text" placeholder=" " required>
					<p>Username</p>
					<span class="border"></span>
				</label>
				<label class="formDiv">
					<input type="password" placeholder=" " required>
					<p>Password</p>
					<span class="border"></span>
				</label>
				<div class="formDiv">
					<input type="submit" value="Login">
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
