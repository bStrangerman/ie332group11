<!DOCTYPE HTML>
<html>
<head>
<?php
$curdate = date("Y/m/d");
//Query the contract amount, start date, and associated space ID of every contract in database
$contractSQL = "SELECT Contracts.StartDate
FROM Contracts
ORDER BY Contracts.StartDate ASC";
$contractInfo = $conn->query($contractSQL);

$userSQL = "SELECT phprbac_users.CreationDate
FROM phprbac_users
ORDER BY phprbac_users.CreationDate ASC";
$userInfo = $conn->query($userSQL);

$contractDateArray=array();
$userDateArray=array();

while($row=$contractInfo ->fetch_assoc()){
	$ContractCreationDate = $row['CreationDate'];
	array_push($contractDateArray,$ContractCreationDate);

}
while($row=$contractInfo->fetch_assoc()){
		$userCreationDate=$row['CreationDate'];
		array_push($userDateArray,$userCreationDate);

	}
	$runningUsers=0;
	$runningContracts=0;


	?>
<script>
window.onload = function () {

var chart = new CanvasJS.Chart("chartContainer", {
	title: {
		text: "Contracts Vs. Users Over Time"
	},
	axisX: {
		valueFormatString: "MMM YYYY"
	},
	axisY2: {
		title: "Count",
		prefix: "",
		suffix: ""
	},
	toolTip: {
		shared: true
	},
	legend: {
		cursor: "pointer",
		verticalAlign: "top",
		horizontalAlign: "center",
		dockInsidePlotArea: true,
		itemclick: toogleDataSeries
	},
	data: [{
		type:"line",
		axisYType: "secondary",
		name: "Users",
		showInLegend: true,
		markerSize: 0,
		yValueFormatString: "#,###",
		dataPoints: [<?php
		while($k<$d){
		echo	"{ x:" . (date("Y,m,d", strtotime($DateList[$k])))", y:" ($runningUsers[$k]) . "},";
			$k++;
		}?>
		]
	},
	{
		type: "line",
		axisYType: "secondary",
		name: "Contracts",
		showInLegend: true,
		markerSize: 0,
		yValueFormatString: "#,###",
		dataPoints: [<?php
				while($k<$d){
				echo "{ x:" . (date("Y,m,d", strtotime($Datelist[$k]))) . ", y:" ($runningContracts[k]) . "},";
					$k++;
				}?>

		]
	},

	}]
});
chart.render();

function toogleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	} else{
		e.dataSeries.visible = true;
	}
	chart.render();
}

}
</script>
</head>
<body>
<div id="chartContainer" style="height: 300px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>
