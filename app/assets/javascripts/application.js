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



$('a[data-popup]').on('click', function(e) { window.open($(this).attr('href')); e.preventDefault(); });

$(document).ready(function() {
  $("input[type=radio]").change(function() {
      var total = 0;
      var questionsAnswered = 0;
      $("input[type=radio]:checked").each(function() {
          total += parseFloat($(this).val());
          questionsAnswered += 1;
      });

      var perc = questionsAnswered *2.22;
     if (perc < 15) {
         $("#hc-question-section .hc-progress-bar").css('background', 'red');
     } else if (perc < 30) {
         $("#hc-progress-bar").css('background', 'orange');
     } else if (perc < 60) {
         $("#hc-progress-bar").css('background', 'yellow');
     } else {
         $("#hc-progress-bar").css('background', 'lime');
     }

      $("#progress").css("width", perc + "%");
      $("#progressRate").text(questionsAnswered + " of 45  (" + perc + "% completed)");
      
      //document.getElementById('progressRate').innerHTML = questionsAnswered "of 45 (" questionsAnswered/45 "%)";
  });
});



