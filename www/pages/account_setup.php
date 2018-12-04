<?php
require_once "../includes/main.php";
// checks if logged in
if(!isset($_SESSION['UserID'])){
  header("Location: login.php");
}
else if (!$rbac->Users->hasRole('need_setup', $UserID = $_SESSION['UserID'])){
  echo "You don't have the proper permissions to access this page. This page will redirect in 10 seconds.";
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
            SET FirstName = '$firstname', LastName = '$lastname', Email = '$email', PhoneNumber = '$phonenumber', Company = '$company'
            WHERE UserID = $UserID";

    if($conn -> query($sql) === TRUE){
      for($i = 0; $i < count($_POST['role']); $i++){
        $rbac->Users->assign($_POST['role'][$i], $UserID = $_SESSION['UserID']);
      }
      $_SESSION['message'] = "Success!";
      header("Location: index.php");
      $_SESSION['message'] = "Success!";
    }
  }
}


// print the header
require_once "../layouts/Calssimax/header.php";


?>
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css'>
<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css'>

<!-- Style for image checkbox -->
<style>
.nopad {
	padding-left: 0 !important;
	padding-right: 0 !important;
}
/*image gallery*/
.image-checkbox {
	cursor: pointer;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
	border: 4px solid transparent;
	margin-bottom: 0;
	outline: 0;
}
.image-checkbox input[type="checkbox"] {
	display: none;
}

.image-checkbox-checked {
	border-color: #ff545a;
  background-color: lightblue;
}
.image-checkbox .fa {
  position: absolute;
  color: #ff545a;
  background-color: #fff;
  padding: 10px;
  top: 0;
  right: 0;
}
.image-checkbox-checked .fa {
  display: block !important;
}
</style>

<!--
Image Checkbox Bootstrap template for multiple image selection
https://www.prepbootstrap.com/bootstrap-template/image-checkbox
-->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<!--==================================
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
						<h5 class="text-center"><?php echo $LesseeInfo[0]['Username']; ?></h5>
						<p>Joined <?php echo date("F d, Y" , strtotime($LesseeInfo[0]['CreationDate'])); ?></p>
					</div>
					<!-- Dashboard Links -->
          <div class="widget user-dashboard-menu">
						<ul>
							<!-- <li class="" ><a href="lesseeAccount.php"><i class="fa fa-user"></i> My Contracts</a></li> -->
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
          <h3 class="widget-header user">Set up your account</h3>
          <form method="POST">
            <input type="hidden" name="editing" value="profile">
            						<!-- First Name -->
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
            <div class="form-group">
                <label for="PhoneNumber">Phone Number</label>
                <input type="num" maxlength="10" name="PhoneNumber" class="form-control" id="PhoneNumber" value="<?php echo $LesseeInfo[0]['PhoneNumber']; ?>">
            </div>
            <!-- Email -->
            <div class="form-group">
                <label for="Email">Email</label>
                <input type="email" name="Email" class="form-control" id="Email" value="<?php echo $LesseeInfo[0]['Email']; ?>">
            </div>
            <!-- code from https://codepen.io/kskhr/pen/pRwKjg -->
            <div class="container">
              <h3>Please Select Your Role(s)</h3>
              <div class="col-xs-4 col-sm-3 col-md-2">
              </div>
              <div class="col-xs-4 col-sm-3 col-md-2 nopad text-center">
                <label class="image-checkbox">
                  <img class="img-responsive" src="https://png.pngtree.com/svg/20170426/warehouse_467076.png" />
                  <p>Warehouse Owner</p>
                  <input type="checkbox" name="role[]" value="Warehouse_Owner" />
                  <i class="fa fa-check hidden"></i>
                </label>
              </div>
              <div class="col-xs-4 col-sm-3 col-md-2 nopad text-center">
                <label class="image-checkbox">
                  <img class="img-responsive" src="https://static.thenounproject.com/png/111378-200.png" />
                  <p>Lessee</p>
                  <input type="checkbox" name="role[]" value="Lessee" />
                  <i class="fa fa-check hidden"></i>
                </label>
              </div>
            </div>

            <!-- Submit button -->
            <button class="btn btn-transparent">Save My Changes</button>
          </form>
        </div>
      </div>
		</div>
	</div>
</section>

<!--============================
=            Footer            =
=============================-->

<?php include_once("../layouts/Calssimax/footer.php"); ?>

  <!-- JAVASCRIPTS -->
  <script src="plugins/jquery/jquery.min.js"></script>
  <script src="plugins/jquery-ui/jquery-ui.min.js"></script>
  <script src="plugins/tether/js/tether.min.js"></script>
  <script src="plugins/raty/jquery.raty-fa.js"></script>
  <script src="plugins/bootstrap/dist/js/popper.min.js"></script>
  <script src="plugins/bootstrap/dist/js/bootstrap.min.js"></script>
  <script src="plugins/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js"></script>
  <script src="plugins/slick-carousel/slick/slick.min.js"></script>
  <script src="plugins/jquery-nice-select/js/jquery.nice-select.min.js"></script>
  <script src="plugins/fancybox/jquery.fancybox.pack.js"></script>
  <script src="plugins/smoothscroll/SmoothScroll.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
  <script src="../includes/js/scripts.js"></script>
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>
 <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js'></script>
 <!-- JS for image checkboxes -->
 <script>
 // image gallery
 // init the state from the input
 $(".image-checkbox").each(function () {
   if ($(this).find('input[type="checkbox"]').first().attr("checked")) {
     $(this).addClass('image-checkbox-checked');
   }
   else {
     $(this).removeClass('image-checkbox-checked');
   }
 });

 // sync the state to the input
 $(".image-checkbox").on("click", function (e) {
   $(this).toggleClass('image-checkbox-checked');
   var $checkbox = $(this).find('input[type="checkbox"]');
   $checkbox.prop("checked",!$checkbox.prop("checked"))

   e.preventDefault();
 });
 </script>
</body>

</html>
