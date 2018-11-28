<?php // TODO: Organize this file into the proper layout (header.php, footer.php, etc.)
require_once "../includes/main.php";

if(isset($_SESSION['UserID'])){
  $hasAccount = $rbac->Users->roleCount($UserID = $_SESSION['UserID']);
  $warehouseRole = $rbac->Users->hasRole("Warehouse_Owner", $UserID = $_SESSION['UserID']);
  $LesseeRole = $rbac->Users->hasRole("Lessee", $UserID = $_SESSION['UserID']);
}
else {
  $hasAccount = 0;
  $warehouseRole = 0;
  $LesseeRole = 0;
}
?>

<!doctype html>
<html class="no-js" lang="en">

<head>
  <!-- meta data -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

  <!--font-family-->
  <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- title of site -->
  <title>@Capacity</title>

  <!-- For favicon png -->
  <link rel="shortcut icon" type="image/icon" href="../includes/logo/favicon.png"/>

  <!--font-awesome.min.css-->
  <link rel="stylesheet" href="../includes/css/font-awesome.min.css">

  <!--linear icon css-->
  <link rel="stylesheet" href="../includes/css/linearicons.css">

  <!-- Font Awesome -->
  <link href="../includes/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">

  <!--animate.css-->
  <link rel="stylesheet" href="../includes/css/animate.css">

  <!--flaticon.css-->
  <link rel="stylesheet" href="../includes/css/flaticon.css">

  <!--slick.css-->
  <link rel="stylesheet" href="../includes/css/slick.css">
  <link rel="stylesheet" href="../includes/css/slick-theme.css">

  <!--bootstrap.min.css-->
  <link rel="stylesheet" href="../includes/css/bootstrap.min.css">

  <!-- bootsnav -->
  <link rel="stylesheet" href="../includes/css/bootsnav.css" >

  <!--home.css-->
  <link rel="stylesheet" href="../includes/css/home.css">

  <!--responsive.css-->
  <link rel="stylesheet" href="../includes/css/responsive.css">

  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css' integrity='sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU' crossorigin='anonymous'>
  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
  <!-- Get user's latitude and longitude from broweser's GPS location -->

  <script>
  window.onload = getLocation;
  var geo = navigator.geolocation;     /*     Here we will check if the browser supports the Geolocation API; if exists, then we will display the location     */
  function getLocation() {
    if( geo ) {
      geo.getCurrentPosition( CookieLocation );
    }
    else  { alert( "Oops, Geolocation API is not supported"); }
  }
  /*     This function gets the latitude and longitude when the browser has a location.     */
  function CookieLocation( position ) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;
    // if there is no cookie for latitude, set the cookie
    <?php if(!isset($_COOKIE['Latitude'])){ ?>
      document.cookie = "Latitude=" + latitude;
    <?php } ?>
    // if there is no cookie for Longitude, set the cookie
    <?php if(!isset($_COOKIE['Longitude'])){ ?>
      document.cookie = "Longitude=" + longitude;
    <?php } ?>
  }
  </script>
  <style>
  #locationField, #controls {
    position: relative;
    width: 480px;
  }

  #address {
    border: 1px solid #000090;
    background-color: #f0f0ff;
    width: 480px;
    padding-right: 2px;
  }
  #address td {
    font-size: 10pt;
  }
  .field {
    width: 99%;
  }
  .slimField {
    width: 80px;
  }
  .wideField {
    width: 200px;
  }
  #locationField {
    height: 20px;
    margin-bottom: 2px;
  }
  </style>

</head>

<body>
  <!--[if lte IE 9]>
  <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="https://browsehappy.com/">upgrade your browser</a> to improve your experience and security.</p>
  <![endif]-->

  <!--header-top start -->
  <header id="header-top" class="header-top">
    <ul>
    </li>
    <li class="head-responsive-right pull-right">
      <div class="header-top-right">
        <ul>
          <li class="header-top-contact">
            +1 222 777 6565
          </li>
          <li class="header-top-contact">
            <a href="#">sign in</a>
          </li>
          <li class="header-top-contact">
            <a href="#">register</a>
          </li>
        </ul>
      </div>
    </li>
  </ul>

