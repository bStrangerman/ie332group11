<?php
session_start();

$_SESSION['UserID'] = $_GET['id'];

require_once 'PhpRbac/src/PhpRbac/Rbac.php';
$rbac = new \PhpRbac\Rbac();

echo "<h1>USER INFORMATION FOR USER ID: " . $_SESSION['UserID'] . "</h1><br>";

$allroles = $rbac->Users->allRoles($UserID = $_SESSION['UserID']);
$i = 0;
echo "<h2>This user has the following roles: </h2>";
while($i < count($allroles)){
  echo "<h3>" . $allroles[$i]['ID'] . "</h3>";
  $i++;
}

$role = 'Warehouse_Owner';
if($rbac->Users->hasRole($role, $UserID = $_SESSION['UserID'])){
  echo "GOOD<br>";
}
else {
  echo "ERROR<br>";
}

$i = 1;
echo "Which users are a " . $role . "?<br>";
while($i <= 2){
  $userHasRole = $rbac->Users->hasRole($role, $UserID = $i);
  echo $i . ": " . $userHasRole . "<br>";
  $i++;
}
?>
