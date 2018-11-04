<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";


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

function getContractInfo($contractID, $UserID){
  return "SELECT *
  FROM phprbac_users
  INNER JOIN contracts
  ON contracts.LesseeID = phprbac_users.UserID
  INNER JOIN spaces
  ON contracts.SpaceID = spaces.SpaceID
  INNER JOIN warehouses
  ON warehouses.warehouseID = spaces.warehouseID
  INNER JOIN Contract_status
  ON Contract_Status.ContractID = Contracts.ContractID
  INNER JOIN status
  ON status.StatusID = Contract_Status.StatusID
  WHERE contracts.contractID = $contractID
  AND warehouses.OwnerID = $UserID
  ORDER BY StatusTime DESC";
}


if(isset($_GET['contract'])){  // checks if the customer is searching a contract
  // echo "<h1>URL has a contract ID in it. " . $_GET['contract'] . "</h1><br>";

  if(isset($_SESSION['contractID'])){  // checks if a contract is in the session
    // echo "<h1>Session has a contractID already in it. " . $_SESSION['contractID'] . "</h1><br>";

    if($_SESSION['contractID'] != $_GET['contract']){  // checks if the sessioned contract is the same as the search
      // echo "<h1>current contractID not in session. I am storing new contract info</h1><br>";

      // if the session changed
      $_SESSION['contractID'] = $_GET['contract'];  // saves the new contract into the session
      $contractID = $_SESSION['contractID'];  // stored for local use
      // sql query for new contract info

      $mainSqlResult = ($conn -> query(getContractInfo($contractID, $UserID)) -> fetch_assoc());
      $_SESSION['contractInfo'] = $mainSqlResult;  // store the results into the session
      if($mainSqlResult['StatusName'])
      $contractStatus = $mainSqlResult['StatusName'];
    }
    else {
      // echo "<h1>current contractID is in session. </h1><br>";

      // if the contract and session did not change
      $contractID = $_SESSION['contractID'];  // retrieve the contract ID from the session
      $mainSqlResult = $_SESSION['contractInfo'];  // retrieve the contract info from the session

      // input the status into the database iff the contract number DID NOT change
      if(isset($_POST['status'])){
        set_contract_status($contractID, $_POST['status'], $conn);
        $mainSqlResult = ($conn -> query(getContractInfo($contractID, $UserID)) -> fetch_assoc());
      }


      // prevents the accept cotract button from showing if it has already been approved or denied
      if($mainSqlResult['StatusName'])
      $contractStatus = $mainSqlResult['StatusName'];
    }
  }
  else {
    // echo "<h1>Session does not have a contractID. Storing contract info.</h1><br>";
    // Initial page setup

    // configure the contract ID's
    $_SESSION['contractID'] = $_GET['contract'];
    $contractID = $_SESSION['contractID'];

    // sql query for new contract info
    $mainSqlResult = ($conn -> query(getContractInfo($contractID, $UserID))) -> fetch_assoc();

    $_SESSION['contractInfo'] = $mainSqlResult;  // store the results into the session

    // prevents the accept cotract button from showing if it has already been approved or denied
    if($mainSqlResult['StatusName'])
      $contractStatus = $mainSqlResult['StatusName'];
  }

  // redirects if the user has no contract with that number
  // header('Location: warehouse.php');
  // if(!$mainSqlResult['countof']){
  // }






}
require_once "../layouts/sb_admin_2/header.php";

?>

