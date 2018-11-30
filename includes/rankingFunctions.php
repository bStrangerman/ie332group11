<?php

//error checking
$location_error = "Please enter a location";
$err = array();
if((isset($_GET['location']) && $_GET['location'] == ""))
array_push($err, $location_error);
else if((isset($_GET['state']) && $_GET['state'] == ""))
array_push($err, $location_error);
else if(!isset($_GET['location']) && !isset($_GET['state']))
array_push($err, $location_error);
else if(isset($_GET['location']) && isset($_GET['state']))
array_push($err, "Please try again");

if((isset($_GET['startdate']) && $_GET['startdate'] == "") || !isset($_GET['startdate']))
array_push($err, "Please enter a valid start date");

if((isset($_GET['enddate']) && $_GET['enddate'] == "") || !isset($_GET['enddate']))
array_push($err, "Please enter a valid end date");

//clean the GET statement
if(isset($_GET['startdate']))
$start = $_SESSION['startdate'] = clean($_GET['startdate']);
else
$start = "";

//clean the GET statement
if(isset($_GET['enddate']))
$end = $_SESSION['enddate'] = clean($_GET['enddate']);
else
$end = "";

/**
* Get all the spaces (no matter what), from the database
* @return [array]       [array of all the spaces with headers]
*/
function getAllSpaces(){
  $getAllSpacesSQL = "SELECT *
  FROM Spaces
  LEFT JOIN Warehouses
  ON Warehouses.warehouseID = Spaces.warehouseID
  LEFT JOIN Space_Attributes
  ON Space_Attributes.SpaceID = Spaces.SpaceID
  LEFT JOIN Attributes
  ON Attributes.AttributeID = Space_Attributes.AttributeID
  WHERE Active = 1";
  $getAllSpaces = array();
  $result = $GLOBALS['conn'] -> query($getAllSpacesSQL);

  while($getAllSpaces[]=mysqli_fetch_array($result));
  unset($getAllSpaces[(count($getAllSpaces) - 1)]);

  return $getAllSpaces;
}