</header><!--/.header-top-->
<!--header-top end -->

<!-- top-area Start -->
<section class="top-area">
  <div class="header-area">
    <!-- Start Navigation -->
    <nav class="navbar navbar-default bootsnav  navbar-sticky navbar-scrollspy"  data-minus-value-desktop="70" data-minus-value-mobile="55" data-speed="1000">

      <div class="container">

        <!-- Start Header Navigation -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
            <i class="fa fa-bars"></i>
          </button>
          <a class="navbar-brand" href="index.php">@<span>Capacity</span></a>
          <!-- <img src="../pictures/image1.jpg" height="42" width="42"> -->
        </div><!--/.navbar-header-->
        <!-- End Header Navigation -->

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse menu-ui-design" id="navbar-menu">
          <ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
            <li class=" scroll active"><a href="#home">home</a></li>
            <li class="scroll"><a href="#nearby">nearby</a></li>
            <li class="scroll"><a href="#reviews">review</a></li>
            <?php if($warehouseRole) {?>
              <li><a href="warehouse.php">My Account</a></li>
            <?php } else if($LesseeRole) {?>
              <li><a href="index.php">My Account</a></li>
            <?php } else if(isset($_SESSION['UserID'])){ ?>
              <li><a href="index.php">My Account</a></li>
            <?php } else { ?>
              <li><a href="login.php">Login/Register</a></li>
            <?php } ?>
          </ul><!--/.nav -->
        </div><!-- /.navbar-collapse -->
      </div><!--/.container-->
    </nav><!--/nav-->
    <!-- End Navigation -->
  </div><!--/.header-area-->
  <div class="clearfix"></div>

</section><!-- /.top-area-->
<!-- top-area End -->

<!--welcome-hero start -->
<section id="home" class="welcome-hero">
  <div class="container">
    <div class="welcome-hero-txt">
      <h2>best place to find and lease <br> warehouses that you need </h2>
      <!-- <p> -->

      <!-- </p> -->
    </div>
    <form action="results.php" method="get" onsubmit="return checkEnteredDates(stdateval, endateval)">
      <div class="welcome-hero-serch-box">
        <div class="welcome-hero-form">
          <!-- <div class="single-welcome-hero-form">
          <h3>what?</h3>
          <input type="text" name="description" placeholder="Ex: climate-controlled, outdoors" />
          <div class="welcome-hero-form-icon">
          <i class="flaticon-list-with-dots"></i>
        </div>
      </div> -->
      <div class="single-welcome-hero-form">
        <h3>location</h3>
        <input id="autocomplete" name="location" placeholder="Ex: new york, indianapolis, houston" onFocus="geolocate()" type="text"></input>
        <div class="welcome-hero-form-icon">
          <i class="flaticon-gps-fixed-indicator" style="font-size:24px"></i>
        </div>
      </div>
      <div class="single-welcome-hero-form">
        <h3>When?</h3>
        <input name="startdate" id="stdateval" placeholder="Start" type="date"></input>
        <h3>to</h3>
        <input name="enddate" id="endateval" placeholder="End" type="date"></input>
        <div class="welcome-hero-form-icon">
          <i class="fa fa-calendar" style="font-size:24px"></i>
        </div>
      </form>
    </div>
  </div>
  <div class="welcome-hero-serch">
    <button type="submit" class="welcome-hero-btn">
      search <i data-feather="search"></i>
    </button>
  </div>
</div>
</div>
</form>

</section><!--/.welcome-hero-->
<!--welcome-hero end -->

