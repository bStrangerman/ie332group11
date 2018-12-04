<?php
require_once "../includes/main.php";

// Set Dates and Amount Charged
$StartDate =  date('Y-m-d', strtotime($_POST['StartDate']));
$EndDate =  date('Y-m-d', strtotime($_POST['EndDate']));
$AmountCharged = ($_POST['FeeRate'] * $_POST['MonthlyPrice'] * $_POST['SpaceSize'] * (1 + date_diff(date_create($StartDate), date_create($EndDate), FALSE)->format("%m")));

// If everything is filled out properly, insert it into the database
if(isset($_POST['SpaceID'])){
  if(isset($_POST['LesseeID'])){
    if(isset($StartDate)){
      if(isset($EndDate)){
        if(isset($_POST['contractInformation'])){
          insertBooking($_POST['SpaceID'], $_POST['LesseeID'], $StartDate, $EndDate, $AmountCharged, $_POST['contractInformation']);
        }
        else{
          insertBooking($_POST['SpaceID'], $_POST['LesseeID'], $_POST['startDate'], $_POST['endDate'], $AmountCharged, "");
        }
      }
    }
  }
}


/**
 * [insertBooking description]
 * @param  [int] $spaceID             [Space ID of Lease]
 * @param  [int] $LesseeID            [User ID of Lessee]
 * @param  [date] $startDate           [Start Date of Lease]
 * @param  [date] $endDate             [End Date of Lease]
 * @param  [real] $AmountCharged       [Amount Charged for the lease]
 * @param  [text] $ContractInformation [Information from the contract]
 * @return [VOID]                      [VOID]
 */
function insertBooking ($spaceID, $LesseeID, $startDate, $endDate, $AmountCharged, $ContractInformation){
  // Insert Contract SQL
  $BookSQL = "INSERT INTO Contracts (SpaceID, LesseeID, StartDate, EndDate, AmountCharged, ContractInformation) VALUES ($spaceID, $LesseeID, '$startDate', '$endDate', $AmountCharged, '$ContractInformation');";

  // Insert Contract and get its ID
  if (($GLOBALS['conn']->query($BookSQL) === TRUE)) {
    $last_id = $GLOBALS['conn']->insert_id;
    $PendingSQL = "INSERT INTO Contract_Status
    SELECT $last_id, StatusID
    FROM Status
    WHERE StatusName = 'Pending';";
  }
  else {
    echo "Error: " . $sql . "<br>" . $GLOBALS['conn']->error;
  }

  //Notify Warehouse Owner of New Contract
    notify($_POST['OwnerID'], 'pending', "A new contract has been created!", 'contract.php?contract=' . $last_id);

    //set contract to pending
    set_contract_status($last_id, 'Pending');
}
