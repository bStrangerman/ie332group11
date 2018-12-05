<!DOCTYPE HTML>
<html>
<head>
<?php
$curdate = date("Y/m/d");
//Query the contract amount, start date, and associated space ID of every contract in database
$contractSQL = "SELECT Contracts.StartDate, COUNT() *
FROM Contracts
ORDER BY StartDate ASC";
$contractInfo = $conn->query($contractSQL);

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
		dataPoints: [<?php ?>
			{ x: new Date(2014, 00, 01), y: 850 },
			{ x: new Date(2014, 01, 01), y: 889 },
			{ x: new Date(2014, 02, 01), y: 890 },
			{ x: new Date(2014, 03, 01), y: 899 },
			{ x: new Date(2014, 04, 01), y: 903 },
			{ x: new Date(2014, 05, 01), y: 925 },
			{ x: new Date(2014, 06, 01), y: 899 },
			{ x: new Date(2014, 07, 01), y: 875 },
			{ x: new Date(2014, 08, 01), y: 927 },
			{ x: new Date(2014, 09, 01), y: 949 },
			{ x: new Date(2014, 10, 01), y: 946 },
			{ x: new Date(2014, 11, 01), y: 927 },
			{ x: new Date(2015, 00, 01), y: 950 },
			{ x: new Date(2015, 01, 01), y: 998 },
			{ x: new Date(2015, 02, 01), y: 998 },
			{ x: new Date(2015, 03, 01), y: 1050 },
			{ x: new Date(2015, 04, 01), y: 1050 },
			{ x: new Date(2015, 05, 01), y: 999 },
			{ x: new Date(2015, 06, 01), y: 998 },
			{ x: new Date(2015, 07, 01), y: 998 },
			{ x: new Date(2015, 08, 01), y: 1050 },
			{ x: new Date(2015, 09, 01), y: 1070 },
			{ x: new Date(2015, 10, 01), y: 1050 },
			{ x: new Date(2015, 11, 01), y: 1050 },
			{ x: new Date(2016, 00, 01), y: 995 },
			{ x: new Date(2016, 01, 01), y: 1090 },
			{ x: new Date(2016, 02, 01), y: 1100 },
			{ x: new Date(2016, 03, 01), y: 1150 },
			{ x: new Date(2016, 04, 01), y: 1150 },
			{ x: new Date(2016, 05, 01), y: 1150 },
			{ x: new Date(2016, 06, 01), y: 1100 },
			{ x: new Date(2016, 07, 01), y: 1100 },
			{ x: new Date(2016, 08, 01), y: 1150 },
			{ x: new Date(2016, 09, 01), y: 1170 },
			{ x: new Date(2016, 10, 01), y: 1150 },
			{ x: new Date(2016, 11, 01), y: 1150 },
			{ x: new Date(2017, 00, 01), y: 1150 },
			{ x: new Date(2017, 01, 01), y: 1200 },
			{ x: new Date(2017, 02, 01), y: 1200 },
			{ x: new Date(2017, 03, 01), y: 1200 },
			{ x: new Date(2017, 04, 01), y: 1190 },
			{ x: new Date(2017, 05, 01), y: 1170 }
		]
	},
	{
		type: "line",
		axisYType: "secondary",
		name: "Contracts",
		showInLegend: true,
		markerSize: 0,
		yValueFormatString: "#,###",
		dataPoints: [<?php ?>
			{ x: new Date(2014, 00, 01), y: 1200 },
			{ x: new Date(2014, 01, 01), y: 1200 },
			{ x: new Date(2014, 02, 01), y: 1190 },
			{ x: new Date(2014, 03, 01), y: 1180 },
			{ x: new Date(2014, 04, 01), y: 1250 },
			{ x: new Date(2014, 05, 01), y: 1270 },
			{ x: new Date(2014, 06, 01), y: 1300 },
			{ x: new Date(2014, 07, 01), y: 1300 },
			{ x: new Date(2014, 08, 01), y: 1358 },
			{ x: new Date(2014, 09, 01), y: 1410 },
			{ x: new Date(2014, 10, 01), y: 1480 },
			{ x: new Date(2014, 11, 01), y: 1500 },
			{ x: new Date(2015, 00, 01), y: 1500 },
			{ x: new Date(2015, 01, 01), y: 1550 },
			{ x: new Date(2015, 02, 01), y: 1550 },
			{ x: new Date(2015, 03, 01), y: 1590 },
			{ x: new Date(2015, 04, 01), y: 1600 },
			{ x: new Date(2015, 05, 01), y: 1590 },
			{ x: new Date(2015, 06, 01), y: 1590 },
			{ x: new Date(2015, 07, 01), y: 1620 },
			{ x: new Date(2015, 08, 01), y: 1670 },
			{ x: new Date(2015, 09, 01), y: 1720 },
			{ x: new Date(2015, 10, 01), y: 1750 },
			{ x: new Date(2015, 11, 01), y: 1820 },
			{ x: new Date(2016, 00, 01), y: 2000 },
			{ x: new Date(2016, 01, 01), y: 1920 },
			{ x: new Date(2016, 02, 01), y: 1750 },
			{ x: new Date(2016, 03, 01), y: 1850 },
			{ x: new Date(2016, 04, 01), y: 1750 },
			{ x: new Date(2016, 05, 01), y: 1730 },
			{ x: new Date(2016, 06, 01), y: 1700 },
			{ x: new Date(2016, 07, 01), y: 1730 },
			{ x: new Date(2016, 08, 01), y: 1720 },
			{ x: new Date(2016, 09, 01), y: 1740 },
			{ x: new Date(2016, 10, 01), y: 1750 },
			{ x: new Date(2016, 11, 01), y: 1750 },
			{ x: new Date(2017, 00, 01), y: 1750 },
			{ x: new Date(2017, 01, 01), y: 1770 },
			{ x: new Date(2017, 02, 01), y: 1750 },
			{ x: new Date(2017, 03, 01), y: 1750 },
			{ x: new Date(2017, 04, 01), y: 1730 },
			{ x: new Date(2017, 05, 01), y: 1730 }
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