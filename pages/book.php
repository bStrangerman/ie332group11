<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";

if(isset($_SESSION['UserID'])){
  if(!$rbac->Users->hasRole('Lessee', $UserID = $_SESSION['UserID'])){
    header('Location: warehouse.php');

  }
}
else {
  $_SESSION['redirect'] = 'Lessee_survey.php';
  header('Location: login.php');
}

require_once "../layouts/Calssimax/header.php";
?>
<div id="page-wrapper">
  <div class="row">
    <div class="col-lg-12">

      <!-- Make this Get there names -->
      <h1 class="page-header">Lessee Survey</h1>
    </div>
    <!-- /.col-lg-12 -->
  </div>
  <!-- /.row -->
  <div class="row">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading">
          Create Your Review
        </div>
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-12">
              <form method="post" action = "lessee_survey_submit.php" role="form">

<!--==============
=   LOAD SPACE   =
===============-->




<!--===================
=     LYKERT SCALES   =
=======================
for Accuracy of Listing, Communication with Staff, Friendlyness of Staff, Location of Warehouse, Value of Space -->

                <div class="form-group">
                  <label>Overall Rating</label> <br>
                  <label class="radio-inline">
                    <input type="radio" name="ls_rating" id="optionsRadiosInline1" value="1" checked>1
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_rating" id="optionsRadiosInline2" value="2">2
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_rating" id="optionsRadiosInline3" value="3">3
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_rating" id="optionsRadiosInline4" value="4">4
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_rating" id="optionsRadiosInline5" value="5">5
                  </label>
                </div>
                <!-- Accuracy of Listing -->
                <div class="form-group">
                  <label>Accuracy of Listing</label> <br>
                  <label class="radio-inline">
                    <input type="radio" name="ls_accuracy" id="optionsRadiosInline1" value="1" checked>1
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_accuracy" id="optionsRadiosInline2" value="2">2
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_accuracy" id="optionsRadiosInline3" value="3">3
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_accuracy" id="optionsRadiosInline4" value="4">4
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_accuracy" id="optionsRadiosInline5" value="5">5
                  </label>
                </div>

                <!-- Communication with Staff-->
                <div class="form-group">
                  <label>Communication with Staff</label> <br>
                  <label class="radio-inline">
                    <input type="radio" name="ls_comm" id="optionsRadiosInline1" value="1" checked>1
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_comm" id="optionsRadiosInline2" value="2">2
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_comm" id="optionsRadiosInline3" value="3">3
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_comm" id="optionsRadiosInline4" value="4">4
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_comm" id="optionsRadiosInline5" value="5">5
                  </label>
                </div>

                <!-- Friendlyness of Staff-->
                <div class="form-group">
                  <label>Friendlyness of Staff</label> <br>
                  <label class="radio-inline">
                    <input type="radio" name="ls_friend" id="optionsRadiosInline1" value="1" checked>1
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_friend" id="optionsRadiosInline2" value="2">2
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_friend" id="optionsRadiosInline3" value="3">3
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_friend" id="optionsRadiosInline4" value="4">4
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_friend" id="optionsRadiosInline5" value="5">5
                  </label>
                </div>


                <!-- Location of Warehouse-->
                <div class="form-group">
                  <label>Location of Warehouse</label> <br>
                  <label class="radio-inline">
                    <input type="radio" name="ls_local" id="optionsRadiosInline1" value="1" checked>1
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_local" id="optionsRadiosInline2" value="2">2
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_local" id="optionsRadiosInline3" value="3">3
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_local" id="optionsRadiosInline4" value="4">4
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_local" id="optionsRadiosInline5" value="5">5
                  </label>
                </div>


                <!-- Value of Space-->
                <div class="form-group">
                  <label>Value of Space</label> <br>
                  <label class="radio-inline">
                    <input type="radio" name="ls_value" id="optionsRadiosInline1" value="1" checked>1
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_value" id="optionsRadiosInline2" value="2">2
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_value" id="optionsRadiosInline3" value="3">3
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_value" id="optionsRadiosInline4" value="4">4
                  </label>
                  <label class="radio-inline">
                    <input type="radio" name="ls_value" id="optionsRadiosInline5" value="5">5
                  </label>
                </div>
                <!-- END OF LYKERT -->

<!--==================
=   FILE SUBMISSION  =
===================-->
                <div class="form-group">
                  <label>Add a photo or video</label>
                  <input type="file" name="ls_files">
                </div>
                <!-- END OF SUBMISSION -->

                <h1 class="page-header"></h1> <!--  Spacing  -->

<!--==================
=   WRTITEN REVIEWS  =
===================-->
                <div class="form-group">
                  <label>Title of your review</label>
                  <input class="form-control" placeholder="What's important to know?" name="ls_title">
                </div>

                <!-- Experience with warehouse -->
                <div class="form-group">
                  <label>Share with the community your warehouse experience</label>
                  <textarea class="form-control" placeholder="How was your warehouse experience?  What did you like or dislike?" rows="3" name="ls_body"></textarea>
                </div>
                <br>
                <!-- END OF Experience -->




                <!-- Private Feedback to Space Owner -->
                <div class="form-group">
                  <label>Share with the community your warehouse experience</label>
                  <textarea class="form-control" placeholder="How can this warehouse owner improve? Only the owner will see this section." rows="3" name="ls_feedback"></textarea>
                </div>
                <br>




<button type="submit" class="btn btn-default">Submit Button</button>
<button type="reset" class="btn btn-default">Reset Button</button>


</form>
</div>
<!-- /.col-lg-6 (nested) -->
</div>
<!-- /.row (nested) -->
</div>
<!-- /.panel-body -->
</div>
<!-- /.panel -->
</div>
<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
</div>
<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="../dist/js/sb-admin-2.js"></script>

</body>

</html>

<?php require_once "../layouts/Calssimax/footer.php"; ?>
