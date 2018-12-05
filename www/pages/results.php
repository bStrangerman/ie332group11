<?php
require_once "../includes/main.php";

require_once "../layouts/Calssimax/header.php";


if($err == array()){
  $type = array();
  $address = array();
  $spaceID = array();
  $monthlyPrice = array();
  $spaceSize = array();
  $latitude = array();
  $longitude = array();
  $spaceInformation = array();
  $state = array();

  if(isset($_GET['type']))
  array_push($type, clean(urldecode($_GET['type'])));

  $spaceInfo = getAvailableSpaces($start, $end, $type, $conn);

  $i = 0;
  while ($i < count($spaceInfo)) {
    array_push($spaceID, $spaceInfo[$i]['SpaceID']);
    array_push($address, $spaceInfo[$i]['Address'] . " " . $spaceInfo[$i]['City'] . " " . $spaceInfo[$i]['State']) . ($spaceInfo[$i]['ZipCode'] != "") ? " " . $spaceInfo[$i]['ZipCode'] : "";
    array_push($monthlyPrice, $spaceInfo[$i]['MonthlyPrice']);
    array_push($state, $spaceInfo[$i]['State']);
    array_push($spaceSize, $spaceInfo[$i]['SpaceSize']);
    array_push($latitude, $spaceInfo[$i]['Latitude']);
    array_push($longitude, $spaceInfo[$i]['Longitude']);
    array_push($spaceInformation, $spaceInfo[$i]['SpaceInformation']);
    $i++;
  }
  if(isset($_GET['location']) || isset($_GET['state'])){
    if(isset($_GET['location'])){
      $origin = urldecode((clean($_GET['location'])));
      $lat_lon = getLatLon(strtr($origin, array('.' => '', ',' => '', 'USA' => '')));
      $origin_lat = $lat_lon[0];
      $origin_lon = $lat_lon[1];
      $stateBoolean = 0;
    }
    else if(isset($_GET['state'])){
      $origin = $_GET['state'];
      $stateBoolean = 1;
    }

    $data = array();
    $max_count = count($spaceID);

    // pushes the results info into an array
    for($i = 0; $i < $max_count; $i++){
      if($stateBoolean == 0 && $latitude[$i] != 0 && $longitude[$i] != 0){
        array_push($data, array("Spaces" => $spaceID[$i], "Latitude" => $latitude[$i], "Longitude" => $longitude[$i], "Addresses" => $address[$i], "Distance" => distanceAlgorithm($origin_lat, $origin_lon, $latitude[$i], $longitude[$i]), "MonthlyPrice" => $monthlyPrice[$i], "SpaceSize" => $spaceSize[$i], "SpaceInformation" => $spaceInformation[$i]));
      }
      else if($stateBoolean == 1 && $state[$i] == $_GET['state']){
        array_push($data, array("Spaces" => $spaceID[$i], "Latitude" => $latitude[$i], "Longitude" => $longitude[$i], "Addresses" => $address[$i], "Distance" => 0, "MonthlyPrice" => $monthlyPrice[$i], "SpaceSize" => $spaceSize[$i], "SpaceInformation" => $spaceInformation[$i]));
      }
    }

    if($stateBoolean == 0) {
      if(isset($_GET['range'])) {
        $range = clean($_GET['range']);
      }
      else {
        $range = 100000;
      }

      $max_count = count($data);
      for ($i = 0; $i < $max_count; $i++) {
        if ($data[$i]["Distance"] > $range) {
          unset($data[$i]);
        }
      }
      unset($data[$max_count - 1]);
    }
  }

  if(count($data) == 0)
  array_push($err, "0 Results");

  $max_size = 0;
  for($i = 0; $i < $max_count; $i++){
    if(isset($data[$i])){
      if($data[$i]['SpaceSize'] > $max_size)
      $max_size = $data[$i]["SpaceSize"];
    }
  }
  if(isset($_GET['size']))
    $size = clean($_GET['size']);
  else
    $size = $max_size;
  if(isset($_GET['price']))
    $price = clean($_GET['price']);
  else
    $price = $max_price;
}

$max_price = 10000;
$max_size = 3000;

$newdata = array();

