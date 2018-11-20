<?php
require_once "../includes/main.php";
include "../includes/rankingFunctions.php";


$str = "A 'quote' is <b>bold</b>;";
//$str = "' or ''='";
echo $str . "<br>";
// Outputs: A 'quote' is <b>bold</b>
echo htmlentities($str) . "<br>";

// Outputs: A 'quote' is <b>bold</b>
echo htmlentities($str, ENT_QUOTES) . "<br>";
echo mysqli_real_escape_string($GLOBALS['conn'],$str) . "<br>";
echo clean($str);

array_print($_SESSION);
?>
