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
    $err = "We are very sorry, but there were error(s) found with the form you submitted. ";
    $err .= "These errors appear below.<br />";
    $err .= $error."<br /><br />";
    $err .= "Please go back and fix these errors.<br /><br />";
    return $err;
  }


  // validation expected data exists
  if(!isset($_POST['first_name']) ||
  !isset($_POST['last_name']) ||
  !isset($_POST['email']) ||
  !isset($_POST['telephone']) ||
  !isset($_POST['comments'])) {
    $error_message = died('We are sorry, but there appears to be a problem with the form you submitted.');
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
    $error_message = died($error_message);
  }

  $email_message = "Form details below.\n\n";


  function clean_string($string) {
    $bad = array("content-type","bcc:","to:","cc:","href");
    return str_replace($bad,"",$string);
  }

$message = "";
  $email_message .= "First Name: ".clean_string($first_name)."\n";
  $email_message .= "Last Name: ".clean_string($last_name)."\n";
  $email_message .= "Email: ".clean_string($email_from)."\n";
  $email_message .= "Telephone: ".clean_string($telephone)."\n";
  $email_message .= "Comments: ".clean_string($comments)."\n";

  if(isset($_POST['g-recaptcha-response']))
    $captcha=$_POST['g-recaptcha-response'];

  if(!$captcha){
    $message = 'Please check the the captcha form.';
  }
  $response=json_decode(file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=6LcUDX8UAAAAAHXHHjeNUcrsldiZza1oF0PCcbwc&response=".$captcha."&remoteip=".$_SERVER['REMOTE_ADDR']), true);
  if($response['success'] == false)
  {
    $message = 'You are a robot. Please leave.';
  }
  else
  {
    // create email headers
    $headers = 'From: '.$email_from."\r\n".
    'Reply-To: '.$email_from."\r\n" .
    'X-Mailer: PHP/' . phpversion();
    if(mail($email_to, $email_subject, $email_message, $headers) != FALSE && mail($email_from, $email_subject, "Thank you for reaching out to @Capacity. We are happy to assist you in any way and will be in contact shortly. Have a great day and remember, you can always store more.", $headers) != FALSE){
      $sent = TRUE;
    }
    $message = 'Your message has been sent.  Thank you for contacting us.';
  }


}
?>

<script src='https://www.google.com/recaptcha/api.js'></script>
<!--==================================
=   Contact form from http://www.freecontactform.com/email_form.php           =
===================================-->
<section class="dashboard section">
  <!-- Container Start -->
  <div class="container">
    <!-- Row Start -->
    <div class="row">
      <div class="col-md-12">
        <h3 style="<?php echo (isset($sent) ? (isset($error_message) ? "color:green" : (isset($message) ? "color:red" : "")) : "")?>"><?php echo (!isset($sent)) ? $error_message : $message ?> </h3>
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
            <div class="g-recaptcha" data-sitekey="6LcUDX8UAAAAAGE2oKBE1tNnsuSANpdtPRFSyDir"></div>
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
<?php include_once "../layouts/Calssimax/footer.php"; ?>
