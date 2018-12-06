<?php
require_once "../includes/main.php";
// checks if user has proper roles
$root = $rbac->Users->hasRole('root', $UserID = $_SESSION['UserID']);

$UserID = $_SESSION['UserID'];
if(isset($_SESSION['UserID'])){
  if(!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID'])){
    header('Location: warehouse.php');
  }
  else if (isset($_GET['contract'])){
    $contract = clean($_GET['contract']);

    // Getting Contract and Warehouse address
    $sql = "SELECT *
    FROM Contracts
    LEFT JOIN Spaces
    ON Spaces.SpaceID = Contracts.SpaceID
    LEFT JOIN Warehouses
    ON Warehouses.WarehouseID = Spaces.WarehouseID
    LEFT JOIN phprbac_users
    ON phprbac_users.UserID = Warehouses.OwnerID
    WHERE Warehouses.OwnerID = $UserID
    AND Contracts.ContractID = $contract";

    $results = $conn -> query($sql);
    while($contractInfo[] = mysqli_fetch_array($results));

    // get the lessee's information
    $lesseeID = $contractInfo[0]['LesseeID'];
    $sql = "SELECT *
            FROM phprbac_users
            WHERE UserID = $lesseeID";
    $lesseeResult = $conn -> query($sql);
    while($lesseeInfo[] = mysqli_fetch_array($lesseeResult));

    if(count($contractInfo) <= 1){
      header("Location: index.php");
      exit;
    }

    // $contractInfo['City']
    $warehouseID = $contractInfo[0]['WarehouseID'];
    // Getting the Picture

    $sql = "SELECT *
    FROM Warehouse_Pictures
    LEFT JOIN Pictures
    ON Pictures.PictureID = Warehouse_Pictures.PictureID
    WHERE WarehouseID = $warehouseID
    ORDER BY Pictures.PictureID
    LIMIT 1";
    $pictureResult = ($conn -> query($sql));
    $picture = $pictureResult -> fetch_assoc();
  }
  // END OF GETTING PICTURE
  //



  // if(count(($conn -> query($sql)) -> fetch_assoc()) > 0) {
  //   header('Location: index.php');
  // }
}

else {
  echo "Not Logged In";
  $_SESSION['redirect'] = 'Lessee_Survey_2.php?contract=' . clean($_GET['contract']);
  // header('Location: login.php');
}
require_once "../layouts/sb_admin_2/header.php";


if($root){
  echo "You need to be signed in as an owner to review contracts.";
  exit;
}

?>
<!-- =====================================
=            TABLE OF NAMES             =
=========================================
= own_title -> title of the review      =
= own_body -> Body of the review        =
= own_feedback -> Feedback to owner     =
= own_files -> Review pictures          =
= own_rating -> overall Rating          =
=                                       =
======================================-->
<!-- The variables for the out of 5 ratings arent in the code. -->


<!--=========================
=     WAREHOUSE LOCATION    =
==========================-->

<!-- Owl Carousel -->
<link href="../includes/plugins/slick-carousel/slick/slick.css" rel="stylesheet">
<link href="../includes/plugins/slick-carousel/slick/slick-theme.css" rel="stylesheet">

<script src='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.js'></script>
<link href='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.css' rel='stylesheet' />

<!--==================================
=            User Profile            =
===================================-->






