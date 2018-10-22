<?php 
session_start();

require_once '332/PhpRbac/src/PhpRbac/Rbac.php';
$rbac = new \PhpRbac\Rbac();
$rbac->reset($Ensure = true);

/* $rbac->enforce('root', $_SESSION['UserID']);

$role_id = $rbac->Users->allRoles($UserID = $_SESSION['UserID']);

print_r($role_id);
echo "<br>";
$rbac->Users->hasRole($role_id, $_SESSION['UserID']);
print_r($rbac); */
?>