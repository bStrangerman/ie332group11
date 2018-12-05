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
          <h2><strong><span style="color:white">@</style><span style="color:red">Capacity</span></strong></h2>
          <!-- description -->
          <p class="alt-color">Your next great warehouse lease is only a few clicks away!</p>
        </div>
      </div>
      <!-- Promotion -->
      <div class="col-lg-4 col-md-7">

            <a class="twitter-timeline" data-width="300" data-height="300" href="https://twitter.com/Capacity_332?ref_src=twsrc%5Etfw">Tweets by Capacity_332</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></div>
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
          <li><a class="fa fa-facebook" href="https://www.facebook.com/AtCapacity-339587599924715"></a></li>
          <li><a class="fa fa-twitter" href="https://twitter.com/capacity_332"></a></li>
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
<script src="../includes/plugins/jquery/dist/jquery.min.js"></script>
<script src="../includes/plugins/jquery/dist/jquery-ui/jquery-ui.min.js"></script>
<script src="../includes/plugins/tether/js/tether.min.js"></script>
<script src="../includes/plugins/raty/jquery.raty-fa.js"></script>
<script src="../includes/plugins/bootstrap/dist/js/popper.min.js"></script>
<script src="../includes/plugins/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="../includes/plugins/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js"></script>
<script src="../includes/plugins/slick-carousel/slick/slick.min.js"></script>
<script src="../includes/plugins/jquery-nice-select/js/jquery.nice-select.min.js"></script>
<script src="../includes/plugins/fancybox/jquery.fancybox.pack.js"></script>
<script src="../includes/plugins/smoothscroll/SmoothScroll.min.js"></script>
<script src="../includes/js/search.js"></script>


<script>
// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.
  autocomplete = new google.maps.places.Autocomplete(
    /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
    {types: ['geocode']});

    // When the user selects an address from the dropdown, populate the address
    // fields in the form.
    autocomplete.addListener('place_changed', fillInAddress);
  }

  function fillInAddress() {
    // Get the place details from the autocomplete object.
    var place = autocomplete.getPlace();

    for (var component in componentForm) {
      document.getElementById(component).value = '';
      document.getElementById(component).disabled = false;
    }

    // Get each component of the address from the place details
    // and fill the corresponding field on the form.
    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (componentForm[addressType]) {
        var val = place.address_components[i][componentForm[addressType]];
        document.getElementById(addressType).value = val;
      }
    }
  }

  // Bias the autocomplete object to the user's geographical location,
  // as supplied by the browser's 'navigator.geolocation' object.
  function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        var circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      });
    }
  }
  </script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDHEHS1YUJVmKDeZhK1zp-5bWFjK7l7Oi0&libraries=places&callback=initAutocomplete" async defer></script>
  <script src="../includes/dateCheck.js"></script>



</body>

</html>
