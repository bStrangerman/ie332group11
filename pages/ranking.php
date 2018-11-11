<?php

// array_multisort(
//   $data[1],
//   SORT_ASC,
//   $data[2],
//   SORT_ASC,
//   $data[0],
//   SORT_ASC
// );

include "../includes/main.php";
include "../includes/rankingFunctions.php";

if(isset($_GET['origin'])){
  $origin = $_GET['origin'];
  $start = '2018-01-20';
  $end = '2018-11-31';
  $spaceInfo = getAvailableSpaces($start,$end,$conn);

  $address = array();
  $spaceID = array();
  $monthlyPrice = array();
  $spaceSize = array();

  $i = 0;
  while ($i < count($spaceInfo)) {
    array_push($spaceID, $spaceInfo[$i]['SpaceID']);
    array_push($address, $spaceInfo[$i]['Address'] . " " . $spaceInfo[$i]['City'] . " " . $spaceInfo[$i]['State']);
    array_push($monthlyPrice, $spaceInfo[$i]['MonthlyPrice']);
    array_push($spaceSize, $spaceInfo[$i]['SpaceSize']);
    $i++;
  }
$data = array("Spaces" => $spaceID, "Addresses" => $address, getDistance($origin, $address), "MonthlyPrice" => $monthlyPrice, "SpaceSize" => $spaceSize);
}
else{
  echo "
  <h1>Origin Location Search</h1>
  <form action='ranking.php' method='get'>
  Origin Location: <input type='text' name='origin' value=''><br>
  <input type='submit'>
  </form>
  <h3>";
  echo count($address); ?> Unformatted Destination Addresses</h3>
  <?php

  for ($i = 0; $i < count($address); $i++) {
    echo $address[$i] . "<br>";
  }

}
echo $data[0]["Origin"] . " to: <form action='ranking.php' method='get'>
<input value='RESET' type='submit'>
</form><br>";
echo "<table style='width:100%'>
<tr>
<th>SpaceID</th>
<th>Address</th>
<th>Distance (Meters) (Score)</th>
<th>Size (sqft) (Score)</th>
<th>Total Price per Month (Score)</th>
<th>D_Score + S_Score + P_Score</th>
</tr>";
$size = $_GET['size'];

$max_size = max($data["SpaceSize"]);

$max_Distance = $_GET['range'];
$max_count = count($data["Spaces"]);
$max_price = 10000;
for ($i = 0; $i < $max_count; $i++) {
  if ($data[0]["Distance"][$i] > $max_Distance OR $data['MonthlyPrice'][$i] * $data['SpaceSize'][$i] > $max_price) {
    unset($data[0]["Distance"][$i]);
    unset($data["Spaces"][$i]);
    unset($data["Addresses"][$i]);
    unset($data[0]["Time"][$i]);
    unset($data["MonthlyPrice"][$i]);
    unset($data["SpaceSize"][$i]);
  }
  }
unset($data[0]["Distance"][$max_count - 1]);
unset($data["Spaces"][$max_count - 1]);
unset($data["Addresses"][$max_count - 1]);
unset($data[0]["Time"][$max_count - 1]);
unset($data["MonthlyPrice"][$max_count - 1]);
unset($data["SpaceSize"][$max_count - 1]);

for($i = 0; $i < $max_count; $i++){
  if(isset($data["Spaces"][$i]))
    echo "<tr><td>" . $data["Spaces"][$i] . "<hr></td><td>" . $data["Addresses"][$i] . "<hr></td><td>" . $data[0]["Distance"][$i] . " (" . round(distance_score($max_Distance, $data[0]['Distance'][$i]), 2) . ")<hr></td><td>" . $data["SpaceSize"][$i] . " (" . round(size_score($size, $data['SpaceSize'][$i], $max_size), 2) . ")<hr></td><td>" . ($data['MonthlyPrice'][$i] * $data['SpaceSize'][$i]) . " (" . round(price_score(($data['MonthlyPrice'][$i] * $data['SpaceSize'][$i]), $max_price), 2) .  ")<hr></td><td>" . round(distance_score($max_Distance, $data[0]['Distance'][$i]) + size_score($size, $data['SpaceSize'][$i], $max_size) + price_score(($data['MonthlyPrice'][$i] * $data['SpaceSize'][$i]), $max_price),2) . "<hr></td></tr>";
}
echo "</table>";

echo "Single Space Solutions for the date range " . $start . " to " . $end . " with a minimum size of " . $size . ", less than " . $max_Distance . " meters from " . $data[0]["Origin"] . ".  The Max Price is $" . $max_price . " per square foot per month";
array_print(singular_spaces($data["Spaces"], $size, $conn));

// multi_spaces(getAvailableSpaces($start, $end, $conn), 25000, 1000, $conn);
?>
