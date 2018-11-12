<?php
require_once "../includes/main.php";
require_once "../layouts/Calssimax/header.php";
include "../includes/rankingFunctions.php";

$start = $_GET['startdate'];
$end = $_GET['enddate'];
$spaceInfo = getAvailableSpaces($start,$end,$conn);
$address = array();
$spaceID = array();
$monthlyPrice = array();
$spaceSize = array();

$i = 0;
while ($i < count($spaceInfo)) {
  array_push($spaceID, $spaceInfo[$i]['SpaceID']);
  array_push($address, $spaceInfo[$i]['Address'] . " " . $spaceInfo[$i]['City'] . " " . $spaceInfo[$i]['State']);
  array_push($monthlyPrice, $spaceInfo[$i]['MonthlyPrice']);
  array_push($spaceSize, $spaceInfo[$i]['SpaceSize']);
  $i++;
}
$data = array("Spaces" => $spaceID, "Addresses" => $address, getDistance($_GET['location'], $address), "MonthlyPrice" => $monthlyPrice, "SpaceSize" => $spaceSize);
$max_count = count($data["Spaces"]);
if(isset($_GET['range']))
$range = $_GET['range'];
else
$range = 10000;

for ($i = 0; $i < $max_count; $i++) {
  if ($data[0]["Distance"][$i] > $range) {
    unset($data[0]["Distance"][$i]);
    unset($data["Spaces"][$i]);
    unset($data["Addresses"][$i]);
    unset($data[0]["Time"][$i]);
    unset($data["MonthlyPrice"][$i]);
    unset($data["SpaceSize"][$i]);
  }
}
unset($data[0]["Distance"][$max_count - 1]);
unset($data["Spaces"][$max_count - 1]);
unset($data["Addresses"][$max_count - 1]);
unset($data[0]["Time"][$max_count - 1]);
unset($data["MonthlyPrice"][$max_count - 1]);
unset($data["SpaceSize"][$max_count - 1]);
?>

<section class="page-search">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <!-- Advance Search -->
        <div class="advance-search">
          <form action="category.php" method="get">
            <div class="form-row">
              <!-- <div class="form-group col-md-3">
              <input type="text" class="form-control" name="description" id="inputtext4" value="<?php echo isset($_GET['description']) ? $_GET['description'] : "" ?>" placeholder="What are you looking for">
            </div> -->
            <div class="form-group col-md-4">
              <input type="text" class="form-control" name="location" id="autocomplete" onFocus="geolocate()" value="<?php echo isset($_GET['location']) ? $_GET['location'] : "" ?>" placeholder="Location">
            </div>
            <div class="form-group col-md-3">
              <input type="date" class="form-control" name="startdate" id="inputdate4" value="<?php echo isset($_GET['startdate']) ? $_GET['startdate'] : "" ?>" placeholder="Start Date">
            </div>
            <div class="form-group col-md-3">
              <input type="date" class="form-control" name="enddate" id="inputdate4" value="<?php echo isset($_GET['enddate']) ? $_GET['enddate'] : "" ?>" placeholder="End Date">
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
        <div class="search-result bg-gray">
          <h2>Results For "<?php echo isset($_GET['location']) ? $_GET['location'] : "" ?>"</h2>
          <p><?php echo count($data['Spaces']); ?> Results on <?php echo date("F d, Y"); ?></p>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-3">
        <div class="category-sidebar">
          <div class="widget category-list">
            <h4 class="widget-header">All Category</h4>
            <ul class="category-list">
              <li><a href="category.html">Laptops <span>93</span></a></li>
              <li><a href="category.html">Iphone <span>233</span></a></li>
              <li><a href="category.html">Microsoft  <span>183</span></a></li>
              <li><a href="category.html">Monitors <span>343</span></a></li>
            </ul>
          </div>

          <div class="widget category-list">
            <h4 class="widget-header">Nearby</h4>
            <ul class="category-list">
              <li><a href="category.html">New York <span>93</span></a></li>
              <li><a href="category.html">New Jersy <span>233</span></a></li>
              <li><a href="category.html">Florida  <span>183</span></a></li>
              <li><a href="category.html">California <span>120</span></a></li>
              <li><a href="category.html">Texas <span>40</span></a></li>
              <li><a href="category.html">Alaska <span>81</span></a></li>
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

          <div class="widget price-range">
            <h4 class="widget-header">Price Range</h4>
            <div class="block">
              <b>$10</b>
              <input id="ex2" type="text" class="span2" value="" data-slider-min="10" data-slider-max="1000" data-slider-step="5" data-slider-value="[250,450]"/>
              <b>$5000</b>
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
              <strong>Short</strong>
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
              <h4 class="card-title"><a href="spaces.php?spaceID=<?php echo $data['Spaces'][$i]; ?>"><?php echo $data['Addresses'][$i]; ?></a></h4>
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
}?>
</div>
</div>
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
        <a class="page-link" href="&page=<?php echo $page + 1;?>" aria-label="Next">
          <span aria-hidden="true">&raquo;</span>
          <span class="sr-only">Next</span>
        </a>
      </li>
    </ul>
  </nav>
</div>
</div>
</div>
</div>
</section>
<?php require_once "../layouts/Calssimax/footer.php"; ?>
