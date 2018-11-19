<!DOCTYPE html>
<html lang="en" >

<head>
  <meta charset="UTF-8">
  <title>Multi Step - Xpressdocs Landing Page - User Account</title>


  <link rel='stylesheet' href='http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css'>
<link rel='stylesheet' href='https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css'>

      <link rel="stylesheet" href="css/style.css">


</head>

<body>

  <div class="container">
  <!-- Start Step Navigation-->
  <div class="row form-group">
    <div class="col-xs-12">
      <ul class="nav nav-pills nav-justified thumbnail setup-panel">
        <li class="active">
          <a href="#step-1">
            <h4 class="list-group-item-heading">Step 1</h4>
            <p class="list-group-item-text">Profile Information</p>
          </a>
        </li>
        <li class="disabled">
          <a href="#step-2">
            <h4 class="list-group-item-heading">Step 2</h4>
            <p class="list-group-item-text">Account Type</p>
          </a>
        </li>
        <li class="disabled">
          <a href="#step-3">
            <h4 class="list-group-item-heading">Step 3</h4>

            <p class="list-group-item-text">Verify Information</p>
          </a>
        </li>
        <li class="disabled">
          <a href="#step-4">
            <h4 class="list-group-item-heading">Step 4</h4>
            <p class="list-group-item-text">Complete Registration</p>
          </a>
        </li>
      </ul>
    </div>
  </div>
  <!-- End Step Navigation for Create new User -->

  <div class="row setup-content well well-sm" id="step-1" style="width: 100%;margin-left: 0%;padding-bottom: 0px;">
    <!-- -->
    <div class="col-md-12">
      <div class="update-nag">
        <div class="update-split update-xd"><i class="ion-document" style="font-size:2em"></i></div>
        <div class="update-text"> Please enter your information to create a new Xpressdocs account. A confirmation email will be sent to the email address provided below. </div>
      </div>
    </div>
  <!-- -->
      <div class="col-md-12 text-center">
        <div class="col-xs-12 col-md-4 col-lg-4 col-sm-4">
            <h4>Your Information</h4>
            <div class="form-group">
              <input id="firstname" maxlength="70" type="text" name="fn" value="" class="form-control xd-required" placeholder="First Name" aria-describedby="basic-addon1">
              <span class="asterix">*</span>
              <span class="cross"><i class="ion-ios-close-empty"></i></span>
              <div class="alert alert-danger custom-alert">
                Please enter First Name
              </div>
            </div>
            <div class="form-group">
             <input id="lastname" maxlength="70" type="text" name="ln" value="" class="form-control xd-required" placeholder="Last Name" aria-describedby="basic-addon1">
              <span class="asterix">*</span>
              <span class="cross"><i class="ion-ios-close-empty"></i></span>
              <div class="alert alert-danger custom-alert">
                Please enter Last Name
              </div>
             </div>
             <!-- <div class="form-group">
              <input id="emailAddress" class="form-control" maxlength="128" type="text" name="em"  value="" placeholder="Email" aria-describedby="basic-addon1">
               <span class="asterix">*</span>
              <span class="cross"><i class="ion-ios-close-empty"></i></span>
              <div class="alert alert-danger custom-alert">
                Please enter Email Address
              </div>
               <div id="email_required" class="alert alert-danger custom-alert" style="display:none">
                Enter Valid Email Address: name@email.com
              </div>
               </div> -->
               <!-- <div class="form-group">
               <input id="password" type="password" name="pw" value="" class="form-control" placeholder="Password" aria-describedby="basic-addon1" autocomplete="off">
                 <span class="asterix">*</span>
                 <i class="ion-eye icon-show-pass"></i>
              <span class="cross"><i class="ion-ios-close-empty"></i></span>
              <div class="alert alert-danger custom-alert">
                Please enter Password
              </div>
              <div id="appendDiv" class="alert alert-warning marginTopSmall" style="display:none">Password requires a minimum of 8 characters, including at least one number. Please re-enter your password.</div>
             </div>
                <div class="form-group">
                <input id="passwordreentry" type="password" name="pw2" value="" class="form-control xd-required" placeholder="Re-enter Password" aria-describedby="basic-addon1" autocomplete="off">
                  <span class="asterix">*</span>
                <span class="cross"><i class="ion-ios-close-empty"></i></span>
                <div class="alert alert-danger custom-alert">
                  Please Re-enter Password
                </div>
                  <div id="appendDiv1" class="alert alert-warning marginTopSmall" style="display:none">Your password not match with Re-enter password.</div>
                </div> -->
      </div>

       <div class="col-xs-12 col-md-4 col-lg-4 col-sm-4">
            <h4>Contact Information</h4>
            <div class="form-group">
              <input id="phone" maxlength="70" type="text" name="fn" value="" class="form-control" placeholder="Phone" aria-describedby="basic-addon1">
            </div>
             <div class="form-group">
              <input id="emailAddress" class="form-control" maxlength="128" type="text" name="em"  value="" placeholder="Email" aria-describedby="basic-addon1">
               <span class="asterix">*</span>
              <span class="cross"><i class="ion-ios-close-empty"></i></span>
              <div class="alert alert-danger custom-alert">
                Please enter Email Address
              </div>
               <div id="email_required" class="alert alert-danger custom-alert" style="display:none">
                Enter Valid Email Address: name@email.com
              </div>
               </div>

        </div>

       <!-- Col 3 -->

        <div class="col-xs-12 col-md-4 col-lg-4 col-sm-4">
          <h4>More Information</h4>
          <a class="btn btn-default btn-select">
             <input type="hidden" class="btn-select-input" id="" name="" value="" />
             <span class="btn-select-value">How did you hear about us?</span>
             <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
             <ul>
                 <li>Used Xpressdocs before</li>
                 <li>My Company Promotes Xpressdocs</li>
                 <li>Referred By Friend/Colleague</li>
                 <li>Internet Search</li>
                 <li>Other</li>
             </ul>
         </a>
         <!--
            <h4>Security Questions</h4>
          <a class="btn btn-default btn-select">
                <input type="hidden" class="btn-select-input" id="" name="" value="" />
                <span class="btn-select-value">-Select-</span>
                <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                <ul>
                    <li>In what city was your first job located?</li>
                    <li>What is the first name of your mother's mother?</li>
                    <li>What was your high school mascot?</li>
                    <li>In what city were you born?</li>
                    <li>What was the name of your first pet?</li>
                    <li>What is your father's middle name?</li>
                    <li>What is your mother's maiden name?</li>
                    <li>In what city did you attend elementary school?</li>
                    <li>What is the first name of your childhood best friend?</li>
                    <li>What is the name of your company?</li>
                    <li>In what city is your primary office?</li>
                    <li>What is your primary industry?</li>
                </ul>
            </a>
            <div class="form-group">
              <input id="question1" maxlength="70" type="text" name="fn" value="" class="form-control" placeholder="Security Question #1 Answer" aria-describedby="basic-addon1">
            </div>
            <a class="btn btn-default btn-select">
                <input type="hidden" class="btn-select-input" id="" name="" value="" />
                <span class="btn-select-value">-Select-</span>
                <span class='btn-select-arrow glyphicon glyphicon-chevron-down'></span>
                <ul>
                    <li>In what city was your first job located?</li>
                    <li>What is the first name of your mother's mother?</li>
                    <li>What was your high school mascot?</li>
                    <li>In what city were you born?</li>
                    <li>What was the name of your first pet?</li>
                    <li>What is your father's middle name?</li>
                    <li>What is your mother's maiden name?</li>
                    <li>In what city did you attend elementary school?</li>
                    <li>What is the first name of your childhood best friend?</li>
                    <li>What is the name of your company?</li>
                    <li>In what city is your primary office?</li>
                    <li>What is your primary industry?</li>
                </ul>
            </a>
            <div class="form-group">
             <input id="question2" maxlength="70" type="text" name="ln" value=""  class="form-control" placeholder="Security Question #2 Answer" aria-describedby="basic-addon1">
             </div>

        </div> -->
        <div class="row"></div>

        <div class="modal-footer">
          <button id="activate-step-2" class="col-sm-3 col-sm-offset-9 btn btn-primary btn-md">Next</button>
      </div>
    <!-- </div> -->

  </div>

  <!--  Tab 2-->

  <div class="row setup-content well well-sm" id="step-2" style="width: 100%;margin-left: 0%;padding-bottom: 0px;">
    <!-- Info Block -->
    <div class="col-md-12">
      <div class="update-nag">
        <div class="update-split update-xd"><i class="ion-ios-information-outline" style="font-size: 2em"></i></div>
        <div class="update-text">Please select your office from the following list.</div>
      </div>
    </div>
  <!-- End Info Block -->
    <div style="margin-left:2em">
      <div class="radio"><label><input type="radio" name="idb" value="34736TALLA"><strong>Tallahassee #185</strong><br>1520 Killearn Center Blvd. Suite 100<br>Tallahassee, FL 32309</label></div>

        <div class="radio"><label><input type="radio" name="idb" value="a10e341c"><strong>Keller Williams Town and Country</strong><br>1520 Killearn Center Blvd<br>Tallahassee, Florida 32309</label></div>

       <div class="radio"><label><input type="radio" name="idb" value="34736TALLA"><strong>Keller William FL #285</strong><br>1520 Killearn Center Blvd. Suite 100<br>Tallahassee, FL 32309</label></div>
    </div>

    <div class="modal-footer">
          <div class="col-md-3">
      <button id="activate-step-1" class="btn btn-default btn-md btn-block">Back</button>
    </div>
    <div class="col-md-3 col-md-offset-6">
      <button id="activate-step-3" class="btn btn-primary btn-md btn-block">Next</button>
    </div>
      </div>
  </div>


  <!-- Tab 3 content -->

  <div class="row setup-content well well-sm" id="step-3" style="width: 100%;margin-left: 0%;padding-bottom: 0px;">
    <!-- Info Block -->
    <div class="col-md-12">
      <div class="update-nag">
        <div class="update-split update-xd"><i class="ion-ios-glasses-outline" style="font-size: 2em"></i></div>
        <div class="update-text" style="font-size: 0.85em;position: relative;top: -0.5em;line-height: 1.3em;">Please check the information below for accuracy. You will be able to modify these values by clicking on the account tab once logged in. When you have verified this information, please click the "Next" button below.</div>
      </div>
    </div>
  <!-- End Info Block -->
    <div style="margin-left:2em">
     <div id="step3_content"><div class="MSF"><h4>Office Information</h4><p><strong>Keller Williams Town and Country </strong><br>1520 Killearn Center Blvd<br>Tallahassee, Florida 32309</p><h4>Account Information</h4><p>xd@gmail.com<br>XD Testing <br>4324234234</p></div><input type="hidden" id="create_action" value="create_account"></div>
    </div>

    <div class="modal-footer">
          <div class="col-md-3">
      <button id="activate-step-2" class="btn btn-default btn-md btn-block">Back</button>
    </div>
    <div class="col-md-3 col-md-offset-6">
      <button id="activate-step-4" class="btn btn-primary btn-md btn-block">Next</button>
    </div>
      </div>
  </div>


  <!-- Tab 4 content -->

  <div class="row setup-content well well-sm" id="step-4" style="width: 100%;margin-left: 0%;padding-bottom: 0px;">
    <!-- Info Block -->
    <div class="col-md-12">
      <div class="update-nag">
        <div class="update-split update-danger"><i class="ion-ios-checkmark-outline" style="font-size: 2em"></i></div>
        <div class="update-text">Congratulations</div>
      </div>
    </div>
  <!-- End Info Block -->
    <div style="margin-left:2em">

    <h5>You are now ready to start creating on-demand marketing materials! To start you first order, click the "Finish" button below.</h5>

    <div class="MSF">Sign me up for Xpressdocs eNews! &nbsp; <input type="checkbox" name="action" id="action" value="create_account"></div>
    </div>

    <div class="modal-footer">
          <div class="col-md-3">
      <button id="activate-step-1" class="btn btn-default btn-md btn-block">Back</button>
    </div>
    <div class="col-md-3 col-md-offset-6">
      <button id="activate-step-3" class="btn btn-primary btn-md btn-block">Next</button>
    </div>
      </div>
  </div>

<!-- End Container-->
</div>
  <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src='http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js'></script>



    <script  src="js/index.js"></script>




</body>

</html>
