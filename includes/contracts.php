<?php
function set_contract_status ($contractID, $status, $conn)
{
  $sql = "INSERT INTO Contract_status (contractID, statusID)
  SELECT $contractID, status.statusID
  FROM status
  WHERE status.StatusName = '$status'";
  mysqli_query($conn, $sql);

  return $status;
} ?>
