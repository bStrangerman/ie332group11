<?php
include_once "../includes/notifications.php";

function set_contract_status ($contractID, $status)
{
  if($status == "Undo"){
    $sql = "DELETE FROM Contract_status
            WHERE contractID = $contractID
            AND statusID IN (
              SELECT statusID
              FROM status
              WHERE status.statusName = 'Approved'
              OR status.statusName = 'Denied'
            )";
    mysqli_query($GLOBALS['conn'], $sql);
  }
  else {
    $getLesseeQuery = "SELECT LesseeID
    FROM contracts
    WHERE contracts.contractID = $contractID";
    $getLesseeResult = $GLOBALS['conn'] -> query($getLesseeQuery);
    $getLessee = $getLesseeResult -> fetch_assoc();

    $sql = "INSERT INTO Contract_status (contractID, statusID)
    SELECT $contractID, status.statusID
    FROM status
    WHERE status.StatusName = '$status'";
    mysqli_query($GLOBALS['conn'], $sql);

    notify($getLessee['LesseeID'], $status, "Contract " . $contractID . " was " . $status, 'contract.php?contract=' . $contractID);
  }

  return $status;
} ?>
