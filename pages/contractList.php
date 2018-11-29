<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";

$feeRate = 1.05;

if (isset($_SESSION['UserID'])) {
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID']))
    header('Location: index.php');
  else
    $UserID = $_SESSION['UserID'];
}
else {
  $_SESSION['redirect'] = 'Location: contractList.php';
  header('Location: login.php');
}
// FIXME: currently an error with  Notice: Undefined index: contractInfo in C:\xampp\htdocs\ie332group11\pages\contract.php on line 44
// Checks if the URL has a contract ID in it

function getContractInfo($UserID){
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
  WHERE warehouses.OwnerID = $UserID
  ORDER BY StatusTime DESC";
}

$mainSqlResult = $conn -> query(getContractInfo($UserID));

require_once "../layouts/sb_admin_2/header.php";

?>

<style>
table tr[data-href] {
    cursor: pointer;
}
</style>
<!-- DataTables CSS -->
<link href="../vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="../vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

<!-- Page Content -->

<div id="page-wrapper">
  <div class="row">
    <div class="col-lg-12">
      <h1 class="page-header">All Contracts</h1>
    </div>
    <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading">
          Contracts
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
          <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
            <thead>
              <tr>
                <th>Contract ID</th>
                <th>Location</th>
                <th>Client</th>
                <th>Dates</th>
                <th>Profit</th>
              </tr>
            </thead>
            <tbody>
              <?php
              $i = 1;
              while($row = $mainSqlResult -> fetch_assoc()){ ?>
                  <tr data-href="contract.php?contract=<?php echo $row['ContractID']; ?>" <?php
                  switch ($row['StatusName']) {
                    case "Approved":
                    echo "class='success'";
                    break;
                    case "Denied":
                    echo "class='danger'";
                    break;
                    case "Pending":
                    echo "class='warning'";
                    break;
                    default:
                    echo "";
                  }

                  ?>>

                  <td><?php echo $row['ContractID']; ?></td>
                  <td><?php echo $row['Address']; ?></td>
                  <td><?php echo $row['FirstName'] . " " . $row['LastName']; ?></td>
                  <td><?php echo date("m-d-Y", strtotime($row['StartDate'])) . " to " . date("m-d-Y", strtotime($row['EndDate'])); ?></td>
                  <td><?php echo "$" . ($row['AmountCharged'] / $feeRate); ?></td>
                </tr>
              <?php $i++;
            } ?>
          </tbody>
        </table>
        <h5 align="right">Current Fee Rate is <?php echo (($feeRate - 1) * 100); ?>%.  This has already been removed from your Profit.</h5>
        <!-- /.table-responsive -->
      </div>
      <!-- /.panel-body -->
    </div>
    <!-- /.panel -->
  </div>
  <!-- /.col-lg-12 -->

  <div class="row">

  </div>
  <!-- /.row -->
</div>
<!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->


<?php require_once "../layouts/sb_admin_2/footer.php"; ?>
