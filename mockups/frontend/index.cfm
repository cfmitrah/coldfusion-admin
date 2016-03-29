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
    <!--- Begin Header --->
    <div id="header">
        <div class="content cf">
            <img src="//placehold.it/250x120" alt="" id="logo">
            <ul id="navigation">
                <li><a href="sub-page.cfm" class='active'>Registration</a></li>
                <li><a href="sub-page.cfm">Link 1</a></li>
                <li><a href="sub-page.cfm">Link 2</a></li>
                <li><a href="sub-page.cfm">Link 3</a></li>
                <li><a href="sub-page.cfm">Long Link Lorem Ipsum Delor</a></li>
                <li><a href="sub-page.cfm">Link 5</a></li>
            </ul>
        </div>
    </div>
    <!--- End Header --->

    <!--- Begin Hero Image  --->
    <div id="hero-image">
        <div class="content">
            <div id="hero-container" class="relative">
                <img src="//placehold.it/1000x300" alt="">
                <div>
                    #ConferenceName# Registration
                </div>
            </div>
        </div>
    </div>
    <!--- End Hero Image --->

    <!--- Start bottom wrap for background --->
    <div id="bottom-wrap">
        <!--- Begin Event Details --->
        <div id="event-details">
            <div class="content">
                <p class="relative"><span class="glyphicon glyphicon-map-marker"></span> #ConferenceLocation#</p>
                <p class="relative"><span class="glyphicon glyphicon-time"></span> #ConferenceDatesAndTimes#</p>
            </div>
        </div>
        <!--- End Event Details --->

        <!--- Begin Event Description --->
        <div id="event-description">
            <div class="content">
                <div id="overflow-wrap">
                    <p><strong>This area will be populated by a WYSIWYG Text Editor.</strong> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Est sapiente velit, assumenda inventore odit excepturi ipsum aliquam! Nulla dolor, facilis sed veritatis maxime impedit quaerat libero. Eum repudiandae corrupti esse. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore libero odit provident saepe unde quasi laboriosam explicabo ut quas, dicta, enim quia architecto aspernatur, amet eaque ullam. Tenetur, sed, accusamus.</p>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Adipisci alias eius, corporis maxime ea atque perferendis excepturi est fugiat sint et reprehenderit consectetur ipsa molestias voluptatibus consequuntur accusantium sit. Voluptate.</p>
                    <p>
                        <span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore iure deleniti iste harum, nobis nesciunt aliquid temporibus aspernatur corrupti est. Non fugiat illum ullam rem harum tempore neque, magni architecto.</span>
                        <span>Non natus est officia dolor, obcaecati autem odio molestias assumenda. Minus quae, ducimus aut reprehenderit commodi voluptatum, quis nulla autem ea dolorum ullam debitis dolorem sapiente soluta velit exercitationem ipsum!</span>
                        <span>A, necessitatibus, laboriosam, aut, provident pariatur nisi repellat ipsa quos eum expedita hic eveniet minus! Nam veniam eveniet, sequi saepe voluptatem minima ex obcaecati odio possimus, delectus quas dolorem, velit.</span>
                        <span>Mollitia deleniti odio quasi consectetur recusandae libero necessitatibus eaque vel doloremque labore? Voluptatum expedita dicta quas iure, suscipit nam error porro assumenda ducimus commodi voluptas, accusamus voluptate enim debitis quae.</span>
                    </p>
                </div>
                <div>
                    <a href="##" id="expand-reading" class="btn btn-default btn-sm">Continue Reading</a>
                </div>
            </div>
        </div>
        <!--- End Event Description --->

        <!--- Begin Form Steps --->
        <div id="form-steps">
            <div class="content">
                <div id="form-wrap" class="relative">
                    <div id="form-navigation" class="cf">
                        <!--- Navigation links will need a step-nav-NUMBER class --->
                        <!--- The first step needs a class of visited --->
                        <a href="#" class='active step-nav-1 visited' data-go-to-step="1">1</a>
                        <a href="#" class='step-nav-2' data-go-to-step="2">2</a>
                        <a href="#" class='step-nav-3' data-go-to-step="3">3</a>
                        <a href="#" class='step-nav-4' data-go-to-step="4">4</a>
                        <a href="#" class='step-nav-5' data-go-to-step="5">5</a>
                    </div>
                    <form id="registration-form" data-parsley-validate>
                     <!--- Begin Form Step One --->
                     <!--- Form Sections will need a class and ID of step-NUMBER  The first Section get's class of show --->
                    <div id="step-1" class="step step-1 show">
                        <h3>Begin Registration</h3>

                        <div class="container-fluid">
                            <div class="row">
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="" class="required">First Name</label>
                                    <input type="text" class="form-control" required data-parsley-group="step-1">
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="" class="required">Last Name</label>
                                    <input type="text" class="form-control" required data-parsley-group="step-1">
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="" class="required">Email Address</label>
                                    <input type="email" class="form-control" required data-parsley-group="step-1">
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="" class="required">Attendee Type</label>
                                    <select name="" id="" class="form-control" required data-parsley-group="step-1">
                                        <option value="">Choose Your Type</option>
                                        <option value="1">Standard Attendee</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-large">
                                <div class="col-md-12">
                                    <a href="##" class="btn btn-lg btn-success next pull-right" data-current-step="1" data-next-step="2">Next Step</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--- End form step One --->


                    <!--- Begin Form Step Two --->
                    
                    <div id="step-2" class="step step-2 hide">
                        <h3>Step Two Name</h3>
                        <div class="well">
                            <p><em>This is some brief optional copy that could be added to the current step. Will need to add an area in admin registration processes area to accomodate for this. Will likely be a new field when creating registration sections.</em></p>
                        </div>
                        <!--- Sample Step 1 Has a 2 Column layout with fields appearing side by side --->
                        <div class="container-fluid">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <!--- Add a class of required to the labels which relate to required inputs --->
                                    <label for="" class="required">Text Input</label>
                                    <!--- Required Fields should get a data-parsley-group attribute in relation to the step it's contained in --->
                                    <input type="text" class="form-control" required data-parsley-group="step-2">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Email Input</label>
                                    <input type="email" class="form-control">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Number Input</label>
                                    <input type="number" class="form-control">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Telephone Input</label>
                                    <input type="tel" class="form-control">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Radio Input</label>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                            Sample Radio One
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                            This Radio Option is a little bit longer than the others
                                        </label>
                                    </div>
                                    <div class="radio disabled">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios3" value="option3" disabled>
                                            Option 3 is disabled to show you what that might look like
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Checkbox Input</label>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="optionsCheckbox" id="optionsCheckbox1" value="option1" checked>
                                            Sample Checkbox One
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="optionsCheckbox" id="optionsCheckbox2" value="option2">
                                            This Checkbox Option is a little bit longer than the others
                                        </label>
                                    </div>
                                    <div class="checkbox disabled">
                                        <label>
                                            <input type="checkbox" name="optionsCheckbox" id="optionsCheckbox3" value="option3" disabled>
                                            Option 3 is disabled to show you what that might look like
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Textarea Input</label>
                                    <textarea name="" id="" rows="4" class="form-control"></textarea>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">WYSIWYG Input</label>
                                    <textarea name="speaker-bio-text" id="speaker-bio-text" rows="4"></textarea>
                                    <script>
                                        CKEDITOR.replace( 'speaker-bio-text' );
                                    </script>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Date Input</label>
                                    <input type="text" class="form-control dateonly-datetime">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Time Input</label>
                                    <input type="text" class="form-control timeonly-datetime">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Date and Time Input</label>
                                    <input type="text" class="form-control std-datetime">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="">Select Input</label>
                                    <select name="" id="" class="form-control">
                                        <option value="">Choose Value...</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-large">
                                <div class="col-md-12">
                                    <!--- Next Buttons Have Data Attributes to Determine Current / Next Step --->
                                    <a href="##" class="btn btn-lg btn-success pull-right next" data-current-step="2" data-next-step="3">Next Step</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--- End form step Two --->

                    <!--- Begin Form Step Three --->
                    <div id="step-3" class="step step-3 hide">
                        <h3>Step Three Name</h3>

                        <!--- Sample Step 2 Has a 1 Column layout--->
                        <div class="container-fluid">
                            <div class="row">
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="">Text Input</label>
                                    <input type="text" class="form-control">
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="">Email Input</label>
                                    <input type="email" class="form-control">
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="">Number Input</label>
                                    <input type="number" class="form-control">
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="">Telephone Input</label>
                                    <input type="tel" class="form-control">
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="">Radio Input</label>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                            Sample Radio One
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                            This Radio Option is a little bit longer than the others
                                        </label>
                                    </div>
                                    <div class="radio disabled">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios3" value="option3" disabled>
                                            Option 3 is disabled to show you what that might look like
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group col-md-6 col-md-offset-3">
                                    <label for="">Select Input</label>
                                    <select name="" id="" class="form-control">
                                        <option value="">Choose Value...</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row mt-large">
                                <div class="col-md-12">
                                    <a href="##" class="btn btn-lg btn-success next pull-right" data-current-step="3" data-next-step="4">Next Step</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--- End form step Three --->

                    <!--- Begin Form Step Four --->
                    <div id="step-4" class="step step-4 hide">
                        <h3>Agenda Overview</h3>
                        <!--- Agenda Display / Selection --->
                        <div class="container-fluid">
                            <div class="alert alert-info"><span class="glyphicon glyphicon-info-sign"></span> &nbsp;For some sessions, extended details are available. To view extended details on a session, click the session name.</div>
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs mt-medium" role="tablist">
                                <li class="active"><a href="#day-1" role="tab" data-toggle="tab">Monday, Aug. 26</a></li>
                                <li><a href="#day-2" role="tab" data-toggle="tab">Tuesday, Aug. 27</a></li>
                                <li><a href="#day-3" role="tab" data-toggle="tab">Wed, Aug. 28</a></li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div class="tab-pane active" id="day-1">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Session Name</th>
                                                <th>Scheduled Time</th>
                                                <th>Associated Fee</th>
                                                <th>Add to Agenda</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><a href="#" data-toggle="modal" data-target="#session-details">This is a sample session name, it is extra and costs money</a></td>
                                                <td>12:00 PM - 1:00 PM</td>
                                                <td>+$50.00</td>
                                                <td class="text-center"><input type="checkbox"></td>
                                            </tr>
                                            <tr>
                                                <td><a href="#" data-toggle="modal" data-target="#session-details">This session is on everybodies agenda by default</a></td>
                                                <td>12:00 PM - 1:00 PM</td>
                                                <td></td>
                                                <td class="text-center"></td>
                                            </tr>
                                            <tr>
                                                <td><a href="#" data-toggle="modal" data-target="#session-details">This session is on everybodies agenda by default</a></td>
                                                <td>12:00 PM - 1:00 PM</td>
                                                <td></td>
                                                <td class="text-center"></td>
                                            </tr>
                                            <tr>
                                                <td><a href="#" data-toggle="modal" data-target="#session-details">This session is optional but doesn't cost extra money</a></td>
                                                <td>12:00 PM - 1:00 PM</td>
                                                <td></td>
                                                <td class="text-center"><input type="checkbox"></td>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                                <div class="tab-pane" id="day-2"><p style="height: 200px; margin-top: 20px;">Day Two Content</p></div>
                                <div class="tab-pane" id="day-3"><p style="height: 200px; margin-top: 20px;">Day Three Content</p></div>
                            </div>
                            
                            <div class="row mt-large">
                                <div class="col-md-12">
                                    <a href="##" class="btn btn-lg btn-success next pull-right" data-current-step="4" data-next-step="5">Next Step</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--- End form step Four --->

                    <!--- Begin Form Step Five --->
                    <div id="step-5" class="step step-5 hide">
                        <h3>Payment Information</h3>
                        <div class="container-fluid">
                            <div class="row">
                                <h4>Cardholder Information</h4>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Name on Card</label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Address Line One</label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Address Line Two</label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">City</label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">State</label>
                                        <select name="" id="" class="form-control">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Zip Code</label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <h4>Discounts and Promo Codes</h4>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Enter Promo Code</label>
                                        <div class="cf">
                                            <input type="text" class="form-control pull-left" style="width: 70%;">
                                            <a href="##" class="btn btn-primary btn-sm pull-right" style="width: 20%;">Apply</a>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="row">
                                <h4>Card Information</h4>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Card Type</label>
                                        <select name="" id="" class="form-control">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Credit Card Number</label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">Expiration</label>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <select name="" id="" class="form-control">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <select name="" id="" class="form-control">
                                                    <option value=""></option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="">CVV Code</label>
                                        <input type="text" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <h4>Review</h4>
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td><strong>Registration Subtotal:</strong></td>
                                            <td>$1000</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Additonal Session Fees:</strong></td>
                                            <td>$0.00</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Discount Applied:</strong></td>
                                            <td>10% Off</td>
                                        </tr>
                                        <tr class="success">
                                            <td><strong>Total</strong></td>
                                            <td><strong>$900.00</strong></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="totalCheckbox" id="totalCheckbox1" value="option1" checked>
                                            I understand my card will be charged the amount of the total listed above
                                        </label>
                                    </div>
                                </div>

                            </div>
                            <div class="row mt-large">
                                <div class="col-md-12">
                                    <input type="submit" value="Complete Registration" class="btn btn-lg btn-success next pull-right">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--- End form step Five --->
                    </form>
                </div>
            </div>
        </div>
        <!--- End Form Steps --->
    </div>
    <!--- End bottom wrap for background --->

    <!--- Begin Footer --->
    <div id="footer">
        <div class="content">  
            <p class="copyright">&copy; #YEAR# #ConferenceName#</p>
        </div>
    </div>
    <!--- End Footer --->

