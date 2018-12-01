<?php
require_once "../includes/main.php";

// checks if the user is logged in and is a warehouse owner
if (isset($_SESSION['UserID'])) {
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID']))
  header('Location: index.php');
  else
  $UserID = $_SESSION['UserID'];
}
else {
  $_SESSION['redirect'] = 'Location: ' . $_SERVER['REQUEST_URI'];
  header('Location: login.php');
}

//divides the page into add or edit sections
if(isset($_GET['add']) && $_GET['add'] == 1){
  $method = "add";
}
else if(isset($_GET['edit']) && $_GET['edit'] == 1){
  $method = "edit";

  // check if a location is selected
  if (isset($_GET['warehouse'])) {
    $warehouseID = clean($_GET['warehouse']);

    // Checks if this user owns this warehouse
    $warehouseExistsSQL = "SELECT COUNT(*) AS CountOF
    FROM Warehouses
    WHERE Warehouses.WarehouseID = $warehouseID
    AND Warehouses.OwnerID = $UserID";

    $warehouseExistsResult = $conn -> query($warehouseExistsSQL);
    while ($warehouseExists = $warehouseExistsResult -> fetch_assoc()) {
      if($warehouseExists['CountOF'] == 0){
        header('Location: locations.php');
      }
    }
    $warehouseSQL = "SELECT *
    FROM Warehouses
    WHERE Warehouses.WarehouseID = $warehouseID";
    $warehouseResult = $conn -> query($warehouseSQL);
    while($warehouse[]=mysqli_fetch_array($warehouseResult));

    // Checks if this user owns this warehouse
    $warehouseExistsSQL = "SELECT COUNT(*) AS CountOF
    FROM Warehouses
    WHERE Warehouses.WarehouseID = $warehouseID
    AND Warehouses.OwnerID = $UserID";

    $warehouseExistsResult = $conn -> query($warehouseExistsSQL);
    while ($warehouseExists = $warehouseExistsResult -> fetch_assoc()) {
      if($warehouseExists['CountOF'] == 0){
        header('Location: locations.php');
      }
    }
    $warehouseSQL = "SELECT *
    FROM Warehouses
    WHERE Warehouses.WarehouseID = $warehouseID";
    $warehouseResult = $conn -> query($warehouseSQL);
    while($warehouse[]=mysqli_fetch_array($warehouseResult));
  }
  else if (isset($_GET['space'])){
    $spaceID = clean($_GET['space']);

    // Checks if this user owns this warehouse
    $spaceExistsSQL = "SELECT COUNT(*) AS CountOF
    FROM Spaces
    LEFT JOIN Warehouses
    ON Warehouses.WarehouseID = Spaces.WarehouseID
    WHERE Spaces.SpaceID = $spaceID
    AND Warehouses.OwnerID = $UserID";

    $spaceExistsResult = $conn -> query($spaceExistsSQL);
    while ($spaceExists = $spaceExistsResult -> fetch_assoc()) {
      if($spaceExists['CountOF'] == 0){
        header('Location: locations.php');
      }
    }
    $spaceSQL = "SELECT *
    FROM Warehouses
    WHERE Warehouses.WarehouseID = $spaceID";
    $spaceResult = $conn -> query($spaceSQL);
    while($space[]=mysqli_fetch_array($spaceResult));
  }
}
else{
  header("Location: locations.php");
}

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

// Uploads the image to the server and database
// Code found on https://www.w3schools.com/php/php_file_upload.asp
$target_dir = "../pictures/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
// Check if image file is a actual image or fake image
if(isset($_POST["upload"])) {
$check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
if($check !== false) {
    // echo "File is an image - " . $check["mime"] . ".";
    $uploadOk = 1;
} else {
    $message = "File is not an image.";
    $uploadOk = 0;
}
}
// Check if file already exists
if (file_exists($target_file)) {
$message = "Sorry, file already exists.";
$uploadOk = 0;
}
// Check file size
if ($_FILES["fileToUpload"]["size"] > 500000) {
$message = "Sorry, your file is too large.";
$uploadOk = 0;
}
// Allow certain file formats
if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" ) {
$message = "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
$uploadOk = 0;
}
// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
$message = "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
} else {
if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
    $message = "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
} else {
    $message = "Sorry, there was an error uploading your file.";
}
}

require_once "../layouts/sb_admin_2/header.php";
?>
<style>
div.imagetiles div.col-lg-3.col-md-3.col-sm-3.col-xs-6{
  padding: 0px;
}
</style>

