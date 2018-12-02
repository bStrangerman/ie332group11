// The below code was found on https://codepen.io/Gibbu/pen/mxGKjP and modified

// jQuery
$(function() {

	// Switch to Forgot Password
	$('.forgotBtn').click(function() {
		$('#forgot').toggleClass('toggle');
	});

	// Switch to Register
	$('.registerBtn').click(function() {
		$('#register, #form').toggleClass('toggle');
	});


});
