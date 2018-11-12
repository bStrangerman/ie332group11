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
  <title>Directory Landing Page</title>

  <!-- For favicon png -->
  <link rel="shortcut icon" type="image/icon" href="../includes/logo/favicon.png"/>

  <!--font-awesome.min.css-->
  <link rel="stylesheet" href="../includes/css/font-awesome.min.css">

  <!--linear icon css-->
  <link rel="stylesheet" href="../includes/css/linearicons.css">

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

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
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

        </div><!--/.navbar-header-->
        <!-- End Header Navigation -->

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse menu-ui-design" id="navbar-menu">
          <ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
            <li class=" scroll active"><a href="#home">home</a></li>
            <li class="scroll"><a href="#explore">explore</a></li>
            <li class="scroll"><a href="#reviews">review</a></li>
            <li><a href="login.php">Login/Register</a></li>
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
    <form action="" method="get">
    <div class="welcome-hero-serch-box">
      <div class="welcome-hero-form">
        <div class="single-welcome-hero-form">
          <h3>what?</h3>
            <input type="text" name="description" placeholder="Ex: climate-controlled, outdoors" />
          <div class="welcome-hero-form-icon">
            <i class="flaticon-list-with-dots"></i>
          </div>
        </div>
        <div class="single-welcome-hero-form">
          <h3>location</h3>
              <input id="autocomplete" name="location" placeholder="Ex: new york, indianapolis, houston" onFocus="geolocate()" type="text"></input>
          </form>
          <div class="welcome-hero-form-icon">
            <i class="flaticon-gps-fixed-indicator"></i>
          </div>
        </div>
      </div>
      <div class="welcome-hero-serch">
        <button type="submit" class="welcome-hero-btn">
          search  <i data-feather="search"></i>
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
        <!-- <?php // TODO: do this
        $sql = "SELECT AttributeName
        FROM Attributes
        WHERE AttributeType = 1
        AND" ?> -->
        <?php for($i = 0; $i < 2 ; $i++){ ?>
          <li>
            <div class="single-list-topics-content">
              <div class="single-list-topics-icon">
                <i class="flaticon-restaurant"></i>
              </div>
              <h2><a href="#">resturent</a></h2>
              <p><?php echo $i; ?> listings</p>
            </div>
          </li>
        <?php  } ?>
      </ul>
    </div>
  </div><!--/.container-->

</section><!--/.list-topics-->
<!--list-topics end-->


