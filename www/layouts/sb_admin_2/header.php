  <!DOCTYPE html>
  <html lang="en">

  <head>

      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="description" content="">
      <meta name="author" content="">
      <title>SB Admin 2 - Bootstrap Admin Theme</title>

      <!-- Bootstrap Core CSS -->
      <link href="../includes/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

      <!-- MetisMenu CSS -->
      <link href="../includes/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

      <!-- Custom CSS -->
      <link href="../includes/dist/css/sb-admin-2.css" rel="stylesheet">

      <!-- Morris Charts CSS -->
      <link href="../includes/vendor/morrisjs/morris.css" rel="stylesheet">

      <!-- Custom Fonts -->
      <link href="../includes/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

  </head>
  <![endif]-->

  <body>

      <div id="wrapper">

          <!-- Navigation -->
          <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
              <div class="navbar-header">
                  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                      <span class="sr-only">Toggle navigation</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                  </button>
                  <a class="navbar-brand" href="index.php"><span class="fa fa-arrow-circle-o-left"> Return Home</span></a>
              </div>
              <!-- /.navbar-header -->
              <?php
              $n = 5;
              $alertInfo = getRecentInfo($_SESSION['UserID'], $n);
              ?>
              <ul class="nav navbar-top-links navbar-right">
                  <li class="dropdown" <?php echo (count($alertInfo)) ? "style='background:red'" : "" ?>>
                      <a class="dropdown-toggle" data-toggle="dropdown" href="#" <?php echo (count($alertInfo)) ? "style='color:white'" : "" ?>>
                          <i class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
                      </a>
                      <ul class="dropdown-menu dropdown-messages">
                  <?php
                        $i=0;
                        while ($i < count($alertInfo)) {
                          $alert = $alertInfo[$i];
                          echo "
                        <li>
                          <a href='$alert[$NotificationLink]'>
                            <div>
                              <strong>" . $alert[$NotificationTypeLongName] . "</strong>
                              <span class='pull-right text-muted'>
                                <em>" . time_ago(date("Y-m-d H:i:s", strtotime($alert[$NotificationTimeElapsed]))) . "</em>
                              </span>
                            </div>
                            <div>" . $alert[$NotificationMessage] . "</div>
                          </a>
                        </li>
                        <li class='divider'></li>";
  $i++;
                        }
                        ?>
                        <li>
                          <a class="text-center" href="#">
                            <strong>Read All Messages</strong>
                            <i class="fa fa-angle-right"></i>
                          </a>
                        </li>
                      </ul>
                      <!-- /.dropdown-messages -->
                  </li>
                  <!-- /.dropdown -->
                  <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                          <i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
                      </a>
                      <ul class="dropdown-menu dropdown-tasks">
                          <li>
                              <a href="#">
                                  <div>
                                      <p>
                                          <strong>Task 1</strong>
                                          <span class="pull-right text-muted">40% Complete</span>
                                      </p>
                                      <div class="progress progress-striped active">
                                          <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                              <span class="sr-only">40% Complete (success)</span>
                                          </div>
                                      </div>
                                  </div>
                              </a>
                          </li>
                          <li class="divider"></li>
                          <li>
                              <a href="#">
                                  <div>
                                      <p>
                                          <strong>Task 2</strong>
                                          <span class="pull-right text-muted">20% Complete</span>
                                      </p>
                                      <div class="progress progress-striped active">
                                          <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                              <span class="sr-only">20% Complete</span>
                                          </div>
                                      </div>
                                  </div>
                              </a>
                          </li>
                          <li class="divider"></li>
                          <li>
                              <a href="#">
                                  <div>
                                      <p>
                                          <strong>Task 3</strong>
                                          <span class="pull-right text-muted">60% Complete</span>
                                      </p>
                                      <div class="progress progress-striped active">
                                          <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                              <span class="sr-only">60% Complete (warning)</span>
                                          </div>
                                      </div>
                                  </div>
                              </a>
                          </li>
                          <li class="divider"></li>
                          <li>
                              <a href="#">
                                  <div>
                                      <p>
                                          <strong>Task 4</strong>
                                          <span class="pull-right text-muted">80% Complete</span>
                                      </p>
                                      <div class="progress progress-striped active">
                                          <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                              <span class="sr-only">80% Complete (danger)</span>
                                          </div>
                                      </div>
                                  </div>
                              </a>
                          </li>
                          <li class="divider"></li>
                          <li>
                              <a class="text-center" href="#">
                                  <strong>See All Tasks</strong>
                                  <i class="fa fa-angle-right"></i>
                              </a>
                          </li>
                      </ul>
                      <!-- /.dropdown-tasks -->
                  </li>
                  <!-- /.dropdown -->

                  <li class="dropdown" <?php echo (count($alertInfo)) ? "style='background:red'" : "" ?>>
                      <a class="dropdown-toggle" data-toggle="dropdown" href="#" <?php echo (count($alertInfo)) ? "style='color:white'" : "" ?>>
                          <i class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i>
                      </a>
                      <ul class="dropdown-menu dropdown-alerts">
                          <?php
                          $n = 5;
                          $i = 0;
                          $alertInfo = getRecentInfo($_SESSION['UserID'], $n);
                          while ($i < count($alertInfo)) {
                            $alert = $alertInfo[$i];
                              echo "<li>
                            <a href='$alert[$NotificationLink]'>
                            <div>
                            <i class='fa " . $alert[$NotificationTypeTypeIcon] . " fa-fw'></i> " . $alert[$NotificationTypeTypeName] . "
                            <span class='pull-right text-muted small'> " . time_ago(date("Y-m-d H:i:s", strtotime($alert[$NotificationTimeElapsed]))) . "</span>
                            </div>
                            </a>
                            </li>
                            <li class='divider'></li>";
                              $i++;
                          }


                      ?>
                          <li>
                              <a class="text-center" href="#">
                                  <strong>See All Alerts</strong>
                                  <i class="fa fa-angle-right"></i>
                              </a>
                          </li>
                      </ul>
                      <!-- /.dropdown-alerts -->
                  </li>
                  <!-- /.dropdown -->
                  <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                          <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                      </a>
                      <ul class="dropdown-menu dropdown-user">
                          <li><a href="ownerProfile.php"><i class="fa fa-user fa-fw"></i> User Profile</a>
                          </li>
                          <!-- <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                          </li> -->
                          <li class="divider"></li>
                          <li><a href="../pages/logout.php"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                          </li>
                      </ul>
                      <!-- /.dropdown-user -->
                  </li>
                  <!-- /.dropdown -->
              </ul>
              <!-- /.navbar-top-links -->

              <div class="navbar-default sidebar" role="navigation">
                  <div class="sidebar-nav navbar-collapse">
                      <ul class="nav" id="side-menu">
                          <li>
                              <a href="warehouse.php"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                          </li>
                          <li>
                              <a href="contractList.php"><i class="fa fa-table fa-fw"></i> Contracts</a>
                          </li>
                          <li>
                              <a href="locations.php"><i class="fa fa-table fa-fw"></i> Locations</a>
                          </li>
                      </ul>
                  </div>
                  <!-- /.sidebar-collapse -->
              </div>
              <!-- /.navbar-static-side -->
          </nav>