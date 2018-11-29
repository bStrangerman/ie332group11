<?php
require_once "../includes/main.php";

echo '$ip=$_SERVER["HTTP_CLIENT_IP"]: ' . $ip=$_SERVER['HTTP_CLIENT_IP'] . "<br>";
echo '$ip=$_SERVER["HTTP_X_FORWARDED_FOR"]: ' . $ip=$_SERVER['HTTP_X_FORWARDED_FOR'] . "<br>";
echo '$ip=$_SERVER["REMOTE_ADDR"]: ' . $ip=$_SERVER['REMOTE_ADDR'] . "<br>";


function get_client_ip() {
    $ipaddress = '';
    if ($_SERVER['HTTP_CLIENT_IP'])
        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    else if($_SERVER['HTTP_X_FORWARDED_FOR'])
        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    else if($_SERVER['HTTP_X_FORWARDED'])
        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    else if($_SERVER['HTTP_FORWARDED_FOR'])
        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    else if($_SERVER['HTTP_FORWARDED'])
        $ipaddress = $_SERVER['HTTP_FORWARDED'];
    else if($_SERVER['REMOTE_ADDR'])
        $ipaddress = $_SERVER['REMOTE_ADDR'];
    else
        $ipaddress = 'UNKNOWN';
    return $ipaddress;
}
$ip = get_client_ip();
echo "IP: " . $ip;

array_print($_COOKIE);


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
echo md5("th!sPwd!s4Le55ee") . "<br>";
echo "878fcd3829462665ff1ad75ad0f9ca11" . "<br>";


//API from ipstack.com
echo '<br> API BREAK <br>';
$ip = '23.237.120.42';
$geoIP  = json_decode(file_get_contents("http://api.ipstack.com/$ip?access_key=d3bc63cb9b643a0c5f818c7762f23dda"), true);

 echo 'lat: ' . $geoIP['latitude'] . "<br>";
 echo 'long: ' . $geoIP['longitude'];

?>
