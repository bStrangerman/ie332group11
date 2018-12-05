<?php
require_once "../includes/main.php";

$feeRate = 1.05;

if(!isset($_SESSION['UserID'])){
  $_SESSION['redirect'] = 'Location: ' . $_SERVER['REQUEST_URI'];
  header("Location: login.php");
}
else if (!$rbac->check('can_lease', $UserID = $_SESSION['UserID'])){
  header("Refresh: 10; index.php");
  echo "You don't have the proper permissions to lease a location. This page will redirect in 10 seconds.";
  exit;
}

require_once "../layouts/Calssimax/header.php";

if(isset($_GET['address']))
$address = clean(urldecode($_GET['address']));

if(isset($_GET['space']))
$space = clean($_GET['space']);

$sql = "SELECT *
FROM Spaces
LEFT JOIN Warehouses
ON Spaces.WarehouseID = Warehouses.WarehouseID
LEFT JOIN phprbac_users
ON phprbac_users.UserID = Warehouses.OwnerID
WHERE Spaces.SpaceID = $space";
$result = $conn -> query($sql);
while($spaceInfo[]=mysqli_fetch_array($result));

$warehouseID = $spaceInfo[0]['WarehouseID'];
$ownerID = $spaceInfo[0]['OwnerID'];

$_SESSION['book_info'] = $_POST;
?>
<!-- Owl Carousel -->
<link href="../includes/plugins/slick-carousel/slick/slick.css" rel="stylesheet">
<link href="../includes/plugins/slick-carousel/slick/slick-theme.css" rel="stylesheet">

<script src='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.js'></script>
<link href='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.css' rel='stylesheet' />

