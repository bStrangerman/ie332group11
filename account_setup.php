<!DOCTYPE html>
<html lang="en">
<?php include "db.php";

require_once 'PhpRbac/src/PhpRbac/Rbac.php';
$rbac = new \PhpRbac\Rbac();

if(isset($_SESSION['UserID'])){
  if(!$rbac->Users->hasRole('need_setup', $UserID = $_SESSION['UserID'])){
    header('Location: index.php');
  }
}
else {
  header('Location: index.php');
  exit;
}
?>
<head>
  <meta charset="UTF-8">
  <title>Multi-step form interface</title>

      <link rel="stylesheet" href="css/account_setup.css">

</head>

<body>
<h1 align="center">Continue your setup</h1>
  <form id="signup" action="somewhere" method="POST">
    <ul id="section-tabs">
      <li class="current active"><span>1.</span> Basic Info</li>
      <li><span>2.</span> Contact Info</li>
      <li><span>3.</span> Settings</li>
      <li><span>4.</span> Last Words</li>
    </ul>
  <div id="fieldsets">
  <fieldset class="current">
    <label for="firstName">First Name:</label>
    <input name="firstname" type="text" class="required" />
    <label for="lastName">Last Name:</label>
    <input name="lastname" type="text" class="required" />
    <label for="role">Select Your Primary Role:</label>
    <?php
    $sql = "SELECT Title
            FROM phprbac_roles
            WHERE OrderNumber IS NOT NULL
            ORDER BY OrderNumber ASC";
    $result = $conn->query($sql);

    echo "<select name='role'>";
      // output data of each row
    while($row = $result->fetch_assoc()) {
      $shortname = $row['Title']; ?>
      <option value="<?php $shortname ;?>"><?php echo $shortname ;?></option>
      <?php }
    ?>
  </select>


  </fieldset>
  <fieldset class="next">
    <label for="company">Company:</label>
    <input name="text" type="text" class="" />
    <label for="username">Phone Number:</label>
    <input name="username" type="text">
    <label for="email">Verify Your Email:</label>
    <input name="email" value="<?php echo $_SESSION['email']; ?>" type="email">
  </fieldset>
  <fieldset class="next">
    <label for="interests">Basic Interests:</label>
    <textarea name="bio"></textarea>
    <p>Receive newsletter?<br>
      <input type="radio" name="newsletter" value="yes"><label for="newsletter">yes</label>
      <input type="radio" name="newsletter" value="no"><label for="newsletter">no</label>
    </p>
  </fieldset>
  <fieldset class="next">
    <label for="referrer">Referred by:</label>
    <input type="text" name="referrer">
    <label for="phone">Daytime Phone:</label>
    <input type="tel" name="phone">
  </fieldset>
  <a class="btn" id="next">Next Section ▷</a>
  <input type="submit" class="btn">
  </div>
</form>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>



    <script  src="js/account_setup.js"></script>




</body>

</html>
