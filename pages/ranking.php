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


  $i = 0;
  while ($i < count($spaceInfo)) {
    array_push($spaceID, $spaceInfo[$i]['SpaceID']);
    array_push($address, $spaceInfo[$i]['Address'] . " " . $spaceInfo[$i]['City'] . " " . $spaceInfo[$i]['State']);
    array_push($monthlyPrice, $spaceInfo[$i]['MonthlyPrice']);
    $i++;
  }

  $data = array("Spaces" => $spaceID, "Addresses" => $address, getDistance($origin, $address), "MonthlyPrice" => $monthlyPrice);
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
<th>Distance (Meters)</th>
<th>Time (Seconds)</th>
</tr>";

$max_Distance = $_GET['range'];
$max_count = count($data["Spaces"]);
for ($i = 0; $i < $max_count; $i++) {
  if ($data[0]["Distance"][$i] > $max_Distance) {
    unset($data[0]["Distance"][$i]);
    unset($data["Spaces"][$i]);
    unset($data["Addresses"][$i]);
    unset($data[0]["Time"][$i]);
    unset($data["MonthlyPrice"][$i]);
  }
}
unset($data[0]["Distance"][$max_count - 1]);
unset($data["Spaces"][$max_count - 1]);
unset($data["Addresses"][$max_count - 1]);
unset($data[0]["Time"][$max_count - 1]);
unset($data["MonthlyPrice"][$max_count - 1]);

for($i = 0; $i < $max_count; $i++){
  if(isset($data["Spaces"][$i]))
    echo "<tr><td>" . $data["Spaces"][$i] . "<hr></td><td>" . $data["Addresses"][$i] . "<hr></td><td>" . $data[0]["Distance"][$i] . "<hr></td><td>" . $data[0]["Time"][$i] . "<hr></td></tr>";
}
echo "</table>";

$size = $_GET['size'];
echo "Single Space Solutions for the date range " . $start . "-" . $end . " with a minimum size of " . $size . ", less than " . $max_Distance . " meters from " . $data[0]["Origin"] . ".";
array_print(singular_spaces($data["Spaces"], $size, $conn));

// multi_spaces(getAvailableSpaces($start, $end, $conn), 25000, 1000, $conn);
?>
