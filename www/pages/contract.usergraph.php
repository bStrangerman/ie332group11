<?php require_once "www/includes/main.php"; ?>
<?php
$curdate = date("Y/m/d");
//Query the contract amount, start date, and associated space ID of every contract in database
$contractSQL = "SELECT Contracts.StartDate, COUNT()
FROM Contracts
ORDER BY Contracts.StartDate ASC";
$contractInfo = $conn->query($contractSQL);

$userSQL = "SELECT phprbac_users.CreationDate, COUNT()
FROM phprbac_users
ORDER BY phprbac_users.CreationDate ASC";
$userInfo = $conn->query($userSQL);

$contractDateArray=array();
$userDateArray=array();

while($row=$contractInfo ->fetch_assoc()){
	$ContractCreationDate = $row['CreationDate'];
	$ContractCount=$row['Count'];
	array_push($contractDateArray,$ContractCount);

}
while($row=$userInfo->fetch_assoc()){
		$userCreationDate=$row['CreationDate'];
		$userCount=$row['Count'];
		array_push($userDateArray,$userCount);

	}
	$j=0;
	$d=0;
	$hold_users=0;
	$DateList=array();
	$DailyUsers=array();
	if($userDateArray != array() && $userCount != array()){
	while($j < (count($userCount))){
	$hold_users = $userCount[$j];
	if(isset($userDateArray[$j+1])){
	if($userDateArray[$j] == $userDateArray[$j + 1]){

		$j= $j + 1;
		$hold_users= $hold_users + $userCount[$j];
		}
	}
	$DateList[$d]= $userDateArray[$j];
	$DailyUsers[$d]= $hold_users + $DailyUsers[$d-1];
	$d=$d+1;
	$j=$j+1;
}
}
?>
<?php
	$k=0;
	$l=0;
	$hold_contracts=0;
	$DateList2=array();
	$DailyContracts=array();
	if($contractDateArray != array() && $ContractCount != array()){
	while($k < (count($ContractCount))){
	$hold_contracts = $ContractCount[$k];
	if(isset($ContractDateArray[$k + 1])){
		if($ContractDateArray[$k] == $ContractDateArray[$k + 1]){
		$k= $k + 1;
		$hold_contracts= $hold_contracts+ $ContractCount[$k];
	}
	}
	$DateList2[$l]= $ContractDateArray[$k];
	$DailyContracts[$l]= $hold_contracts + $DailyContracts[$l-1];
	$l=$l + 1;
	$k=$k + 1;

}
}

	?>
	<html>
	<head>
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
		$m=0;
		while($m<$d){
		echo	"{ x:" . (date("Y,m,d", strtotime($DateList[$m])))", y:" ($runningUsers[$m]) . "},";
			$m++;
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
				$n=0;
				while($n<$d){
				echo "{ x:" . (date("Y,m,d", strtotime($Datelist2[$n]))) . ", y:" ($runningContracts[$n]) . "},";
					$n++;
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
