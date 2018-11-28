<?php
require_once "../includes/main.php";

$feeRate = 1.05;

if (isset($_SESSION['UserID'])) {
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID']))
  header('Location: pages/index.php');
  else
  $UserID = $_SESSION['UserID'];
}
else {
  $_SESSION['redirect'] = 'Location: pages/warehouse.php';
  header('Location: login.php');
}
// FIXME: currently an error with  Notice: Undefined index: contractInfo in C:\xampp\htdocs\ie332group11\pages\contract.php on line 44
// Checks if the URL has a contract ID in it

function getLocations($UserID){
  return "SELECT *
  FROM Warehouses
  LEFT JOIN Spaces
  ON Spaces.WarehouseID = Warehouses.WarehouseID
  WHERE Warehouses.OwnerID = $UserID
  ORDER BY Warehouses.WarehouseID ASC, Spaces.SpaceID ASC";
}

// sql query for new contract info
$mainSqlMidResult = ($conn -> query(getLocations($UserID)));

// redirects if the user has no contract with that number
// header('Location: warehouse.php');
// if(!$mainSqlResult['countof']){
// }

require_once "../layouts/sb_admin_2/header.php";

?>

<div id="page-wrapper">
  <div class="row">
    <div class="col-lg-12">
      <h1 class="page-header">Locatons</h1>
    </div>
    <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading">
          Locations
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Address</th>
                  <th>Space #</th>
                  <th>Profit</th>
                  <th>Current Status</th>
                  <th>Edit</th>
                </tr>
              </thead>
              <tbody>
                <?php
                $warehouse = "";
                while($mainSqlResult = $mainSqlMidResult -> fetch_assoc()){?>
                  <tr>
                    <?php
                    $warehouseID = $mainSqlResult['WarehouseID'];

                    if($warehouse != $mainSqlResult['WarehouseID']){ ?>
                      <td><?php echo $mainSqlResult['Address']; ?></td>
                      <td></td>
                      <td><?php
                      $profitByWarehouseSQL = "SELECT SUM(Contracts.AmountCharged) AS Profit
                      FROM Contracts
                      RIGHT JOIN Spaces
                      ON Spaces.SpaceID = Contracts.SpaceID
                      INNER JOIN Warehouses
                      ON Warehouses.WarehouseID = Spaces.WarehouseID
                      WHERE Warehouses.WarehouseID = $warehouseID
                      GROUP BY Warehouses.WarehouseID";

                      $profitByWarehouseResult = $conn -> query($profitByWarehouseSQL);
                      $max_profit_per_warehouse = 0;
                      while($profitByWarehouse = $profitByWarehouseResult -> fetch_assoc()){
                        if($profitByWarehouse['Profit'] > $max_profit_per_warehouse){
                          $max_profit_per_warehouse = $profitByWarehouse['Profit'];
                        }
                      }
                      echo "$ " . round($max_profit_per_warehouse / $feeRate,2);

                      ?></td>
                      <td></td>
                      <td></td>
                    </tr>
                    <tr>
                      <td align="center">-</td>
                      <td><?php
                      $space = $mainSqlResult['SpaceID'];
                      echo $mainSqlResult['SpaceID'];
                      ?></td>
                      <td></td>
                      <td>
                        <?php
                        // Get all the contracts for this space
                        $statusSQL = "SELECT *
                                      FROM Contracts
                                      WHERE SpaceID = $space";
                        $statusResult = $conn -> query($statusSQL);

                        while($status = $statusResult -> fetch_assoc()){
                          if(isset($status['ContractID'])){
                            $date_diff_future = date_diff(date_create(date("Y-m-d")), date_create(date("Y-m-d",strtotime($status['StartDate']))))->format("%R%a");
                            $date_diff_past = date_diff(date_create(date("Y-m-d",strtotime($status['EndDate']))), date_create(date("Y-m-d")))->format("%R%a");
                            if($date_diff_future <= 0 && $date_diff_past >= 0){
                              echo "Currently being used";
                              break;
                              // echo $status['ContractID'] . " " . date_diff(date_create(date("Y-m-d",strtotime($status['StartDate']))), date_create(date("Y-m-d")))->format("%R%a") . "<br>";
                            }
                            else if($date_diff_future > 0){
                              echo "Next contract in " . $date_diff_future . " days";
                              break;
                            }
                          }
                        }

                        // Is this space currently under lease?
                        // echo "Currently Leased to " . $FirstName . " . $LastName;
                        //
                        // else if this space has a contract in the futurefuture
                        // echo "Next contract in " . date_diff . "days";
                        //
                        //  else if this space has a contract in the past
                        //  echo "Last contract " . date_diff . "ago";
                        //
                        // else
                        // echo "--";
                        ?>
                      </td>
                      <td>
                        <a href="editLocation.php?location=<?php $location = "2"; echo $location; ?>">
                          <button>Edit</button></a>
                        </td>
                      </tr>
                      <?php
                      $warehouse = $mainSqlResult['WarehouseID'];
                    }
                    else {?>
                      <td></td>
                      <td><?php echo $mainSqlResult['SpaceID']; ?></td>
                      <td></td>
                      <td>
                        <?php
                        // Is this space currently under lease?
                        // echo "Currently Leased to " . $FirstName . " . $LastName;
                        //
                        // else if this space has a contract in the futurefuture
                        // echo "Next contract in " . date_diff . "days";
                        //
                        //  else if this space has a contract in the past
                        //  echo "Last contract " . date_diff . "ago";
                        //
                        // else
                        // echo "--";
                        echo "--";
                        ?>
                      </td>
                      <td>
                        <a href="editLocation.php?location=<?php $location = "2"; echo $location; ?>">
                          <button>Edit</button></a>
                        </td>
                      <?php } ?>
                    </tr>
                  <?php } ?>
                </tbody>
              </table>
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
