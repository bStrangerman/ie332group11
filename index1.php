<html>
<body>
  <h1> HELLO WORLD</h1>
</body>
</html>
<?php
include('geo.php');
$ip = $_SESSION['ip'];
$lat = $_SESSION['lat'];
$lon = $_SESSION['lon'];


$sql = "INSERT INTO visit (ip, latitude, longitude) VALUES ('$ip', $lat, $lon)";

$conn->query($sql);

// if ($conn->query($sql) === TRUE) {
//     echo "New record created successfully";
// } else {
//     echo "Error: " . $sql . "<br>" . $conn->error;
// }
?>
