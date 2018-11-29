<?php
require_once "../includes/main.php";
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
