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

  if (isset($_GET['space'])){
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
    FROM Spaces
    LEFT JOIN Warehouses
    ON Warehouses.WarehouseID = Spaces.WarehouseID
    WHERE Spaces.SpaceID = $spaceID";
    $spaceResult = $conn -> query($spaceSQL);
    while($space[]=mysqli_fetch_array($spaceResult));
  }
}
else{
  header("Location: locations.php");
}

if(isset($_POST['editing']) && !isset($_GET['add'])){
  if($_POST['editing'] == 'space'){
    $spaceID = clean($_POST['spaceID']);
    $size = clean($_POST['size']);
    $monthlyPrice = clean($_POST['monthlyPrice']);
    $info = clean($_POST['info']);
    $sql = "UPDATE Spaces
    SET WarehouseID = $warehouseID, SpaceSize = $size, MonthlyPrice = $monthlyPrice, SpaceInformation = '$info'
    WHERE SpaceID = $spaceID";
    if($conn -> query($sql) === TRUE){
      $_SESSION['message'] = "Success!";
      header("Refresh: 0.1");
      $_SESSION['message'] = "Success!";
    }
  }
}
else if($_GET['add'] == "1"){
  if($_POST['editing'] == 'space'){
    $spaceID = clean($_POST['spaceID']);
    $size = clean($_POST['size']);
    $monthlyPrice = clean($_POST['monthlyPrice']);
    $info = clean($_POST['info']);
    $sql = "INSERT INTO Spaces (WarehouseID, SpaceSize, MonthlyPrice, SpaceInformation)
    VALUES ($warehouseID, $size, $monthlyPrice, '$info')";
    if($conn -> query($sql) === TRUE){
      $spaceID = $conn->insert_id;
      $_SESSION['message'] = "Success!";
      header("Refresh: 0.1");
      header("Location: editLocation.php?edit=1&warehouse=" . $warehouseID);
      $_SESSION['message'] = "Success!";
    }
  }
}

require_once "../layouts/sb_admin_2/header.php";
?>

<?php if((isset($_GET['space']) && $method == "edit") || $method == "add"){ ?>
  <div id="page-wrapper">
    <div class="row">
      <div class="col-lg-12">
        <h1 class="page-header"><?php echo ($method == "add") ? "Add a new space" : "Edit this space" ?></h1>
      </div>
      <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
      <div class="col-lg-12">
        <div class="panel panel-<?php echo ($_SESSION['message'] == 'Success!' && ($_POST['editing'] == 'warehouse')) ? "success" : "default"; unset($_SESSION['message']); ?>">
          <div class="panel-heading">
            Space Details
          </div>
          <div class="panel-body">
            <div class="row">
              <div class="col-lg-12">
                <form role="form" method="POST">
                  <input type="hidden" name="editing" value="warehouse">
                  <?php
                  if($method == "edit") { ?>
                    <fieldset disabled>
                      <div class="form-group">
                          <label for="disabledSelect">Warehouse Location</label>
                          <select id="disabledSelect" class="form-control">
                              <option><?php echo $space[0]['Address']; ?></option>
                          </select>
                      </div>
                  </fieldset>
                <?php
                }
                else if($method == "add") {?>
                  <div class="form-group">
                      <label for="disabledSelect">Warehouse Location</label>
                      <select id="disabledSelect" class="form-control">
                        <?php
                        $sql = "SELECT *
                                FROM Warehouses
                                WHERE OwnerID = $UserID";
                        $result = $conn -> query($sql);
                        while($row = $result -> fetch_assoc()){ ?>
                          <option>
                            <?php echo $row['Address']; ?>
                          </option>
                        <?php}?>
                      </select>
                  </div>
                <?php}?>

                  <div class="form-group">
                    <label>Space Size</label>
                    <input required type="number" class="form-control" name="size" value="<?php echo ($method == "edit") ? $space[0]['SpaceSize'] : ""; ?>">
                  </div>
                  <label>Monthly Price</label>
                  <div class="form-group input-group">
                      <span class="input-group-addon">$</span>
                      <input required type="text" name="monthlyPrice" class="form-control">
                      <span class="input-group-addon">.00</span>
                  </div>
                  <div class="form-group">
                    <label>Description</label>
                    <textarea class="form-control" name="details" placeholder="Please describe this space for potential customers.  This could be private restrooms, security cameras, bay doors, etc." rows="3"><?php echo ($method == "edit") ? $warehouse[0]['WarehouseInformation'] : ""; ?></textarea>
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
    </div>
  </div>
<?php }?>
</div>
<!-- /.panel -->

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