<!--list-topics start -->
<section id="list-topics" class="list-topics">
  <div class="container">
    <div class="list-topics-content">
      <ul>
        <?php
        $sql = "SELECT AttributeID, AttributeName, AttributeIcon
        FROM Attributes
        WHERE AttributeType = 1";

        $result = $conn -> query($sql);

        while($row = $result -> fetch_assoc()){
          $ID = $row['AttributeID'];
          $innerSQL = "SELECT COUNT(*) AS CountOf
          FROM Space_Attributes
          WHERE AttributeID = $ID";
          $innerresult = ($conn -> query($innerSQL));
          while($innerrow = $innerresult -> fetch_assoc()){
            ?>
            <li>
              <div class="single-list-topics-content">
                <div class="single-list-topics-icon">
                  <i class="<?php echo $row['AttributeIcon']; ?>" style="font-size:48px"></i>
                </div>
                <h2><a href="results.php?type=<?php echo urlencode($row['AttributeName']); ?>"><?php echo $row['AttributeName']; ?></a></h2>
                <p><?php echo $innerrow['CountOf']; ?> listings</p>
              </div>
            </li>
          <?php } } ?>
        </ul>
      </div>
    </div><!--/.container-->

  </section><!--/.list-topics-->
  <!--list-topics end-->

  <!--nearby start -->
  <section id="nearby" class="explore">
    <div class="container">
      <div class="section-header">
        <h2>nearby</h2>
        <p>Explore nearby and recommended locations</p>
      </div><!--/.section-header-->
      <div class="explore-content">

        <?php
        $results = 1;
        while($results <= 6){?>
          <div class="row">
            <?php
            $spaceInfo = getAllSpaces();

            if(isset($_COOKIE['Latitude']))
              $latitude = $_COOKIE['Latitude'];
            else
              $latitude = FALSE;

            if(isset($_COOKIE['Longitude']))
              $longitude = $_COOKIE['Longitude'];
            else
              $longitude = FALSE;
// TODO: javascript to adapt this on load
            if($latitude && $longitude){
              for($i = 0; $i < count($spaceInfo); $i++){
                $spaceInfo[$i]["Distance"] = distanceAlgorithm($spaceInfo[$i]["Latitude"], $spaceInfo[$i]["Longitude"], $latitude, $longitude);
                $spaceInfo[$i]["Utilization"] = Utilization($spaceInfo[$i]['SpaceID'], time(), time(), 100);
              }
              foreach($spaceInfo as $key => $value) {
                $distance[$key] = $value['Distance'];
                $Utilization[$key] = $value['Utilization'];
              }
              array_multisort($distance, SORT_ASC, $Utilization, SORT_DESC, $spaceInfo);
            }
            else{
              for($i = 0; $i < count($spaceInfo); $i++){
                $spaceInfo[$i]["Utilization"] = Utilization($spaceInfo[$i]['SpaceID'], time(), time(), 100);
              }
              foreach($spaceInfo as $key => $value) {
                $Utilization[$key] = $value['Utilization'];
              }
              array_multisort($Utilization, SORT_DESC, $spaceInfo);
            }

            for($i = 0; $i < 6; $i++){
              $warehouseID = $spaceInfo[$i]['WarehouseID'];
              $SpaceID = $spaceInfo[$i]['SpaceID'];
              $sql = "SELECT *
              FROM Warehouse_Pictures
              LEFT JOIN Pictures
              ON Pictures.PictureID = Warehouse_Pictures.PictureID
              WHERE WarehouseID = $warehouseID
              ORDER BY Pictures.PictureID
              LIMIT 1";

              $picResult = ($conn -> query($sql));
              $picture = $picResult -> fetch_assoc();

              $sql = "SELECT *
              FROM Space_Attributes
              LEFT JOIN Attributes
              ON Attributes.AttributeID = Space_Attributes.AttributeID
              WHERE SpaceID = $SpaceID
              AND AttributeType = 1
              LIMIT 1";

              $attResult = ($conn -> query($sql));
              $attributes = $attResult -> fetch_assoc();
              ?>
              <div class=" col-md-4 col-sm-6">
                <div class="single-explore-item">
                  <div class="single-explore-img">
                    <img src="../pictures/<?php echo $picture['FileName']; ?>" alt="explore image">
                    <!-- <?php if($i == 0){ ?>
                      <div class="single-explore-img-info">
                        <button onclick="window.location.href='space.php?space=<?php echo $spaceInfo[$i]['SpaceID']; ?>'">Closest</button>
                      </div> <?php } ?> -->
                    </div>
                    <div class="single-explore-txt bg-theme-1">
                      <h2><a href="space.php?space=<?php echo $spaceInfo[$i]['SpaceID']; ?>"><?php echo $spaceInfo[$i]['Address'] . ", " . $spaceInfo[$i]['City'] . " " . $spaceInfo[$i]['State']; ?></a></h2>
                      <p class="explore-rating-price">
                        <span class="explore-rating">5.0</span>
                        <a href="space.php?space=<?php echo $spaceInfo[$i]['SpaceID']; ?>"> <?php echo $results; ?> ratings</a>
                        <span class="explore-price-box">
                          From
                          <span class="explore-price">$<?php echo ($spaceInfo[$i]['MonthlyPrice'] * $spaceInfo[$i]['SpaceSize']); ?>/mo</span>
                        </span>
                        <a href="space.php?space=<?php echo $spaceInfo[$i]['SpaceID']; ?>"><?php echo $attributes['AttributeName']; ?></a>
                      </p>
                      <div class="explore-person">
                        <div class="row">
                          <!-- <div class="col-sm-2">
                          <div class="explore-person-img">
                          <a href="#">
                          <img src="../includes/images/explore/person.png" alt="explore person">
                        </a>
                      </div>
                    </div> -->
                    <div class="col-sm-12">
                      <p>
                        <?php
                        $lines = 2;
                        $charactersPerLine = 50;
                        if(isset($spaceInfo[$i]['SpaceInformation']))
                        $spaceInfoPrint = limitTextLength($spaceInfo[$i]['SpaceInformation'], $lines * $charactersPerLine - strlen($spaceInfo[$i]['SpaceInformation']) - 3);
                        else
                        $spaceInfoPrint = "";

                        if(isset($spaceInfo[$i]['WarehouseInformation']))
                        $warehouseInfoPrint = limitTextLength($spaceInfo[$i]['WarehouseInformation'], $lines * $charactersPerLine - 3);
                        else
                        $warehouseInfoPrint = "";

                        echo $warehouseInfoPrint . "<br>" . $spaceInfoPrint;
                        echo (strlen($spaceInfo[$i]['SpaceInformation']) + strlen($spaceInfo[$i]['WarehouseInformation'])) > ($lines * $charactersPerLine - 3) ? " ...." : "";  ?>
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <?php
          $results++;
        }
      }
      ?>
    </div>
  </div>
