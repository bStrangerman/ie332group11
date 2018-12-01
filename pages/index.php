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

//Grab REAL IP (not $_SERVER[‘REMOTE_ADDR’] )
//Pulled from https://stackoverflow.com/questions/22323525/how-get-latitude-and-longitude-by-client-ip)
function get_client_ip() {
    $ipaddress = '';
    if ($_SERVER['HTTP_CLIENT_IP'] != "")
        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    else if($_SERVER['HTTP_X_FORWARDED_FOR'] != "")
        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    else if($_SERVER['HTTP_X_FORWARDED'] != "")
        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    else if($_SERVER['HTTP_FORWARDED_FOR'] != "")
        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    else if($_SERVER['HTTP_FORWARDED'] != "")
        $ipaddress = $_SERVER['HTTP_FORWARDED'];
    else if($_SERVER['REMOTE_ADDR'] != "")
        $ipaddress = $_SERVER['REMOTE_ADDR'];
    else
        $ipaddress = 'UNKNOWN';

    return $ipaddress;
}

//API from ipstack.com This makes the cookie for the IP LATS
//to use this unserialize ($geoIP and call its array, refer to the link below to see what can be called.)
if(!isset($_COOKIE["IP_Data"])){
  $geoIP = json_decode(file_get_contents("http://api.ipstack.com/172.58.4.147?access_key=d3bc63cb9b643a0c5f818c7762f23dda"), true);
  setcookie("IP_Data", serialize($geoIP)); //test
  //setcookie("IP_Latitude", $geoIP["latitude"]);  //set LAT
  //setcookie("IP_Longitude", $geoIP["longitude"]);  //set Lon
}

$IP_Use = unserialize($_COOKIE["IP_Data"]);
//if you need zip do $IP_Use["zip"]
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


<?php if(!isset($_COOKIE['Latitude']) && !isset($_COOKIE['Latitude'])){ ?>
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
      document.cookie = "Latitude=" + latitude;
    // if there is no cookie for Longitude, set the cookie
      document.cookie = "Longitude=" + longitude;
  }
  </script>
<?php } ?>


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
      <h2>best place to find and lease <br> warehouses </h2>
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
        echo "lat: " . $lat . " lon: " . $lon . " zip: " . getZip($lat, $lon);
        $results = 1;
        while($results <= 6){?>
          <div class="row">
            <?php
            $time_pre_dist = microtime(true);

            $spaceInfo = getAllSpaces();

            if(isset($_COOKIE['Latitude']))
              $latitude = $_COOKIE['Latitude'];
            elseif(isset($_COOKIE['IP_Data']))
              $latitude = $IP_Use['latitude'];
            else
              $latitude = FALSE;

            if(isset($_COOKIE['Longitude']))
              $longitude = $_COOKIE['Longitude'];
            elseif(isset($_COOKIE['IP_Data']))
              $longitude = $IP_Use['longitude'];
            else
              $longitude = FALSE;

            if($latitude && $longitude){
              $time_pre = microtime(true);
              for($i = 0; $i < count($spaceInfo); $i++){
                $spaceInfo[$i]["Distance"] = distanceAlgorithm($spaceInfo[$i]["Latitude"], $spaceInfo[$i]["Longitude"], $latitude, $longitude);
                $spaceInfo[$i]["Utilization"] = Utilization($spaceInfo[$i]['SpaceID'], time(), time(), 100);
              }
              $time_post_dist = microtime(true);
              $exec_time = $time_post_dist - $time_pre_dist;
              echo "<script>console.log( 'Distance Date: " . ($exec_time * 0.000001) . "' );</script>";
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
            $time_post = microtime(true);
            $exec_time = $time_post - $time_pre;
            echo "<script>console.log( 'Get Date: " . ($exec_time * 0.000001) . "' );</script>";
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
  <div class="col-lg-3" align="center">
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
            <?php if($warehouseRole) {?>
              <li><a href="warehouse.php">My Account</a></li>
            <?php } else if($LesseeRole) {?>
              <li><a href="lesseeAccount.php">My Account</a></li>
            <?php } else { ?>
              <a class="nav-link" href="login.php">Dashboard</a>
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

    // get lng
    var lng = place.geometry.location.lng();

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
