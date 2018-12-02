<?php
require_once "../includes/main.php";
// print the header
require_once "../layouts/Calssimax/header.php";

if(isset($_POST['email'])) {

  // EDIT THE 2 LINES BELOW AS REQUIRED
  $email_to = "mventres+ie332.fall2018.group11@purdue.edu";
  $email_subject = "@Capacity CONFIRMATION: Contact Form";

  function died($error) {
    // your error code can go here
    echo "We are very sorry, but there were error(s) found with the form you submitted. ";
    echo "These errors appear below.<br /><br />";
    echo $error."<br /><br />";
    echo "Please go back and fix these errors.<br /><br />";
    die();
  }


  // validation expected data exists
  if(!isset($_POST['first_name']) ||
  !isset($_POST['last_name']) ||
  !isset($_POST['email']) ||
  !isset($_POST['telephone']) ||
  !isset($_POST['comments'])) {
    died('We are sorry, but there appears to be a problem with the form you submitted.');
  }

  $first_name = $_POST['first_name']; // required
  $last_name = $_POST['last_name']; // required
  $email_from = $_POST['email']; // required
  $telephone = $_POST['telephone']; // not required
  $comments = $_POST['comments']; // required

  $error_message = "";
  $email_exp = '/^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/';

  if(!preg_match($email_exp,$email_from)) {
    $error_message .= 'The Email Address you entered does not appear to be valid.<br />';
  }

  $string_exp = "/^[A-Za-z .'-]+$/";

  if(!preg_match($string_exp,$first_name)) {
    $error_message .= 'The First Name you entered does not appear to be valid.<br />';
  }

  if(!preg_match($string_exp,$last_name)) {
    $error_message .= 'The Last Name you entered does not appear to be valid.<br />';
  }

  if(strlen($comments) < 2) {
    $error_message .= 'The Comments you entered do not appear to be valid.<br />';
  }

  if(strlen($error_message) > 0) {
    died($error_message);
  }

  $email_message = "Form details below.\n\n";


  function clean_string($string) {
    $bad = array("content-type","bcc:","to:","cc:","href");
    return str_replace($bad,"",$string);
  }


  $email_message .= "First Name: ".clean_string($first_name)."\n";
  $email_message .= "Last Name: ".clean_string($last_name)."\n";
  $email_message .= "Email: ".clean_string($email_from)."\n";
  $email_message .= "Telephone: ".clean_string($telephone)."\n";
  $email_message .= "Comments: ".clean_string($comments)."\n";

  // create email headers
  $headers = 'From: '.$email_from."\r\n".
  'Reply-To: '.$email_from."\r\n" .
  'X-Mailer: PHP/' . phpversion();
  if(mail($email_to, $email_subject, $email_message, $headers) != FALSE && mail($email_from, $email_subject, "Thank you for reaching out to @Capacity. We are happy to assist you in any way and will be in contact shortly. Have a great day and remember, you can always store more.", $headers) != FALSE){
    $sent = TRUE;
  }

}
?>


<!--==================================
=   Contact form from http://www.freecontactform.com/email_form.php           =
===================================-->
<section class="dashboard section">
  <!-- Container Start -->
  <div class="container">
    <!-- Row Start -->
    <div class="row">
      <div class="col-md-12">
        <h3 style="color:green"><?php echo (!isset($sent)) ? $error_message : "Your message has been sent.  Thank you for contacting us." ?> </h3>
        <div class="widget personal-info">
          <h3 class="widget-header user">Contact Us</h3>
          <form name="contactform" method="POST">
          <div class="form-group">
            <label for="first-name">First Name *</label>
            <input required type="text"  name="first_name" maxlength="50" size="30" class="form-control" id="first-name" value="<?php echo $LesseeInfo[0]['FirstName']; ?>">
          </div>
          <!-- Last Name -->
          <div class="form-group">
            <label for="last-name">Last Name *</label>
            <input required type="text"  name="last_name" maxlength="50" size="30" class="form-control" id="last-name" value="<?php echo $LesseeInfo[0]['LastName']; ?>">
          </div>
          <!-- Company -->
          <div class="form-group">
            <label for="Company">Company</label>
            <input type="text"  name="company" maxlength="80" size="30" class="form-control" id="Company" value="<?php echo $LesseeInfo[0]['Company']; ?>">
          </div>
          <!-- Phone Number -->
          <div class="form-group">
            <label for="PhoneNumber">Phone Number</label>
            <input type="num" name="telephone" maxlength="30" size="30" class="form-control" id="PhoneNumber" value="<?php echo $LesseeInfo[0]['PhoneNumber']; ?>">
          </div>
          <!-- Email -->
          <div class="form-group">
            <label for="Email">Email *</label>
            <input required type="email" name="email" class="form-control" id="Email" value="<?php echo $LesseeInfo[0]['Email']; ?>">
          </div>
          <label for="comments">Comments *</label>
          <div class="form-group">
            <textarea required name="comments" maxlength="1000" cols="75" rows="6"></textarea>
          </div>
          <!-- Submit button -->
          <button class="btn btn-transparent">Submit</button>
        </form>
      </div>
    </div>
  </div>
  <!-- Row End -->