</div><!--/.container-->

</section><!--/.explore-->
<!--explore end -->
<div class="row">
  <div class="col-lg-6" align="center">
    <blockquote class="instagram-media" data-instgrm-captioned data-instgrm-permalink="https://www.instagram.com/&amp;utm_medium=loading" data-instgrm-version="12" style=" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:540px; min-width:326px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);"><div style="padding:16px;"> <a href="https://www.instagram.com/p/Bqa6UWMFFcs/?utm_source=ig_embed&amp;utm_medium=loading" style=" background:#FFFFFF; line-height:0; padding:0 0; text-align:center; text-decoration:none; width:100%;" target="_blank"> <div style=" display: flex; flex-direction: row; align-items: center;"> <div style="background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 40px; margin-right: 14px; width: 40px;"></div> <div style="display: flex; flex-direction: column; flex-grow: 1; justify-content: center;"> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; margin-bottom: 6px; width: 100px;"></div> <div style=" background-color: #F4F4F4; border-radius: 4px; flex-grow: 0; height: 14px; width: 60px;"></div></div></div><div style="padding: 19% 0;"></div><div style="display:block; height:50px; margin:0 auto 12px; width:50px;"><svg width="50px" height="50px" viewBox="0 0 60 60" version="1.1" xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink"><g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd"><g transform="translate(-511.000000, -20.000000)" fill="#000000"><g><path d="M556.869,30.41 C554.814,30.41 553.148,32.076 553.148,34.131 C553.148,36.186 554.814,37.852 556.869,37.852 C558.924,37.852 560.59,36.186 560.59,34.131 C560.59,32.076 558.924,30.41 556.869,30.41 M541,60.657 C535.114,60.657 530.342,55.887 530.342,50 C530.342,44.114 535.114,39.342 541,39.342 C546.887,39.342 551.658,44.114 551.658,50 C551.658,55.887 546.887,60.657 541,60.657 M541,33.886 C532.1,33.886 524.886,41.1 524.886,50 C524.886,58.899 532.1,66.113 541,66.113 C549.9,66.113 557.115,58.899 557.115,50 C557.115,41.1 549.9,33.886 541,33.886 M565.378,62.101 C565.244,65.022 564.756,66.606 564.346,67.663 C563.803,69.06 563.154,70.057 562.106,71.106 C561.058,72.155 560.06,72.803 558.662,73.347 C557.607,73.757 556.021,74.244 553.102,74.378 C549.944,74.521 548.997,74.552 541,74.552 C533.003,74.552 532.056,74.521 528.898,74.378 C525.979,74.244 524.393,73.757 523.338,73.347 C521.94,72.803 520.942,72.155 519.894,71.106 C518.846,70.057 518.197,69.06 517.654,67.663 C517.244,66.606 516.755,65.022 516.623,62.101 C516.479,58.943 516.448,57.996 516.448,50 C516.448,42.003 516.479,41.056 516.623,37.899 C516.755,34.978 517.244,33.391 517.654,32.338 C518.197,30.938 518.846,29.942 519.894,28.894 C520.942,27.846 521.94,27.196 523.338,26.654 C524.393,26.244 525.979,25.756 528.898,25.623 C532.057,25.479 533.004,25.448 541,25.448 C548.997,25.448 549.943,25.479 553.102,25.623 C556.021,25.756 557.607,26.244 558.662,26.654 C560.06,27.196 561.058,27.846 562.106,28.894 C563.154,29.942 563.803,30.938 564.346,32.338 C564.756,33.391 565.244,34.978 565.378,37.899 C565.522,41.056 565.552,42.003 565.552,50 C565.552,57.996 565.522,58.943 565.378,62.101 M570.82,37.631 C570.674,34.438 570.167,32.258 569.425,30.349 C568.659,28.377 567.633,26.702 565.965,25.035 C564.297,23.368 562.623,22.342 560.652,21.575 C558.743,20.834 556.562,20.326 553.369,20.18 C550.169,20.033 549.148,20 541,20 C532.853,20 531.831,20.033 528.631,20.18 C525.438,20.326 523.257,20.834 521.349,21.575 C519.376,22.342 517.703,23.368 516.035,25.035 C514.368,26.702 513.342,28.377 512.574,30.349 C511.834,32.258 511.326,34.438 511.181,37.631 C511.035,40.831 511,41.851 511,50 C511,58.147 511.035,59.17 511.181,62.369 C511.326,65.562 511.834,67.743 512.574,69.651 C513.342,71.625 514.368,73.296 516.035,74.965 C517.703,76.634 519.376,77.658 521.349,78.425 C523.257,79.167 525.438,79.673 528.631,79.82 C531.831,79.965 532.853,80.001 541,80.001 C549.148,80.001 550.169,79.965 553.369,79.82 C556.562,79.673 558.743,79.167 560.652,78.425 C562.623,77.658 564.297,76.634 565.965,74.965 C567.633,73.296 568.659,71.625 569.425,69.651 C570.167,67.743 570.674,65.562 570.82,62.369 C570.966,59.17 571,58.147 571,50 C571,41.851 570.966,40.831 570.82,37.631"></path></g></g></g></svg></div><div style="padding-top: 8px;"> <div style=" color:#3897f0; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:550; line-height:18px;"> View this post on Instagram</div></div><div style="padding: 12.5% 0;"></div> <div style="display: flex; flex-direction: row; margin-bottom: 14px; align-items: center;"><div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(0px) translateY(7px);"></div> <div style="background-color: #F4F4F4; height: 12.5px; transform: rotate(-45deg) translateX(3px) translateY(1px); width: 12.5px; flex-grow: 0; margin-right: 14px; margin-left: 2px;"></div> <div style="background-color: #F4F4F4; border-radius: 50%; height: 12.5px; width: 12.5px; transform: translateX(9px) translateY(-18px);"></div></div><div style="margin-left: 8px;"> <div style=" background-color: #F4F4F4; border-radius: 50%; flex-grow: 0; height: 20px; width: 20px;"></div> <div style=" width: 0; height: 0; border-top: 2px solid transparent; border-left: 6px solid #f4f4f4; border-bottom: 2px solid transparent; transform: translateX(16px) translateY(-4px) rotate(30deg)"></div></div><div style="margin-left: auto;"> <div style=" width: 0px; border-top: 8px solid #F4F4F4; border-right: 8px solid transparent; transform: translateY(16px);"></div> <div style=" background-color: #F4F4F4; flex-grow: 0; height: 12px; width: 16px; transform: translateY(-4px);"></div> <div style=" width: 0; height: 0; border-top: 8px solid #F4F4F4; border-left: 8px solid transparent; transform: translateY(-4px) translateX(8px);"></div></div></div></a> <p style=" margin:8px 0 0 0; padding:0 4px;"> <a href="https://www.instagram.com/p/Bqa6UWMFFcs/?utm_source=ig_embed&amp;utm_medium=loading" style=" color:#000; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none; word-wrap:break-word;" target="_blank">As promised. The new Trailer for Lego 2!!! Super brickin excited for this one. Watch and share if you please. 🙏♥️</a></p> <p style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;">A post shared by <a href="https://www.instagram.com/prattprattpratt/?utm_source=ig_embed&amp;utm_medium=loading" style=" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px;" target="_blank"> chris pratt</a> (@prattprattpratt) on <time style=" font-family:Arial,sans-serif; font-size:14px; line-height:17px;" datetime="2018-11-20T23:26:45+00:00">Nov 20, 2018 at 3:26pm PST</time></p></div></blockquote> <script async src="//www.instagram.com/embed.js"></script>
  </div>
  <div class="col-lg-6" align="center">
