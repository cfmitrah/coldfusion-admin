<cfscript>
    application.timestamp = now();
    cachebuster = dateFormat(application.timestamp,"mmddyyyy") & timeFormat(application.timestamp,"hhmmss");
</cfscript>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Meetingplay Registration</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <!--- Bootstrap Datatables --->
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/plug-ins/be7019ee387/integration/bootstrap/3/dataTables.bootstrap.css">
    <link rel="stylesheet" href="css/date-timepicker.css">
    <link rel="stylesheet" href="css/colorpicker/colorpicker.css">
    <cfoutput><link rel="stylesheet" href="css/main.css?v=#cachebuster#"></cfoutput>
    
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <cfoutput><script src="js/combined.js?v=#cachebuster#"></script></cfoutput>
    <script src="js/plugins/ckeditor/ckeditor.js"></script>
    <script src="js/plugins/colorpicker/colorpicker.js"></script>


    <script src="js/main.js"></script>
  </head>
  <body>
    
    