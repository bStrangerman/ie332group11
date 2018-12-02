$(function () {
		var regularError  = true,
			EmailError = true,
      passwordError = true;

$(".xd-required").blur(function() {
	if($(this).val() === '') {
		requiredError(this);
		regularError = true;
	} else{
    removeRequiredErr(this);
		regularError = false;
	}
});

$("#emailAddress").blur(function() {
  if($(this).val() === '') {
		requiredError(this);
    $('#email_required').hide();
		EmailError = true;
	} else if (!validateEmail(document.getElementById('emailAddress').value )) {
    removeRequiredErr(this);
    EmailError = true;
    showValidEmail()
  } else{
    removeRequiredErr(this);
		EmailError = false;
    $("[id^=activate-step-]").prop("disabled", false);
	}
});

  $("#password").blur(function() {
      var pwd = $(this).val();
      var passwordLength = $(this).val().length;
    if($(this).val() === '') {
      requiredError(this);
      $('#appendDiv').fadeOut(300);
      passwordError = true;
    } else if ( passwordLength < 8 && passwordError === true) {
      addError(this);
      $('#appendDiv').fadeIn(300);
      passwordError = true;
    }
    else if ( !(/([a-zA-Z]+)/.test(document.getElementById('password').value ) ) && passwordError === false ) {
      $('#appendDiv').after('<div id="requiredChar" class="alert alert-warning marginTopSmall">Password must include at least one character!</div>')
      passwordError = true;
    }
    else if (passwordLength > 8 ) {
      $('#appendDiv').fadeOut(300);
      removeRequiredErr(this);
       passwordError = false;
    }
      else{
      removeRequiredErr(this);
      $('#requiredChar').fadeOut(300);
      EmailError = false;
    }
  });

  $("#passwordreentry").blur(function() {
	if($(this).val() === "" ) {
		requiredError(this);
		regularError = true;
	} else if($(this).val() != $("#password").val() && $(this).val() != "") {
		addError(this);
    $('#appendDiv1').fadeIn(300);
    regularError = true;
	} else{
    removeRequiredErr(this);
    $('#appendDiv1').fadeOut(300);
		regularError = false;
	}
});

  // Default disabled Next Button
  $("[id^=activate-step-]").prop("disabled", "disabled");

  // Validation on click Next btn

  $('button').on('click', function(e) {
    if(regularError === true || EmailError === true || !validateEmail() ) {
      e.preventDefault(); // prevent sending
      $('.xd-required, #emailAddress').blur();
      $("#activate-step-2").prop("disabled", "disabled");
    }
    else {
      console.log("You are good");
    }
  });

  function requiredError(self) {
    $(self).css('border','1px solid #F00');
    $(self).parent().find('.custom-alert').fadeIn(300).end().find('.asterix').fadeOut(300).end().find('span.cross').fadeIn(300).end().find('span.verify').fadeOut(300);
}

  function addError(self) {
    $(self).css('border','1px solid #F00');
  $(self).parent().find('.asterix').fadeOut(300).end().find('span.cross').fadeIn(300).end().find('span.verify').fadeOut(300);
}

  function removeRequiredErr(self) {
    $(self).css('border','1px solid #080');
		$(self).parent().find('.custom-alert').fadeOut(300).end().find('.asterix').fadeOut(300).end().find('span.verify').fadeIn(300).end().find('span.cross').fadeOut(300);
  }

 function validateEmail(email) {
        var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        return re.test(email);
    }

  function validatePass(pass) {
    var re = "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
    return re.test(pass);
  }

  function showValidEmail() {
    $('#email_required').show();
    EmailError = true;
  }

});

// Custom Steps

$(document).ready(function() {

    var navListItems = $('ul.setup-panel li a'),
        allWells = $('.setup-content');

    allWells.hide();

    navListItems.click(function(e)
    {
        e.preventDefault();
        var $target = $($(this).attr('href')),
            $item = $(this).closest('li');

        if (!$item.hasClass('disabled')) {
            navListItems.closest('li').removeClass('active');
            $item.addClass('active');
            allWells.hide();
            $target.show();
        }
    });

    $('ul.setup-panel li.active a').trigger('click');

    // DEMO ONLY //
    $('#activate-step-2').on('click', function(e) {
      if($('#firstname').val() == "") {
        console.log("Required fields!");
      } else {
        $('ul.setup-panel li:eq(1)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-2"]').trigger('click');
     }
    })

    $('#activate-step-3').on('click', function(e) {
        $('ul.setup-panel li:eq(2)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-3"]').trigger('click');
    })

    $('#activate-step-4').on('click', function(e) {
        $('ul.setup-panel li:eq(3)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-4"]').trigger('click');
    })

    $('#activate-step-3').on('click', function(e) {
        $('ul.setup-panel li:eq(2)').removeClass('disabled');
        $('ul.setup-panel li a[href="#step-3"]').trigger('click');
        //$(this).remove();
    })

    // Select - Using for Demo right now.
    $(".btn-select").each(function (e) {
      var value = $(this).find("ul li.selected").html();
      if (value != undefined) {
        $(this).find(".btn-select-input").val(value);
        $(this).find(".btn-select-value").html(value);
      }
    });

    $(".icon-show-pass").click(function() {
      var pass_val = $("#password");
      var pass_type = $("#password").attr("type");
      if (pass_type === "password") {
        pass_val.attr("type", "text");
        $(this).removeClass("ion-eye").addClass("ion-eye-disabled move-right");
      }
      else {
        pass_val.attr("type", "password");
        $(this).removeClass("ion-eye-disabled").addClass("ion-eye move-right");
      }
    });

});


$(document).on('click', '.btn-select', function (e) {
    e.preventDefault();
    var ul = $(this).find("ul");
    if ($(this).hasClass("active")) {
        if (ul.find("li").is(e.target)) {
            var target = $(e.target);
            target.addClass("selected").siblings().removeClass("selected");
            var value = target.html();
            $(this).find(".btn-select-input").val(value);
            $(this).find(".btn-select-value").html(value);
        }
        ul.hide();
        $(this).removeClass("active");
    }
    else {
        $('.btn-select').not(this).each(function () {
            $(this).removeClass("active").find("ul").hide();
        });
        ul.slideDown(300);
        $(this).addClass("active");
    }
});

$(document).on('click', function (e) {
    var target = $(e.target).closest(".btn-select");
    if (!target.length) {
        $(".btn-select").removeClass("active").find("ul").hide();
    }
});

// Format Phone number - Short way - Trying to write Vanilla JS
document.getElementById('phone').addEventListener('input', function (e) {
  var x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
  e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
});
