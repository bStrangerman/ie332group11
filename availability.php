<?php include "db.php";

$sql = "SELECT calendar.*, spaces.*
FROM calendar
RIGHT JOIN spaces
ON calendar.spaceID = spaces.spaceID
ORDER BY start, end ASC";

$result = $conn -> query($sql);

echo "<table style='width:100%'>
<tr>
<th>Space</th>
<th>Start Date</th>
<th>End Date</th>
</tr>";
echo "The following schedule is for debugging purposes.<br>";
while($row = $result -> fetch_assoc())
{
  echo "<tr><td>" . $row['spaceName'] . "</td><td>" . $row['start'] . "</td><td>" . $row['end'] . "</td>";
}
echo "</table>";
echo "<br><hr>";

if(isset($_GET['start']) & isset($_GET['end'])){
  $start = $_GET['start'];
  $end = $_GET['end'];

  $sql = "SELECT *
  FROM spaces
  WHERE spaceID NOT IN
  (SELECT spaceID FROM Calendar
    WHERE (NOT Calendar.start > '$end' OR NOT Calendar.start > '$start')
    AND
    (NOT Calendar.end < '$end' OR NOT Calendar.end < '$start'))";

    $result = $conn -> query($sql);

    echo "The following spaces are available during the dates " . $start . " and " . $end . ".<br>";
    while($row = $result -> fetch_assoc())
    {
      echo $row['spaceName'] . "<br>";
    }?>
    <br>
    <br>
    <form action="availability.php" method="get">
      <input value="RESET" type="submit">
    </form>
  <?php }
  else {
    ?>
    <form action="availability.php" method="get">
      Start Date: <input type="date" name="start" value="<?php echo date("Y-m-d"); ?>"><br>
      End Date: <input type="date" name="end" value="<?php echo date("Y-m-d"); ?>"><br>
      <input type="submit">
    </form>
    <?php
  }
  ?>
