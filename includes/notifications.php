<?php
include_once "../includes/timeago.php";

$NotificationTypeLongName = 0;
$NotificationTimeElapsed = 1;
$NotificationIcon = 2;
$NotificationMessage = 3;
$NotificationLink = 4;
$NotificationTypeName = 5;
$NotificationTypeTypeName = 6;
$NotificationTypeTypeIcon = 7;

/**
* Inserts new notifications into the database
* @param  [int] $TargetUser  UserID of the user recieving the new notification
* @param  [varchar] $Message The message that will be delivered to the selected user
* @return [void]             none
*/
function notify($TargetUser, $Type, $Message, $url, $conn)
{
  $sql = "INSERT INTO Notifications
  (UserID, Message, NotificationType, LinksTo)
  SELECT $TargetUser,'$Message', TypeID, '$url'
  FROM Notification_Types
  WHERE TypeShortName = '$Type'";
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
  $sql = "SELECT *
  FROM Notifications
  INNER JOIN Notification_Types
  ON Notification_Types.TypeID = Notifications.NotificationType
  INNER JOIN Notification_Types_Types
  ON Notification_Types_Types.TypeTypeID = Notification_Types.TypeTypeID
  WHERE UserID = $TargetUser
  ORDER BY NotificationTime DESC
  LIMIT $n";
  
  $result = $conn -> query($sql);
  $out = array();
  while($row = $result -> fetch_assoc())
  {
    $inner = array();
    array_push($inner, $row['TypeShortName'], $row['NotificationTime'], $row['TypeIcon'], $row['Message'], $row['LinksTo'], $row['TypeName'], $row['TypeTypeName'], $row['TypeTypeIcon']);
    array_push($out, $inner);
  }

  return $out;
}
