// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .



// $('a[data-popup]').on('click', function(e) { window.open($(this).attr('href')); e.preventDefault(); });

// $(document).ready(function() {
//   $("input[type=radio]").change(function() {
//       var total = 0;
//       var questionsAnswered = 0;
//       $("input[type=radio]:checked").each(function() {
//           total += parseFloat($(this).val());
//           questionsAnswered += 1;
//       });
//       var totalNo = $("#survey_qc").val();
//       var perc = questionsAnswered *100/totalNo;
//      if (perc < 15) {
//          $("#hc-question-section .hc-progress-bar").css('background', 'red');
//      } else if (perc < 30) {
//          $("#hc-question-section .hc-progress-bar").css('background', 'orange');
//      } else if (perc < 60) {
//          $("#hc-question-section .hc-progress-bar").css('background', 'yellow');
//      } else {
//          $("#hc-question-section .hc-progress-bar").css('background', 'lime');
//      }
//
//       $("#progress").css("width", perc + "%");
//       $("#progressRate").text(questionsAnswered + " of " + totalNo + " (" + perc.toFixed(2) + "% completed)");
//       $("#score").val(total/totalNo);
//
//   });

var validateAnswers = function () {
  var names = {};
  var radios = $('#new_survey_attempt [type="radio"]');
  var checkedRadios = $('#new_survey_attempt [type="radio"]:checked');

  radios.each(function () {
    if (!($(this).attr('name') in names)) {
      names[$(this).attr('name')] = 0;
    }
    names[$(this).attr('name')] += $(this).prop('checked') ? 1 : 0;
  });

  if (checkedRadios.length !== Object.keys(names).length) {
    $.each(names, function (key, val) {
      if (val == 0) {
        $('#new_survey_attempt [type="radio"][name="' + key + '"]').closest('.hc-question-group').find('.hc-question-number').addClass('warning');
      } else {
        $('#new_survey_attempt [type="radio"][name="' + key + '"]').closest('.hc-question-group').find('.hc-question-number').removeClass('warning');
      }
    });
    return false;
  }

  return true;
};

$(document).ready(function() {
  $('.hc-button-next').on('click', function(ev) {
    if (validateAnswers()) {
      $('form#new_survey_attempt').submit();
      return true;
    }
    return false;
  });

  $('#hc-report-button').on('click', function(ev) {
    $('.hc-report-response').removeClass('collapsed');
  });
});
