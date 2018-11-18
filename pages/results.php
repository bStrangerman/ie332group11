<?php
require_once "../includes/main.php";
require_once "../layouts/Calssimax/header.php";
include "../includes/rankingFunctions.php";



if($err == array()){

  $type = array();

  if(isset($_GET['type']))
  array_push($type, urldecode($_GET['type']));


  $spaceInfo = getAvailableSpaces($start,$end,$type,$conn);

  $address = array();
  $spaceID = array();
  $monthlyPrice = array();
  $spaceSize = array();

  $i = 0;
  while ($i < count($spaceInfo)) {
    array_push($spaceID, $spaceInfo[$i]['SpaceID']);
    array_push($address, $spaceInfo[$i]['Address'] . " " . $spaceInfo[$i]['City'] . " " . $spaceInfo[$i]['State']) . ($spaceInfo[$i]['ZipCode'] != "") ? " " . $spaceInfo[$i]['ZipCode'] : "";
    array_push($monthlyPrice, $spaceInfo[$i]['MonthlyPrice']);
    array_push($spaceSize, $spaceInfo[$i]['SpaceSize']);
    $i++;
  }

  if(isset($_GET['location'])){
    $data = array("Spaces" => $spaceID, "Addresses" => $address, getDistance($_GET['location'], $address), "MonthlyPrice" => $monthlyPrice, "SpaceSize" => $spaceSize);

    $max_count = count($data["Spaces"]);

    if(isset($_GET['range']))
    $range = $_GET['range'];
    else
    $range = 10000;

    for ($i = 0; $i < $max_count; $i++) {
      if ($data[0]["Distance"][$i] > $range) {
        unset($data["Spaces"][$i]);
        unset($data["Addresses"][$i]);
        unset($data["MonthlyPrice"][$i]);
        unset($data["SpaceSize"][$i]);
      }
    }
    unset($data["Spaces"][$max_count - 1]);
    unset($data["Addresses"][$max_count - 1]);
    unset($data["MonthlyPrice"][$max_count - 1]);
    unset($data["SpaceSize"][$max_count - 1]);
  }
  else if($_GET['state']){
    $data = array("Spaces" => $spaceID, "Addresses" => $address, "MonthlyPrice" => $monthlyPrice, "SpaceSize" => $spaceSize);
    for($i = 0; $i < count($spaceInfo); $i++){
      if ($spaceInfo[$i]['State'] != $_GET['state']) {
        unset($data["Spaces"][$i]);
        unset($data["Addresses"][$i]);
        unset($data["MonthlyPrice"][$i]);
        unset($data["SpaceSize"][$i]);
      }
        unset($data["Spaces"][count($spaceInfo) - 1]);
        unset($data["Addresses"][count($spaceInfo) - 1]);
        unset($data["MonthlyPrice"][count($spaceInfo) - 1]);
        unset($data["SpaceSize"][count($spaceInfo) - 1]);
    }
  }

if(count($data["Spaces"]) == 0)
array_push($err, "0 Results");
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
              <input type="text" class="form-control" name="location" id="autocomplete" onFocus="geolocate()" value="<?php echo isset($_GET['location']) ? $_GET['location'] : (isset($_GET['state']) ? $_GET['state'] : "") ?>" placeholder="Location">
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
            <h2>Results For "<?php echo isset($_GET['location']) ? $_GET['location'] : (isset($_GET['state']) ? $_GET['state'] : ""); ?>"</h2>
            <p><?php echo (isset($data)) ? count($data['Spaces']) : "0" ?> Results on <?php echo date("F d, Y"); ?></p>
          </div>
        <?php }?>
      </div>
    </div>
    <div class="row">
      <div class="col-md-3">
        <div class="category-sidebar">
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
                <li><a href="results.php?location=<?php echo urlencode($_GET['location']);?>&type=<?php echo urlencode($row['AttributeName']); ?>&startdate=<?php echo $start;?>&enddate=<?php echo $end;?>"><?php echo $row['AttributeName']; ?> <span><?php echo $row['countof']; ?></span></a></li>
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

          <div class="widget filter">
            <h4 class="widget-header">Show Produts</h4>
            <select>
              <option>Popularity</option>
              <option value="1">Top rated</option>
              <option value="2">Lowest Price</option>
              <option value="4">Highest Price</option>
            </select>
          </div>

