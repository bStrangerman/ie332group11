<?php
require_once "../includes/main.php";
// FIXME: no proper zipcode.  sometimes outputs United States
$sql = "SELECT *
        FROM Warehouses";
$result = $conn -> query($sql);
$i = 0;
while($row = $result -> fetch_assoc()){
  if(($row['Longitude'] == 0 && $row['Latitude'] == 0) || $row['ZipCode'] == ""){
    $address = $row['Address'] . " " . $row['City'] . " " . $row['State'] . " " . $row['ZipCode'];
    $WarehouseID = $row['WarehouseID'];
    $locationInfo = geocode($address);

    $sql = "UPDATE warehouses
    SET Latitude = '$locationInfo[0]', Longitude = '$locationInfo[1]', ZipCode = '$locationInfo[2]'
    WHERE WarehouseID = $WarehouseID";

    if(!is_numeric($locationInfo[2]))
      echo $address . "<br>";
    else
      $conn -> query($sql);
  }
}


// function to geocode address, it will return false if unable to geocode address
function geocode($address){
  // url encode the address
  $address = urlencode($address);
  // google map geocode api url
  $url = "https://maps.googleapis.com/maps/api/geocode/json?address={$address}&key=AIzaSyDdGKJ_S6C6zYyhJdmVmzHRD4vHo8t4j-s";
  // echo $url;
  // get the json response
  $resp_json = file_get_contents($url);
  // decode the json
  $resp = json_decode($resp_json, true);
  // response status will be 'OK', if able to geocode given address
  if($resp['status']=='OK'){
    // get the important data
    $lati = isset($resp['results'][0]['geometry']['location']['lat']) ? $resp['results'][0]['geometry']['location']['lat'] : "";
    $longi = isset($resp['results'][0]['geometry']['location']['lng']) ? $resp['results'][0]['geometry']['location']['lng'] : "";
    $zip = isset($resp['results'][0]['address_components'][6]['long_name']) ? $resp['results'][0]['address_components'][6]['long_name'] : "";
    $formatted_address = isset($resp['results'][0]['formatted_address']) ? $resp['results'][0]['formatted_address'] : "";
    // verify if data is complete
    if($lati && $longi && $formatted_address){
      // put the data in the array
      $data_arr = array();
      array_push(
        $data_arr,
        $lati,
        $longi,
        $zip,
        $formatted_address
      );
      return $data_arr;
    }else{
      return false;
    }
  }
  else{
    echo "<strong>ERROR: {$resp['status']}</strong>";
    return false;
  }
}
?>
