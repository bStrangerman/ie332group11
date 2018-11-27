<?php
// include the database and authentication information
require_once "../includes/main.php";

// is the user signed in
if(isset($_SESSION['UserID'])){
  // Is the user id not NULL
  if($_SESSION['UserID'] != ""){
    // redirects to account_setup if user has the need setup role
    if($rbac->Users->hasRole('need_setup', $UserID = $_SESSION['UserID'])){
      header('Location: account_setup.php');
      exit;
    }
    // redirects to other pages otherwise
    else{
      // is the redirect session variable set?
      if(isset($_SESSION['redirect']) && $_SESSION['redirect'] != ""){
        $redirect = $_SESSION['redirect'];
        $_SESSION['redirect'] = "";
        unsset($_SESSION['redirect']);
        header($redirect);
        exit;
      }
      // redirect to index.php
      else {
        header('Location: index.php');
        exit;
      }
    }
  }
}
?>
<!-- The below code was found on https://codepen.io/Gibbu/pen/mxGKjP and modified -->
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="../includes/css/login.css">
  <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
  <script src="../includes/js/login.js"></script>
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

        <!-- Forget Password tab -->
        <form id="forgot" class="contentArea otherForm">
          <!-- Forget Password feature is not currently working -->
          <!-- <div class="formHead">
          <h1>Forgot Password?</h1>
          <p>Looks like you forgot your password</p>
        </div>
        <label class="formDiv">
        <input type="email" placeholder=" " required>
        <p>Type your Email</p>
        <span class="border"></span>
      </label>
    -->
    <div class="formDiv">
      <input type="submit" value="Send">
    </div>
    <footer>
      <p class="forgotBtn">Back to Login</p>
    </footer>
  </form>

  <!-- Registration tab -->
  <form id="register" class="contentArea otherForm" method="post" action="login.php">
    <div class="formHead">
      <h1>Become a member!</h1>
      <p>Register now</p>
    </div>
    <?php
    include_once('../includes/errors.php');
    if(isset($register_Errors))
    errors($register_Errors); ?>
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

  <!-- Login tab -->
  <form class="contentArea" id="login" method="post" action="login.php">
    <div class="formHead">
      <h1>WELCOME BACK</h1>
      <p>Login to continue</p>
    </div>
    <?php
    include_once('../includes/errors.php');
    if(isset($login_Errors))
    errors($login_Errors); ?>
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