<?php // TODO: this is not that great of looking ?>
          <div class="widget price-range">
            <h4 class="widget-header">Price Range</h4>
            <div class="block">
              <b>10km</b>
              <input id="ex2" type="range" class="span2" value="" data-slider-min="10000" data-slider-max="100000" data-slider-step="5" data-slider-value="[250,450]"/>
              <b>1000km</b>
            </div>
          </div>

          <div class="widget product-shorting">
            <h4 class="widget-header">By Condition</h4>
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox" value="">
                Brand New
              </label>
            </div>
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox" value="">
                Almost New
              </label>
            </div>
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox" value="">
                Gently New
              </label>
            </div>
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox" value="">
                Havely New
              </label>
            </div>
          </div>

        </div>
      </div>
      <div class="col-md-9">
        <div class="category-search-filter">
          <div class="row">
            <div class="col-md-6">
              <strong>Sort</strong>
              <select>
                <option>Most Recent</option>
                <option value="1">Most Popular</option>
                <option value="2">Lowest Price</option>
                <option value="4">Highest Price</option>
              </select>
            </div>
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
</div>
<div class="product-grid-list">
  <div class="row mt-30">
    <?php
    if($err != array()) { ?>
      <div class="col-sm-12 col-lg-12 col-md-12">
        <?php
        for($i = 0; $i < count($err); $i++){
          echo "<h2 align='center'>" . $err[$i] . "</h2>"; } ?>
        </div>
      <?php } else {
        for($i = 0; $i < count($spaceID); ++$i){
          if(isset($data["Spaces"][$i])) {?>
            <div class="col-sm-12 col-lg-12 col-md-12">
              <!-- product card -->
              <div class="product-item bg-light">
                <div class="card">
                  <div class="thumb-content">
                    <!-- <div class="price">$200</div> -->
                    <!-- <a href="">
                    <img class="card-img-left img-fluid" src="../includes/images/products/products-2.jpg" alt="Card image cap">
                  </a> -->
                </div>
                <div class="card-body">
                  <h4 class="card-title"><a href="space.php?address=<?php echo urlencode($data['Addresses'][$i]); ?>&space=<?php echo $data['Spaces'][$i]; ?>"><?php echo $data['Addresses'][$i]; ?></a></h4>
                  <ul class="list-inline product-meta">
                    <!-- <li class="list-inline-item">
                    <a href="spaces.php?spaceID=<?php echo $data['Spaces'][$i]; ?>"><i class="fa fa-folder-open-o"></i>Furnitures</a>
                  </li> -->
                  <!-- <li class="list-inline-item">
                  <a href=""><i class="fa fa-calendar"></i>26th December</a>
                </li> -->
              </ul>
              <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, aliquam!</p>
              <div class="product-ratings">
                <ul class="list-inline">
                  <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
                  <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
                  <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
                  <li class="list-inline-item selected"><i class="fa fa-star"></i></li>
                  <li class="list-inline-item"><i class="fa fa-star"></i></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    <?php }
  }
  ?>
</div>
</div>
<?php // TODO: pagination is not complete.  see issue #24 ?>
<?php
if(isset($_GET['page']))
$page = $_GET['page'];
else
$page = 1;
?>
<div class="pagination justify-content-center">
  <nav aria-label="Page navigation example">
    <ul class="pagination">
      <?php $i = 2;
      if($page > 1){ ?>
        <li class="page-item">
          <a class="page-link" href="?page=<?php echo $page - 1;?>" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
            <span class="sr-only">Previous</span>
          </a>
        </li>
        <li class="page-item <?php echo ($page - 1 == $i) ? "active" : "" ?>"><a class="page-link" href="?page=<?php echo $page - 1;?>"><?php echo $page - 1;?></a></li>
      <?php } ?>
      <li class="page-item <?php echo ($page == $i) ? "active" : "" ?>"><a class="page-link" href="&page=<?php echo $page;?>"><?php echo $page;?></a></li>
      <li class="page-item <?php echo ($page + 1 == $i) ? "active" : "" ?>"><a class="page-link" href="&page=<?php echo $page + 1;?>"><?php echo $page + 1;?></a></li>
      <li class="page-item">
        <a class="page-link" href="&page=<?php echo $page + 1; ?>" aria-label="Next">
          <span aria-hidden="true">&raquo;</span>
          <span class="sr-only">Next</span>
        </a>
      </li>
    </ul>
  </nav>
</div>
<?php } ?>
</div>
</div>
</div>
</section>
<?php
require_once "../layouts/Calssimax/footer.php"; ?>