<!--==================================
=            User Profile            =
===================================-->
<!-- <button value="Return"></button> -->
<section class="user-profile section">

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <?php
        if($_POST != array()) {?>
          <h1 align="center">Confirm Lease Details</h1> <?php
        }
        else {?>
          <h1 align="center">Lease Details</h1>
          <h6 align="center">A confirmation page will be displayed on the following page with all the finalized lease details.</h6><hr>
<?php }?>
      </div>
    </div>
    <div class="row">
      <div class="col-md-10 offset-md-1 col-lg-4 offset-lg-0">
        <div class="sidebar">
          <!-- User Widget -->
          <div class="widget user-dashboard-profile" style="background: #F0F0F0">
            <?php
            if((isset($_POST['book_info']['StartDate']) && clean($_POST['book_info']['StartDate']) != "") && (isset($_POST['book_info']['EndDate']) && clean($_POST['book_info']['EndDate']) != "")) { ?>
              <h1 align="center" style="color: green; padding: 0px"><strong>$<?php echo ($feeRate * $spaceInfo[0]['MonthlyPrice'] * $spaceInfo[0]['SpaceSize'] * (1 + date_diff(date_create(clean($_POST['book_info']['StartDate'])), date_create(clean($_POST['EndDate'])), FALSE)->format("%m")));?></strong></h1>
            <?php }
            else if((isset($_GET['startdate']) && clean($_GET['startdate']) != "") && (isset($_GET['enddate']) && clean($_GET['enddate']) != "")) { ?>
              <h1 align="center" style="color: green; padding: 0px"><strong>$<?php echo ($feeRate * $spaceInfo[0]['MonthlyPrice'] * $spaceInfo[0]['SpaceSize'] * (1 + date_diff(date_create(clean($_GET['startdate'])), date_create(clean($_GET['enddate'])), FALSE)->format("%m")));?></strong></h1>
            <?php }
            else { ?>
              <h1 align="center" style="color: green; padding: 0px"><strong>$<?php echo ($spaceInfo[0]['MonthlyPrice'] * $spaceInfo[0]['SpaceSize']);?></strong><span style="color:black; font-size:50%"> <?php
              ($_POST != array()) ? "/Month" : "" ?></span></h1>
            <?php }

            if(!isset($_POST['book_info'])){ ?>
              <h3><span style="color:black; font-size:50%"><b><?php echo ($_POST != array()) ? "" : "This is not the final booking price.<br> The final booking price will be shown on the next page."?></b></h3></span>
            <?php  }?>
          </div>
          <div class="widget user-dashboard-profile">
            <!-- User Image -->
            <div class="profile-thumb">
              <!-- Map Widget -->
              <style>
              /* Set the size of the div element that contains the map */
              #map {
                height: inherit;  /* The height is 400 pixels */
                width: inherit;  /* The width is the width of the web page */
              }
              </style>

              <div class="widget map">

                <div id="map"></div>
                <script>
                var map = L.map('map')
                .setView([<?php echo $spaceInfo[0]['Latitude']; ?>, <?php echo $spaceInfo[0]['Longitude']; ?>], 15);
                var marker = L.marker([<?php echo $spaceInfo[0]['Latitude']; ?>, <?php echo $spaceInfo[0]['Longitude']; ?>]).addTo(map);
                var tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?{foo}', {foo: 'bar'}).addTo(map);
                </script>
              </div>
            </div>
            <!-- User Name -->
            <h5 class="text-center"><?php echo $spaceInfo[0]['Address'];?></h5>
            <p><?php echo $spaceInfo[0]['City'] . ", " . $spaceInfo[0]['State'] . " " . $spaceInfo[0]['ZipCode']; ?></p>
          </div>
        </div>
      </div>
      <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">

        <?php if($_POST != array()){ ?>
          <form action="../includes/book_submit.php" method="post">

            <input type="hidden" name="book_app" value="submit">
            <input type="hidden" name="SpaceID" value="<?php echo $space; ?>">
            <input type="hidden" name="LesseeID" value="<?php echo $UserID; ?>">
            <input type="hidden" name="FeeRate" value="<?php echo $feeRate; ?>">
            <input type="hidden" name="MonthlyPrice" value="<?php echo $spaceInfo[0]['MonthlyPrice']; ?>">
            <input type="hidden" name="SpaceSize" value="<?php echo $spaceInfo[0]['SpaceSize']; ?>">
            <input type="hidden" name="OwnerID" value="<?php echo $spaceInfo[0]['OwnerID']; ?>">

            <!-- Edit Leese Info -->
            <div class="widget personal-info">
              <h1 class="widget-header user">Verify the dates of the leese</h1>
              <div class="row">
                <!-- Start Date -->
                <div class="col-lg-6 form-group">
                  <label for="start-date">Start Date</label>
                  <input disabled type="date" name="StartDate" <?php if(isset($_SESSION['book_info']['StartDate']) && (clean($_SESSION['book_info']['StartDate']) != "")){ echo "value='" . clean($_SESSION['book_info']['StartDate']) . "'"; }?> class="form-control" id="start-date" required>
                </div>
                <!-- End Date -->
                <div class="col-lg-6 form-group">
                  <label for="end-date">End Date</label>
                  <input disabled type="date" name="EndDate" <?php if(isset($_SESSION['book_info']['EndDate']) && (clean($_SESSION['book_info']['EndDate']) != "")){ echo "value='" . clean($_SESSION['book_info']['EndDate']) . "'"; }?> class="form-control" id="end-date" required>
                </div>
              </div>
            </div>
            <!-- Change Password -->
            <div class="widget change-password">
              <h3 class="widget-header user">What will you be using this space for?</h3>
              <!-- Submit button -->
              <textarea disabled name="contractInformation" id="review" rows="2" cols="69" maxlength="400" placeholder="Ex: I will be storing new unpublished books in this space.  Does this place have low humidity?  If so, please accept this contract."><?php echo $_SESSION['book_info']['contractInformation'];?></textarea>
            </div>
            <!-- Change Password -->
            <div class="widget change-password">
              <h3 class="widget-header user">Payment</h3>
              <p>INSERT EXPENSIVE PAYPAL WIDGET HERE</p>
              <!-- Submit button -->
            </div>
            <button class="btn btn-transparent">Submit Lessee Application</button>
          </form>
        <?php }
        else{?>
          <form method="post">

            <input type="hidden" name="book_app" value="submit">
            <input type="hidden" name="SpaceID" value="<?php echo $space; ?>">
            <input type="hidden" name="LesseeID" value="<?php echo $UserID; ?>">
            <input type="hidden" name="FeeRate" value="<?php echo $feeRate; ?>">
            <input type="hidden" name="MonthlyPrice" value="<?php echo $spaceInfo[0]['MonthlyPrice']; ?>">
            <input type="hidden" name="SpaceSize" value="<?php echo $spaceInfo[0]['SpaceSize']; ?>">
            <input type="hidden" name="OwnerID" value="<?php echo $spaceInfo[0]['OwnerID']; ?>">

            <!-- Edit Leese Info -->
            <div class="widget personal-info">
              <h1 class="widget-header user">Verify the dates of the leese</h1>
              <div class="row">
                <!-- Start Date -->
                <div class="col-lg-6 form-group">
                  <label for="start-date">Start Date</label>
                  <input type="date" name="StartDate" <?php if(isset($_GET['startdate']) && (clean($_GET['startdate']) != "")){ echo "value='" . clean($_GET['startdate']) . "'"; }?> class="form-control" id="start-date" required>
                </div>
                <!-- End Date -->
                <div class="col-lg-6 form-group">
                  <label for="end-date">End Date</label>
                  <input type="date" name="EndDate" <?php if(isset($_GET['enddate']) && (clean($_GET['enddate']) != "")){ echo "value='" . clean($_GET['enddate']) . "'"; }?> class="form-control" id="end-date" required>
                </div>
              </div>
            </div>
            <!-- Change Password -->
            <div class="widget change-password">
              <h3 class="widget-header user">What will you be using this space for?</h3>
              <!-- Submit button -->
              <textarea name="contractInformation" id="review" rows="2" cols="69" maxlength="400" placeholder="Ex: I will be storing new unpublished books in this space.  Does this place have low humidity?  If so, please accept this contract."></textarea>
            </div>
            <!-- Change Password -->


            <button class="btn btn-transparent">Confirm</button>
          </form>
        <?php }?>
        <!-- <form method="post"> -->

      </div>
    </div>
  </div>
</div>
</section>

<?php require_once "../layouts/Calssimax/footer.php"; ?>
