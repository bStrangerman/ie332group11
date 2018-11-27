<!--====================================
=            TABLE OF NAMES            =
========================================
= ls_title -> title of the review      =
= ls_body -> Body of the review        =
= ls_feedback -> Feedback to owner     =
= ls_files -> Review pictures          =
= ls_rating -> overall Rating          =
= ls_accuracy -> accuracy of listing   =
= ls_comm -> communication with owner  =
= ls_friend -> Friendlyness            =
= ls_local -> location of warehouse    =
= ls_val -> Value of Space             =
======================================-->
<!-- The variables for the out of 5 ratings arent in the code. -->

<?php
require_once "../includes/main.php";

array_print($_POST);
array_print($_SESSION);

$RatingsSQL = "";

insertNumericRating($_SESSION['reviewContract'],"Overall", clean($_POST['ls_rating']));
insertNumericRating($_SESSION['reviewContract'],"Accuracy", clean($_POST['ls_rating']));
insertNumericRating($_SESSION['reviewContract'],"Communication", clean($_POST['ls_comm']));
insertNumericRating($_SESSION['reviewContract'],"StaffFriend", clean($_POST['ls_friend']));
insertNumericRating($_SESSION['reviewContract'],"Location", clean($_POST['ls_local']));
insertNumericRating($_SESSION['reviewContract'],"SpaceValue", clean($_POST['ls_value']));

insertTextRating($_SESSION['reviewContract'],"Title", clean($_POST['ls_title']));
insertTextRating($_SESSION['reviewContract'],"Body", clean($_POST['ls_body']));
insertTextRating($_SESSION['reviewContract'],"Feedback", clean($_POST['ls_feedback']));

echo $RatingsSQL;

function insertNumericRating ($contract, $name, $score){
  if(isset($score) && $score != ""){
    $GLOBALS['RatingsSQL'] .= "INSERT INTO Numeric_Contract_Ratings (ContractID, Numeric_Rating_Name, RatingResult)
                               SELECT($contract, NumericContractID, $score)
                               FROM Numeric_Rating_Types
                               WHERE RatingShortName = '$name';<br>";
  }
}

function insertTextRating ($contract, $name, $text){
  if(isset($text) && $text != ""){
    $GLOBALS['RatingsSQL'] .= "INSERT INTO Text_Contract_Ratings (ContractID, Text_Rating_Name, RatingResult)
                               SELECT($contract, TextContractID, $score)
                               FROM Text_Rating_Types
                               WHERE RatingShortName = '$name';<br>";
  }
}

$RatingsSQL = "SELECT OwnerID
        FROM Warehouses
        WHERE WarehouseID IN(
          SELECT WarehouseID
          FROM Spaces
          WHERE SpaceID IN(
            SELECT SpaceID
            FROM Contracts
            WHERE ContractID = $contract
          )
        )";
        echo $RatingsSQL;
// notify($owner, , $Message, $url, $conn);
