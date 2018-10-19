<?php include "db.php";

$destination = array(
  "Library of Congress",
  "Los Angeles City Hall",
  "Disney World",
  "101 N Hope St, Los angeles",
  "LAX",
  "350 Fifth Avenue New York, NY 10118",
  "4059 Mt Lee Dr. Hollywood, CA 90068",
  "Statue of Liberty, Liberty Island New York, NY 10004",
  "685 Arrowhead Ave. Bettendorf, IA 52722",
  "705 Rockland Dr. Woodstock, GA 30188",
  "6 S. Peachtree Court Waukegan, IL 60085",
  "4 Wilson Dr. Helena, MT 59601",
  "777 Brockton Avenue, Abington MA 2351",
  "30 Memorial Drive, Avon MA 2322",
  "250 Hartford Avenue, Bellingham MA 2019",
  "700 Oak Street, Brockton MA 2301",
  "66-4 Parkhurst Rd, Chelmsford MA 1824",
  "591 Memorial Dr, Chicopee MA 1020",
  "55 Brooksby Village Way, Danvers MA 1923",
  "137 Teaticket Hwy, East Falmouth MA 2536",
  "42 Fairhaven Commons Way, Fairhaven MA 2719",
  "374 William S Canning Blvd, Fall River MA 2721",
  "121 Worcester Rd, Framingham MA 1701",
  "677 Timpany Blvd, Gardner MA 1440",
  "337 Russell St, Hadley MA 1035",
  "295 Plymouth Street, Halifax MA 2338",
  "1775 Washington St, Hanover MA 2339",
  "280 Washington Street, Hudson MA 1749",
  "20 Soojian Dr, Leicester MA 1524",
  "11 Jungle Road, Leominster MA 1453",
  "301 Massachusetts Ave, Lunenburg MA 1462",
  "780 Lynnway, Lynn MA 1905",
  "70 Pleasant Valley Street, Methuen MA 1844",
  "830 Curran Memorial Hwy, North Adams MA 1247",
  "1470 S Washington St, North Attleboro MA 2760",
  "506 State Road, North Dartmouth MA 2747",
  "742 Main Street, North Oxford MA 1537",
  "72 Main St, North Reading MA 1864",
  "200 Otis Street, Northborough MA 1532",
  "180 North King Street, Northhampton MA 1060",
  "555 East Main St, Orange MA 1364",
  "555 Hubbard Ave-Suite 12, Pittsfield MA 1201",
  "300 Colony Place, Plymouth MA 2360",
  "301 Falls Blvd, Quincy MA 2169",
  "36 Paramount Drive, Raynham MA 2767",
  "450 Highland Ave, Salem MA 1970",
  "1180 Fall River Avenue, Seekonk MA 2771",
  "1105 Boston Road, Springfield MA 1119",
  "100 Charlton Road, Sturbridge MA 1566",
  "262 Swansea Mall Dr, Swansea MA 2777",
  "333 Main Street, Tewksbury MA 1876",
  "1415 7Th Street South, Clanton AL 35045",
  "626 Olive Street Sw, Cullman AL 35055",
  "27520 Hwy 98, Daphne AL 36526",
  "2800 Spring Avn SW, Decatur AL 35603",
  "969 Us Hwy 80 West, Demopolis AL 36732",
  "3300 South Oates Street, Dothan AL 36301",
  "4310 Montgomery Hwy, Dothan AL 36303",
  "600 Boll Weevil Circle, Enterprise AL 36330",
  "3176 South Eufaula Avenue, Eufaula AL 36027",
  "7100 Aaron Aronov Drive, Fairfield AL 35064",
  "10040 County Road 48, Fairhope AL 36533",
  "3186 Hwy 171 North, Fayette AL 35555",
  "3100 Hough Rd, Florence AL 35630",
  "2200 South Mckenzie St, Foley AL 36535",
  "2001 Glenn Bldv Sw, Fort Payne AL 35968",
  "340 East Meighan Blvd, Gadsden AL 35903",
  "890 Odum Road, Gardendale AL 35071",
  "1608 W Magnolia Ave, Geneva AL 36340",
  "501 Willow Lane, Greenville AL 36037",
  "170 Fort Morgan Road, Gulf Shores AL 36542",
  "11697 US Hwy 431, Guntersville AL 35976",
  "42417 Hwy 195, Haleyville AL 35565",
  "1706 Military Street South, Hamilton AL 35570",
  "1201 Hwy 31 NW, Hartselle AL 35640",
  "209 Lakeshore Parkway, Homewood AL 35209",
  "2780 John Hawkins Pkwy, Hoover AL 35244",
  "5335 Hwy 280 South, Hoover AL 35242",
  "1007 Red Farmer Drive, Hueytown AL 35023",
  "2900 S Mem PkwyDrake Ave, Huntsville AL 35801",
  "11610 Memorial Pkwy South, Huntsville AL 35803",
  "2200 Sparkman Drive, Huntsville AL 35810",
  "330 Sutton Rd, Huntsville AL 35763",
  "6140A Univ Drive, Huntsville AL 35806",
  "4206 N College Ave, Jackson AL 36545",
  "1625 Pelham South, Jacksonville AL 36265",
  "1801 Hwy 78 East, Jasper AL 35501",
  "8551 Whitfield Ave, Leeds AL 35094",
  "8650 Madison Blvd, Madison AL 35758",
  "145 Kelley Blvd, Millbrook AL 36054",
  "1970 S University Blvd, Mobile AL 36609",
  "6350 Cottage Hill Road, Mobile AL 36609",
  "101 South Beltline Highway, Mobile AL 36606",
  "2500 Dawes Road, Mobile AL 36695",
  "5245 Rangeline Service Rd, Mobile AL 36619",
  "685 Schillinger Rd, Mobile AL 36695",
  "3371 S Alabama Ave, Monroeville AL 36460",
  "10710 Chantilly Pkwy, Montgomery AL 36117",
  "3801 Eastern Blvd, Montgomery AL 36116");

