<?php
require_once "../includes/main.php";
// checks if they are a proper user
$root = $rbac->Users->hasRole('root', $UserID = $_SESSION['UserID']);
array_print($_POST);
// checks if the user is logged in and is a warehouse owner
if (isset($_SESSION['UserID'])) {
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID']) && !$root)
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
    WHERE Warehouses.WarehouseID = $warehouseID " . (($root) ? "" : "
    AND Warehouses.OwnerID = $UserID");

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
    $ownerID = $warehouse[0]['OwnerID'];

    // Checks if this user owns this warehouse
    $warehouseExistsSQL = "SELECT COUNT(*) AS CountOF
    FROM Warehouses
    WHERE Warehouses.WarehouseID = $warehouseID
    AND Warehouses.OwnerID = $ownerID";

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

if(isset($_POST['editing']) && !isset($_GET['add'])){
  if($_POST['editing'] == 'warehouse'){
    $street = clean($_POST['address']);
    $city = clean($_POST['city']);
    $state = clean($_POST['state']);
    $zip = clean($_POST['zip-code']);
    $lat = clean($_POST['lat']);
    $lon = clean($_POST['lon']);
    $sql = "UPDATE Warehouses
    SET Address = '$street', City = '$city', State = '$state', ZipCode = '$zip', Latitude = '$lat', Longitude = '$lon'
    WHERE WarehouseID = $warehouseID";
    if($conn -> query($sql) === TRUE){
      $_SESSION['message'] = "Success!";
      header("Refresh: 0.1");
      $_SESSION['message'] = "Success!";
    }
  }
  if($_POST['editing'] == 'details'){
    $details = clean($_POST['details']);
    $buildingSize = clean($_POST['BuildingSize']);
    $sql = "UPDATE Warehouses
    SET WarehouseInformation = '$details', BuildingSize = '$buildingSize'
    WHERE WarehouseID = $warehouseID";
    if($conn -> query($sql) === TRUE){
      $_SESSION['message'] = "Success!";
      header("Refresh: 0.1");
      $_SESSION['message'] = "Success!";
    }
  }
}
else if($_GET['add'] == "1"){
  if($_POST['editing'] == 'warehouse'){
    $street = clean($_POST['address']);
    $city = clean($_POST['city']);
    $state = clean($_POST['state']);
    $zip = clean($_POST['zip-code']);
    $lat = clean($_POST['lat']);
    $lon = clean($_POST['lon']);
    $sql = "INSERT INTO Warehouses (OwnerID, Address,City,State,ZipCode,Latitude,Longitude)
    VALUES ($UserID, '$street', '$city', '$state', '$zip', '$lat', '$lon')";
    echo $sql;
    if($conn -> query($sql) === TRUE){
      $warehouseID = $conn->insert_id;
      $_SESSION['message'] = "Success!";
      header("Refresh: 0.1");
      header("Location: editLocation.php?edit=1&warehouse=" . $warehouseID);
      $_SESSION['message'] = "Success!";
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
  // if everything is ok, try to upload file
} else {
  if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
    $pictureName = basename( $_FILES["fileToUpload"]["name"]);
    $insertPicSql = "INSERT INTO Pictures (FileName) VALUES ('$pictureName')";
    if ($conn->query($insertPicSql) === TRUE) {
      $last_id = $conn->insert_id;
      $picToWarehouse = "INSERT INTO Warehouse_Pictures VALUES ($last_id, $warehouseID)";
      if ($conn->query($picToWarehouse) === TRUE) {
        $message = "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
      }
      else {
        $message = "Sorry, there was an error uploading your file.";
      }
    }
    else {
      $message = "Sorry, there was an error uploading your file.";
    }
  }
  else {
    $message = "Sorry, there was an error uploading your file.";
  }
}

// Deletes the picture from Warehouse_pictures table
// Note: for this project, we are not deleting the image from the site because the image is used on multiple pages.
if(isset($_POST["del_picture"])) {
  $imageForDeletion = $_POST['del_picture'];
  $deleteSQL = "DELETE FROM Warehouse_Pictures WHERE PictureID = $imageForDeletion AND WarehouseID = $warehouseID";
  if ($conn->query($deleteSQL) === TRUE) {
    $message = "Image Successfully Deleted";
  }
}


require_once "../layouts/sb_admin_2/header.php";
?>
<style>
div.imagetiles div.col-lg-3.col-md-3.col-sm-3.col-xs-6{
  padding: 0px;
}
</style>

<?php if((isset($_GET['warehouse']) && $method == "edit") || $method == "add"){ ?>
  <div id="page-wrapper">
    <div class="row">
      <div class="col-lg-12">
        <h1 class="page-header"><?php echo ($method == "add") ? "Add a new Location" : "Edit this location" ?></h1>
        <p class="page-header">Make sure you add at least one space in this warehouse at the bottom of this page to start getting contracts.</p>
      </div>
      <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
      <div class="col-lg-6">
        <div class="panel panel-<?php echo ($_SESSION['message'] == 'Success!' && ($_POST['editing'] == 'warehouse')) ? "success" : "default"; unset($_SESSION['message']); ?>">
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
                    <input type="text" class="form-control" name="lat" value="<?php echo ($method == "edit") ? $warehouse[0]['Latitude'] : ""; ?>">
                    <p>Please input the Latitude so @Capacity's search can provide accurate results to the lessees.</p>
                  </div>
                  <div class="form-group">
                    <label>Longitude</label>
                    <input type="text" class="form-control" name="lon" value="<?php echo ($method == "edit") ? $warehouse[0]['Longitude'] : ""; ?>">
                    <p>Please input the Longitude so @Capacity's search can provide accurate results to the lessees.</p>
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
          <?php if($method != "add"){?>
      <div class="col-lg-6">
        <div class="panel panel-<?php echo (($_SESSION['message'] == 'Success!') && ($_POST['editing'] == 'details')) ? "success" : "default"; unset($_SESSION['message']); ?>">
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
                    <textarea class="form-control" name="details" placeholder="Please describe this location for potential customers.  This could be parking, traffic, the age of this building, etc." rows="3"><?php echo ($method == "edit") ? $warehouse[0]['WarehouseInformation'] : ""; ?></textarea>
                  </div>
                  <div class="form-group">
                    <label>Building Size</label>
                    <input type="number" class="form-control" name="BuildingSize" value="<?php echo ($method == "edit") ? $warehouse[0]['BuildingSize'] : ""; ?>">
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
          <p>The following pictures are pictures for your warehouse.  These will be displayed on all the spaces partitioned in this spaces.</p>
          <?php
          $pictureSQL = "SELECT *
          FROM Pictures
          LEFT JOIN Warehouse_Pictures
          ON Warehouse_Pictures.PictureID = Pictures.PictureID
          WHERE Warehouse_Pictures.WarehouseID = $warehouseID";
          if($method != "add"){
            $pictureResult = $conn -> query($pictureSQL);
            while($pictures[]=mysqli_fetch_array($pictureResult));
          ?>

          <!-- Image grid from https://stackoverflow.com/questions/39320966/bootstrap-responsive-image-grid -->
          <div class="panel-body">
            <div class="col-lg-12">
              <?php
              for($i = 0; $i < count($pictures); $i++){
                if($i % 4 == 0){
                  if($i != 0){?>
                  </div>
                <?php } ?>
                <div class="row imagetiles">
                <?php }
                if(isset($pictures[$i]['FileName'])){?>
                  <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6">
                    <img class="img-responsive" src="../pictures/<?php echo $pictures[$i]['FileName']; ?>">
                    <div class="row">
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
                  </div>

                <?php } ?>
              <?php } ?>
            </div>
          </div>
<?php } ?>

          <form action="" method="post" enctype="multipart/form-data">
            <input type="hidden" name="upload" value="1">
            <div class="form-group">
              <label>Select Image Files to Add:</label>
              <input type="file" name="fileToUpload" id="fileToUpload">
            </div>
            <button type="submit" class="btn btn-default">Upload</button>
          </form>
          <?php echo (isset($_POST["upload"]) || isset($_POST['del_picture'])) ? $message : ""; ?>
        </div>
        <!-- /.col-lg-6 (nested) -->
        <!-- /.row (nested) -->
      </div>
      <!-- /.panel-body -->
    </div>
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Spaces in this Warehouse
                <div class="pull-right">
                <div class="btn-group">
                  <a href="editSpace.php?add=1&warehouse=<?php echo $warehouseID; ?>">
                    <button type="button" class="btn btn-info btn-xs">
                      Add Space
                    </button>
                  </a>
                </div>
              </div>
            </div>
            <!-- /.panel-heading -->
            <?php
            $spaceSQL = "SELECT * FROM Spaces WHERE WarehouseID = $warehouseID";
            $spaceResult = $conn -> query($spaceSQL); ?>
            <div class="panel-body">
                <div class="table-responsive table-bordered">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Space ID</th>
                                <th>Size</th>
                                <th>Monthly Price</th>
                                <th>Space Information</th>
                                <th>View</th>
                            </tr>
                        </thead>
                        <tbody>
                          <?php
                          while($spaceRow = $spaceResult -> fetch_assoc()){ ?>
                            <tr>
                                <td><?php echo $spaceRow['SpaceID']; ?></td>
                                <td><?php echo $spaceRow['SpaceSize']; ?></td>
                                <td><?php echo $spaceRow['MonthlyPrice']; ?></td>
                                <td><?php echo $spaceRow['SpaceInformation']; ?></td>
                                <td>
                                  <a href="editSpace.php?edit=1&space=<?php echo $spaceRow['SpaceID']; ?>">
                                    <button class="btn btn-outline btn-primary">
                                      Edit
                                    </button>
                                  </a>
                                </td>
                            </tr>
                          <?php }?>
                        </tbody>
                    </table>
                </div>
                <!-- /.table-responsive -->
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
  </div>
<?php }?>
</div>
<!-- /.panel -->

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
