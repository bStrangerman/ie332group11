<?php
require_once "../includes/main.php";

//set the fee rate
$feeRate = 1.05;

// checks if they are a proper user
$root = $rbac->Users->hasRole('root', $UserID = $_SESSION['UserID']);

// checks if the user is logged in and is a warehouse owner
if (isset($_SESSION['UserID'])) {
  // checks if they are a proper user
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID']) && !$root)
  header('Location: index.php');
  else
  $UserID = $_SESSION['UserID'];
}
else {
  $_SESSION['redirect'] = 'Location: locations.php';
  header('Location: login.php');
}

/**
* Gets all the locations that this warehouse owner has
* @param  [int] $UserID [Owner ID]
* @return [VOID]         [VOID]
*/
function getLocations($UserID){
  return "SELECT *
  FROM Warehouses" .
  (($GLOBALS['root'] == 1) ? "" : "
  WHERE Warehouses.OwnerID = $UserID") . "
  ORDER BY Warehouses.WarehouseID ASC";

}

// sql query for new contract info
$mainSqlMidResult = ($conn -> query(getLocations($UserID)));

// header layout
require_once "../layouts/sb_admin_2/header.php";
?>

<div id="page-wrapper">
  <div class="row">
    <div class="col-lg-12">
      <h1 class="page-header">Locations</h1>
    </div>
    <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading">
          Locations
          <div class="pull-right">
            <div class="btn-group">
              <a href="editLocation.php?add=1">
                <button type="button" class="btn btn-info btn-xs">
                  Add Location
                </button>
              </a>
            </div>
          </div>
          <!-- /.panel-heading -->
        </div>
        <div class="panel-body">
          <div class="table-responsive">
            <!-- Table for all locations -->
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Address</th>
                  <th>Space #</th>
                  <th>Profit</th>
                  <th>Utilization</th>
                  <th>Edit</th>
                </tr>
              </thead>
              <tbody>
                <?php

                $warehouse = "";
                while($mainSqlResult = $mainSqlMidResult -> fetch_assoc()){
                  $warehouseID = $mainSqlResult['WarehouseID'];?>
                  <tr>
                    <td><?php echo $mainSqlResult['Address']; ?></td>
                    <td>--</td>
                    <td>
                      <?php
                      $profitByWarehouseSQL = "SELECT SUM(Contracts.AmountCharged) AS Profit
                      FROM Contracts
                      RIGHT JOIN Spaces
                      ON Spaces.SpaceID = Contracts.SpaceID
                      INNER JOIN Warehouses
                      ON Warehouses.WarehouseID = Spaces.WarehouseID
                      WHERE Warehouses.WarehouseID = $warehouseID
                      GROUP BY Warehouses.WarehouseID";

                      //gets the profit for each warehouse
                      $profitByWarehouseResult = $conn -> query($profitByWarehouseSQL);
                      while($profitByWarehouse = $profitByWarehouseResult -> fetch_assoc()){
                        // print the profit for each warehouse - our fee
                        echo "$ " . round($profitByWarehouse['Profit'] / $feeRate, 2);
                      }
                      ?>
                    </td>
                    <td><a href="editLocation.php?edit=1&warehouse=<?php echo $warehouseID; ?>">
                      <button class="btn btn-outline btn-primary">Edit</button></a>
                    </td>
                  </tr>
                  <?php
                  // Gets spaces for this warehosue
                  $spacesSQL = "SELECT *
                  FROM Spaces
                  LEFT JOIN Warehouses
                  ON Warehouses.WarehouseID = Spaces.WarehouseID
                  WHERE Spaces.WarehouseID = $warehouseID";
                  $spacesResult = $conn -> query($spacesSQL);

                  if ($spacesResult->num_rows <= 0) {
                    ?>
                    <tr>
                      <td>No Space has been created.</td>
                      <td></td>
                      <td></td>
                      <td><a href="editSpace.php?add=1&warehouse=<?php echo $warehouseID; ?>">
                        <button class="btn btn-outline btn-primary">Add Space</button></a>
                      </td>
                    </tr>
                    <?php
                    }
                    else {
                      while ($spaces = $spacesResult -> fetch_assoc()) {
                        ?>
                        <tr>
                          <td>--</td>
                          <td><?php echo $spaces['SpaceID']; ?></td>
                          <td><?php
                          $space = $spaces['SpaceID'];
                          $profitBySpaceSQL = "SELECT SUM(Contracts.AmountCharged) AS Profit
                          FROM Contracts
                          WHERE Contracts.SpaceID = $space
                          GROUP BY Contracts.SpaceID";

                          //gets the profit for each warehouse
                          $profitBySpaceResult = $conn -> query($profitBySpaceSQL);
                          $max_profit_per_space = 0;
                          if(isset($spaces['SpaceID'])){

                            while($profitBySpace = $profitBySpaceResult -> fetch_assoc()){
                              if($profitBySpace['Profit'] > $max_profit_per_space){
                                $max_profit_per_space = $profitBySpace['Profit'];
                              }
                            }
                          }

                          // print the profit for each warehouse - our fee
                          echo "$ " . round($max_profit_per_space / $feeRate,2);?></td>
                          <td><a href="editSpace.php?edit=1&space=<?php echo $spaces['SpaceID']; ?>">
                            <button class="btn btn-outline btn-primary">Edit</button></a></td>
                          </tr>
                          <?php
                        }
                      }
                    }


                    ?>


                  </tbody>
                </table>
                <h5 align="right">Current Fee Rate is <?php echo (($feeRate - 1) * 100); ?>%.  This has already been removed from your Profit.</h5>
              </div>
              <!-- /.table-responsive -->
            </div>
            <!-- /.panel-body -->
          </div>
          <!-- /.panel -->
          <!-- /.panel -->
        </div>
        <!-- /.col-lg-6 -->
      </div>


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
<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="dist/js/sb-admin-2.js"></script>

</body>

</html>
<?php require_once "../layouts/sb_admin_2/footer.php"; ?>
