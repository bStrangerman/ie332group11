<?php if(isset($_SESSION['UserID'])){
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

<!DOCTYPE html>
<html lang="en">
<head>

  <!-- SITE TITTLE -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>@Capacity</title>

  <!-- PLUGINS CSS STYLE -->
  <link href="../includes/plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet">
  <!-- Bootstrap -->
  <link href="../includes/plugins/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="../includes/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- Owl Carousel -->
  <link href="../includes/plugins/slick-carousel/slick/slick.css" rel="stylesheet">
  <link href="../includes/plugins/slick-carousel/slick/slick-theme.css" rel="stylesheet">
  <!-- Fancy Box -->
  <link href="../includes/plugins/fancybox/jquery.fancybox.pack.css" rel="stylesheet">
  <link href="../includes/plugins/jquery-nice-select/css/nice-select.css" rel="stylesheet">
  <link href="../includes/plugins/seiyria-bootstrap-slider/dist/css/bootstrap-slider.min.css" rel="stylesheet">
  <!-- CUSTOM CSS -->
  <link href="../includes/css/search.css" rel="stylesheet">

  <!-- FAVICON -->
  <link href="../includes/img/favicon.png" rel="shortcut icon">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
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

<body class="body-wrapper">

  <section>
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <nav class="navbar navbar-expand-lg  navigation">
            <a class="navbar-brand" href="index.php">
              <h2><strong>@<span style="color:red">Capacity</span></strong></h2>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav ml-auto main-nav ">
                <li class="nav-item active">
                  <a class="nav-link" href="index.php">Home</a>
                </li>
                <li class="nav-item">
                  <?php if($warehouseRole) {?>
                    <a class="nav-link" href="warehouse.php">Dashboard</a>
                  <?php } else if($LesseeRole) {?>
                    <a class="nav-link" href="lesseeAccount.php">Dashboard</a>
                  <?php } else { ?>
                    <a class="nav-link" href="login.php">Dashboard</a>
                  <?php } ?>
                </li>
                <!-- <li class="nav-item dropdown dropdown-slide">
                <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Pages <span><i class="fa fa-angle-down"></i></span>
              </a> -->
              <!-- Dropdown list -->
              <!-- <div class="dropdown-menu dropdown-menu-right">
              <a class="dropdown-item" href="category.html">Category</a>
              <a class="dropdown-item" href="single.html">Single Page</a>
              <a class="dropdown-item" href="store-single.html">Store Single</a>
              <a class="dropdown-item" href="dashboard.html">Dashboard</a>
              <a class="dropdown-item" href="lesseeProfile.php">User Profile</a>
              <a class="dropdown-item" href="submit-coupon.html">Submit Coupon</a>
              <a class="dropdown-item" href="blog.html">Blog</a>
              <a class="dropdown-item" href="single-blog.html">Single Post</a>
            </div>
          </li>
          <li class="nav-item dropdown dropdown-slide">
          <a class="nav-link dropdown-toggle" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Listing <span><i class="fa fa-angle-down"></i></span>
        </a> -->
        <!-- Dropdown list -->
        <!-- <div class="dropdown-menu dropdown-menu-right">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <a class="dropdown-item" href="#">Something else here</a>
      </div>
    </li> -->
  </ul>
  <ul class="navbar-nav ml-auto mt-10">
    <li class="nav-item">
      <?php if($LesseeRole) { ?>
      <a class="nav-link login-button" href="lesseeAccount.php">My Account</a>
      <?php }
      else if($warehouseRole) { ?>
        <a class="nav-link login-button" href="warehouse.php">My Account</a>
      <?php }
      else { ?>
        <a class="nav-link login-button" href="login.php">Login</a>
      <?php } ?>
    </li>
    <li class="nav-item">
      <a class="nav-link add-button" href="#"><i class="fa fa-plus-circle"></i> Add Listing</a>
    </li>
  </ul>
</div>
</nav>
</div>
</div>
</div>
</section>