<!-- Twitter timeline -->
<a class="twitter-timeline" data-width="300" data-height="300" href="https://twitter.com/Capacity_332?ref_src=twsrc%5Etfw">Tweets by Capacity_332</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>
</div>
<!--footer start-->
<footer id="footer"  class="footer">
  <div class="container">
    <div class="footer-menu">
      <div class="row">
        <div class="col-sm-3">
          <div class="navbar-header">
            <a class="navbar-brand" href="index.php">@<span>Capacity</span></a>
          </div><!--/.navbar-header-->
        </div>
        <div class="col-sm-9">
          <ul class="footer-menu-item">
            <li class="scroll"><a href="#explore">explore</a></li>
            <li class="scroll"><a href="#reviews">review</a></li>
            <li class="scroll"><a href="#blog">blog</a></li>
            <li class="scroll"><a href="#contact">contact</a></li>
            <?php if($hasAccount > 0) {?>
              <li><a href="warehouse.php">My Account</a></li>
            <?php } else { ?>
              <li><a href="login.php">Login/Register</a></li>
            <?php } ?>
          </ul><!--/.nav -->
        </div>
      </div>
    </div>
    <div class="hm-footer-copyright">
      <div class="row">
        <div class="col-sm-5">
          <p>
            &copy;copyright. designed and developed by <a href="https://www.themesine.com/">themesine</a>
          </p><!--/p-->
        </div>
        <div class="col-sm-7">
          <div class="footer-social">
            <span><i class="fa fa-phone"> +1  (123) 456 7890</i></span>
            <a class="fa fa-facebook" href="https://www.facebook.com/AtCapacity-339587599924715"></a>
            <a class="fa fa-twitter" href="https://twitter.com/capacity_332"></a>
            <!-- <a href="#"><i class="fa fa-linkedin"></i></a>
            <a href="#"><i class="fa fa-google-plus"></i></a> -->
          </div>
        </div>
      </div>

    </div><!--/.hm-footer-copyright-->
  </div><!--/.container-->

  <div id="scroll-Top">
    <div class="return-to-top">
      <i class="fa fa-angle-up " id="scroll-top" data-toggle="tooltip" data-placement="top" title="" data-original-title="Back to Top" aria-hidden="true"></i>
    </div>

  </div><!--/.scroll-Top-->

