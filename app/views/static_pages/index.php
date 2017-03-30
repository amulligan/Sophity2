<?php
  if (array_key_exists('check_submit', $_POST)) {
     echo "<!DOCTYPE html><html lang='en'>";
     echo "
       <head>
           <meta charset='utf-8'>
           <meta http-equiv='X-UA-Compatible' content='IE=edge'>
           <meta name='viewport' content='width=device-width, initial-scale=1'>
           <meta name='description' content=''>
           <meta name='author' content='Sam Nolting, SLN'>

           <title>Sophity Health Check</title>
           <link rel='shortcut icon' type='image/x-icon' href='img/Sophity.png'>

           <link href='css/normalize.css' rel='stylesheet'>
           <link href='css/style.css' rel='stylesheet'>
           <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet'>
           <link href='https://fonts.googleapis.com/css?family=Poppins' rel='stylesheet'>

           <script src='./js/smoothscroll.js' type='text/javascript'></script>
           <script src='bundle.js' type='text/javascript'></script>

       </head>
     ";

     echo "<body>";
       require "html/sophity-top-bar.php";
       $uuid = uniqid('#', true);
       echo "<section class='uinfo'><div class='gone hidden' id='hc-user-email'>{$_POST['email']}</div>";
       echo "<div class='gone hidden' id='hc-session-id'>" . $uuid . "</div></section>";
       require "html/survey-results.php";
       require "html/survey-questions.php";
     echo "</body>";
     echo "</html>";
  } else {
    header("Location: http://sophity.com");
  }
?>
