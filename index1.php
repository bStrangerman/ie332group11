<?php
include('geo.php');
$ip = $_SESSION['ip'];
$lat = $_SESSION['lat'];
$lon = $_SESSION['lon'];
?>
<html>
<body>
  <h1> HELLO WORLD</h1>
</body>
</html>
<?php

// $sql = "INSERT INTO visit (ip, latitude, longitude) VALUES ('$ip', $lat, $lon)";

// $conn->query($sql);

// if ($conn->query($sql) === TRUE) {
//     echo "New record created successfully";
// } else {
//     echo "Error: " . $sql . "<br>" . $conn->error;
// }

// index1.php
echo "<form action='index1.php' method='post'>";
echo "Number values to generate: <input type='text' name='N'/>";
echo "<input type='submit'/>";
echo "</form>";

$RscriptPath = 'C:\\"Program Files"\\R\\R-3.5.1\\bin\\';

if( isset($_POST['N']))
{
  $N = $_POST['N'];


  // execute R script from shell
  // this will save a plot at temp.png to the filesystem
  exec($RscriptPath . 'Rscript.exe my_rscript.R ' . $N);

  // return image tag

  $nocache = rand();

  echo("<img src='temp.png?$nocache'/>");
}

// exec($RscriptPath . 'Rscript.exe testapp.R');
?>

 <iframe height="75%" frameborder="0" width="100%" src="https://bstrangerman.shinyapps.io/test/"></iframe> 
