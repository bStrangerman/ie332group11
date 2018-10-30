<?php
function notify($TargetUser, $Message){
  $sql = "INSERT INTO User_Notifications
  (UserID, Message)
  VALUES ($TargetUser, $Message)";

  mysqli_query($conn, $sql);
}

function getNotifications($TargetUser, $n, $conn){
  $sql = "SELECT TIMEDIFF(NOW, NotificationTimeStamp) AS Time_Elapsed, *
  FROM User_Notifications
  WHERE User_ID = $TargetUser
  ORDER BY NotificationTimeStamp DESC
  LIMIT $n";
  // $result = ($conn -> query($sql)) -> fetch_assoc();
  $result = array(
    "Type"=>"new_contract",
    "Time_Elapsed"=>"43 minutes",
    "Content"=>"You've got mail");
    // print_r($result);

    $i = 1;
    while($i <= $n){ ?>
      <li>
        <a href="#">
          <div>
            <strong><?php echo $result['Type']; ?></strong>
            <span class="pull-right text-muted">
              <em><?php echo $result['Time_Elapsed']; ?></em>
            </span>
          </div>
          <div><?php echo $result['Content']; ?></div>
        </a>
      </li>
      <li class="divider"></li>
      <?php
      $i++;
    }
  }

function getAlerts($TargetUser, $n, $conn){
  $sql = "SELECT TIMEDIFF(NOW, AlertTimeStamp) AS Time_Elapsed, *
  FROM User_Alerts
  WHERE User_ID = $TargetUser
  ORDER BY AlertsTimeStamp DESC
  LIMIT $n";
  // $result = ($conn -> query($sql)) -> fetch_assoc();
  $result = array(
    "Type"=>"new_contract",
    "Time_Elapsed"=>"43 minutes",
    "Content"=>"You've got mail",
    "Icon"=>"fa-comment");
    // print_r($result);

    $i = 1;
    while($i <= $n){ ?>
      <li>
          <a href="#">
              <div>
                  <i class="fa <?php echo $result['Icon']; ?> fa-fw"></i> <?php echo $result['Type']; ?>
                  <span class="pull-right text-muted small"><?php echo $result['Time_Elapsed']; ?></span>
              </div>
          </a>
      </li>
      <li class="divider"></li>
      <?php
      $i++;
    }
  }
  ?>