if(isset($_POST['origin'])){
  $origin = $_POST['origin'];

    // get latitude, longitude and formatted address
    $start = microtime(true);
    $data_arr = distance($origin,$destination);
    $time_elapsed_secs = microtime(true) - $start;
    echo "API Execution Time: " . $time_elapsed_secs . "ms <br> ";

    // if able to geocode the address
    if($data_arr){
      $getorigin = $data_arr[0];
      $formatted_address = $data_arr[1];
      $distance = $data_arr[2];
      $time = $data_arr[3];
      echo $getorigin . " to: <form action='distance.php' method='get'>
                  <input value='RESET' type='submit'>
                </form><br>";
      echo "<table style='width:100%'>
      <tr>
      <th>Address</th>
      <th>Distance (Meters)</th>
      <th>Time (Seconds)</th>
      </tr>";

      for($i = 0; $i < count($formatted_address); $i++){
        echo "<tr><td>" . $formatted_address[$i] . "</td><td>" . $distance[$i] . "</td><td>" . $time[$i] . "</td>";
      }
      echo "</table>";

    }
  }


  else {
    ?>
    <h1>Origin Location Search</h1>
    <form action="distance.php" method="post">
      Origin Location: <input type="text" name="origin" value=""><br>
      <input type="submit">
    </form>
    <h3><?php echo count($destination); ?> Unformatted Destination Addresses</h3><?php

    for($i = 0; $i < count($destination); $i++){
      echo $destination[$i] . "<br>";
    }
  }

  function distance($origin, $destination){
    // url encode the address
    $origin = urlencode($origin);
    $destinationURL = "";

    for($i = 0; $i < count($destination); $i++){
      $destinationURL = $destinationURL . urlencode($destination[$i]);
      if(isset($destination[$i + 1]))
      {
        $destinationURL = $destinationURL . "|";
      }
    }

    // google map geocode api url
    $url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins={$origin}&destinations={$destinationURL}&key=AIzaSyAMIMPJxBWxHe6H8OpZRH7dSSSYNosj2eY";
    echo "<a href='" . $url . "'>" . $url . "</a><br>";
    // get the json response
    $resp_json = file_get_contents($url);

    // decode the json
    $resp = json_decode($resp_json, true);

    // response status will be 'OK', if able to geocode given address
    if($resp['status']=='OK'){

      $dist = array();
      $time = array();
      $formatted_address = array();
      // get the important data

      for($i = 0; $i < count($destination); $i++){
        $getaddress = isset($resp['destination_addresses'][$i]) ? $resp['destination_addresses'][$i] : "";
        array_push($formatted_address, $getaddress);
        $getdistance = isset($resp['rows'][0]['elements'][$i]['distance']['value']) ? $resp['rows'][0]['elements'][$i]['distance']['value'] : "";
        array_push($dist, $getdistance);
        $gettime = isset($resp['rows'][0]['elements'][$i]['duration']['value']) ? $resp['rows'][0]['elements'][$i]['duration']['value'] : "";
        array_push($time, $gettime);
      }
      $getorigin = isset($resp['origin_addresses'][0]) ? $resp['origin_addresses'][0] : "";
      // verify if data is complete
      if($dist && $time){

        // put the data in the array
        $data_arr = array(
          $getorigin,
          $formatted_address,
          $dist,
          $time
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
