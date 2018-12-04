<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";

$feeRate = 1.05;

if (isset($_SESSION['UserID'])) {
  if (!$rbac->Users->hasRole('root', $UserID = $_SESSION['UserID']))
    header('Location: index.php');
  else
    $UserID = $_SESSION['UserID'];
}
else {
  $_SESSION['redirect'] = 'Location: adminContract.php';
  header('Location: login.php');
}
// Checks if the URL has a contract ID in it

function getContractInfo(){
  return "SELECT *
  FROM Contracts
  INNER JOIN phprbac_users
  ON phprbac_users.UserID = Contracts.LesseeID
  INNER JOIN Spaces
  ON Contracts.SpaceID = Spaces.SpaceID
  INNER JOIN Warehouses
  ON Warehouses.WarehouseID = Spaces.WarehouseID
  INNER JOIN Contract_Status
  ON Contract_Status.ContractID = Contracts.ContractID
  INNER JOIN Status
  ON Status.StatusID = Contract_Status.StatusID
  ORDER BY Contracts.ContractID ASC";
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
                <th>View</th>
                <th>Review</th>
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
                  <td><?php echo "$" . round(($row['AmountCharged'] / $feeRate)); ?></td>
                  <td><a href="contract.php?contract=<?php echo $row['ContractID']; ?>">
                    <button class="btn btn-primary">View</button></a></td>
                  <td><a href="Owner_Survey.php?contract=<?php echo $row['ContractID']; ?>">
                    <button class="btn btn-primary">Review</button></a></td>
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
