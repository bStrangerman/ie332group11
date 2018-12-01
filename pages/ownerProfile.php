<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";

// checks if logged in
if(!isset($_SESSION['UserID'])){
  $_SESSION['redirect'] = 'Location: ownerProfile.php';
  header("Location: login.php");
}
else if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID'])) {
  header("Location: lesseeAccount.php");
}
else{
  $UserID = $_SESSION['UserID'];
}

// get user info
$sql = "SELECT *
        FROM phprbac_users
        WHERE phprbac_users.UserID = $UserID";

$result = $conn -> query($sql);
while($ownerProfile[]=mysqli_fetch_array($result));


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
    if(md5(clean($_POST['current-password'])) == $ownerProfile[0]['Password']){
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

require_once "../layouts/sb_admin_2/header.php";
?>
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Edit Your Profile</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-<?php echo ($_SESSION['message'] == 'Success!') ? "success" : "default"; unset($_SESSION['message']); ?>">
                        <div class="panel-heading">
                            Personal Information
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form role="form" method="POST">
                                      <input type="hidden" name="editing" value="profile">
                                        <div class="form-group">
                                            <label>First Name</label>
                                            <input type="text" class="form-control" name="first-name" value="<?php echo $ownerProfile[0]['FirstName']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label>Last Name</label>
                                            <input type="text" class="form-control" name="last-name" value="<?php echo $ownerProfile[0]['LastName']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label>Company</label>
                                            <input type="text" class="form-control" name="Company" value="<?php echo $ownerProfile[0]['Company']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label>Phone Number</label>
                                            <input type="tel" maxlength="10" class="form-control" name="PhoneNumber" value="<?php echo $ownerProfile[0]['PhoneNumber']; ?>">
                                        </div>
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input type="tel" maxlength="10" class="form-control" name="Email" value="<?php echo $ownerProfile[0]['Email']; ?>">
                                        </div>
                                        <button type="submit" class="btn btn-default">Save My Changes</button>
                                    </form>
                                </div>
                                <!-- /.col-lg-6 (nested) -->
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
                <div class="col-lg-6">
                    <div class="panel panel-<?php echo ($_SESSION['message'] == 'Success!') ? "success" : "default"; unset($_SESSION['message']); ?>">
                        <div class="panel-heading">
                            Change your password
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form role="form" method="post">
                                      <input type="hidden" name="editing" value="password">
                                        <div class="form-group">
                                            <label>Current Password</label>
                                            <input type="password" autocomplete="off" class="form-control" name="current-password" value="">
                                        </div>
                                        <div class="form-group">
                                            <label>New Password</label>
                                            <input type="password" autocomplete="off" class="form-control" name="new-password">
                                        </div>
                                        <button type="submit" class="btn btn-default">Change Password</button>
                                    </form>
                                </div>
                                <!-- /.col-lg-6 (nested) -->
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="../vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../dist/js/sb-admin-2.js"></script>

</body>

</html>
