<?php include "db.php";

$sql = "SELECT *
        FROM factors";

$factor1 = (1000>9000) ? 1 : 0;
$factor2 = 0;
$factor3 = 1;
$result = $conn->query($sql);
echo "wID f1 &nbsp;&nbsp;f2 &nbsp;&nbsp;f3 <br>";
echo "T" . "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" . $factor1 . "&nbsp;&nbsp;&nbsp;&nbsp;" . $factor2 . "&nbsp;&nbsp;&nbsp;&nbsp;" . $factor3 . "<br>";
while($row = $result->fetch_assoc()){
  echo $row['warehouseID'];
  $factordb1 = $row['factor1'];
  $factordb2 = $row['factor2'];
  $factordb3 = $row['factor3'];
  echo " &nbsp; &nbsp; &nbsp; " . $factordb1;
  echo " &nbsp; &nbsp;  " . $factordb2;
  echo " &nbsp; &nbsp;  " . $factordb3 . "&nbsp;";

  if($factordb1 == $factor1 & $factordb2 == $factor2 & $factordb3 == $factor3){
    echo "TRUE <br>";
  }
  else {
    echo "<br>";
  }


}
?>
