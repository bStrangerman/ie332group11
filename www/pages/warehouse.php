<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";

if (isset($_SESSION['UserID'])) {
  if (!$rbac->Users->hasRole('Warehouse_Owner', $UserID = $_SESSION['UserID'])) {
    header('Location: login.php');
    $_SESSION['redirect'] = 'Location: warehouse.php';
  }
}

require_once "../layouts/sb_admin_2/header.php";
?>
<div id="page-wrapper">
  <div class="row">
    <div class="col-lg-12">
      <?php
      $UserID = $_SESSION['UserID'];
      $sql = "SELECT Company
      FROM phprbac_users
      WHERE UserID = $UserID";
      $result = $conn -> query($sql);
      $row = $result -> fetch_assoc();
      $company = ($row['Company'] == "") ? "Dashboard" : $row['Company'];
      ?>

      <h1 class="page-header">
        <?php echo $company; ?>
      </h1>
    </div>
    <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-primary">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="fa fa-comments fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">26</div>
              <div>New Comments!</div>
            </div>
          </div>
        </div>
        <a href="#">
          <div class="panel-footer">
            <span class="pull-left">View Details</span>
            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
            <div class="clearfix"></div>
          </div>
        </a>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-green">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="fa fa-tasks fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">12</div>
              <div>New Tasks!</div>
            </div>
          </div>
        </div>
        <a href="#">
          <div class="panel-footer">
            <span class="pull-left">View Details</span>
            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
            <div class="clearfix"></div>
          </div>
        </a>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-yellow">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="fa fa-shopping-cart fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">124</div>
              <div>New Orders!</div>
            </div>
          </div>
        </div>
        <a href="#">
          <div class="panel-footer">
            <span class="pull-left">View Details</span>
            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
            <div class="clearfix"></div>
          </div>
        </a>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="panel panel-red">
        <div class="panel-heading">
          <div class="row">
            <div class="col-xs-3">
              <i class="fa fa-support fa-5x"></i>
            </div>
            <div class="col-xs-9 text-right">
              <div class="huge">13</div>
              <div>Support Tickets!</div>
            </div>
          </div>
        </div>
        <a href="#">
          <div class="panel-footer">
            <span class="pull-left">View Details</span>
            <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
            <div class="clearfix"></div>
          </div>
        </a>
      </div>
    </div>
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-8">
      <div class="panel panel-default">
        <div class="panel-heading">
          <i class="fa fa-bar-chart-o fa-fw"></i> Area Chart Example
          <div class="pull-right">
            <div class="btn-group">
              <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                Actions
                <span class="caret"></span>
              </button>
              <ul class="dropdown-menu pull-right" role="menu">
                <li><a href="#">Action</a>
                </li>
                <li><a href="#">Another action</a>
                </li>
                <li><a href="#">Something else here</a>
                </li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
          <div id="morris-area-chart"></div>
        </div>
        <!-- /.panel-body -->
      </div>
    </div>
    <!-- /.row -->
    <div class="row">
      <div class="col-lg-8">
        <!-- /.panel -->
        <div class="panel panel-default">
          <div class="panel-heading">
            <i class="fa fa-bar-chart-o fa-fw"></i> Profit By Warehouse
          </div>
        <!-- /.panel -->
        <div class="panel-body">
          <div id="myChart"></div>
        </div>
      </div>

        <?php
        $sqlBarGraph = "SELECT *
        FROM Contracts
        RIGHT JOIN Spaces
        ON Spaces.SpaceID = Contracts.SpaceID
        RIGHT JOIN Warehouses
        ON Warehouses.WarehouseID = Spaces.WarehouseID
        WHERE Warehouses.OwnerID = $UserID
        GROUP BY Warehouses.WarehouseID";

        $data=$conn -> query($sqlBarGraph);

        ?>
        <script>
        //assigns the amount charged data into myData
        var myData=[<?php
        while($info = $data -> fetch_assoc())
        echo $info['AmountCharged'].',';
        ?>];
        //Grabs total money earned by space and spaceID

        //assigns SpaceID into labels on bar gragh
        var myLabels=[<?php
        while($info = $data -> fetch_assoc())
        echo '"'.$info['WarehouseID'].'",';
        ?>];
        </script>
        ]
        <script>
        window.onload=function(){
          zingchart.render({
            id:"myChart",
            width:"100%",
            height:400,
            data:{
              "type":"bar",
              "title":{
                "text":"Total Earnings by Warehouse"
              },
              "scale-x":{
                "labels":myLabels
              },
              "series":[
                {
                  "values":myData
                }
              ]
            }
          });
        };
        </script>
      </div>
    </div>
  </div>
