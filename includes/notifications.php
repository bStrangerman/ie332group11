<?php

/**
* Inserts new notifications into the database
* @param  [int] $TargetUser  UserID of the user recieving the new notification
* @param  [varchar] $Message The message that will be delivered to the selected user
* @return [void]             none
*/
function notify($TargetUser, $Message)
{
    $sql = "INSERT INTO User_Notifications
  (UserID, Message)
  VALUES ($TargetUser, $Message)";

    mysqli_query($conn, $sql);
}

/**
 * [getRecentInfo description]
 * @param  [type] $TargetUser [description]
 * @param  [type] $n          [description]
 * @param  [type] $conn       [description]
 * @return [array]            Information to be displayed in the notification
 */
function getRecentInfo($TargetUser, $n, $conn)
{
    $sql = "SELECT TIMEDIFF(CURRENT_TIMESTAMP, NotificationTimeStamp) AS Time_Elapsed, *
  FROM User_Notifications
  WHERE User_ID = $TargetUser
  ORDER BY NotificationTimeStamp DESC
  LIMIT $n";

    // $result = $conn -> query($sql);

    $row = array(
  "Type"=>"new_contract",
  "Time_Elapsed"=>"43 minutes",
  "Content"=>"You've got mail",
  "Icon"=>"fa-comment");

    $i = 1;
    // while($row = -> $result -> fetch_assoc()){
    while ($i <= $n) {
        $out['Type'] = $row['Type'];
        $out['Time_Elapsed'] = $row['Time_Elapsed'];
        $out['Content'] = $row['Content'];
        $out['Icon'] = $row['Icon'];
        $i++;
    }

    return $row;
}