<!-- Modal -->
<div class="modal fade" id="session-details" tabindex="-1" role="dialog" aria-labelledby="staff-manage-label" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="staff-manage-label">Session Overview</h4>
            </div>
            <div class="modal-body">
                <h3>Breakout Session 21: Sample Name</h3>
                <h4>8/26/2014 <span>&nbsp;|&nbsp;</span> 1:00PM - 2:00PM <span>&nbsp;|&nbsp;</span> Location not yet available</h4>
                <h5>This is where the Session Description will appear if it is available</h5>
                <hr>
                <div id="session-description">
                    <p>Session Overview will be entered here. Entered through the WYSIWYG Editor in admin. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur recusandae, cumque, quas iure assumenda ad consectetur vero! Molestiae dignissimos maiores quo, cupiditate. Laudantium beatae, ullam ab quas sint, animi repudiandae.</p>
                    <ul>
                        <li>Sample List Item</li>
                        <li>Another List Item</li>
                        <li>This list was unordered</li>
                    </ul>
                </div>
                <hr>
                <h3>Session Speakers</h3>
                <div class="speaker">
                    <img src="//placehold.it/100x100" alt="">
                    <h4>Speaker Name</h4>
                    <h5>Title <span>&nbsp;|&nbsp;</span> Company</h5>
                    <p><strong>This would be populated by the speaker summary field.</strong> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quisquam perferendis iste reprehenderit fugit eos molestiae dolorem, necessitatibus, explicabo illo molestias, doloribus? Eveniet dolores odio vel ab debitis, cum facere accusamus! Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi atque dicta illo distinctio cupiditate, necessitatibus facilis quis numquam eum? Excepturi reprehenderit sint dolore quia accusamus commodi illo quae magni voluptatum?</p>
                </div>
                <div class="speaker">
                    <img src="//placehold.it/100x100" alt="">
                    <h4>Speaker Name</h4>
                    <h5>Title <span>&nbsp;|&nbsp;</span> Company</h5>
                    <p><strong>This would be populated by the speaker summary field.</strong> Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quisquam perferendis iste reprehenderit fugit eos molestiae dolorem, necessitatibus, explicabo illo molestias, doloribus? Eveniet dolores odio vel ab debitis, cum facere accusamus! Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi atque dicta illo distinctio cupiditate, necessitatibus facilis quis numquam eum? Excepturi reprehenderit sint dolore quia accusamus commodi illo quae magni voluptatum?</p>
                </div>
                <br>
                <h3>Downloadable Assets</h3>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>File Type</th>
                            <th>Password</th>
                            <th>Options</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2014 White Page</td>
                            <td>PDF</td>
                            <td><input type="password" placeholder="Password needed to download this file" class="form-control"></td>
                            <td><a href="##" class="btn btn-primary disabled">Download</a></td>
                        </tr>
                        <tr>
                            <td>All Members Spreadsheet</td>
                            <td>DOC</td>
                            <td><em>Not Required</em></td>
                            <td><a href="##" class="btn btn-primary">Download</a></td>
                        </tr>
                    </tbody>
                </table>
                <br>
                <h3>Photo Gallery</h3>
                <!--- Simple photo gallery uses change image function below --->
                <div id="thumbs" class="cf">
                    <cfoutput>
                        <cfloop from="1" to="6" index="i">
                             <a href="javascript: changeImage(#i#);"><img src="//placehold.it/100x10#i#" alt="" /></a>
                        </cfloop>
                    </cfoutput>
                </div>

                <div id="gallery">
                    <cfoutput>
                        <cfloop from="1" to="6" index="i">
                            <div id="photo-#i#" class="gallery-photo">
                                <img src="//placehold.it/500x40#i#" alt=""/>
                            </div>
                        </cfloop>
                    </cfoutput>
                </div>
                <script>
                    // Photo Gallery in session overlay
                    function changeImage(current) {
                        // Needs to be set to max results returned - hard coded to 6
                        var imagesNumber = 6;

                        for (i=1; i<=imagesNumber; i++) {
                            if (i == current) {
                                document.getElementById("photo-" + current).style.display = "block";
                            } else {
                                document.getElementById("photo-" + i).style.display = "none";
                            }
                        }
                    }
                </script>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close Details</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>


    