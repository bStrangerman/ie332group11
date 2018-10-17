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
  $currentspace = $row['spaceID'];

  $selectOutterDates = "SELECT COUNT(*) as DateCount
                        FROM calendar
                        WHERE
                        calendar.spaceID = $currentspace
                        AND
                        (calendar.end < CURRENT_DATE()
                        AND
                        calendar.end > DATE(NOW()) + INTERVAL -90 DAY)
                        OR
                        (calendar.start > CURRENT_DATE()
                        AND
                        calendar.start < DATE(NOW()) + INTERVAL +90 DAY)";

  $outerResult = $conn->query($selectOutterDates);
  while($outerrow = $outerResult -> fetch_assoc())
  {
    if(isset($outerrow['DateCount'])){
      $datecount = $outerrow['DateCount'];
    }
    else{
      $datecount = 0;
    }
  }
  echo "<tr><td>" . $row['spaceName'] . " (" . $datecount . ") " . "</td><td>" . $row['start'] . "</td><td>" . $row['end'] . "</td>";
}?>

<form action="availability.php" method="post">
  <tr> <td><h4>Add Booking:</h4></td></tr>
<tr>
  <td>
    <select name="in_space">
      <?php
      $sql = "SELECT *
              FROM spaces";
      $result = $conn -> query($sql);

      while($row = $result -> fetch_assoc())
      {
        echo "<option value='" . $row['spaceID'] . "'>" . $row['spaceName'] . "</option>";
      }?>
    </select>
  </td>
  <td>
    <input type="date" name="in_start" value="">
  </td>
  <td>
    <input type="date" name="in_end" value="">
  </td>
</tr>
</table>

<input type="submit">
</form>
<br><hr>
<?php
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
  else if (isset($_POST["in_space"]) || isset($_POST["in_start"]) || isset($_POST["in_end"])){
    $sql2 = "INSERT INTO calendar (spaceID, start, end) VALUES ('" . $_POST['in_space'] . "', '" . $_POST['in_start'] . "', '" . $_POST['in_end'] . "')";

    if ($conn->query($sql2) === TRUE) {
        echo "New record created successfully<br>";
        echo "<a href='availability.php' target='_self' >Refresh</a>";

    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

  }
  else {
    ?>
    <h1>Search</h1>
    <form action="availability.php" method="get">
      Start Date: <input type="date" name="start" value="<?php echo date("Y-m-d"); ?>"><br>
      End Date: <input type="date" name="end" value="<?php echo date("Y-m-d"); ?>"><br>
      <input type="submit">
    </form>
    <?php
  }
?>