</div>
<!-- Container End -->
</section>
<!--============================
=            Footer            =
=============================-->

<footer class="footer section section-sm">
  <!-- Container Start -->
  <div class="container">
    <div class="row">
      <div class="col-lg-3 col-md-7 offset-md-1 offset-lg-0">
        <!-- About -->
        <div class="block about">
          <!-- footer logo -->
          <img src="images/logo-footer.png" alt="">
          <!-- description -->
          <p class="alt-color">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        </div>
      </div>
      <!-- Link list -->
      <div class="col-lg-2 offset-lg-1 col-md-3">
        <div class="block">
          <h4>Site Pages</h4>
          <ul>
            <li><a href="#">Boston</a></li>
            <li><a href="#">How It works</a></li>
            <li><a href="#">Deals & Coupons</a></li>
            <li><a href="#">Articls & Tips</a></li>
            <li><a href="#">Terms of Services</a></li>
          </ul>
        </div>
      </div>
      <!-- Link list -->
      <div class="col-lg-2 col-md-3 offset-md-1 offset-lg-0">
        <div class="block">
          <h4>Admin Pages</h4>
          <ul>
            <li><a href="#">Boston</a></li>
            <li><a href="#">How It works</a></li>
            <li><a href="#">Deals & Coupons</a></li>
            <li><a href="#">Articls & Tips</a></li>
            <li><a href="#">Terms of Services</a></li>
          </ul>
        </div>
      </div>
      <!-- Promotion -->
      <div class="col-lg-4 col-md-7">
        <!-- App promotion -->
        <div class="block-2 app-promotion">
          <a href="">
            <!-- Icon -->
            <img src="images/footer/phone-icon.png" alt="mobile-icon">
          </a>
          <p>Get the Dealsy Mobile App and Save more</p>
        </div>
      </div>
    </div>
  </div>
  <!-- Container End -->
</footer>
<!-- Footer Bottom -->
<footer class="footer-bottom">
  <!-- Container Start -->
  <div class="container">
    <div class="row">
      <div class="col-sm-6 col-12">
        <!-- Copyright -->
        <div class="copyright">
          <p>Copyright © 2016. All Rights Reserved</p>
        </div>
      </div>
      <div class="col-sm-6 col-12">
        <!-- Social Icons -->
        <ul class="social-media-icons text-right">
          <li><a class="fa fa-facebook" href=""></a></li>
          <li><a class="fa fa-twitter" href=""></a></li>
          <li><a class="fa fa-pinterest-p" href=""></a></li>
          <li><a class="fa fa-vimeo" href=""></a></li>
        </ul>
      </div>
    </div>
  </div>
  <!-- Container End -->
  <!-- To Top -->
  <div class="top-to">
    <a id="top" class="" href=""><i class="fa fa-angle-up"></i></a>
  </div>
</footer>

<!-- JAVASCRIPTS -->
<script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="plugins/tether/js/tether.min.js"></script>
<script src="plugins/raty/jquery.raty-fa.js"></script>
<script src="plugins/bootstrap/dist/js/popper.min.js"></script>
<script src="plugins/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="plugins/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js"></script>
<script src="plugins/slick-carousel/slick/slick.min.js"></script>
<script src="plugins/jquery-nice-select/js/jquery.nice-select.min.js"></script>
<script src="plugins/fancybox/jquery.fancybox.pack.js"></script>
<script src="plugins/smoothscroll/SmoothScroll.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCC72vZw-6tGqFyRhhg5CkF2fqfILn2Tsw"></script>
<script src="js/scripts.js"></script>

</body>

</html>
