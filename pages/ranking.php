<?php
// TODO: make functions that only output the spaceID's.  These functions are:
// getting the distance and time between an origin and an array of destinations
// sorting the


?>
<?php include "../includes/main.php";

$sql = "SELECT *
        FROM Spaces
        LEFT JOIN Warehouse
        ON spaces.WarehouseID = Warehouse.WarehouseID";

$result = $conn -> query($sql);

$address = array();
$spaceID = array();
while ($row = $result -> fetch_assoc()) {
    array_push($spaceID, $row['spaceID']);
    array_push($address, $row['address'] . " " . $row['city'] . " " . $row['state']);
}

if (isset($_GET['origin'])) {
    $origin = $_GET['origin'];

    $arr = array_chunk($address, 99);
    $data_arr = array();
    $distance = array();
    $time = array();

    for ($i = 0; $i < count($arr); $i++) {
        $data_arr[$i] = distance($origin, $arr[$i]);
        $distance = array_merge($distance, $data_arr[$i][1]);
        $time = array_merge($time, $data_arr[$i][2]);
    }

    // if able to geocode the address
    if ($data_arr) {
        $getorigin = $data_arr[0][0];

        $data = array($spaceID,
        $distance,
        $time);

        array_multisort(
            $data[1],
            SORT_ASC,
            $data[2],
            SORT_ASC,
            $data[0],
            SORT_ASC
        );
    }
}
else {
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

  function distance($origin, $destination)
  {
      // url encode the address
      $origin = urlencode($origin);
      $destinationURL = "";

      for ($i = 0; $i < count($destination); $i++) {
          $destinationURL = $destinationURL . urlencode($destination[$i]);
          if (isset($destination[$i + 1])) {
              $destinationURL = $destinationURL . "|";
          }
      }

      // google map geocode api url
      $url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins={$origin}&destinations={$destinationURL}&key=AIzaSyAMIMPJxBWxHe6H8OpZRH7dSSSYNosj2eY";
      // echo "<a href='" . $url . "'>" . $url . "</a><br>";
      // get the json response
      $resp_json = file_get_contents($url);

      // decode the json
      $resp = json_decode($resp_json, true);

      // response status will be 'OK', if able to geocode given address
      if ($resp['status']=='OK') {
          $dist = array();
          $time = array();

          for ($i = 0; $i < count($destination); $i++) {
              // $getaddress = isset($resp['destination_addresses'][$i]) ? $resp['destination_addresses'][$i] : "";
              // array_push($formatted_address, $getaddress);
              $getdistance = isset($resp['rows'][0]['elements'][$i]['distance']['value']) ? $resp['rows'][0]['elements'][$i]['distance']['value'] : "";
              array_push($dist, $getdistance);
              $gettime = isset($resp['rows'][0]['elements'][$i]['duration']['value']) ? $resp['rows'][0]['elements'][$i]['duration']['value'] : "";
              array_push($time, $gettime);
          }
          $getorigin = isset($resp['origin_addresses'][0]) ? $resp['origin_addresses'][0] : "";
          // verify if data is complete
          if ($dist && $time) {

        // put the data in the array
              $data_arr = array($getorigin, $dist, $time);

              return $data_arr;
          }
          else {
              return false;
          }
      }
      else {
          echo "<strong>ERROR: {$resp['status']}</strong>";
          return false;
      }
  }

  function array_print($array)
  {
    echo "<pre>";
      print_r($array);
      echo "</pre>";
    }

/**
 * [getAvailableSpaces description]
 * @param  [type] $start_date [description]
 * @param  [type] $end_date   [description]
 * @param  [type] $conn       [description]
 * @return [array]            All the spaces that are available during the date range
 */
function getAvailableSpaces ($start_date, $end_date, $conn){
  $sql = "SELECT *
          FROM spaces
          WHERE spaceID NOT IN
          (SELECT spaceID FROM contracts
            WHERE (NOT contracts.start_date > '$end_date' OR NOT contracts.start_date > '$start_date')
            AND
            (NOT contracts.end_date < '$end_date' OR NOT contracts.end_date < '$start_date'))";

  $result = $conn -> query($sql);

  $spaces = array();
  while ($row = $result -> fetch_assoc()) {
    array_push($spaces, $row['spaceID']);
  }
  // echo "The following spaces are available during the dates " . $start_date . " and " . $end_date . ".<br>";

  return $spaces;
}

/**
 * [sortedAddressResults description]
 * @param  [array] $origin [description]
 * @param  [array] $spacesLocations [description]
 * @return [array]         sorted array of spaces (ID, distance, tim) to destinationascending on distance, time, and spaceID
*/
function sortedAddressResults ($origin, $spacesLocations, $returning = "array")
{
  $address = array();
  $spaceID = array();
  array_push($spaceID, $spacesLocations['spaceID']);
  array_push($address, $spacesLocations['address'] . " " . $spacesLocations['city'] . " " . $spacesLocations['state']);

  $arr = array_chunk($address, 99);
  $data_arr = array();
  $distance = array();
  $time = array();

  for ($i = 0; $i < count($arr); $i++) {
      $data_arr[$i] = distance($origin, $arr[$i]);
      $distance = array_merge($distance, $data_arr[$i][1]);
      $time = array_merge($time, $data_arr[$i][2]);
  }

  // if able to geocode the address
  if ($data_arr)
      $getorigin = $data_arr[0][0];

  $sortedDestinations = array($spaceID,
  $distance,
  $time);

  array_multisort(
      $sortedDestinations[1],
      SORT_ASC,
      $sortedDestinations[2],
      SORT_ASC,
      $sortedDestinations[0],
      SORT_ASC
  );
  return $sortedDestinations;
}


echo $getorigin . " to: <form action='ranking.php' method='get'>
                    <input value='RESET' type='submit'>
                    </form><br>";
echo "<table style='width:100%'>
      <tr>
      <th>SpaceID</th>
      <th>Distance (Meters)</th>
      <th>Time (Seconds)</th>
      </tr>";

$start = '2018-01-20';
$end = '2018-11-31';
$NotScheduled = $data;
for ($i = 0; $i < count($spaceID); ++$i) {
    if (!in_array($data[0][$i], getAvailableSpaces($start,$end,$conn))) {
      $colorStart = "<h1 style='background-color:Tomato;'>";
      $colorEnd = "</h1>";
      unset($NotScheduled[0][$i]);
      unset($NotScheduled[1][$i]);
      unset($NotScheduled[2][$i]);
    }
    else if (in_array($data[0][$i], getAvailableSpaces($start,$end,$conn))){
      $colorStart = "<p style='background-color:MediumSeaGreen;'>";
      $colorEnd = "</p>";
    }
    else{
      $colorEnd = "</p>";
      $colorStart = "<p>";
    }
    echo "<tr><td>" . $colorStart . $data[0][$i] . $colorEnd . "<hr></td><td>" . $colorStart . $data[1][$i] . $colorEnd . "<hr></td><td>" . $colorStart . $data[2][$i] . $colorEnd . "<hr></td></tr>";
}

echo "</table>";
?>
