<?php
require_once "www/includes/main.php";
 ?>
<!-- Prints -->
 <?php
 	$curdate = date("Y/m/d");
 	//Query the contract amount, start date, and associated space ID of every contract in database
 	$contractSQL = "SELECT *
 	FROM Contracts
 	ORDER BY StartDate ASC";
 	$contractInfo = $conn->query($contractSQL);
 	//parse the query into 3 identically indexed arrays
 	$priceArray=array();
	$dateArray=array();
 	while($row = $contractInfo -> fetch_assoc()){
		$amountCharged = $row['AmountCharged'];
		$startDate = $row['StartDate'];
 		array_push($priceArray, $amountCharged);
		array_push($dateArray, $startDate);
		//echo $row["AmountCharged"] . " " . $row["StartDate"] . "<br>";
	}




 //iteratively creates array dayTake, where every index is the sum of contract value for that day
 //indexed the same as the date range from first contract to current day (business day we have been running)
 //j is contract Number
 //$d is dates

 $j=0;
 $d=0;
$daily_hold = 0;
$DateList = array();
$dailyTake = array();
if($dateArray != array() && $priceArray != array()){
 while($j < (count($priceArray))){

 	$daily_hold = $priceArray[$j];
	if(isset($dateArray[$j + 1])){
 	if($dateArray[$j] == $dateArray[$j + 1]){
 		$j = $j + 1;
 		$daily_hold = $daily_hold + $priceArray[$j];

 	}
}
 	$DateList[$d] = $dateArray[$j];
 	$dailyTake[$d] = $daily_hold;
 	$d = $d + 1;
 	$j = $j + 1;
 }
}
 // echo "DateList: " . array_print($DateList);
 // echo "dailyTake: " . array_print($dailyTake);

 //echos the arrays needed for the chart
 $k=0;
 while($k<$d){
	 echo "{ x: new Date(" . (date("Y,m,d", strtotime($DateList[$k]))) . "), y: " . ($dailyTake[$k]) . "},<br>";
	 $k++;
 }
 ?>


<html>
<head>
<script>
window.onload = function () {

var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	title: {
		text: "Company Profit Over Time"
	},
	axisX: {
	// minimum: new Date(<?php (date("Y,m,d", strtotime($DateList[0])))?>),
	// maximum: new Date(<?php (date("Y,m,d", strtotime($DateList[$d-1])))?>),
	minimum: new Date(2013,01,01),
	maximum: new Date(2025,01,15),
		valueFormatString: "MMM YY"
	},
	axisY: {
		title: "Revenue Per Day",
		titleFontColor: "#4F81BC",
		suffix: "Dollars"
	},
	data: [{
		indexLabelFontColor: "darkSlateGray",
		name: "views",
		type: "area",
		yValueFormatString: "#,##0.0mn",
		dataPoints: [
	<?php
		$k=0;
		while($k<$d){
 			echo "{ x: new Date(" . (date("Y,m,d", strtotime($DateList[$k]))) . "), y: " . ($dailyTake[$k]) . "},";
			$k++;
	 	}?>

		]
	}]
});
chart.render();

}
</script>
</head>
<body>
<div id="chartContainer" style="height: 300px; width: 100%;"></div>
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
