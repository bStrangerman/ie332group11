<?php

/**
* Inserts new notifications into the database
* @param  [int] $TargetUser  UserID of the user recieving the new notification
* @param  [varchar] $Message The message that will be delivered to the selected user
* @return [void]             none
*/
function notify($TargetUser, $Message){
  $sql = "INSERT INTO User_Notifications
  (UserID, Message)
  VALUES ($TargetUser, $Message)";

  mysqli_query($conn, $sql);
}

/**
* Get and display the notifications (mail, messages) for the selected user
* @param  [int] $TargetUser  UserID of the user that is connected
* @param  [int] $n           Number of Notifications to display
* @param  [function] $conn   MySQL connection decleration
* @return [void]             None
*/
function getNotifications($TargetUser, $n, $conn){
  $sql = "SELECT TIMEDIFF(NOW, NotificationTimeStamp) AS Time_Elapsed, *
  FROM User_Notifications
  WHERE User_ID = $TargetUser
  ORDER BY NotificationTimeStamp DESC
  LIMIT $n";

  // $result = $conn -> query($sql);

  $row = array(
    "Type"=>"new_contract",
    "Time_Elapsed"=>"43 minutes",
    "Content"=>"You've got mail");

    $i = 1;
    // while($row = -> $result -> fetch_assoc()){
    while($i <= $n){
      echo "<li>
        <a href='#'>
          <div>
            <strong>" . $row['Type'] . "</strong>
            <span class='pull-right text-muted'>
              <em>" . $row['Time_Elapsed'] . "</em>
            </span>
          </div>
          <div>" . $row['Content'] . "</div>
        </a>
      </li>
      <li class='divider'></li>";
      $i++;
    }
  }

  /**
  * Get and display the alerts for the selected user
  * @param  [Text] $Type       Location of where the alerts will be printed
  * @param  [int] $TargetUser  UserID of the user being accessed
  * @param  [int] $n           Number of Alerts to show
  * @param  [function] $conn   MySQL Connection Decleration
  * @return [void]             none
  */
  function getAlerts($Type, $TargetUser, $n, $conn){
    $sql = "SELECT TIMEDIFF(NOW, AlertTimeStamp) AS Time_Elapsed, *
    FROM User_Alerts
    WHERE User_ID = $TargetUser
    ORDER BY AlertsTimeStamp DESC
    LIMIT $n";

    // $result = ($conn -> query($sql));

    $row = array(
      "Type"=>"new_contract",
      "Time_Elapsed"=>"43 minutes",
      "Content"=>"You've got mail",
      "Icon"=>"fa-comment");
      // print_r($row);

      $i = 1;
      if($Type == "Panel"){
        // while($row = -> $result -> fetch_assoc()){
        while($i <= $n){
          echo "<a href='#' class='list-group-item'>
            <i class='fa ". $row['Icon'] . " fa-fw'></i> " . $row['Type'] . "
            <span class='pull-right text-muted small'><em> " . $row['Time_Elapsed'] . "</em>
            </span>
          </a>";
          $i++;
        }
      }
      else if($Type == "Bar")
      {
        // while($row = -> $result -> fetch_assoc()){
        while($i <= $n){
          echo "<li>
            <a href='#'>
              <div>
                <i class='fa " . $row['Icon'] . " fa-fw'></i> " . $row['Type'] . "
                <span class='pull-right text-muted small'> " . $row['Time_Elapsed'] . "</span>
              </div>
            </a>
          </li>
          <li class='divider'></li>";
          $i++;
        }
      }
    }
    ?>
