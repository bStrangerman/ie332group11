<?php
/**
 * function changes the contract status for the assigned contract
 * @param [int] $contractID [id of the contract]
 * @param [text] $status     [new status of the contract]
 */
function set_contract_status ($contractID, $status)
{
  if($status == "Undo"){
    $sql = "DELETE FROM Contract_Status
    WHERE ContractID = $contractID
    AND StatusID IN (
      SELECT StatusID
      FROM Status
      WHERE Status.StatusName = 'Approved'
      OR Status.StatusName = 'Denied'
    )";
    mysqli_query($GLOBALS['conn'], $sql);

    $sql = "INSERT INTO Contract_Status (ContractID, StatusID)
              SELECT $contractID, StatusID
              FROM Status
              WHERE Status.StatusName = 'Pending'";

    mysqli_query($GLOBALS['conn'], $sql);
  }
  else {
    // get the Lessee ID
    $getLesseeQuery = "SELECT LesseeID
    FROM Contracts
    WHERE Contracts.ContractID = $contractID";
    $getLesseeResult = $GLOBALS['conn'] -> query($getLesseeQuery);
    $getLessee = $getLesseeResult -> fetch_assoc();

    $sql = "INSERT INTO Contract_Status (ContractID, StatusID)
    SELECT $contractID, Status.StatusID
    FROM Status
    WHERE Status.StatusName = '$status'";
    mysqli_query($GLOBALS['conn'], $sql);

    notify($getLessee['LesseeID'], $status, "Contract " . $contractID . " was " . $status, 'contract.php?contract=' . $contractID);

    $sql = "DELETE FROM Contract_Status
    WHERE ContractID = $contractID
    AND StatusID IN (
      SELECT StatusID
      FROM Status
      WHERE Status.StatusName = 'Pending'
    )";
    mysqli_query($GLOBALS['conn'], $sql);
  }

  return $status;
} ?>
