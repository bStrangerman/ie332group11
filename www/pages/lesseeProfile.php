<?php
require_once "../includes/main.php";

// checks if logged in
if(!isset($_SESSION['UserID'])){
  $_SESSION['redirect'] = 'Location: lesseeAccount.php';
  header("Location: login.php");
}
else if (!$rbac->check('can_lease', $UserID = $_SESSION['UserID'])){
  echo "You don't have the proper permissions to lease a location. This page will redirect in 10 seconds.";
  header("Refresh: 10; index.php");
  exit;
}
else{
  $UserID = $_SESSION['UserID'];
}

// get user info
$sql = "SELECT *
        FROM phprbac_users
        WHERE phprbac_users.UserID = $UserID";
$result = $conn -> query($sql);
while($LesseeInfo[]=mysqli_fetch_array($result));


if(isset($_POST['editing'])){
  if($_POST['editing'] == 'profile'){
    $firstname = clean($_POST['first-name']);
    $lastname = clean($_POST['last-name']);
    $email = clean($_POST['Email']);
    $phonenumber = clean($_POST['PhoneNumber']);
    $company = clean($_POST['Company']);
    $sql = "UPDATE phprbac_users
            SET FirstName = '$firstname', LastName = '$lastname', Email = '$email', PhoneNumber = $phonenumber, Company = '$company'
            WHERE UserID = $UserID";
    if($conn -> query($sql) === TRUE){
      $_SESSION['message'] = "Success!";
      header("Refresh: 0.1");
      $_SESSION['message'] = "Success!";
    }
  }
  if($_POST['editing'] == 'password'){
    if(md5(clean($_POST['current-password'])) == $LesseeInfo[0]['Password']){
      $newPassword = md5(clean($_POST['new-password']));
      $sql = "UPDATE phprbac_users
              SET Password = '$newPassword'
              WHERE UserID = $UserID";
      if($conn -> query($sql) === TRUE){
        $_SESSION['message'] = "Success!";
        header("Refresh: 0.1");
        $_SESSION['message'] = "Success!";
      }
    }
  }
}


// print the header
require_once "../layouts/Calssimax/header.php";


?><!--==================================
=            User Profile            =
===================================-->

<section class="user-profile section">
	<div class="container">
		<div class="row">
			<div class="col-md-10 offset-md-1 col-lg-4 offset-lg-0">
				<div class="sidebar">
					<!-- User Widget -->
					<div class="widget user-dashboard-profile">
            <!-- User Image -->
						<!-- <div class="profile-thumb">
							<img src="images/user/user-thumb.jpg" alt="" class="rounded-circle">
						</div> -->
						<!-- User Name -->
						<h5 class="text-center"><?php echo $LesseeInfo[0]['FirstName'] . " " . $LesseeInfo[0]['LastName']; ?></h5>
						<p>Joined <?php echo date("F d, Y" , strtotime($LesseeInfo[0]['CreationDate'])); ?></p>
						<a href="lesseeProfile.php" class="btn btn-main-sm">Edit Profile</a>
					</div>
					<!-- Dashboard Links -->
          <div class="widget user-dashboard-menu">
						<ul>
							<li class="" ><a href="lesseeAccount.php"><i class="fa fa-user"></i> My Contracts</a></li>
							<!-- <li><a href=""><i class="fa fa-bookmark-o"></i> Favourite Ads <span>5</span></a></li>
							<li><a href=""><i class="fa fa-file-archive-o"></i>Archived Ads <span>12</span></a></li>
							<li><a href=""><i class="fa fa-bolt"></i> Pending Approval<span>23</span></a></li> -->
							<li><a href="logout.php"><i class="fa fa-cog"></i> Logout</a></li>
							<!-- <li><a href=""><i class="fa fa-power-off"></i>Delete Account</a></li> -->
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
				<!-- Edit Personal Info -->
				<div class="widget personal-info">
          <h3 style="color: green"><?php echo $_SESSION['message']; unset($_SESSION['message']); ?></h3>
					<h3 class="widget-header user">Edit Personal Information</h3>
          <form action="lesseeProfile.php" method="POST">
            <input type="hidden" name="editing" value="profile">						<!-- First Name -->
						<div class="form-group">
						    <label for="first-name">First Name</label>
						    <input type="text" name="first-name" class="form-control" id="first-name" value="<?php echo $LesseeInfo[0]['FirstName']; ?>">
						</div>
						<!-- Last Name -->
						<div class="form-group">
						    <label for="last-name">Last Name</label>
						    <input type="text" name="last-name" class="form-control" id="last-name" value="<?php echo $LesseeInfo[0]['LastName']; ?>">
						</div>
						<!-- Company -->
						<div class="form-group">
						    <label for="Company">Company</label>
						    <input type="text" name="Company" class="form-control" id="Company" value="<?php echo $LesseeInfo[0]['Company']; ?>">
						</div>
						<!-- File chooser -->
						<!-- <div class="form-group choose-file">
							<i class="fa fa-user text-center"></i>
						    <input type="file" class="form-control-file d-inline" id="input-file">
						 </div> -->
						<!-- Comunity Name -->
						<!-- <div class="form-group">
						    <label for="comunity-name">Comunity Name</label>
						    <input type="text" class="form-control" id="comunity-name">
						</div> -->
						<!-- Checkbox -->
						<!-- <div class="form-check">
						  <label class="form-check-label" for="hide-profile">
						    <input class="form-check-input" type="checkbox" value="" id="hide-profile">
						    Hide Profile from Public/Comunity
						  </label>
						</div> -->
						<!-- Phone Number -->
						<div class="form-group">
						    <label for="PhoneNumber">Phone Number</label>
						    <input type="num" maxlength="10" name="PhoneNumber" class="form-control" id="PhoneNumber" value="<?php echo $LesseeInfo[0]['PhoneNumber']; ?>">
						</div>
						<!-- Email -->
						<div class="form-group">
						    <label for="Email">Email</label>
						    <input type="email" name="Email" class="form-control" id="Email" value="<?php echo $LesseeInfo[0]['Email']; ?>">
						</div>
						<!-- Submit button -->
						<button class="btn btn-transparent">Save My Changes</button>
					</form>
				</div>
				<!-- Change Password -->
				<div class="widget change-password">
					<h3 class="widget-header user">Edit Password</h3>
					<form action="lesseeProfile.php" method="POST">
            <input type="hidden" name="editing" value="password">
						<!-- Current Password -->
						<div class="form-group">
              <input type="password" autocomplete="off" name="current-password" class="form-control" id="current-password">
						</div>
						<!-- New Password -->
						<div class="form-group">
						    <label for="new-password">New Password</label>
						    <input type="password" autocomplete="off" name="new-password" class="form-control" id="new-password">
						</div>
						<!-- Submit Button -->
						<button class="btn btn-transparent">Change Password</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<?php include_once "../layouts/Calssimax/footer.php";?>
