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

$RatingsSQL = "";

if(isset($_POST['ls_rating']))
  insertNumericRating($_POST['contract'],"Overall", clean($_POST['ls_rating']));
if(isset($_POST['ls_rating']))
  insertNumericRating($_POST['contract'],"Accuracy", clean($_POST['ls_accuracy']));
if(isset($_POST['ls_comm']))
  insertNumericRating($_POST['contract'],"Communication", clean($_POST['ls_comm']));
if(isset($_POST['ls_friend']))
  insertNumericRating($_POST['contract'],"StaffFriend", clean($_POST['ls_friend']));
if(isset($_POST['ls_local']))
  insertNumericRating($_POST['contract'],"Location", clean($_POST['ls_local']));
if(isset($_POST['ls_value']))
  insertNumericRating($_POST['contract'],"SpaceValue", clean($_POST['ls_value']));

if(isset($_POST['ls_title']))
  insertTextRating($_POST['contract'],"Title", clean($_POST['ls_title']));
if(isset($_POST['ls_body']))
  insertTextRating($_POST['contract'],"Body", clean($_POST['ls_body']));
if(isset($_POST['ls_feedback']))
  insertTextRating($_POST['contract'],"Feedback", clean($_POST['ls_feedback']));


function insertNumericRating ($contract, $name, $score){
  $NumericRatingID_SQL = "SELECT NumericRatingID FROM Numeric_Rating_Types WHERE RatingShortName = '$name'";
  $NumericRatingID_Result = $GLOBALS['conn'] -> query($NumericRatingID_SQL);
  while($NumericRatingID_Row[]=mysqli_fetch_array($NumericRatingID_Result));
  $NumericRatingID = $NumericRatingID_Row[0]['NumericRatingID'];

  if(isset($score) && $score != ""){
    $RatingsSQL = "INSERT INTO Numeric_Contract_Ratings VALUES ($contract, $NumericRatingID, $score);";
  }
  if (mysqli_query($GLOBALS['conn'], $RatingsSQL)) {
  }
  else {
      echo "Error: " . $RatingsSQL . "<br>" . mysqli_error($GLOBALS['conn']);
  }
}

function insertPictureRating ($contract, $FileName, $Description = ""){
  if(isset($FileName) && $FileName != ""){
    $RatingsSQL = "INSERT INTO Ratings_Pictures VALUES ($contract, '$FileName', '$Description');";
  }
  if (mysqli_query($GLOBALS['conn'], $RatingsSQL)) {
  }
  else {
      echo "Error: " . $RatingsSQL . "<br>" . mysqli_error($GLOBALS['conn']);
  }
}

function insertTextRating ($contract, $name, $text){
  $TextRatingID_SQL = "SELECT TextRatingID FROM Text_Rating_Types WHERE RatingShortName = '$name'";
  $TextRatingID_Result = $GLOBALS['conn'] -> query($TextRatingID_SQL);
  while($TextRatingID_Row[]=mysqli_fetch_array($TextRatingID_Result));
  $TextRatingID = $TextRatingID_Row[0]['TextRatingID'];

  if(isset($score) && $score != ""){
    $RatingsSQL = "INSERT INTO Text_Contract_Ratings VALUES ($contract, $TextRatingID, $score);";
  }
  if (mysqli_query($GLOBALS['conn'], $RatingsSQL)) {
  }
  else {
      echo "Error: " . $RatingsSQL . "<br>" . mysqli_error($GLOBALS['conn']);
  }
}


notify($_POST['owner'], 'new_review', $_POST['lesseeFirstName'] . " " . $_POST['lesseeLastName'] . "has been created!", 'contract.php?contract=' . $_POST['contract']);