</div>
<!-- /.panel-heading -->
<div class="panel-body">
  <div class="row">
    <div class="col-lg-4">
      <div class="table-responsive">
        <table class="table table-bordered table-hover table-striped">
          <thead>
            <tr>
              <th>#</th>
              <th>Date</th>
              <th>Time</th>
              <th>Amount</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>3326</td>
              <td>10/21/2013</td>
              <td>3:29 PM</td>
              <td>$321.33</td>
            </tr>
            <tr>
              <td>3325</td>
              <td>10/21/2013</td>
              <td>3:20 PM</td>
              <td>$234.34</td>
            </tr>
            <tr>
              <td>3324</td>
              <td>10/21/2013</td>
              <td>3:03 PM</td>
              <td>$724.17</td>
            </tr>
            <tr>
              <td>3323</td>
              <td>10/21/2013</td>
              <td>3:00 PM</td>
              <td>$23.71</td>
            </tr>
            <tr>
              <td>3322</td>
              <td>10/21/2013</td>
              <td>2:49 PM</td>
              <td>$8345.23</td>
            </tr>
            <tr>
              <td>3321</td>
              <td>10/21/2013</td>
              <td>2:23 PM</td>
              <td>$245.12</td>
            </tr>
            <tr>
              <td>3320</td>
              <td>10/21/2013</td>
              <td>2:15 PM</td>
              <td>$5663.54</td>
            </tr>
            <tr>
              <td>3319</td>
              <td>10/21/2013</td>
              <td>2:13 PM</td>
              <td>$943.45</td>
            </tr>
          </tbody>
        </table>
      </div>
      <!-- /.table-responsive -->
    </div>
    <!-- /.col-lg-4 (nested) -->
    <div class="col-lg-8">
      <div id="morris-bar-chart"></div>
    </div>
    <!-- /.col-lg-8 (nested) -->
  </div>
  <!-- /.row -->