<!--explore start -->
<section id="explore" class="explore">
  <div class="container">
    <div class="section-header">
      <h2>explore</h2>
      <p>Explore New place, food, culture around the world and many more</p>
    </div><!--/.section-header-->
    <div class="explore-content">
      <div class="row">
        <div class=" col-md-4 col-sm-6">
          <div class="single-explore-item">
            <div class="single-explore-img">
              <img src="../includes/images/explore/e1.jpg" alt="explore image">
              <div class="single-explore-img-info">
                <button onclick="window.location.href='#'">best rated</button>
                <div class="single-explore-image-icon-box">
                  <ul>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-arrows-alt"></i>
                      </div>
                    </li>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-bookmark-o"></i>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="single-explore-txt bg-theme-1">
              <h2><a href="#">tommy helfinger bar</a></h2>
              <p class="explore-rating-price">
                <span class="explore-rating">5.0</span>
                <a href="#"> 10 ratings</a>
                <span class="explore-price-box">
                  form
                  <span class="explore-price">5$-300$</span>
                </span>
                <a href="#">resturent</a>
              </p>
              <div class="explore-person">
                <div class="row">
                  <div class="col-sm-2">
                    <div class="explore-person-img">
                      <a href="#">
                        <img src="../includes/images/explore/person.png" alt="explore person">
                      </a>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incid ut labore et dolore magna aliqua....
                    </p>
                  </div>
                </div>
              </div>
              <div class="explore-open-close-part">
                <div class="row">
                  <div class="col-sm-5">
                    <button class="close-btn" onclick="window.location.href='#'">close now</button>
                  </div>
                  <div class="col-sm-7">
                    <div class="explore-map-icon">
                      <a href="#"><i data-feather="map-pin"></i></a>
                      <a href="#"><i data-feather="upload"></i></a>
                      <a href="#"><i data-feather="heart"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4 col-sm-6">
          <div class="single-explore-item">
            <div class="single-explore-img">
              <img src="../includes/images/explore/e2.jpg" alt="explore image">
              <div class="single-explore-img-info">
                <button onclick="window.location.href='#'">featured</button>
                <div class="single-explore-image-icon-box">
                  <ul>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-arrows-alt"></i>
                      </div>
                    </li>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-bookmark-o"></i>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="single-explore-txt bg-theme-2">
              <h2><a href="#">swim and dine resort</a></h2>
              <p class="explore-rating-price">
                <span class="explore-rating">4.5</span>
                <a href="#"> 8 ratings</a>
                <span class="explore-price-box">
                  form
                  <span class="explore-price">50$-500$</span>
                </span>
                <a href="#">hotel</a>
              </p>
              <div class="explore-person">
                <div class="row">
                  <div class="col-sm-2">
                    <div class="explore-person-img">
                      <a href="#">
                        <img src="../includes/images/explore/person.png" alt="explore person">
                      </a>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incid ut labore et dolore magna aliqua....
                    </p>
                  </div>
                </div>
              </div>
              <div class="explore-open-close-part">
                <div class="row">
                  <div class="col-sm-5">
                    <button class="close-btn open-btn" onclick="window.location.href='#'">open now</button>
                  </div>
                  <div class="col-sm-7">
                    <div class="explore-map-icon">
                      <a href="#"><i data-feather="map-pin"></i></a>
                      <a href="#"><i data-feather="upload"></i></a>
                      <a href="#"><i data-feather="heart"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4 col-sm-6">
          <div class="single-explore-item">
            <div class="single-explore-img">
              <img src="../includes/images/explore/e3.jpg" alt="explore image">
              <div class="single-explore-img-info">
                <button onclick="window.location.href='#'">best rated</button>
                <div class="single-explore-image-icon-box">
                  <ul>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-arrows-alt"></i>
                      </div>
                    </li>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-bookmark-o"></i>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="single-explore-txt bg-theme-3">
              <h2><a href="#">europe tour</a></h2>
              <p class="explore-rating-price">
                <span class="explore-rating">5.0</span>
                <a href="#"> 15 ratings</a>
                <span class="explore-price-box">
                  form
                  <span class="explore-price">5k$-10k$</span>
                </span>
                <a href="#">destination</a>
              </p>
              <div class="explore-person">
                <div class="row">
                  <div class="col-sm-2">
                    <div class="explore-person-img">
                      <a href="#">
                        <img src="../includes/images/explore/person.png" alt="explore person">
                      </a>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incid ut labore et dolore magna aliqua....
                    </p>
                  </div>
                </div>
              </div>
              <div class="explore-open-close-part">
                <div class="row">
                  <div class="col-sm-5">
                    <button class="close-btn" onclick="window.location.href='#'">close now</button>
                  </div>
                  <div class="col-sm-7">
                    <div class="explore-map-icon">
                      <a href="#"><i data-feather="map-pin"></i></a>
                      <a href="#"><i data-feather="upload"></i></a>
                      <a href="#"><i data-feather="heart"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class=" col-md-4 col-sm-6">
          <div class="single-explore-item">
            <div class="single-explore-img">
              <img src="../includes/images/explore/e4.jpg" alt="explore image">
              <div class="single-explore-img-info">
                <button onclick="window.location.href='#'">most view</button>
                <div class="single-explore-image-icon-box">
                  <ul>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-arrows-alt"></i>
                      </div>
                    </li>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-bookmark-o"></i>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="single-explore-txt bg-theme-4">
              <h2><a href="#">banglow with swiming pool</a></h2>
              <p class="explore-rating-price">
                <span class="explore-rating">5.0</span>
                <a href="#"> 10 ratings</a>
                <span class="explore-price-box">
                  form
                  <span class="explore-price">10k$-15k$</span>
                </span>
                <a href="#">real estate</a>
              </p>
              <div class="explore-person">
                <div class="row">
                  <div class="col-sm-2">
                    <div class="explore-person-img">
                      <a href="#">
                        <img src="../includes/images/explore/person.png" alt="explore person">
                      </a>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incid ut labore et dolore magna aliqua....
                    </p>
                  </div>
                </div>
              </div>
              <div class="explore-open-close-part">
                <div class="row">
                  <div class="col-sm-5">
                    <button class="close-btn" onclick="window.location.href='#'">close now</button>
                  </div>
                  <div class="col-sm-7">
                    <div class="explore-map-icon">
                      <a href="#"><i data-feather="map-pin"></i></a>
                      <a href="#"><i data-feather="upload"></i></a>
                      <a href="#"><i data-feather="heart"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4 col-sm-6">
          <div class="single-explore-item">
            <div class="single-explore-img">
              <img src="../includes/images/explore/e5.jpg" alt="explore image">
              <div class="single-explore-img-info">
                <button onclick="window.location.href='#'">featured</button>
                <div class="single-explore-image-icon-box">
                  <ul>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-arrows-alt"></i>
                      </div>
                    </li>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-bookmark-o"></i>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="single-explore-txt bg-theme-2">
              <h2><a href="#">vintage car expo</a></h2>
              <p class="explore-rating-price">
                <span class="explore-rating">4.2</span>
                <a href="#"> 8 ratings</a>
                <span class="explore-price-box">
                  form
                  <span class="explore-price">500$-1200$</span>
                </span>
                <a href="#">automotion</a>
              </p>
              <div class="explore-person">
                <div class="row">
                  <div class="col-sm-2">
                    <div class="explore-person-img">
                      <a href="#">
                        <img src="../includes/images/explore/person.png" alt="explore person">
                      </a>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incid ut labore et dolore magna aliqua....
                    </p>
                  </div>
                </div>
              </div>
              <div class="explore-open-close-part">
                <div class="row">
                  <div class="col-sm-5">
                    <button class="close-btn open-btn" onclick="window.location.href='#'">open now</button>
                  </div>
                  <div class="col-sm-7">
                    <div class="explore-map-icon">
                      <a href="#"><i data-feather="map-pin"></i></a>
                      <a href="#"><i data-feather="upload"></i></a>
                      <a href="#"><i data-feather="heart"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-md-4 col-sm-6">
          <div class="single-explore-item">
            <div class="single-explore-img">
              <img src="../includes/images/explore/e6.jpg" alt="explore image">
              <div class="single-explore-img-info">
                <button onclick="window.location.href='#'">best rated</button>
                <div class="single-explore-image-icon-box">
                  <ul>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-arrows-alt"></i>
                      </div>
                    </li>
                    <li>
                      <div class="single-explore-image-icon">
                        <i class="fa fa-bookmark-o"></i>
                      </div>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="single-explore-txt bg-theme-5">
              <h2><a href="#">thailand tour</a></h2>
              <p class="explore-rating-price">
                <span class="explore-rating">5.0</span>
                <a href="#"> 15 ratings</a>
                <span class="explore-price-box">
                  form
                  <span class="explore-price">5k$-10k$</span>
                </span>
                <a href="#">destination</a>
              </p>
              <div class="explore-person">
                <div class="row">
                  <div class="col-sm-2">
                    <div class="explore-person-img">
                      <a href="#">
                        <img src="../includes/images/explore/person.png" alt="explore person">
                      </a>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incid ut labore et dolore magna aliqua....
                    </p>
                  </div>
                </div>
              </div>
              <div class="explore-open-close-part">
                <div class="row">
                  <div class="col-sm-5">
                    <button class="close-btn" onclick="window.location.href='#'">close now</button>
                  </div>
                  <div class="col-sm-7">
                    <div class="explore-map-icon">
                      <a href="#"><i data-feather="map-pin"></i></a>
                      <a href="#"><i data-feather="upload"></i></a>
                      <a href="#"><i data-feather="heart"></i></a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div><!--/.container-->

