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
  console.log($('[type="radio"]'));
  // $('[type="radio"]').each(function(el) { //[name|="survey_attempt[answers_attributes]"]
  //   alert(el.closest('hc-question-group').find('hc-question-number').innerHTML + " = " + el.val());
  // });
  return false;
};

$(document).ready(function() {
  $('.hc-button-next').on('click', function(ev) {
    if (validateAnswers()) {
      $('form#new_survey_attempt').submit();
      return true;
    }
    return false;
  });
});
  // var names = {};
  // $(':radio').each(function() {
  //     names[$(this).attr('name')] = true;
  // });
  // var count = 0;
  // $.each(names, function() {
  //     count++;
  // });
  // if ($(':radio:checked').length != count) {
  //   $(':radio').each(function(el) {
  //     if (!el.is(':checked')) {
  //       el.parent().parent().addClass("warning");
  //     }
  //   });
  //   return false;
  // }
