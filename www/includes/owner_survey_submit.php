<!--=====================================
=            TABLE OF NAMES             =
=========================================
= own_title -> title of the review      =
= own_body -> Body of the review        =
= own_feedback -> Feedback to owner     =
= own_files -> Review pictures          =
= own_rating -> overall Rating          =
= - - - - - - - - - - - - - - - - - - - =
=     DATABASE VALUES AND NAMES         =
= OwnOverall ->                         =
= OwnTitle ->                           =
= OwnBody ->                            =
======================================-->
<!-- The variables for the out of 5 ratings arent in the code. -->

<?php
require_once "../includes/main.php";

$RatingsSQL = "";

if(isset($_POST['own_rating']))
  insertNumericRating($_POST['contract'],"OwnOverall", clean($_POST['own_rating']));

if(isset($_POST['own_title']))
  insertTextRating($_POST['contract'],"OwnTitle", clean($_POST['own_title']));
if(isset($_POST['own_body']))
  insertTextRating($_POST['contract'],"OwnBody", clean($_POST['own_body']));



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
