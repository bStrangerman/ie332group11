<?php

/**
* Get all the spaces (no matter what), from the database
* @param  [func] $conn [SQL Database connection]
* @return [array]       [array of all the spaces with headers]
*/
function getAllSpaces($conn){
  $getAllSpacesSQL = "SELECT *
  FROM Spaces
  LEFT JOIN Warehouses
  ON spaces.WarehouseID = Warehouses.WarehouseID";
  $getAllSpaces = array();
  $result = $conn -> query($getAllSpacesSQL);

  while($getAllSpaces[]=mysqli_fetch_array($result));

  return $getAllSpaces;
}

/**
* Runs the Google API function to get distance and time
* @param  [text] $origin  [Origin of the query]
* @param  [array] $address [list of destinations to be searched.  Can be as many as possible]
* @return [array]          [Outputs formatted Origin Address, and all distance and time]
*/
function getDistance($origin, $address){
  if (isset($origin)) {
    $arr = array_chunk($address, 99);

    $data_arr = array();
    $distance = array();
    $time = array();

    for ($i = 0; $i < count($arr); $i++) {
      $data_arr[$i] = distance($origin, $arr[$i]);
      $distance = array_merge($distance, $data_arr[$i][1]);
      $time = array_merge($time, $data_arr[$i][2]);
    }
  }
  return array("Origin" => $data_arr[0][0], "Distance" => $distance, "Time" => $time);
}

/**
* Google API
* @param  [text] $origin      [origin of the query]
* @param  [array] $destination [destinations of the query]
* @return [array]              [Returns unformatted results]
*/
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


/**
* Gets all the available spaces from the database
* @param  [date] $start_date [start date that the customer wants]
* @param  [date] $end_date   [end date that the customer wants]
* @param  [function] $conn       [SQL database connection]
* @return [array]            All the spaces that are available during the date range
*/
function getAvailableSpaces ($start_date, $end_date, $conn){
  $sql = "SELECT *
  FROM Spaces
  LEFT JOIN Warehouses
  ON Warehouses.warehouseID = Spaces.warehouseID
  WHERE spaceID NOT IN
  (SELECT DISTINCT spaceID
    FROM Contracts
    WHERE contractID IN
    (SELECT contractID
      FROM Contract_Status
      WHERE StatusID IN
      (SELECT StatusID
        FROM Status
        WHERE StatusName <> 'Approved'
        OR StatusName <> 'Pending'
        OR StatusName <> 'Reserved')))";
        $result = $conn -> query($sql);

        while($getAllSpaces[]=mysqli_fetch_array($result));
        return $getAllSpaces;
      }

      /**
      * Stylized array printing
      * @param  [array] $array array to be formatted
      * @return [void]        [None]
      */
      function array_print($array){
        echo "<pre>";
        print_r($array);
        echo "</pre>";
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

      function singular_spaces ($spaceIDs, $size, $conn){
        $sql = "SELECT *
        FROM spaces
        WHERE SpaceID IN (".implode(',',$spaceIDs).")
        AND SpaceSize >= $size
        ORDER BY SpaceSize ASC
        ";
        $result = $conn -> query($sql);

        $out = array();

        while($row = $result -> fetch_assoc()){
          array_push($out, $row['SpaceID']);
        }
        return $out;
      }


      function multi_spaces ($spaceIDs, $maxsize, $maxNumOfSpaces, $conn) {
        $sql = "SELECT *
        FROM spaces
        WHERE SpaceID IN (".implode(',',$spaceIDs).")
        AND SpaceSize < $maxsize
        ORDER BY SpaceSize ASC";

        $result = $conn -> query($sql);

        $spaces = array();
        $size = array();
        while($row = $result -> fetch_assoc()) {
          array_push($spaces, $row['SpaceID']);
          array_push($size, $row['SpaceSize']);
        }
        $warehousesPicked = array();

        for($i = 0; $i < count($spaces); $i++) {
          $currentSize = 0;
          echo "<br>Solution Number " . $i . ": ";
          $innerwarehousesPicked = array();

          for ($j = $i; $j < count($spaces); $j++) {
            if($currentSize + $size[$j] <= $maxsize) {
              $currentSize += $size[$j];
              array_push($innerwarehousesPicked, $spaces[$j]);
              echo $spaces[$j] . " ";
            }
            else {
              $currentSize += $size[$j];
              array_push($innerwarehousesPicked, $spaces[$j]);
              echo $spaces[$j] . " ";
              break;
            }
          }
          // array_print($innerwarehousesPicked);
          $warehousesPicked[$i] = $innerwarehousesPicked;
          echo "<strong>" . $currentSize . "</strong>";
        }
        return $warehousesPicked;
      }


      function distance_score($max_distance_wanted , $distance_away, $scale = 33.3){
        $distance_score = $scale * (1 - $distance_away / $max_distance_wanted);
        return $distance_score;
      }

      function size_score($size_wanted, $space_size, $scale = 100){
        // y = a(x – h)2 + k
        if($space_size >= $size_wanted){
          $a = (0 - $scale) / pow((0 - $size_wanted), 2);
          $space_score = $a * pow(($space_size - $size_wanted), 2) + $scale;
        }
        else
          $space_score = 0;

        if($space_score < 0)
          $space_score = 0;
        
        return $space_score;
      }

      function price_score($space_price, $max_price, $min_price = 0, $scale = 33.3){
        $price_score = $scale * (1 - ($space_price - $min_price) / ($max_price - $min_price));
        return $price_score;
      }

      function previousRatings($spaceID, $scale = 50){
        $rating_range = 5;
        $rating_score = ($scale / $rating_range) * $rating;
      }

      function ifMulti($result){
        if(count($result) == 1){
          $score = 100;
        }
        else
        $score = 0;
      }
