<?php
require_once "../includes/main.php";

// checks if logged in
if(!isset($_SESSION['UserID'])){
  $_SESSION['redirect'] = 'Location: lesseeAccount.php';
  header("Location: login.php");
}
else if (!$rbac->check('can_lease', $UserID = $_SESSION['UserID'])){
  echo "You don't have the proper permissions to lease a location. This page will redirect in 10 seconds.";
  header("Refresh: 10; index.php");
  exit;
}
else{
  $UserID = $_SESSION['UserID'];
}

// print the header
require_once "../layouts/Calssimax/header.php";

// get user info
$sql = "SELECT *
        FROM phprbac_users
        WHERE phprbac_users.UserID = $UserID";
$result = $conn -> query($sql);
while($LesseeInfo[]=mysqli_fetch_array($result));

?>
<!--==================================
=            User Profile            =
===================================-->
<section class="dashboard section">
	<!-- Container Start -->
	<div class="container">
		<!-- Row Start -->
		<div class="row">
			<div class="col-md-10 offset-md-1 col-lg-4 offset-lg-0">
				<div class="sidebar">
					<!-- User Widget -->
					<div class="widget user-dashboard-profile">
						<!-- User Image -->
						<!-- <div class="profile-thumb">
							<img src="images/user/user-thumb.jpg" alt="" class="rounded-circle">
						</div> -->
						<!-- User Name -->
						<h5 class="text-center"><?php echo $LesseeInfo[0]['FirstName'] . " " . $LesseeInfo[0]['LastName']; ?></h5>
						<p>Joined <?php echo date("F d, Y" , strtotime($LesseeInfo[0]['CreationDate'])); ?></p>
						<a href="lesseeProfile.php" class="btn btn-main-sm">Edit Profile</a>
					</div>
					<!-- Dashboard Links -->
					<div class="widget user-dashboard-menu">
						<ul>
							<li class="active" ><a href=""><i class="fa fa-user"></i> My Contracts</a></li>
							<!-- <li><a href=""><i class="fa fa-bookmark-o"></i> Favourite Ads <span>5</span></a></li>
							<li><a href=""><i class="fa fa-file-archive-o"></i>Archived Ads <span>12</span></a></li>
							<li><a href=""><i class="fa fa-bolt"></i> Pending Approval<span>23</span></a></li> -->
							<li><a href="logout.php"><i class="fa fa-cog"></i> Logout</a></li>
							<!-- <li><a href=""><i class="fa fa-power-off"></i>Delete Account</a></li> -->
						</ul>
					</div>
				</div>
			</div>
			<div class="col-md-10 offset-md-1 col-lg-8 offset-lg-0">
				<!-- Recently Favorited -->
				<div class="widget dashboard-container my-adslist">
					<h3 class="widget-header">My Contracts</h3>
          <?php
          $sql = "SELECT *
                  FROM Contracts
                  LEFT JOIN Spaces
                  ON Spaces.SpaceID = Contracts.SpaceID
                  LEFT JOIN Warehouses
                  ON Warehouses.WarehouseID = Spaces.WarehouseID
                  LEFT JOIN Contract_Status
                  ON Contract_Status.ContractID = Contracts.ContractID
                  LEFT JOIN Status
                  ON Status.StatusID = Contract_Status.StatusID
                  WHERE Contracts.LesseeID = $UserID";
          $result = $conn -> query($sql);?>
					<table class="table table-responsive product-dashboard-table">
						<thead>
							<tr>
								<th>Location</th>
								<th>Contract Info</th>
								<th class="text-center">Status</th>
								<th class="text-center">Review</th>
								<!-- <th class="text-center">Action</th> -->
							</tr>
						</thead>
						<tbody>
              <?php
              while($row = $result -> fetch_assoc()){
                $warehouseID = $row['WarehouseID'];

                $pictureSQL = "SELECT FileName
                               FROM Pictures
                               LEFT JOIN Warehouse_Pictures
                               ON Warehouse_Pictures.PictureID = Pictures.PictureID
                               WHERE Warehouse_Pictures.WarehouseID = $warehouseID
                               LIMIT 1";
                $pictureResult = $conn -> query($pictureSQL);

                echo "<tr>";

                while($picture = $pictureResult -> fetch_assoc()){ ?>
                  <td class="product-thumb">
  									<img width="auto" height="100px" src="../pictures/<?php echo $picture['FileName']; ?>" alt="<?php echo $picture['FileName']; ?>"></td>
                <?php }?>

								<td class="product-details">
									<h3 class="title"><?php echo $row['Address']; ?></h3>
									<span class="add-id"><strong>Contract ID:</strong> <?php echo $row['ContractID']; ?></span>
									<span><strong>Updated on: </strong><time><?php echo $row['StatusTime']; ?></time> </span>
									<!-- <span class="status active"><strong>Status</strong><?php echo $row['StatusName']; ?></span> -->
									<span class="location"><strong>Location</strong><?php echo $row['City'] . ", " . $row['State']; ?></span>
								</td>
								<td class="product-category"><span style="color: <?php echo ($row['StatusName'] == 'Denied') ? 'red' : (($row['StatusName'] == 'Approved') ? 'green' : 'orange') ?>" class="categories"><?php echo $row['StatusName']; ?></span></td>
								<td class="action" data-title="Action">
									<div class="">
										<ul class="list-inline justify-content-center">
											<li class="list-inline-item">
												<a data-toggle="tooltip" data-placement="top" title="Tooltip on top" class="view" href="Lessee_Survey_2.php?contract=<?php echo $row['ContractID'];?>">
													<i class="fa fa-eye"></i>
												</a>
											</li>
                    </ul>
                  </div>
                </td>
                      <!--
											<li class="list-inline-item">
												<a class="edit" href="">
													<i class="fa fa-pencil"></i>
												</a>
											</li>
											<li class="list-inline-item">
												<a class="delete" href="">
													<i class="fa fa-trash"></i>
												</a>
											</li>
										</ul>
									</div>
								</td> -->
							</tr>
            <?php }?>

						</tbody>
					</table>

				</div>
			</div>
		</div>
		<!-- Row End -->
	</div>
	<!-- Container End -->
</section>
<?php include_once "../layouts/Calssimax/footer.php"; ?>