</div>
<!-- /.panel-body -->
</div>
<!-- /.panel -->
<div class="panel panel-default">
  <div class="panel-heading">
    <i class="fa fa-clock-o fa-fw"></i> Responsive Timeline
  </div>
  <!-- /.panel-heading -->
  <div class="panel-body">
    <ul class="timeline">
      <li>
        <div class="timeline-badge"><i class="fa fa-check"></i>
        </div>
        <div class="timeline-panel">
          <div class="timeline-heading">
            <h4 class="timeline-title">Lorem ipsum dolor</h4>
            <p><small class="text-muted"><i class="fa fa-clock-o"></i> 11 hours ago via Twitter</small>
            </p>
          </div>
          <div class="timeline-body">
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Libero laboriosam dolor perspiciatis omnis exercitationem. Beatae, officia pariatur? Est cum veniam excepturi. Maiores praesentium, porro voluptas suscipit facere rem
              dicta, debitis.</p>
            </div>
          </div>
        </li>
        <li class="timeline-inverted">
          <div class="timeline-badge warning"><i class="fa fa-credit-card"></i>
          </div>
          <div class="timeline-panel">
            <div class="timeline-heading">
              <h4 class="timeline-title">Lorem ipsum dolor</h4>
            </div>
            <div class="timeline-body">
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem dolorem quibusdam, tenetur commodi provident cumque magni voluptatem libero, quis rerum. Fugiat esse debitis optio, tempore. Animi officiis alias, officia
                repellendus.</p>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Laudantium maiores odit qui est tempora eos, nostrum provident explicabo dignissimos debitis vel! Adipisci eius voluptates, ad aut recusandae minus eaque facere.</p>
              </div>
            </div>
          </li>
          <li>
            <div class="timeline-badge danger"><i class="fa fa-bomb"></i>
            </div>
            <div class="timeline-panel">
              <div class="timeline-heading">
                <h4 class="timeline-title">Lorem ipsum dolor</h4>
              </div>
              <div class="timeline-body">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Repellendus numquam facilis enim eaque, tenetur nam id qui vel velit similique nihil iure molestias aliquam, voluptatem totam quaerat, magni commodi quisquam.</p>
              </div>
            </div>
          </li>
          <li class="timeline-inverted">
            <div class="timeline-panel">
              <div class="timeline-heading">
                <h4 class="timeline-title">Lorem ipsum dolor</h4>
              </div>
              <div class="timeline-body">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptates est quaerat asperiores sapiente, eligendi, nihil. Itaque quos, alias sapiente rerum quas odit! Aperiam officiis quidem delectus libero, omnis ut debitis!</p>
              </div>
            </div>
          </li>
          <li>
            <div class="timeline-badge info"><i class="fa fa-save"></i>
            </div>
            <div class="timeline-panel">
              <div class="timeline-heading">
                <h4 class="timeline-title">Lorem ipsum dolor</h4>
              </div>
              <div class="timeline-body">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nobis minus modi quam ipsum alias at est molestiae excepturi delectus nesciunt, quibusdam debitis amet, beatae consequuntur impedit nulla qui! Laborum, atque.</p>
                <hr>
                <div class="btn-group">
                  <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown">
                    <i class="fa fa-gear"></i> <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="#">Action</a>
                    </li>
                    <li><a href="#">Another action</a>
                    </li>
                    <li><a href="#">Something else here</a>
                    </li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </li>
          <li>
            <div class="timeline-panel">
              <div class="timeline-heading">
                <h4 class="timeline-title">Lorem ipsum dolor</h4>
              </div>
              <div class="timeline-body">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi fuga odio quibusdam. Iure expedita, incidunt unde quis nam! Quod, quisquam. Officia quam qui adipisci quas consequuntur nostrum sequi. Consequuntur, commodi.</p>
              </div>
            </div>
          </li>
          <li class="timeline-inverted">
            <div class="timeline-badge success"><i class="fa fa-graduation-cap"></i>
            </div>
            <div class="timeline-panel">
              <div class="timeline-heading">
                <h4 class="timeline-title">Lorem ipsum dolor</h4>
              </div>
              <div class="timeline-body">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deserunt obcaecati, quaerat tempore officia voluptas debitis consectetur culpa amet, accusamus dolorum fugiat, animi dicta aperiam, enim incidunt quisquam maxime neque
                  eaque.</p>
                </div>
              </div>
            </li>
          </ul>
        </div>
        <!-- /.panel-body -->
      </div>
      <!-- /.panel -->
    </div>
    <!-- /.col-lg-8 -->
    <div class="col-lg-4">
      <div class="panel panel-default">
        <div class="panel-heading">
          <i class="fa fa-bell fa-fw"></i> Notifications Panel
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
          <div class="list-group">
            <?php
            $n = 9;
            $i = 0;
            $alertInfo = getRecentInfo($_SESSION['UserID'], $n);
            while ($i < count($alertInfo)) {
              $alert = $alertInfo[$i];
              echo "<a href='" . $alert[$NotificationLink] . "' class='list-group-item'>
              <i class='fa ". $alert[$NotificationTypeTypeIcon] . " fa-fw'></i> " . $alert[$NotificationTypeTypeName] . "
              <span class='pull-right text-muted small'><em> " . time_ago(date("Y-m-d H:i:s", strtotime($alert[$NotificationTimeElapsed]))) . "</em>
              </span>
              </a>";
              $i++;
            }
            ?>
          </div>
          <!-- /.list-group -->
          <a href="#" class="btn btn-default btn-block">View All Alerts</a>
        </div>
        <!-- /.panel-body -->
      </div>
      <!-- /.panel -->
      <div class="panel panel-default">
        <div class="panel-heading">
          <i class="fa fa-bar-chart-o fa-fw"></i> Donut Chart Example
        </div>
        <div class="panel-body">
          <div id="morris-donut-chart"></div>
          <a href="#" class="btn btn-default btn-block">View Details</a>
        </div>
        <!-- /.panel-body -->
      </div>
      <!-- /.panel -->
      <div class="chat-panel panel panel-default">
        <div class="panel-heading">
          <i class="fa fa-comments fa-fw"></i> Chat
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="#">
                  <i class="fa fa-refresh fa-fw"></i> Refresh
                </a>
              </li>
              <li>
                <a href="#">
                  <i class="fa fa-check-circle fa-fw"></i> Available
                </a>
              </li>
              <li>
                <a href="#">
                  <i class="fa fa-times fa-fw"></i> Busy
                </a>
              </li>
              <li>
                <a href="#">
                  <i class="fa fa-clock-o fa-fw"></i> Away
                </a>
              </li>
              <li class="divider"></li>
              <li>
                <a href="#">
                  <i class="fa fa-sign-out fa-fw"></i> Sign Out
                </a>
              </li>
            </ul>
          </div>
        </div>
        <!-- /.panel-heading -->
        <div class="panel-body">
          <ul class="chat">
            <li class="left clearfix">
              <span class="chat-img pull-left">
                <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />
              </span>
              <div class="chat-body clearfix">
                <div class="header">
                  <strong class="primary-font">Jack Sparrow</strong>
                  <small class="pull-right text-muted">
                    <i class="fa fa-clock-o fa-fw"></i> 12 mins ago
                  </small>
                </div>
                <p>
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                </p>
              </div>
            </li>
            <li class="right clearfix">
              <span class="chat-img pull-right">
                <img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar" class="img-circle" />
              </span>
              <div class="chat-body clearfix">
                <div class="header">
                  <small class=" text-muted">
                    <i class="fa fa-clock-o fa-fw"></i> 13 mins ago</small>
                    <strong class="pull-right primary-font">Bhaumik Patel</strong>
                  </div>
                  <p>
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                  </p>
                </div>
              </li>
              <li class="left clearfix">
                <span class="chat-img pull-left">
                  <img src="http://placehold.it/50/55C1E7/fff" alt="User Avatar" class="img-circle" />
                </span>
                <div class="chat-body clearfix">
                  <div class="header">
                    <strong class="primary-font">Jack Sparrow</strong>
                    <small class="pull-right text-muted">
                      <i class="fa fa-clock-o fa-fw"></i> 14 mins ago</small>
                    </div>
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                    </p>
                  </div>
                </li>
                <li class="right clearfix">
                  <span class="chat-img pull-right">
                    <img src="http://placehold.it/50/FA6F57/fff" alt="User Avatar" class="img-circle" />
                  </span>
                  <div class="chat-body clearfix">
                    <div class="header">
                      <small class=" text-muted">
                        <i class="fa fa-clock-o fa-fw"></i> 15 mins ago</small>
                        <strong class="pull-right primary-font">Bhaumik Patel</strong>
                      </div>
                      <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur bibendum ornare dolor, quis ullamcorper ligula sodales.
                      </p>
                    </div>
                  </li>
                </ul>
              </div>
              <!-- /.panel-body -->
              <div class="panel-footer">
                <div class="input-group">
                  <input id="btn-input" type="text" class="form-control input-sm" placeholder="Type your message here..." />
                  <span class="input-group-btn">
                    <button class="btn btn-warning btn-sm" id="btn-chat">
                      Send
                    </button>
                  </span>
                </div>
              </div>
              <!-- /.panel-footer -->
            </div>
            <!-- /.panel .chat-panel -->
          </div>
          <!-- /.col-lg-4 -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /#page-wrapper -->

      <?php require_once "../layouts/sb_admin_2/footer.php"; ?>