for($i = 0; $i < count($spaceID); ++$i){
  if(isset($data[$i]["Spaces"])) {
    $score = 0;
    $score += Utilization($data[$i]['Spaces'], $start, $end, (100 * (5/15)));
    if($stateBoolean == 0)
    {
      $score += distance_score($range, $data[$i]['Distance'], 100 * (3/15));
    }
    else {
      $score += 100 * (3 / 15);
    }

    $score += price_score(($data[$i]['MonthlyPrice'] * $data[$i]['SpaceSize']), $price, 100 * (2/15));
    $score += size_score($size, $data[$i]['SpaceSize'], $max_size, 100 * (5/15));
    $score = round($score) > 100 ? 100 : round($score);
    array_push($newdata, array("Spaces" => $data[$i]['Spaces'], "Latitude" => $data[$i]['Latitude'], "Longitude" => $data[$i]['Longitude'], "Addresses" => $data[$i]['Addresses'], "Distance" => $data[$i]['Distance'], "MonthlyPrice" => $data[$i]['MonthlyPrice'], "SpaceSize" => $data[$i]['SpaceSize'], "SpaceInformation" => $newdata[$i]['SpaceInformation'], "Score" => $score));
  }
}

?>

<section class="page-search">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <!-- Advance Search -->
        <div class="advance-search">
          <form action="results.php" method="get">
            <div class="form-row">
              <!-- <div class="form-group col-md-3">
              <input type="text" class="form-control" name="description" id="inputtext4" value="<?php echo isset($_GET['description']) ? $_GET['description'] : "" ?>" placeholder="What are you looking for">
            </div> -->
            <div class="form-group col-md-4">
              <input type="text" class="form-control" name="location" id="autocomplete" onFocus="geolocate()" value="<?php echo isset($_GET['location']) ? urldecode($_GET['location']) : (isset($_GET['state']) ? urldecode($_GET['state']) : "") ?>" placeholder="Location">
            </div>
            <div class="form-group col-md-3">
              <input type="date" class="form-control" name="startdate" id="inputdate4" value="<?php echo $start; ?>" placeholder="Start Date">
            </div>
            <div class="form-group col-md-3">
              <input type="date" class="form-control" name="enddate" id="inputdate4" value="<?php echo $end; ?>" placeholder="End Date">
            </div>
            <div class="form-group col-md-2">
              <button type="submit" class="btn btn-primary">Search Now</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</section>