<div id="page-wrapper">
  <div class="row">
    <div class="col-lg-12">

      <!-- Make this Get there names -->
      <h1 class="page-header">Owner Survey</h1>
    </div>
    <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading">
          Location info
        </div>

        <div class="panel-body">
          <?php
          $ownerID = $contractInfo[0]['OwnerID'];
          $ownerSQL = "SELECT *
                       FROM phprbac_users
                       WHERE UserID = $ownerID";
          $ownerResult = $conn -> query($ownerSQL);
          while($ownerInfo[]=mysqli_fetch_array($ownerResult));
          ?>
          <form action = "../includes/lessee_survey_submit.php" method="post">
            <!-- Edit Leese Info -->
            <input type="hidden" id="contract" name="contract" value="<?php echo $contract; ?>">
            <input type="hidden" id="owner" name="owner" value="<?php echo $ownerInfo[0]['UserID']; ?>">
            <input type="hidden" id="lesseeFirstName" name="lesseeFirstName" value="<?php echo $ownerInfo[0]['FirstName']; ?>">
            <input type="hidden" id="lesseeLastName" name="lesseeLastName" value="<?php echo $ownerInfo[0]['LastName']; ?>">
              <p><strong>Address:</strong><address> <?php echo $contractInfo[0]['Address']; ?>
              <br><strong>          </strong> <?php  echo $contractInfo[0]['City'] . ", " . $contractInfo[0]['State'] . " " . $contractInfo[0]['ZipCode']; ?> </address></p>
              <p><strong>Space Lessee:</strong> <?php echo $lesseeInfo[0]['FirstName'] . " " . $lesseeInfo[0]['LastName']; ?>
              <p><strong>Company:</strong> <?php echo $lesseeInfo[0]['Company']; ?></p>
              <p><strong>Contract Dates:</strong> <?php echo date("m/d/Y", strtotime($contractInfo[0]['StartDate'])) . " to " . date("m/d/Y", strtotime($contractInfo[0]['EndDate'])); ?></p>
              <p><strong>Contract Details:</strong> <?php echo $contractInfo[0]['ContractInformation']; ?></p>






        </div>





</div>
<div class="panel panel-default">
        <div class="panel-heading">
          Create Your Review
        </div>
        <div class="panel-body">
          Thank you for taking the time to rate your experience with <?php  echo $lesseeInfo[0]['FirstName'] . " " . $lesseeInfo[0]['LastName']; ?>. Please note that only the written review will be public.  The star rating is for internal use.
          <div class="row">
            <div class="col-lg-12">
              <form method="post" action = "../includes/lessee_survey_submit.php" role="form">

<!--==============
=   LOAD SPACE   =
===============-->



<!--===================
=     LYKERT SCALES   =
=======================
for Accuracy of Listing, Communication with Staff, Friendlyness of Staff, Location of Warehouse, Value of Space -->

                <div class="form-group">
                  <br>
                  <label>Overall Rating</label> <br>
                  <label class="radio-inline">
                    <input type="radio" name="own_rating" id="optionsRadiosInline1" value="1">1
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="own_rating" id="optionsRadiosInline2" value="2">2
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="own_rating" id="optionsRadiosInline3" value="3">3
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="own_rating" id="optionsRadiosInline4" value="4">4
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="own_rating" id="optionsRadiosInline5" value="5">5
                  </label>
                </div>
                <!-- END OF LYKERT -->

                <h1 class="page-header"></h1> <!--  Spacing  -->
<!--==================
=   WRTITEN REVIEWS  =
===================-->
                <div class="form-group">
                  <label>Title of your review</label>
                  <input class="form-control" placeholder="What's important to know?" name="own_title">
                </div>

                <!-- Experience with warehouse -->
                <div class="form-group">
                  <label>Share your experience with this lessee</label>
                  <textarea class="form-control" placeholder="How was your warehouse experience?  What did you like or dislike?" rows="3" name="own_body"></textarea>
                </div>
                <h1 class="page-header"></h1> <!--  Spacing  -->
                <!-- END OF Experience -->

<!--==================
=   FILE SUBMISSION  =
===================-->

                <div class="form-group">
                  <label>Add an image </label>
                  <input type="file" accept= "image/*" name="ls_files" id="file_submit">
                </div>


    <!-- Code found on https://jsfiddle.net/7bjfr/808/ -->
    <!--Size Checker-->
    <script>
    var uploadField = document.getElementById("file_submit");

    uploadField.onchange = function() {
        if(this.files[0].size > 2200000){
           alert("File is too big! <br> Upl");
           this.value = "";
        };
    };
    </script>
    <!-- END OF SUBMISSION -->

<button type="submit" class="btn btn-default">Submit Button</button>

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
<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
</div>
<!-- /#page-wrapper -->

</div>
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

<?php require_once "../layouts/sb_admin_2/footer.php"; ?>
