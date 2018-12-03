<?php
require_once "../includes/main.php";

echo '$ip=$_SERVER["HTTP_CLIENT_IP"]: ' . $ip=$_SERVER['HTTP_CLIENT_IP'] . "<br>";
echo '$ip=$_SERVER["HTTP_X_FORWARDED_FOR"]: ' . $ip=$_SERVER['HTTP_X_FORWARDED_FOR'] . "<br>";
echo '$ip=$_SERVER["REMOTE_ADDR"]: ' . $ip=$_SERVER['REMOTE_ADDR'] . "<br>";



$geoIP = json_decode(file_get_contents("http://api.ipstack.com/" . $_SERVER["REMOTE_ADDR"] . "?access_key=d3bc63cb9b643a0c5f818c7762f23dda"), true);
setcookie("IP_Data", serialize($geoIP)); //test

array_print($_COOKIE);

$IP_Use = unserialize($_COOKIE["IP_Data"]);
echo "<br> IP_Use:  " . array_print($IP_Use);
echo $IP_Use["latitude"];
if(isset($_COOKIE["IP_Data"]))
  echo "<br> It works";


$str = "' OR 1 = 1;/*";
//$str = "' or ''='";
echo $str . "<br>";
// Outputs: A 'quote' is <b>bold</b>
echo htmlentities($str) . "<br>";

// Outputs: A 'quote' is <b>bold</b>
echo htmlentities($str, ENT_QUOTES) . "<br>";
echo mysqli_real_escape_string($GLOBALS['conn'],$str) . "<br>";
echo clean($str);

array_print($_SESSION);
echo clean("th!sPwd!s4Le55ee") . "<br>";
echo clean("th!sPwd!s4r00t") . "<br>";
echo md5("th!sPwd!s4Le55ee") . "<br>";
echo "878fcd3829462665ff1ad75ad0f9ca11" . "<br>";


//API from ipstack.com
echo '<br> API BREAK <br>';
$ip = '23.237.120.42';
$geoIP  = json_decode(file_get_contents("http://api.ipstack.com/$ip?access_key=d3bc63cb9b643a0c5f818c7762f23dda"), true);

 echo 'lat: ' . $geoIP['latitude'] . "<br>";
 echo 'long: ' . $geoIP['longitude'];

?>
