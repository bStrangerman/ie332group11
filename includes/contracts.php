<?php
function set_contract_status ($contractID, $status, $conn)
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
    mysqli_query($conn, $sql);
  }
  else {
    $sql = "INSERT INTO Contract_status (contractID, statusID)
    SELECT $contractID, status.statusID
    FROM status
    WHERE status.StatusName = '$status'";
    mysqli_query($conn, $sql);
  }

  return $status;
} ?>
