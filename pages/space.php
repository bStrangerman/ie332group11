<?php
require_once "../includes/main.php";
require_once "../layouts/Calssimax/header.php";
include "../includes/rankingFunctions.php";

if(isset($_GET['address']))
$address = urldecode($_GET['address']);

if(isset($_GET['space']))
$space = $_GET['space'];

$sql = "SELECT *
FROM Spaces
LEFT JOIN Warehouses
ON spaces.WarehouseID = Warehouses.WarehouseID
LEFT JOIN phprbac_users
ON phprbac_users.UserID = Warehouses.OwnerID
WHERE Spaces.SpaceID = $space";

// LEFT JOIN Warehouse_Pictures
// ON Warehouse_Pictures.WarehouseID = Warehouses.WarehouseID
// LEFT JOIN Pictures
// ON Pictures.PictureID = Warehouse_Pictures.PictureID

$result = $conn -> query($sql);
while($spaceInfo[]=mysqli_fetch_array($result));

$warehouseID = $spaceInfo[0]['WarehouseID'];

$pictures = array();

$sql = "SELECT FileName
FROM Pictures
WHERE PictureID IN
(SELECT PictureID
  FROM Warehouse_Pictures
  WHERE WarehouseID = $warehouseID)
  ORDER BY PictureID";

  $result = $conn -> query($sql);

  while($row = $result -> fetch_assoc()){
    array_push($pictures, $row['FileName']);
  }

  ?>
  <!-- Owl Carousel -->
  <link href="../includes/plugins/slick-carousel/slick/slick.css" rel="stylesheet">
  <link href="../includes/plugins/slick-carousel/slick/slick-theme.css" rel="stylesheet">

  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.4/dist/leaflet.css"
    integrity="sha512-puBpdR0798OZvTTbP4A8Ix/l+A4dHDD0DGqYW6RQ+9jxkRFclaxxQb/SJAWZfWAkuyeQUytO7+7N4QKrDh+drA=="
    crossorigin=""/>
  <script src="https://unpkg.com/leaflet@1.3.4/dist/leaflet.js"
    integrity="sha512-nMMmRyTVoLYqjP9hrbed9S+FzjZHW5gY1TWCHA5ckwXZBadntCNs8kEqAWdrb9O7rxbCaA4lKTIWjDXZxflOcA=="
    crossorigin=""></script>
    
  <section class="page-search">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <!-- Advance Search -->
          <div class="advance-search">
            <form action="results.php?startdate=<?php echo $start; ?>&enddate=<?php echo $end; ?>" method="get">
              <div class="form-row">
                <div class="form-group col-md-4">
                  <input type="text" class="form-control" name="location" id="autocomplete" onFocus="geolocate()" value="<?php echo $address; ?>" placeholder="Location">
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
  <!--===================================
  =            Store Section            =
  ====================================-->
  <section class="section bg-gray">
    <!-- Container Start -->
    <div class="container">
      <div class="row">
        <!-- Left sidebar -->
        <div class="col-md-8">
          <div class="product-details">
            <h1 class="product-title"><?php echo $spaceInfo[0]['Address']; ?></h1>
            <div class="product-meta">
              <ul class="list-inline">
                <li class="list-inline-item"><i class="fa fa-user-o"></i> By <a href=""><?php echo $spaceInfo[0]['Username']; ?></a></li>
                <?php
                $attributes = array();

                $sql = "SELECT *
                FROM Attributes
                WHERE AttributeID IN
                (SELECT AttributeID
                  FROM Space_Attributes
                  WHERE SpaceID = $space)";

                  $result = $conn -> query($sql);

                  while($row = $result -> fetch_assoc()){?>
                    <li class="list-inline-item"><i class="fa fa-folder-open-o"></i> Category<a href=""><?php echo ($row['AttributeType'] == 1) ? $row['AttributeName'] : ""; ?></a></li>
                  <?php  } ?>
                  <li class="list-inline-item"><i class="fa fa-location-arrow"></i> Location<a href=""><?php echo $spaceInfo[0]['State']?></a></li>
                </ul>
              </div>
              <div id="carouselExampleIndicators" class="product-slider carousel slide" data-ride="carousel">
                <ol class="carousel-indicators">
                  <?php
                  for($i = 0; $i < count($pictures); $i++){ ?>
                    <li data-target="#carouselExampleIndicators" data-slide-to="<?php echo $i; ?>" <?php ($i == 0) ? "class='active'>" : "" ?></li>
                  <?php } ?>
                </ol>
                <div class="carousel-inner">
                  <?php
                  for($i = 0; $i < count($pictures); $i++){ ?>
                    <div class="carousel-item <?php echo ($i == 0) ? "active" : "" ?>">
                      <img class="d-block w-100" src="../pictures/<?php echo $pictures[$i]; ?>" alt="First slide">
                    </div>
                  <?php } ?>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
                </a>
              </div>
              <div class="content">
                <ul class="nav nav-pills  justify-content-center" id="pills-tab" role="tablist">
                  <li class="nav-item">
                    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Space Details</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Specifications</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Reviews</a>
                  </li>
                </ul>
                <div class="tab-content" id="pills-tabContent">
                  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                    <h3 class="tab-title">Space Description</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Officia laudantium beatae quod perspiciatis, neque dolores eos rerum, ipsa iste cum culpa numquam amet provident eveniet pariatur, sunt repellendus quas voluptate dolor cumque autem molestias. Ab quod quaerat molestias culpa eius, perferendis facere vitae commodi maxime qui numquam ex voluptatem voluptate, fuga sequi, quasi! Accusantium eligendi vitae unde iure officia amet molestiae velit assumenda, quidem beatae explicabo dolore laboriosam mollitia quod eos, eaque voluptas enim fuga laborum, error provident labore nesciunt ad. Libero reiciendis necessitatibus voluptates ab excepturi rem non, nostrum aut aperiam? Itaque, aut. Quas nulla perferendis neque eveniet ullam?</p>

                    <iframe width="100%" height="400" src="https://www.youtube.com/embed/LUH7njvhydE?rel=0&amp;controls=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>
                    <p></p>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quibusdam sed, officia reiciendis necessitatibus obcaecati eum, quaerat unde illo suscipit placeat nihil voluptatibus ipsa omnis repudiandae, excepturi! Id aperiam eius perferendis cupiditate exercitationem, mollitia numquam fuga, inventore quam eaque cumque fugiat, neque repudiandae dolore qui itaque iste asperiores ullam ut eum illum aliquam dignissimos similique! Aperiam aut temporibus optio nulla numquam molestias eum officia maiores aliquid laborum et officiis pariatur, delectus sapiente molestiae sit accusantium a libero, eligendi vero eius laboriosam minus. Nemo quibusdam nesciunt doloribus repellendus expedita necessitatibus velit vero?</p>

                  </div>
                  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                    <h3 class="tab-title">Space Specifications</h3>
                    <table class="table table-bordered product-table">
                      <tbody>
                        <tr>
                          <td>Size</td>
                          <td><?php echo $spaceInfo[0]['SpaceSize']; ?> Square Feet</td>
                        </tr>
                        <tr>
                          <td>Price</td>
                          <td>$<?php echo $spaceInfo[0]['MonthlyPrice']; ?> per Square Foot Per Month</td>
                        </tr>
                        <tr>
                          <td>Added</td>
                          <td><?php echo date("F d, Y", strtotime($spaceInfo[0]['DateAdded'])); ?></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                    <h3 class="tab-title">Space Review</h3>
                    <div class="product-review">
                      <div class="media">
                        <!-- Avater -->
                        <img src="../includes/images/user/user-thumb.jpg" alt="avater">
                        <div class="media-body">
                          <!-- Ratings -->
                          <div class="ratings">
                            <ul class="list-inline">
                              <li class="list-inline-item">
                                <i class="fa fa-star"></i>
                              </li>
                              <li class="list-inline-item">
                                <i class="fa fa-star"></i>
                              </li>
                              <li class="list-inline-item">
                                <i class="fa fa-star"></i>
                              </li>
                              <li class="list-inline-item">
                                <i class="fa fa-star"></i>
                              </li>
                              <li class="list-inline-item">
                                <i class="fa fa-star"></i>
                              </li>
                            </ul>
                          </div>
                          <div class="name">
                            <h5>Jessica Brown</h5>
                          </div>
                          <div class="date">
                            <p></p>
                          </div>
                          <div class="review-comment">
                            <p>
                              Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremqe laudant tota rem ape riamipsa eaque.
                            </p>
                          </div>
                        </div>
                      </div>
                      <div class="review-submission">
                        <h3 class="tab-title">Submit your review</h3>
                        <!-- Rate -->
                        <div class="rate">
                          <div class="starrr"></div>
                        </div>
                        <div class="review-submit">
                          <form action="#" class="row">
                            <div class="col-lg-6">
                              <input type="text" name="name" id="name" class="form-control" placeholder="Name">
                            </div>
                            <div class="col-lg-6">
                              <input type="email" name="email" id="email" class="form-control" placeholder="Email">
                            </div>
                            <div class="col-12">
                              <textarea name="review" id="review" rows="10" class="form-control" placeholder="Message"></textarea>
                            </div>
                            <div class="col-12">
                              <button type="submit" class="btn btn-main">Sumbit</button>
                            </div>
                          </form>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="sidebar">
              <div class="widget price text-center">
                <h4>Price Per Month</h4>
                <p>$<?php echo ($spaceInfo[0]['MonthlyPrice'] * $spaceInfo[0]['SpaceSize']); ?></p>
                <a href="book.php" class="btn btn-transparent-white">Book Now</a>
              </div>
              <?php // TODO: change the map dynamically based on warehouse address ?>
              <!-- Map Widget -->
              <style>
              /* Set the size of the div element that contains the map */
              #map {
                height: inherit;  /* The height is 400 pixels */
                width: inherit;  /* The width is the width of the web page */
              }
              </style>

              <div class="widget map">
                <style>
                #mapid { height: 180px; }
                </style>
                <div id="mapid"></div>
                <script>
                var mymap = L.map('mapid').setView([51.505, -0.09], 13);
                }
                </script>
                <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDdGKJ_S6C6zYyhJdmVmzHRD4vHo8t4j-s&callback=initMap"
                async defer></script>


              </div>

              <!-- Coupon Widget -->
              <div class="widget coupon text-center">
                <!-- Coupon description -->
                <p>Have a great product to post ? Share it with
                  your fellow users.
                </p>
                <!-- Submii button -->
                <a href="" class="btn btn-transparent-white">Submit Listing</a>
              </div>

            </div>
          </div>

        </div>
      </div>
      <!-- Container End -->
    </section>

    <!-- Make sure you put this AFTER Leaflet's CSS -->

    <?php
    require_once "../layouts/Calssimax/footer.php"; ?>
