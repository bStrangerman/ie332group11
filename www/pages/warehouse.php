<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";
$feeRate = 1.05;

// checks if user has proper roles
$root = $rbac->Users->hasRole('root', $UserID = $_SESSION['UserID']);

if (isset($_SESSION['UserID'])) {
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID']) || !$root) {
    // header('Location: login.php');
    $_SESSION['redirect'] = 'Location: warehouse.php';
  }
}

require_once "../layouts/sb_admin_2/header.php";
?>
<div id="page-wrapper">
  <div class="row">
    <div class="col-lg-12">
      <?php
      $UserID = $_SESSION['UserID'];
      $sql = "SELECT Company
      FROM phprbac_users
      WHERE UserID = $UserID";
      $result = $conn -> query($sql);
      $row = $result -> fetch_assoc();
      $company = ($row['Company'] == "") ? "Dashboard" : $row['Company'];
      ?>

      <h1 class="page-header">
        <?php echo $company; ?>
      </h1>
    </div>
    <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-primary">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="fa fa-map-marker fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">
                <?php
                // print number of locations
                $sql = "SELECT COUNT(*) AS countOF
                FROM Warehouses " . (($root) ? "" : " WHERE OwnerID = $UserID");
                $result = $conn -> query($sql);
                while($row = $result -> fetch_assoc()){
                  echo $row['countOF'];
                }?>
              </div>
              <div>Locations</div>
            </div>
          </div>
        </div>
        <a href="locations.php">
          <div class="panel-footer">
            <span class="pull-left">View Details</span>
            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
            <div class="clearfix"></div>
          </div>
        </a>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-green">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="fa fa-clipboard fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">
                <?php
                $sql = "SELECT COUNT(*) AS countOF
                FROM Contracts
                LEFT JOIN Spaces
                ON Spaces.SpaceID = Contracts.SpaceID
                LEFT JOIN Warehouses
                ON Warehouses.WarehouseID = Spaces.SpaceID " . (($root) ? "" : " WHERE Warehouses.OwnerID = $UserID");
                $result = $conn -> query($sql);
                while($row = $result -> fetch_assoc()){
                  echo $row['countOF'];
                }?>
              </div>
              <div>Contracts</div>
            </div>
          </div>
        </div>
        <a href="contractList.php">
          <div class="panel-footer">
            <span class="pull-left">View Details</span>
            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
            <div class="clearfix"></div>
          </div>
        </a>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-yellow">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="fa fa-inbox fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">
                <?php
                $sql = "SELECT *
                FROM Contracts
                LEFT JOIN Spaces
                ON Spaces.SpaceID = Contracts.SpaceID
                LEFT JOIN Warehouses
                ON Warehouses.WarehouseID = Spaces.WarehouseID
                LEFT JOIN Contract_Status
                ON Contract_Status.ContractID = Contracts.ContractID
                LEFT JOIN Status
                ON Status.StatusID = Contract_Status.StatusID " . (($root) ? "" : "
                WHERE Warehouses.OwnerID = $UserID
                ORDER BY Contract_Status.StatusTime DESC");

                $result = $conn -> query($sql);
                $sum = 0;
                while($row = $result -> fetch_assoc()){
                  if($row['StatusName'] == 'Pending')
                  $sum++;
                }
                echo $sum;
                ?>
              </div>
              <div>Pending Contracts</div>
            </div>
          </div>
        </div>
        <a href="contractList.php">
          <div class="panel-footer">
            <span class="pull-left">View Details</span>
            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
            <div class="clearfix"></div>
          </div>
        </a>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-<?php echo ($root) ? "green" : "red"; ?>">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="<?php echo ($root ? "fa fa-money" : "fa fa-thumbs-o-up"); ?> fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">
                <?php
                if(!$root){
                  $sql = "SELECT COUNT(*) AS countOF
                  FROM Contracts
                  LEFT JOIN Spaces
                  ON Spaces.SpaceID = Contracts.SpaceID
                  LEFT JOIN Warehouses
                  ON Warehouses.WarehouseID = Spaces.WarehouseID " . (($root) ?
                  "WHERE ( " : "WHERE Warehouses.OwnerID = $UserID AND ( ") . "
                  ContractID NOT IN (
                    SELECT ContractID
                    FROM Numeric_Contract_Ratings
                    )
                    OR
                    ContractID NOT IN (
                      SELECT ContractID
                      FROM Numeric_Contract_Ratings
                      )
                      )";
                      $result = $conn -> query($sql);
                      while($row = $result -> fetch_assoc()){
                        $showResult = $row['countOF'];
                      }
                }
                else {
                  $sql = "SELECT SUM(AmountCharged) AS sumOf FROM Contracts";
                  $result = $conn -> query($sql);
                  while($row = $result -> fetch_assoc()){
                    $showResult = $row['sumOf'];
                  }
                }

                echo "$" . round(($showResult) / $feeRate * ($feeRate - 1), 2);

                    ?>
                  </div>
                  <div><?php echo ($root) ? "Profit" : "Pending Reviews"; ?></div>
                </div>
              </div>
            </div>
            <a href="#">
              <div class="panel-footer">
                <span class="pull-left">View Details</span>
                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                <div class="clearfix"></div>
              </div>
            </a>
          </div>
        </div>
      </div>
      <?php
      $sql = "SELECT SUM(AmountCharged) AS Profit, COUNT(*) AS countOF
      FROM Contracts
      WHERE ContractID = $UserID";

      $result = $conn -> query($sql);
      while($row = $result -> fetch_assoc()){
        $percentage = round((($row['Profit'] / 500000) * 100),2);
        $profit = round($row['Profit'],2);
      }
      include_once "../includes/css/ThermometerStyle.php"; ?>

      <div class="row">
        <style>
        div.temp * {
          font-family: 'Nunito', sans-serif;
          box-sizing: border-box;
        }

        div.temp {
          background-color: #142F4C;
        }
        </style>
        <?php
        if(!$root){ ?>
        <div class="col-lg-6">
          <div class="panel panel-default">
            <div class="panel-heading">
              <i class="fa fa-bar-chart-o fa-fw"></i> Rewards System
            </div>
            <div class="temp panel-body">
              <div id="countdown-wrap">
                <div id="goal">$500,000</div>
                <div id="glass">
                  <div id="progress"></div>
                </div>
                <div class="goal-stat">
                  <span class="goal-number"><?php echo $percentage;?>% </span>
                  <span class="goal-label">Funded</span>
                </div>
                <div class="goal-stat">
                  <span class="goal-number">$<?php echo $profit;?></span>
                  <span class="goal-label">Raised</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    <?php } ?>
      <!-- /.row -->
      <div class="row">
        <div class="col-lg-8">
          <div class="panel panel-default">
            <div class="panel-heading">
              <i class="fa fa-bar-chart-o fa-fw"></i> Area Chart Example
            </div><div class="panel-body">
              <div id ="AreaGraph"></div>
            </div>
            <?php
            //Calculates time since account creation
            $curdate = date("Y/m/d");
            $diff = $curdate - DATE($StartDate);
            //Breaks total time into 4 quarters for divisions
            $DateIncr = $diff / 4;
            //Each quarter is a separate query to accomodate time difference
            $quarter1SQL ="SELECT Contracts.AmountCharged, Contracts.SpaceID
            FROM Contracts
            LEFT JOIN phprbac_users
            ON phprbac_users.UserID = $UserID
            WHERE phprbac_users.CreationDate < StartDate + INTERVAL $DateIncr DAY AND phprbac_users.CreationDate > StartDate
            AND Contracts.SpaceID IN (
              SELECT SpaceID
              FROM Spaces
              WHERE Spaces.WarehouseID IN (
                SELECT WarehouseID
                FROM Warehouses
                WHERE OwnerID = $UserID
              )
            )";

            $quarter2SQL = "SELECT Contracts.AmountCharged, Contracts.SpaceID
            FROM Contracts
            LEFT JOIN phprbac_users
            ON phprbac_users.UserID = $UserID
            WHERE phprbac_users.CreationDate < (StartDate + INTERVAL (2 * $DateIncr) DAY AND phprbac_users.CreationDate > StartDate + INTERVAL $DateIncr DAY)
            AND Contracts.SpaceID IN (
              SELECT SpaceID
              FROM Spaces
              WHERE Spaces.WarehouseID IN (
                SELECT WarehouseID
                FROM Warehouses
                WHERE OwnerID = $UserID
              ))";

              $quarter3SQL = "SELECT Contracts.AmountCharged, Contracts.SpaceID
              FROM Contracts
              LEFT JOIN phprbac_users
              ON phprbac_users.UserID = $UserID
              WHERE phprbac_users.CreationDate <
              (
                StartDate + INTERVAL
                (
                  3 * $DateIncr
                )
                DAY AND phprbac_users.CreationDate > StartDate + INTERVAL
                (
                  2 * $DateIncr
                )
                DAY
              )
              AND Contracts.SpaceID IN
              (
                SELECT SpaceID
                FROM Spaces
                WHERE Spaces.WarehouseID IN
                (
                  SELECT WarehouseID
                  FROM Warehouses
                  WHERE OwnerID = $UserID
                )
              )";

              $quarter4SQL = "SELECT Contracts.AmountCharged, Contracts.SpaceID
              FROM Contracts
              LEFT JOIN phprbac_users
              ON phprbac_users.UserID = $UserID
              WHERE phprbac_users.CreationDate <= $curdate AND phprbac_users.CreationDate > StartDate + INTERVAL
              (
                3 * $DateIncr
              ) DAY
              AND Contracts.SpaceID IN
              (
                SELECT SpaceID
                FROM Spaces
                WHERE Spaces.WarehouseID IN
                (
                  SELECT WarehouseID
                  FROM Warehouses
                  WHERE OwnerID = $UserID
                )
              )";
              $quarter1Result = $conn -> query($quarter1SQL);
              $quarter2Result = $conn -> query($quarter2SQL);
              $quarter3Result = $conn -> query($quarter3SQL);
              $quarter4Result = $conn -> query($quarter4SQL);

              ?>
              <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
              <script type="text/javascript">
              google.charts.load('current', {'packages':['corechart']});
              google.charts.setOnLoadCallback(drawChart);

              function drawChart() {
                var data = google.visualization.arrayToDataTable([
                  //Each array fills with quarterly earnings by space, dependant upon the time between start and current date
                  ['Quarter'<?php
                  $numOfSpaces = $quarter1Result -> num_rows;
                  while($spaces = $quarter1Result -> fetch_assoc())
                  echo ', "' . $spaces['SpaceID'] . '"';
                  ?>],
                  ['Q1'<?php
                  $quarter1Result = $conn -> query($quarter1SQL);
                  if($quarter1Result -> num_rows > 0){
                    while($quarter1 = $quarter1Result -> fetch_assoc())
                    echo "," . $quarter1['AmountCharged'];
                  }
                  else{
                    for($i = 0; $i < $numOfSpaces; $i++){
                      echo ", 0";
                    }
                  }?>],
                  ['Q2'<?php $quarter2Result = $conn -> query($quarter2SQL);
                  if($quarter2Result -> num_rows > 0){
                    while($quarter2 = $quarter2Result -> fetch_assoc())
                    echo ", " . $quarter2['AmountCharged'];
                  }
                  else{
                    for($i = 0; $i < $numOfSpaces; $i++){
                      echo ", 0";
                    }
                  }?>],
                  ['Q3'<?php $quarter3Result = $conn -> query($quarter3SQL);
                  if($quarter3Result -> num_rows > 0){
                    while($quarter3 = $quarter3Result -> fetch_assoc())
                    echo $quarter3['AmountCharged'] . ',';
                  }
                  else{
                    for($i = 0; $i < $numOfSpaces; $i++){
                      echo ", 0";
                    }
                  }?>],
                  ['Q4' <?php $quarter4Result = $conn -> query($quarter4SQL);
                  if($quarter4Result -> num_rows > 0){
                    while($quarter4 = $quarter4Result -> fetch_assoc())
                    echo ", " . $quarter4['AmountCharged'];
                  }
                  else{
                    for($i = 0; $i < $numOfSpaces; $i++){
                      echo ", 0";
                    }
                  }?>]
                ]);

                var options = {
                  title: 'Relatives Earnings by Space',
                  hAxis: {title: 'Time',  titleTextStyle: {color: '#333'}},
                  vAxis: {minValue: 0}
                };
                var options_fullStacked = {
                  isStacked: 'relative',
                  height: 300,
                  legend: {position: 'top', maxLines: 10},
                  vAxis: {
                    minValue: 0,
                    ticks: [0, .25, .5, .75, 1]
                  }
                };

                var chart = new google.visualization.AreaChart(document.getElementById('AreaGraph'));
                chart.draw(data, options);
              }
              </script>
            </div>
            <!-- /.panel-body -->
          </div>
        </div>


        <!-- /.row -->
        <div class="row">
          <div class="col-lg-8">
            <!-- /.panel -->
            <div class="panel panel-default">
              <div class="panel-heading">
                <i class="fa fa-bar-chart-o fa-fw"></i> Profit By Warehouse
              </div>
              <!-- /.panel -->
              <div class="panel-body">
                <div id="myChart"></div>
              </div>
            </div>

            <?php
            $sqlBarGraph = "SELECT *
            FROM Contracts
            RIGHT JOIN Spaces
            ON Spaces.SpaceID = Contracts.SpaceID
            RIGHT JOIN Warehouses
            ON Warehouses.WarehouseID = Spaces.WarehouseID
            WHERE Warehouses.OwnerID = $UserID
            GROUP BY Warehouses.WarehouseID";

            $data=$conn -> query($sqlBarGraph);

            ?>
            <script>
            //assigns the amount charged data into myData
            var myData=[<?php while($info = $data -> fetch_assoc()) echo
            $info['AmountCharged'] . ','; ?>];
            //Grabs total money earned by space and spaceID

            //assigns SpaceID into labels on bar gragh
            var myLabels=[<?php
            while($info = $data -> fetch_assoc())
            echo '"'.$info['WarehouseID'].'",';
            ?>];
            </script>

            <script>
            window.onload=function(){
              zingchart.render({
                id:"myChart",
                width:"100%",
                height:400,
                data:{
                  "type":"bar",
                  "title":{
                    "text":"Total Earnings by Warehouse"
                  },
                  "scale-x":{
                    "labels":myLabels
                  },
                  "series":[
                    {
                      "values":myData
                    }
                  ]
                }
              });
            };
            </script>
          </div>
        </div>


    <!-- /.row -->
    <div class="row">
      <div class="col-lg-8">

      <div class="panel panel-default">
        <div class="panel-heading">
          <i class="fa fa-bell fa-fw"></i> Notifications Panel
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
          <div class="list-group">
            <?php
            $n = 9;
            $i = 0;
            $alertInfo = getRecentInfo($_SESSION['UserID'], $n);
            while ($i < count($alertInfo)) {
              $alert = $alertInfo[$i];
              echo "<a href='" . $alert[$NotificationLink] . "' class='list-group-item'>
              <i class='fa ". $alert[$NotificationTypeTypeIcon] . " fa-fw'></i> " . $alert[$NotificationTypeTypeName] . "
              <span class='pull-right text-muted small'><em> " . time_ago(date("Y-m-d H:i:s", strtotime($alert[$NotificationTimeElapsed]))) . "</em>
              </span>
              </a>";
              $i++;
            }
            ?>
          </div>
          <!-- /.list-group -->
          <a href="#" class="btn btn-default btn-block">View All Alerts</a>
        </div>
        <!-- /.panel-body -->
      </div>
    </div>
    </div>
  </div>
    <!-- /.row -->
  </div>
  <!-- /#page-wrapper -->

  <?php require_once "../layouts/sb_admin_2/footer.php"; ?>