<?php if(isset($_GET['warehouse']) && ($method == "edit" || $method == "add")){ ?>
  <div id="page-wrapper">
    <div class="row">
      <div class="col-lg-12">
        <h1 class="page-header"><?php echo ($method == "add") ? "Add a new Location" : "Edit this location" ?></h1>
      </div>
      <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
      <div class="col-lg-6">
        <div class="panel panel-<?php echo ($_SESSION['message'] == 'Success!') ? "success" : "default"; unset($_SESSION['message']); ?>">
          <div class="panel-heading">
            Address Information
          </div>
          <div class="panel-body">
            <div class="row">
              <div class="col-lg-12">
                <form role="form" method="POST">
                  <input type="hidden" name="editing" value="warehouse">
                  <div class="form-group">
                    <label>Street Address</label>
                    <input type="text" class="form-control" name="address" value="<?php echo ($method == "edit") ? $warehouse[0]['Address'] : ""; ?>">
                  </div>
                  <div class="form-group">
                    <label>City</label>
                    <input type="text" class="form-control" name="city" value="<?php echo ($method == "edit") ? $warehouse[0]['City'] : ""; ?>">
                  </div>
                  <div class="form-group">
                    <label>State</label>
                    <input type="text" class="form-control" name="state" value="<?php echo ($method == "edit") ? $warehouse[0]['State'] : ""; ?>">
                  </div>
                  <div class="form-group">
                    <label>Zip Code</label>
                    <input type="number" maxlength="5" class="form-control" name="zip-code" value="<?php echo ($method == "edit") ? $warehouse[0]['ZipCode'] : ""; ?>">
                  </div>
                  <div class="form-group">
                    <label>Latitude</label>
                    <input type="number" maxlength="10" class="form-control" name="lat" value="<?php echo ($method == "edit") ? $warehouse[0]['Latitude'] : ""; ?>">
                  </div>
                  <div class="form-group">
                    <label>Longitude</label>
                    <input type="number" maxlength="10" class="form-control" name="lon" value="<?php echo ($method == "edit") ? $warehouse[0]['Longitude'] : ""; ?>">
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
      <div class="col-lg-6">
        <div class="panel panel-<?php echo ($_SESSION['message'] == 'Success!') ? "success" : "default"; unset($_SESSION['message']); ?>">
          <div class="panel-heading">
            Location Specifications
          </div>
          <div class="panel-body">
            <div class="row">
              <div class="col-lg-12">
                <form role="form" method="POST">
                  <input type="hidden" name="editing" value="details">
                  <div class="form-group">
                    <label>Description</label>
                    <textarea class="form-control" name="details"  value="<?php echo ($method == "edit") ? $warehouse[0]['WarehouseInformation'] : ""; ?>" placeholder="Please describe this location for potential customers.  This could be parking, traffic, the age of this building, etc." rows="3"></textarea>
                  </div>
                  <div class="form-group">
                    <label>Building Size</label>
                    <input type="number" class="form-control" name="buildingSize" value="<?php echo ($method == "edit") ? $warehouse[0]['BuildingSize'] : ""; ?>">
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
    </div>
    <div class="row">
      <div class="col-lg-12">
        <div class="panel panel-<?php echo ($_SESSION['message'] == 'Success!') ? "success" : "default"; unset($_SESSION['message']); ?>">
          <div class="panel-heading">
            Pictures
          </div>
          <?php
          $pictureSQL = "SELECT *
          FROM Pictures
          LEFT JOIN Warehouse_Pictures
          ON Warehouse_Pictures.PictureID = Pictures.PictureID
          WHERE Warehouse_Pictures.WarehouseID = $warehouseID";
          $pictureResult = $conn -> query($pictureSQL);
          while($pictures[]=mysqli_fetch_array($pictureResult));
          ?>
          <div class="panel-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="row imagetiles">
                  <?php for($i = 0; $i < count($pictures); $i++){
                    if($i % 4 == 0){ ?>
                    <?php }
                    if(isset($pictures[$i]['FileName'])){?>
                      <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6">
                        <img class="img-responsive" src="../pictures/<?php echo $pictures[$i]['FileName']; ?>">
                        <div class="col-lg-3">
                        </div>
                        <div class="col-lg-3">
                          <form role="form" method="POST">
                            <input type="hidden" name="del_picture" value="<?php echo $pictures[$i]['PictureID']; ?>">
                            <input type="hidden" name="warehouse" value="<?php echo $warehouseID; ?>">
                            <button align="center" type="submit" class="btn btn-default">Delete Picture</button>
                          </form>
                        </div>
                      </div>
                    <?php }?>
                    <?php if($i % 7 == 0){ ?>
                    <?php } ?>
                  <?php }?>
                </div>


                <form action="" method="post" enctype="multipart/form-data">
                  <div class="col-lg-6">
                  Select Image Files to Upload:
                  <input type="hidden" name="upload" value="1">
                    <input type="file" name="fileToUpload" id="fileToUpload">
                  </div>
                  <div class="col-lg-6">
                    <button type="submit" class="btn btn-default">Upload</button>
                  </div>
                </form>
                <?php echo (isset($_POST["upload"])) ? $message : ""; ?>
              </div>
              <!-- /.col-lg-6 (nested) -->
            </div>
            <!-- /.row (nested) -->
          </div>
          <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
      </div>
    </div>
  </div>
  <!-- /.row -->
</div>
<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->
<?php } ?>
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