/**
* Runs the Google API function to get distance and time for all addresses
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
* Google API execution
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
  $url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins={$origin}&destinations={$destinationURL}&key=AIzaSyDdGKJ_S6C6zYyhJdmVmzHRD4vHo8t4j-s";
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
* @return [array]            All the spaces that are available during the date range
*/
function getAvailableSpaces ($start_date, $end_date, $type){
  $sql = "SELECT *
  FROM Spaces
  LEFT JOIN Warehouses
  ON Warehouses.warehouseID = Spaces.warehouseID
  LEFT JOIN Space_Attributes
  ON Space_Attributes.SpaceID = Spaces.SpaceID
  INNER JOIN Attributes
  ON Attributes.AttributeID = Space_Attributes.AttributeID
  WHERE Active = 1
  AND Spaces.SpaceID NOT IN
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
        OR StatusName <> 'Reserved'))
        AND (NOT Contracts.StartDate > '$end_date' OR NOT Contracts.StartDate > '$start_date')
        AND (NOT Contracts.EndDate < '$end_date' OR NOT Contracts.EndDate < '$start_date'))";

        $sql .= ($type == array()) ? "" : " AND AttributeName IN ('".implode(',',$type)."')";

        $result = $GLOBALS['conn'] -> query($sql);

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
 * Algorithm to determine the utilization of the space
 * @param [int]  $space [spaceID of the space]
 * @param [date]  $start [start date of wanted contract]
 * @param [date]  $end   [end date of wanted contract]
 * @param integer $scale [default scacle value]
 */
      function Utilization($space, $start, $end, $scale = 100){
        $score = 1;
        $start = date_create($start);
        $end = date_create($end);
        $sql = "SELECT *
        FROM Contracts
        WHERE SpaceID = $space";
        $result = ($GLOBALS['conn'] -> query($sql));

        if ($result && $result->num_rows > 0) {
          $i = 0;
          $max_Utilization = 0;
          while($row = $result->fetch_assoc()) {
            $Utilization[$i] = 0;
            if(count($row) > 0){

              // create formatted dates
              $contractStart =  date_create($row['StartDate']);
              $contractEnd = date_create($row['EndDate']);

              // calculate contract length
              $contractLength  = date_diff($contractStart, $contractEnd , true);
              $contractLength = $contractLength->format("%a");

              // Select Future Contracts
              if($start > $contractEnd){
                $timeUntil = date_diff($start, $contractEnd, true);
                $timeUntil = $timeUntil->format("%a");
                $Utilization[$i] = $timeUntil / $contractLength;
              }
              // Select Past Contracts
              else if($end < $contractStart){
                $timePast = date_diff($end, $contractStart, true);
                $timePast = $timePast->format("%a");
                $Utilization[$i] = $timePast / $contractLength;
              }
              else{
                $Utilization[$i] = 0;
              }

              if($Utilization[$i] > $max_Utilization){
                $max_Utilization = $Utilization[$i];
              }
            }
            $i++;
          }
        }
        else {
          $max_Utilization = $scale;
        }

        return $max_Utilization;
      }

      function distance_score($max_distance_wanted , $distance_away, $scale = 100){
        $distance_score = $scale * (1 - $distance_away / $max_distance_wanted);
        return $distance_score;
      }

      function size_score($size_wanted, $space_size, $max_size, $scale = 100){
        if($space_size < $size_wanted)
          $space_score = 0;
        else if($space_size > $size_wanted)
          $space_score = (-($max_size / ($space_size - $size_wanted)) + $scale);
        else
          $space_score = $scale;

        return $space_score;
      }

      function price_score($space_price, $max_price, $min_price = 0, $scale = 100){

        $price_score = $scale * (1 - ($space_price - $min_price) / ($max_price - $min_price));
        if($space_price > $max_price)
        $price_score = 0;
        return $price_score;
      }


      function previousRatings($spaceID, $scale = 100){
        $rating_range = 5;
        $rating_score = ($scale / $rating_range) * $rating;
      }

      function ifMulti($result){
        if(count($result) == 1){
          $score = 100 / 3;
        }
        else
        $score = 0;
      }

      function distanceAlgorithm($lat1, $lon1, $lat2, $lon2) {
        $pi80 = M_PI / 180;
        $lat1 *= $pi80;
        $lon1 *= $pi80;
        $lat2 *= $pi80;
        $lon2 *= $pi80;

        $r = 6372.797; // mean radius of Earth in km
        $dlat = $lat2 - $lat1;
        $dlon = $lon2 - $lon1;
        $a = sin($dlat / 2) * sin($dlat / 2) + cos($lat1) * cos($lat2) * sin($dlon / 2) * sin($dlon / 2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
        $km = $r * $c;

        //echo '<br/>'.$km;
        return ($km * 1000);
      }

      function getLatLon($address){
        // Adapted from the google geocoding API
        // Source: http://www.datasciencetoolkit.org/developerdocs#street2coordinates
        $API_CALL = "http://www.datasciencetoolkit.org/maps/api/geocode/json?sensor=false&address=" . urlencode($address);

        // echo "<a href='" . $url . "'>" . $url . "</a><br>";
        // get the json response
        $resp_json = file_get_contents($API_CALL);

        // decode the json
        $resp = json_decode($resp_json, true);

        // response status will be 'OK', if able to geocode given address
        if ($resp['status'] == 'OK') {

          $getLat = isset($resp['results'][0]['geometry']['location']['lat']) ? $resp['results'][0]['geometry']['location']['lat'] : "";
          $getLon = isset($resp['results'][0]['geometry']['location']['lng']) ? $resp['results'][0]['geometry']['location']['lng'] : "";

          // verify if data is complete
          if ($getLat && $getLon) {

            // put the data in the array
            $data_arr = array($getLat, $getLon);

            return $data_arr;
          }
          else {
            return false;
          }
        }
        else {
          // echo "<strong>ERROR: {$resp['status']}</strong>";
          return false;
        }
      }

      function getZip($lat, $lon){
        // Adapted from the google geocoding API
        // Source: http://www.datasciencetoolkit.org/developerdocs#street2coordinates
          $API_CALL = "http://www.datasciencetoolkit.org/coordinates2politics/". $lat . "%2c" . $lon;

        // echo "<a href='" . $url . "'>" . $url . "</a><br>";
        // get the json response
        $resp_json = file_get_contents($API_CALL);

        // decode the json
        $resp = json_decode($resp_json, true);

        // response status will be 'OK', if able to geocode given address
        if ($resp['status'] == 'OK') {

          $getZip = isset($resp['location']['']) ? $resp['location'][''] : "";

          // verify if data is complete
          if ($getZip) {
            return $getZip;
          }
          else {
            return false;
          }
        }
        else {
          // echo "<strong>ERROR: {$resp['status']}</strong>";
          return false;
        }
      }
      ?>
