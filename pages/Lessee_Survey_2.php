<?php
require_once "../includes/main.php";
$_SESSION['UserID'] = 1;
$contract = 1;
$userID = $_SESSION['UserID'];

if(isset($_SESSION['UserID'])){
  if($rbac->Users->hasRole('Lessee', $UserID = $_SESSION['UserID'])){
    // header('Location: warehouse.php');
  }
  else if (isset($_GET['contract'])){
    $contract = $_GET['contract'];
    $_SESSION['reviewContract'] = $contract;
    $user = $_SESSION['UserID'];
    // Getting Contract and Warehouse address
    $sql = "SELECT *
    FROM Contracts
    LEFT JOIN Spaces
    ON Spaces.SpaceID =Contracts.SpaceID
    LEFT JOIN warehouses
    ON Warehouses.WarehouseID = Spaces.SpaceID
    WHERE LesseeID = $UserID
    AND ContractID = $contract";

    $results = $GLOBALS ['conn'] -> query($sql);
    while($contractInfo[]=mysqli_fetch_array($results));


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
    $picture = ($conn -> query($sql)) -> fetch_assoc();
  }
  // END OF GETTING PICTURE
  //



  // if(count(($conn -> query($sql)) -> fetch_assoc()) > 0) {
  //   header('Location: index.php');
  // }
}

else {
  $_SESSION['redirect'] = 'Lessee_survey.php';
  // header('Location: login.php');
}
require_once "../layouts/Calssimax/header.php";


?>



<!-- Owl Carousel -->
<link href="../includes/plugins/slick-carousel/slick/slick.css" rel="stylesheet">
<link href="../includes/plugins/slick-carousel/slick/slick-theme.css" rel="stylesheet">

<script src='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.js'></script>
<link href='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.css' rel='stylesheet' />

<!--==================================
=            User Profile            =
===================================-->

<section class="user-profile section">

  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h1 align="center">Lessee Survey</h1>
      </div>
    </div>
    <div class="row">
      <div class="col-md-10 offset-md-1 col-lg-4 offset-lg-0">
        <div class="sidebar">
          <!-- User Widget -->
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
                .setView([<?php echo $contractInfo[0]['Latitude']; ?>, <?php echo $contractInfo[0]['Longitude']; ?>], 15);
                var marker = L.marker([<?php echo $contractInfo[0]['Latitude']; ?>, <?php echo $contractInfo[0]['Longitude']; ?>]).addTo(map);
                var tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?{foo}', {foo: 'bar'}).addTo(map);
                </script>
              </div>
            </div>
            <!-- Contract Location -->
            <h5 class="text-center"><?php echo $contractInfo[0]['Address'];?></h5>
            <p><?php echo $contractInfo[0]['City'] . ", " . $contractInfo[0]['State'] . " " . $contractInfo[0]['ZipCode']; ?></p>
          </div>
        </div>
      </div>
      <div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">

        <form action="book.php" method="post">
          <!-- Edit Leese Info -->
          <div class="widget personal-info">
            <h1 class="widget-header user">Verify the dates of the leese</h1>
            <div class="row">
              <!-- Start Date -->
              <!--===================
              =     LYKERT SCALES   =
              =======================
              for Accuracy of Listing, Communication with Staff, Friendlyness of Staff, Location of Warehouse, Value of Space -->

              <div class="col-lg-12 row form-group">
                <label>Overall Rating     </label> <br>
                <label class="radio-inline">
                  <input type="radio" name="ls_rating" id="optionsRadiosInline1" value="1" checked>1
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_rating" id="optionsRadiosInline2" value="2">2
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_rating" id="optionsRadiosInline3" value="3">3
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_rating" id="optionsRadiosInline4" value="4">4
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_rating" id="optionsRadiosInline5" value="5">5
                </label>
              </div>
            </div>
            <div class="row">
              <!-- Accuracy of Listing -->
              <div class="col-lg-12 row form-group">
                <label>Accuracy of Listing     </label> <br>
                <label class="radio-inline">
                  <input type="radio" name="ls_accuracy" id="optionsRadiosInline1" value="1" checked>1
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_accuracy" id="optionsRadiosInline2" value="2">2
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_accuracy" id="optionsRadiosInline3" value="3">3
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_accuracy" id="optionsRadiosInline4" value="4">4
                </label>
                <label class="radio-inline">
                  <input type="radio" name="ls_accuracy" id="optionsRadiosInline5" value="5">5
                </label>
              </div>
            </div>
            <!-- End Date -->
            <div class="col-lg-6 form-group">
              <label for="end-date">End Date</label>
              <input type="date" class="form-control" id="end-date" required>
            </div>
          </div>
        </div>
        <!-- Submit button -->
        <button class="btn btn-transparent">Submit Lessee Application</button>
      </form>
      <!-- Change Password -->
      <div class="widget change-password">
        <h3 class="widget-header user">Edit Password</h3>
        <form action="#">
          <!-- Current Password -->
          <div class="form-group">
            <label for="current-password">Current Password</label>
            <input type="password" class="form-control" id="current-password">
          </div>
          <!-- New Password -->
          <div class="form-group">
            <label for="new-password">New Password</label>
            <input type="password" class="form-control" id="new-password">
          </div>
          <!-- Confirm New Password -->
          <div class="form-group">
            <label for="confirm-password">Confirm New Password</label>
            <input type="password" class="form-control" id="confirm-password">
          </div>
          <!-- Submit Button -->
          <button class="btn btn-transparent">Change Password</button>
        </form>
      </div>
      <!-- Change Email Address -->
      <div class="widget change-email mb-0">
        <h3 class="widget-header user">Edit Email Address</h3>
        <form action="#">
          <!-- Current Password -->
          <div class="form-group">
            <label for="current-email">Current Email</label>
            <input type="email" class="form-control" id="current-email">
          </div>
          <!-- New email -->
          <div class="form-group">
            <label for="new-email">New email</label>
            <input type="email" class="form-control" id="new-email">
          </div>
          <!-- Submit Button -->
          <button class="btn btn-transparent">Change email</button>
        </form>
      </div>
    </div>
  </div>
</div>
</section>




<?php require_once "../layouts/Calssimax/footer.php"; ?>
