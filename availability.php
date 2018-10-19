<?php include "db.php";

$sql = "SELECT calendar.*, spaces.*
FROM calendar
RIGHT JOIN spaces
ON calendar.spaceID = spaces.spaceID
ORDER BY start, end ASC";

$result = $conn -> query($sql);

echo "<table style='width:100%'>
<tr>
<th>Space (past 90/ next 90/ Now)</th>
<th>Start Date</th>
<th>End Date</th>
</tr>";
echo "The following schedule is for debugging purposes.<br>";
while($row = $result -> fetch_assoc())
{
  $currentspace = $row['spaceID'];

  $pastDays = "SELECT count(*) as DateCount
  FROM calendar
  WHERE spaceID = '$currentspace'
  AND (
    (calendar.end BETWEEN
      DATE(NOW()) + INTERVAL -90 DAY AND CURRENT_DATE())
      OR (calendar.start
        BETWEEN
        DATE(NOW()) + INTERVAL -90 DAY AND CURRENT_DATE())
        AND NOT CURRENT_DATE() = DATE(NOW())
      )";

      $nextDays = "SELECT count(*) as DateCount
      FROM calendar
      WHERE spaceID = '$currentspace'
      AND (
        (calendar.end BETWEEN
          CURRENT_DATE() AND DATE(NOW()) + INTERVAL +90 DAY)
          OR (calendar.start
            BETWEEN
            CURRENT_DATE() AND DATE(NOW()) + INTERVAL +90 DAY)
            AND NOT CURRENT_DATE() = DATE(NOW())
          )";

          $currentlyUsedSQL = "SELECT count(*) as DateCount
          FROM calendar
          WHERE spaceID = '$currentspace'
          AND (CURRENT_DATE() BETWEEN calendar.start AND calendar.end)";

          $pastDaysResult = $conn->query($pastDays);
          $nextDaysResult = $conn->query($nextDays);
          $currentlyUsedResult = $conn->query($currentlyUsedSQL);
          while($pastDaysRows = $pastDaysResult -> fetch_assoc()){
            while($nextDaysRows = $nextDaysResult -> fetch_assoc()){
              while($currentlyUsedRows = $currentlyUsedResult -> fetch_assoc()){
                {
                  if(isset($pastDaysRows['DateCount'])){
                    $pastDays = $pastDaysRows['DateCount'];
                  }
                  else{
                    $pastDays = 0;
                  }
                  if(isset($nextDaysRows['DateCount'])){
                    $nextDays = $nextDaysRows['DateCount'];
                  }
                  else{
                    $nextDays = 0;
                  }
                  if(isset($currentlyUsedRows['DateCount'])){
                    $currentlyUsed = $currentlyUsedRows['DateCount'];
                  }
                  else{
                    $currentlyUsed = 0;
                  }
                }
              }
            }
          }
          echo "<tr><td>" . $row['spaceName'] . " ( " . $pastDays . " / " . $nextDays . " / " . $currentlyUsed . " ) " . "</td><td>" . $row['start'] . "</td><td>" . $row['end'] . "</td>";
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
        (SELECT spaceID FROM calendar
          WHERE (NOT calendar.start > '$end' OR NOT calendar.start > '$start')
          AND
          (NOT calendar.end < '$end' OR NOT calendar.end < '$start'))";

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