<!-- Page Content -->
<div id="page-wrapper">
  <div class="container-fluid">
    <div class="row">
      <div class="col-lg-12">
        <h1 class="page-header">Contract No. <?php echo $contractID; ?></h1>
      </div>
      <!-- /.col-lg-12 -->
    </div>
    <div class="row">
      <div class="col-lg-12">
        <!-- Changes box color depending on status -->
        <div class="panel <?php
        echo ($contractStatus == "Approved") ? "panel-green" : "";
        echo ($contractStatus == "Denied") ? "panel-red" : "";
        echo ($contractStatus == "Pending") ? "panel-yellow" : "";
        echo ($contractStatus == "") ? "panel-default" : "";
        ?>">
        <div class="panel-heading">
          <?php
          $address = $mainSqlResult['Address'] . "<br>" . $mainSqlResult['City'] . " " . $mainSqlResult['State'] . (($mainSqlResult['ZipCode'] != NULL) ? ", " . $mainSqlResult['ZipCode'] : "");
          echo $address; ?>
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
          <h4><?php
          $startdate = date("M d, Y", strtotime($mainSqlResult['StartDate']));
          $enddate = date("M d, Y", strtotime($mainSqlResult['EndDate']));
          echo $startdate . " to " . $enddate . "</h4>";
          $lesseeID = $mainSqlResult['LesseeID'];
          echo "Name: " . $mainSqlResult['FirstName'] . " " . $mainSqlResult['LastName'] . "<br>";
          echo "Company: " . $mainSqlResult['Company'] . "<br>";
          echo "Phone Number: " . $mainSqlResult['PhoneNumber'] . "<br>";
          echo "Email: " . $mainSqlResult['Email'] . "<br><br>";

          echo "<h4>The customer provided this information regarding what the space will be used for:</h4>";
          echo "<p>" . $mainSqlResult['ContractInformation'] . "</p><br>";

          // get the number of contracts (of any status) for this customer
          $getCustomerPreviousCount = "SELECT COUNT(*) as COUNT
          FROM contracts
          WHERE LesseeID = $lesseeID";

          echo "<h4>Important Client Information</h4>";
          $prevCountResult = $conn -> query($getCustomerPreviousCount);
          $prevCount = $prevCountResult -> fetch_assoc();

          if($prevCount['COUNT'] == 1){
            echo "This is this customer's <strong>First</strong> booking on this site.";
          }
          else if($prevCount['COUNT'] == 2){
            echo "This is this customer's <strong>Second</strong> booking on this site.";
          }
          else if($prevCount['COUNT'] == 3){
            echo "This is this customer's <strong>Third</strong> booking on this site.";
          }
          else{
            echo "This is this customer's <strong>" . $prevCount['COUNT'] . "th</strong> Booking on this site.";
          }

          echo "</div>";

          if($contractStatus == "Pending")
          { ?>
            <div class="panel-footer">
              <div class="row">
                <div align="center" class="col-md-6">
                  <button class="btn btn-success" data-toggle="modal" data-target="#accept_contract">
                    Accept this contract
                  </button>
                </div>
                <div align="center" class="col-md-6">
                  <button class="btn btn-danger" data-toggle="modal" data-target="#deny_contract">
                    Deny this contract
                  </button>
                </div>
              </div>

              <!-- Modal -->
              <div class="modal fade" id="accept_contract" tabindex="-1" role="dialog" aria-labelledby="accept_contract" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Are you sure you would like to accept this contract?</h4>
                    </div>
                    <div class="modal-body">
                      This step can only be done once.
                    </div>
                    <div class="modal-footer">
                      <form action="" method="POST">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success" name="status" value="Approved">Approve Contract</button>
                      </form>
                    </div>
                  </div>
                  <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
              </div>

              <div class="modal fade" id="deny_contract" tabindex="-1" role="dialog" aria-labelledby="deny_contract" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Are you sure you would like to deny this contract?</h4>
                    </div>
                    <div class="modal-body">
                      This step can only be done once.
                    </div>
                    <div class="modal-footer">
                      <form action="" method="POST">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger" name="status" value="Denied">Deny Contract</button>
                      </form>
                    </div>
                  </div>
                  <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
              </div>
            </div>
            <!-- /.modal -->
          <?php }
          else if($contractStatus = "Approved" OR $contractStatus = "Denied"){ ?>
            <div class="panel-footer">
              <div class="row">
                <div align="center" class="col-md-12">
                  <button class="btn btn-success" data-toggle="modal" data-target="#accept_contract">
                    Undo
                  </button>
                </div>
              </div>

              <!-- Modal -->
              <div class="modal fade" id="accept_contract" tabindex="-1" role="dialog" aria-labelledby="accept_contract" aria-hidden="true">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h4 class="modal-title" id="myModalLabel">Are you sure you would like to accept this contract?</h4>
                    </div>
                    <div class="modal-body">
                      This step can only be done once.
                    </div>
                    <div class="modal-footer">
                      <form action="" method="POST">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-success" name="status" value="Undo">Undo</button>
                      </form>
                    </div>
                  </div>
                  <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
              </div>
            </div>
            <!-- /.modal -->
            <?php

          } ?>

        </div>
        <!-- /.panel-body -->
      </div>
      <!-- /.panel -->
    </div>
    <!-- /.row -->
  </div>
  <!-- /.container-fluid -->
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