</section><!--/.explore-->
<!--explore end -->

<!--reviews start -->
<section id="reviews" class="reviews">
  <div class="section-header">
    <h2>clients reviews</h2>
    <p>What our client say about us</p>
  </div><!--/.section-header-->
  <div class="reviews-content">
    <div class="testimonial-carousel">
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c1.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>Tom Leakar</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c2.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>monirul islam</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c3.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>Shohrab Hossain</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c4.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>Tom Leakar</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c1.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>Tom Leakar</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c2.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>monirul islam</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c3.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>Shohrab Hossain</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
      <div class="single-testimonial-box">
        <div class="testimonial-description">
          <div class="testimonial-info">
            <div class="testimonial-img">
              <img src="../includes/images/clients/c4.png" alt="clients">
            </div><!--/.testimonial-img-->
            <div class="testimonial-person">
              <h2>Tom Leakar</h2>
              <h4>london, UK</h4>
              <div class="testimonial-person-star">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
              </div>
            </div><!--/.testimonial-person-->
          </div><!--/.testimonial-info-->
          <div class="testimonial-comment">
            <p>
              Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis eaque.
            </p>
          </div><!--/.testimonial-comment-->
        </div><!--/.testimonial-description-->
      </div><!--/.single-testimonial-box-->
    </div>
  </div>

</section><!--/.reviews-->
<!--reviews end -->







<!--footer start-->
<footer id="footer"  class="footer">
  <div class="container">
    <div class="footer-menu">
      <div class="row">
        <div class="col-sm-3">
          <div class="navbar-header">
            <a class="navbar-brand" href="index.php">list<span>race</span></a>
          </div><!--/.navbar-header-->
        </div>
        <div class="col-sm-9">
          <ul class="footer-menu-item">
            <li class="scroll"><a href="#explore">explore</a></li>
            <li class="scroll"><a href="#reviews">review</a></li>
            <li class="scroll"><a href="#blog">blog</a></li>
            <li class="scroll"><a href="#contact">contact</a></li>
            <li class="scroll"><a href="#contact">my account</a></li>
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
            <!-- <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-linkedin"></i></a>
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

</body>

</html>
