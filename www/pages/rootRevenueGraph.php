<?php
require_once "../includes/main.php";
 ?>

 <?php
 	echo "Line: 6";
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
		$startDate = date("Y,m,d", strtotime($row['StartDate']));
 		array_push($priceArray, $amountCharged);
		array_push($dateArray, $startDate);
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
 $k = 0;
 while($k<$d){
 	echo "{ x: new Date(" . $DateList[$k] . "), y: " . ($dailyTake[$k]) . "},";
 	$k++;
 }?>


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
		minimum: new Date(<?php min($dateArray)?>),
		maximum: new Date(<?php max($dateArray)?>),

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
		dataPoints: [<?php
		echo "Line: 34";
		$curdate = date("Y/m/d");
    //Query the contract amount, start date, and associated space ID of every contract in database
    $contractSQL = "SELECT AmountCharged, StartDate, *
    FROM Contracts
    ORDER BY StartDate ASC";
    $contractInfo = $conn->query($contractSQL);
		//parse the query into 3 identically indexed arrays
	  $priceArray=array();
		while($row= mysql_fetch_assoc($contractInfo)){
			$priceArray=$row['AmountCharged'];}

    $dateArray=array();
		while($row= mysql_fetch_assoc($contractInfo)){
			$dateArray=$row['StartDate'];}


	 //iteratively creates array dayTake, where every index is the sum of contract value for that day
	 //indexed the same as the date range from first contract to current day (business day we have been running)
	 //j is contract Number
	 //$d is dates

    $j=0;
		$d=0;

		while($j < (sizeof($priceArray)+1)){

			$daily_hold = $daily_hold[$j];
			while($dateArray[$j] == $dateArray[$j + 1]){
				$j = $j + 1;
				$daily_hold = $daily_hold + $priceArray[$j];

			}
			$DateList[$d] = $dateArray[$j];
			$dailyTake[$d] = $daily_hold;
			$d = $d + 1;
			$j = $j + 1;
		}
		echo "DateList: " . array_print($DateList);
		echo "dailyTake: " . array_print($dailyTake);

		//echos the arrays needed for the chart
		$k = 0;
		while($k<$d){
    	echo "{ x:" . (date("Y,m,d", strtotime($DateList[$k]))) . ", y: " . ($dailyTake[$k]) . "}, label:'' ";
			$k++;
		}?>
			{ x: new Date(2015, 02, 1), y: 54.6, label: "Q1-2015" },
			// { x: new Date(2015, 05, 1), y: 61.1, label: "Q2-2015" },
			// { x: new Date(2015, 08, 1), y: 47.0, label: "Q3-2015" },
			// { x: new Date(2015, 11, 1), y: 48.0, label: "Q4-2015" },
			// { x: new Date(2016, 02, 1), y: 74.8, label: "Q1-2016" },
			// { x: new Date(2016, 05, 1), y: 51.1, label: "Q2-2016" },
			// { x: new Date(2016, 08, 1), y: 40.4, label: "Q3-2016" },
			// { x: new Date(2016, 11, 1), y: 45.5, label: "Q4-2016" },
			// { x: new Date(2017, 02, 1), y: 78.3, label: "Q1-2017", indexLabel: "Highest", markerColor: "red" }
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
