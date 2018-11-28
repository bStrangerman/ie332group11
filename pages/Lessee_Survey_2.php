<?php
require_once "../includes/main.php";
$_SESSION['UserID'] = 3;
$UserID = $_SESSION['UserID'];

if(isset($_SESSION['UserID'])){
  if(!$rbac->Users->hasRole('Lessee', $UserID = $_SESSION['UserID'])){
    header('Location: warehouse.php');
  }
  else if (isset($_GET['contract'])){
    $contract = $_GET['contract'];

    // Getting Contract and Warehouse address
    $sql = "SELECT *
    FROM Contracts
    LEFT JOIN Spaces
    ON Spaces.SpaceID =Contracts.SpaceID
    LEFT JOIN warehouses
    ON Warehouses.WarehouseID = Spaces.SpaceID
    LEFT JOIN phprbac_users
    ON phprbac_users.UserID = Contracts.LesseeID
    WHERE LesseeID = $UserID
    AND ContractID = $contract";

    $results = $GLOBALS ['conn'] -> query($sql);
    while($contractInfo[]=mysqli_fetch_array($results));

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
  $_SESSION['redirect'] = 'Lessee_Survey_2.php?contract=' . $_GET['contract'];
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
          <div class="widget personal-info">
            <h1 class="widget-header user">Lease Details</h1>
            <p><strong>Warehouse Owner:</strong> <?php echo $ownerInfo[0]['FirstName'] . " " . $ownerInfo[0]['LastName']; ?></p>
            <p><strong>Company:</strong> <?php echo $ownerInfo[0]['Company']; ?></p>
            <p><strong>Contract Dates:</strong> <?php echo $contractInfo[0]['StartDate'] . " to " . $contractInfo[0]['EndDate']; ?></p>

          </div>
          <div class="widget personal-info">
            <h1 class="widget-header user">Numerical Ratings</h1>
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
          </div>
        <!-- Submit button -->
        <button class="btn btn-transparent">Submit Lessee Application</button>
      </form>
    </div>
    </div>
      </div>
    </div>
  </div>
</div>
</section>




<?php require_once "../layouts/Calssimax/footer.php"; ?>
