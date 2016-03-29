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
<title>#EventName#</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<cfoutput><link rel="stylesheet" href="css/template-01.css?v=#cachebuster#"></cfoutput>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<cfoutput><script src="js/combined.js?v=#cachebuster#"></script></cfoutput>
<script src="../js/plugins/ckeditor/ckeditor.js"></script>

<cfoutput><script src="js/main.js?v=#cachebuster#"></script></cfoutput>
</head>
<body>
    <div id="footer-position">
        <!--- Begin Header --->
        <div id="header">
            <div class="content cf">
                <img src="//placehold.it/250x120" alt="" id="logo">
                <ul id="navigation">
                    <li><a href="sub-page.cfm">Registration</a></li>
                    <li><a href="sub-page.cfm" class='active'>Link 1</a></li>
                    <li><a href="sub-page.cfm">Link 2</a></li>
                    <li><a href="sub-page.cfm">Link 3</a></li>
                    <li><a href="sub-page.cfm">Long Link Lorem Ipsum Delor</a></li>
                    <li><a href="sub-page.cfm">Link 5</a></li>
                </ul>
            </div>
        </div>
        <!--- End Header --->

        

        <!--- Start bottom wrap for background --->
        <div id="subpage-content">
            <div class="content">
                <h1>Page Name</h1>
                <h2>Page Description Lorem ipsum dolor sit amet, consectetur adipisicing elit.</h2>

                <div id="wysiwyg-content">
                    <p>Embedded wysiwyg content</p>
                </div>
            </div>   
        </div>
        <!--- End bottom wrap for background --->

        <!--- Begin Footer --->
        <div id="footer">
            <div class="content">  
                <p class="copyright">&copy; #YEAR# #ConferenceName#</p>
            </div>
        </div>
        <!--- End Footer --->
    </div>
    <!--- end footer position --->

</body>
</html>


    