<section class="section-sm">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <?php if($err == array() || !in_array($location_error, $err)){ ?>
          <div class="search-result bg-gray">
            <h2>Results For "<?php echo isset($_GET['location']) ? urldecode($_GET['location']) : (isset($_GET['state']) ? urldecode($_GET['state']) : ""); ?>"</h2>
            <p><?php echo (isset($newdata)) ? count($newdata) : "0" ?> Results on <?php echo date("F d, Y"); ?></p>
          </div>
        <?php }?>
      </div>
    </div>
    <div class="row">
      <div class="col-md-3">
        <div class="category-sidebar">
          <form action="<?php $_SERVER['REQUEST_URI']; ?>" method="GET">
            <?php if($stateBoolean == 1){ ?>
              <input type="hidden" name="state" value="<?php echo $state; ?>">
            <?php }
            else { ?>
              <input type="hidden" name="location" value="<?php echo $origin; ?>">
            <?php }?>
            <input type="hidden" name="startdate" value="<?php echo $start; ?>">
            <input type="hidden" name="enddate" value="<?php echo $end; ?>">
            <?php if(isset($_GET['range'])){ ?>
              <input type="hidden" name="range" value="<?php echo clean($_GET['range']); ?>">
            <?php }?>
            <div class="widget filter">
              <h4 class="widget-header">Size Needed (sqft)</h4>
              <input class="form-control" type="number" name="size" value="<?php echo clean($_GET['size']); ?>" placeholder="Square Feet">
            </div>
            <div class="widget filter">
              <h4 class="widget-header">Max Price ($)</h4>
              <input class="form-control" type="number" name="price" value="<?php echo clean($_GET['price']); ?>" placeholder="$">
            </div>
            <div class="form-group col-md-2">
              <button type="submit" class="btn btn-primary">Search Now</button>
            </div>
          </form>
          <div class="widget category-list">
            <h4 class="widget-header">All Category</h4>
            <ul class="category-list">
              <?php
              $sql = "SELECT AttributeName,
              (SELECT COUNT(*)
              FROM Space_Attributes
              WHERE Space_Attributes.AttributeID = Attributes.AttributeID) AS countof
              FROM Attributes
              WHERE AttributeType = 1
              LIMIT 6";
              $result = $conn -> query($sql);
              while($row = $result -> fetch_assoc()){ ?>
                <li><a href="results.php?location=<?php echo urlencode($_GET['location']);?>&type=<?php echo (isset($_GET['type']) ? $_GET['type'] . "&type=x" : "") . urlencode($row['AttributeName']); ?>&startdate=<?php echo $start;?>&enddate=<?php echo $end;?>"><?php echo $row['AttributeName']; ?> <span><?php echo $row['countof']; ?></span></a></li>
              <?php } ?>
            </ul>
          </div>

          <div class="widget category-list">
            <h4 class="widget-header">Nearby</h4>
            <ul class="category-list">
              <?php
              $sql = "SELECT State, COUNT(*) AS countof
              FROM Warehouses
              GROUP BY State
              LIMIT 6";
              $result = $conn -> query($sql);
              while($row = $result -> fetch_assoc()){ ?>
                <li><a href="results.php?state=<?php echo $row['State']; ?>&startdate=<?php echo $start;?>&enddate=<?php echo $end;?>"><?php echo $row['State']; ?> <span><?php echo $row['countof']; ?></span></a></li>
              <?php } ?>
            </ul>
          </div>

        </div>
      </div>
      <div class="col-md-9">
        <div class="row">
          <!-- <div class="col-md-6">
          <div class="view">
          <strong>Views</strong>
          <ul class="list-inline view-switcher">
          <li class="list-inline-item">
          <a href="javascript:void(0);"><i class="fa fa-th-large"></i></a>
        </li>
        <li class="list-inline-item">
        <a href="javascript:void(0);"><i class="fa fa-reorder"></i></a>
      </li>
    </ul>
  </div>
</div> -->
</div>
<div class="product-grid-list">
  <div class="row mt-30">
    <?php

    // prints errors from the search
    if($err != array()) {

      ?>
      <div class="col-sm-12 col-lg-12 col-md-12">
        <?php
        for($i = 0; $i < count($err); $i++){
          echo "<h2 align='center'>" . $err[$i] . "</h2>";
        }
        ?>
      </div>
      <?php
    }
    else {
      for($i = 0; $i < count($newdata); $i++){
      ?>

      <div class="col-sm-12 col-lg-12 col-md-12">
        <!-- product card -->
        <div class="product-item bg-light">
          <div class="card" <?php echo ($newdata[$i]['Score'] >= 75) ? 'style="background:lightgreen"' : "" ?>>
            <div class="thumb-content">
              <!-- <div class="price">$200</div> -->
              <!-- <a href="">
              <img class="card-img-left img-fluid" src="../includes/images/products/products-2.jpg" alt="Card image cap">
            </a> -->
          </div>
          <div class="card-body">
            <h4 class="card-title"><a href="space.php?space=<?php echo $newdata[$i]['Spaces']; ?>&startdate=<?php echo $_GET['startdate']; ?>&enddate=<?php echo $_GET['enddate']; ?>"><?php echo $newdata[$i]['Addresses']; ?></a></h4>
            <ul class="list-inline product-meta">
              <!-- <li class="list-inline-item">
              <a href="spaces.php?spaceID=<?php echo $newdata['Spaces'][$i]; ?>"><i class="fa fa-folder-open-o"></i>Furnitures</a>
            </li> -->
            <li class="list-inline-item">
              <a href=""><strong><?php echo $newdata[$i]['Score'] . "%</strong> match"; ?></a>
            </li>
          </ul>
          <p class="card-text"><?php echo $newdata[$i]['SpaceInformation']; ?></p>
          <!-- <div class="product-ratings">
            <ul class="list-inline">
              <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
              <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
              <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
              <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
              <li class="list-inline-item"><i class="fa fa-star"></i></li>
            </ul>
          </div> -->
        </div>
      </div>
    </div>
  </div>
<?php }
}

?>
</div>
</div>
</div>
</div>
</div>
</section>
<?php
require_once "../layouts/Calssimax/footer.php"; ?>