</footer><!--/.footer-->
<!--footer end-->

<!-- Include all js compiled plugins (below), or include individual files as needed -->

<script src="../includes/js/jquery.js"></script>

<!--modernizr.min.js-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>

<!--bootstrap.min.js-->
<script src="../includes/js/bootstrap.min.js"></script>

<!-- bootsnav js -->
<script src="../includes/js/bootsnav.js"></script>

<!--feather.min.js-->
<script  src="../includes/js/feather.min.js"></script>

<!-- counter js -->
<script src="../includes/js/jquery.counterup.min.js"></script>
<script src="../includes/js/waypoints.min.js"></script>

<!--slick.min.js-->
<script src="../includes/js/slick.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

<!--Custom JS-->
<script src="../includes/js/custom.js"></script>


<script>
// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.
  autocomplete = new google.maps.places.Autocomplete(
    /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
    {types: ['geocode']});

    // When the user selects an address from the dropdown, populate the address
    // fields in the form.
    autocomplete.addListener('place_changed', fillInAddress);
  }

  function fillInAddress() {
    // Get the place details from the autocomplete object.
    var place = autocomplete.getPlace();
    // get lat
    var lat = place.geometry.location.lat();
    console.log(lat);
    // get lng
    var lng = place.geometry.location.lng();
    console.log(lon);

    for (var component in componentForm) {
      document.getElementById(component).value = '';
      document.getElementById(component).disabled = false;
    }

    // Get each component of the address from the place details
    // and fill the corresponding field on the form.
    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (componentForm[addressType]) {
        var val = place.address_components[i][componentForm[addressType]];
        document.getElementById(addressType).value = val;
      }
    }
  }

  // Bias the autocomplete object to the user's geographical location,
  // as supplied by the browser's 'navigator.geolocation' object.
  function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        var circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      });
    }
  }
  </script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHEHS1YUJVmKDeZhK1zp-5bWFjK7l7Oi0&libraries=places&callback=initAutocomplete" async defer></script>
  <script src="../includes/dateCheck.js"></script>

</body>

</html>
<?php
function limitTextLength($string, $length){
  $string = strip_tags($string);
  if (strlen($string) > $length) {
    // truncate string
    $stringCut = substr($string, 0, $length);
    $endPoint = strrpos($stringCut, ' ');

    //if the string doesn't contain any space then it will cut without word basis.
    $string = $endPoint? substr($stringCut, 0, $endPoint) : substr($stringCut, 0);
  }
  return $string;
}
?>
