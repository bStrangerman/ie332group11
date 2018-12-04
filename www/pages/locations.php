<?php
require_once "../includes/main.php";

//set the fee rate
$feeRate = 1.05;

// checks if they are a proper user
$root = $rbac->Users->hasRole('root', $UserID = $_SESSION['UserID']);

// checks if the user is logged in and is a warehouse owner
if (isset($_SESSION['UserID'])) {
  // checks if they are a proper user
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID']) || !$root)
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
  FROM Warehouses
  LEFT JOIN Spaces
  ON Spaces.WarehouseID = Warehouses.WarehouseID " . ((!$root) ? "" : "
  WHERE Warehouses.OwnerID = $UserID") . "
  ORDER BY Warehouses.WarehouseID ASC, Spaces.SpaceID ASC";
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
                <button type="button" class="btn btn-default btn-xs">
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
                  <th>Current Status</th>
                  <th>Utilization</th>
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

                    // Is this a new warehouse row? then print out the warehouse information
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

                      //gets the profit for each warehouse
                      $profitByWarehouseResult = $conn -> query($profitByWarehouseSQL);
                      $max_profit_per_warehouse = 0;
                      if(isset($mainSqlResult['SpaceID'])){
                        while($profitByWarehouse = $profitByWarehouseResult -> fetch_assoc()){
                          if($profitByWarehouse['Profit'] > $max_profit_per_warehouse){
                            $max_profit_per_warehouse = $profitByWarehouse['Profit'];
                          }
                        }
                      }
                      // print the profit for each warehouse - our fee
                      echo "$ " . round($max_profit_per_warehouse / $feeRate,2);

                      ?></td>
                      <td></td>
                      <td></td>
                      <td><a href="editLocation.php?edit=1&warehouse=<?php echo $warehouseID; ?>">
                        <button class="btn btn-outline btn-primary">Edit</button></a></td>
                      </tr>
                      <!-- Print out the first space information -->
                      <tr>
                        <td align="center">-</td>
                        <td><?php
                        $space = $mainSqlResult['SpaceID'];
                        echo $mainSqlResult['SpaceID'];
                        ?></td>
                        <td>
                          <?php
                          $profitBySpaceSQL = "SELECT SUM(Contracts.AmountCharged) AS Profit
                          FROM Contracts
                          WHERE Contracts.SpaceID = $space
                          GROUP BY Contracts.SpaceID";

                          //gets the profit for each warehouse
                          $profitBySpaceResult = $conn -> query($profitBySpaceSQL);
                          $max_profit_per_space = 0;
                          if(isset($mainSqlResult['SpaceID'])){
                            while($profitBySpace = $profitBySpaceResult -> fetch_assoc()){
                              if($profitBySpace['Profit'] > $max_profit_per_space){
                                $max_profit_per_space = $profitBySpace['Profit'];
                              }
                            }
                          }
                          // print the profit for each warehouse - our fee
                          echo "$ " . round($max_profit_per_space / $feeRate,2);

                          ?>
                        </td>
                        <td>
                          <?php
                          // Get all the contracts for this space
                          $statusSQL = "SELECT *
                          FROM Contracts
                          LEFT JOIN Contract_Status
                          ON Contract_Status.ContractID = Contracts.ContractID
                          LEFT JOIN Status
                          ON Status.StatusID = Contract_Status.StatusID
                          WHERE SpaceID = $space";
                          $statusResult = $conn -> query($statusSQL);

                          //displays important status of the space
                          $isThere_aStatus = FALSE; //checks if there is a status
                          if(isset($mainSqlResult['SpaceID'])){

                            while($status = $statusResult -> fetch_assoc()){
                              $isThere_aStatus = TRUE;  //set status as true
                              if(isset($status['ContractID'])){
                                $date_diff_future = date_diff(date_create(date("Y-m-d",strtotime($status['StartDate']))), date_create(date("Y-m-d")))->format("%R%a");
                                $date_diff_past = date_diff(date_create(date("Y-m-d",strtotime($status['EndDate']))), date_create(date("Y-m-d")))->format("%R%a");
                                echo "future: " . $date_diff_future . " past: " . $date_diff_past . "<br>";
                                if($date_diff_future <= 0 && $date_diff_past <= 0){
                                  echo "Currently being leased";
                                  break;
                                }
                                else if($date_diff_future > 0 && $date_diff_past < 0){
                                  echo "Next lease in " . $date_diff_future . " days";
                                  break;
                                }
                                else if($date_diff_future < 0 && $date_diff_past > 0){
                                  echo "Last lease was " . $date_diff_past . " days ago";
                                  break;
                                }
                                else{
                                  echo "Never been leased";
                                }
                              }
                            }                    }

                            if ($isThere_aStatus == FALSE){
                              echo "Never been leased";
                            }
                            ?>
                          </td>
                          <td><?php echo round(100 - Utilization($space, time(), time()), 2); ?>%</td>
                          <td>
                            <a href="editSpace.php?edit=1&space=<?php echo $space; ?>">
                              <button class="btn btn-outline btn-primary">Edit</button></a>
                            </td>
                          </tr>
                          <?php
                          $warehouse = $mainSqlResult['WarehouseID'];
                        }
                        // print out the rest of the spaces for this warehouse
                        else {?>
                          <td align="center">-</td>
                          <td><?php
                          $space = $mainSqlResult['SpaceID'];
                          echo $mainSqlResult['SpaceID'];
                          ?></td>
                          <td>
                            <?php
                            $profitBySpaceSQL = "SELECT SUM(Contracts.AmountCharged) AS Profit
                            FROM Contracts
                            WHERE Contracts.SpaceID = $space
                            GROUP BY Contracts.SpaceID";

                            //gets the profit for each warehouse
                            $profitBySpaceResult = $conn -> query($profitBySpaceSQL);
                            $max_profit_per_space = 0;
                            if(isset($mainSqlResult['SpaceID'])){

                              while($profitBySpace = $profitBySpaceResult -> fetch_assoc()){
                                if($profitBySpace['Profit'] > $max_profit_per_space){
                                  $max_profit_per_space = $profitBySpace['Profit'];
                                }
                              }
                            }

                            // print the profit for each warehouse - our fee
                            echo "$ " . round($max_profit_per_space / $feeRate,2);?>
                          </td>
                          <td>
                            <?php
                            // Get all the contracts for this space
                            $statusSQL = "SELECT *
                            FROM Contracts
                            LEFT JOIN Contract_Status
                            ON Contract_Status.ContractID = Contracts.ContractID
                            LEFT JOIN Status
                            ON Status.StatusID = Contract_Status.StatusID
                            WHERE SpaceID = $space";
                            $statusResult = $conn -> query($statusSQL);

                            //displays important status of the space
                            $isThere_aStatus = FALSE; //checks if there is a status
                            if(isset($mainSqlResult['SpaceID'])){

                              while($status = $statusResult -> fetch_assoc()){
                                $isThere_aStatus = TRUE;  //set status as true
                                if(isset($status['ContractID'])){
                                  $date_diff_future = date_diff(date_create(date("Y-m-d",strtotime($status['StartDate']))), date_create(date("Y-m-d")))->format("%R%a");
                                  $date_diff_past = date_diff(date_create(date("Y-m-d",strtotime($status['EndDate']))), date_create(date("Y-m-d")))->format("%R%a");
                                  echo "future: " . $date_diff_future . " past: " . $date_diff_past . "<br>";

                                  if($date_diff_future <= 0 && $date_diff_past <= 0){
                                    echo "Currently being leased";
                                    break;
                                  }
                                  else if($date_diff_future > 0 && $date_diff_past < 0){
                                    echo "Next lease in " . $date_diff_future . " days";
                                    break;
                                  }
                                  else if($date_diff_future < 0 && $date_diff_past > 0){
                                    echo "Last lease was " . $date_diff_past . " days ago";
                                    break;
                                  }
                                  else{
                                    echo "Never been leased";
                                  }
                                }
                              }
                            }
                            if ($isThere_aStatus == FALSE){
                              echo "Never been leased";
                            }
                            ?>
                          </td>
                          <td><?php echo round(100 - Utilization($mainSqlResult['SpaceID'], time(), time()) , 2); ?>%</td>
                          <td>
                            <a href="editSpace.php?edit=1&space=<?php echo $space; ?>">
                              <button class="btn btn-outline btn-primary">Edit</button></a>
                            </td>
                          <?php } ?>
                        </tr>
                      <?php } ?>
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
