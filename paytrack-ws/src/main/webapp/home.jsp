<!DOCTYPE html>
<html>
<head>
<title>PayTrack</title>
<meta name="viewport"
	content="width=device-width, user-scalable=0, initial-scale=1.0, maximum-scale=1.0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />

<link rel="apple-touch-startup-image"
	media="(max-device-width: 480px) and not (-webkit-min-device-pixel-ratio: 2)"
	href="img/startup-320x460.png">
<link rel="apple-touch-startup-image"
	media="(max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2)"
	href="img/startup-640x920.png">
<link rel="apple-touch-icon" href="img/apple-touch-icon.png" />

<link rel="apple-touch-icon" sizes="114x114"
	href="img/apple-touch-icon-114x114.png">

<link rel="stylesheet" href="jquery/jquery.mobile-1.0.min.css" />
<link rel="stylesheet" href="css/mobile.css" />
<script type="text/javascript" src="jquery/jquery-1.6.4.min.js"></script>
<script type="text/javascript">
	// configure jQMobile settings before auto-init which occurrs when the script loads
	$(document).bind("mobileinit", function() {
		$.mobile.touchOverflowEnabled = false;
	});
</script>
<script type="text/javascript" src="jquery/jquery.mobile-1.0.min.js"></script>
<script type="text/javascript" src="js/iHealthMobile.js"></script>

<script type="text/javascript" src="js/jquery.touchScroll-1.16.min.js"></script>
</head>
<body>

	<div data-role="page" id="home">
		<div data-role="header" data-theme="b" data-position="fixed">
			<h1>PayTrack</h1>
		</div>

		<div class="scrollPanel">
			<div data-role="content">

				<nav>
					<ul class="pushable">
						<li class="messages tappable"><a id="ADDPAYMENT"
							href="./add_payment.do" data-theme="g" data-transition="slideup"
							data-direction="reverse">ADD PAYMENT</a> </li>
							
						<li>	<a id="ADDPAYMENT"
							href="./add_client.do" data-theme="g" data-transition="slideup"
							data-direction="reverse">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ADD CLIENT</a></li>

					</ul>

					<a id="feedbackLink" href="#feedback" data-transition="slideup">Feedback</a>
				</nav>

			</div>
			<!-- /content -->
			<a id="addToHome">
				<div>
					<span>Want a shortcut to this app on your home screen? Just
						tap below.</span>
				</div> <img src="img/bubbleArrowDwn.png"> </a>
		</div>
	</div>
	<!-- /page: home -->


	<div data-role="page" id="login">
		<div data-role="header" data-theme="b">
			<h1>PayTrack</h1>
		</div>
		<!-- /header -->

		<div data-role="content" style="padding: 0">
			<form class="login">
				<h2>
					<div id="betaSpacer"></div>
					Maple Street Clinic has partnered with Intuit Health so you can
					access your online patient services <strong>anytime,
						anywhere!</strong>

				</h2>
				<h3>Sign In with your doctor's website credentials.</h3>
				<fieldset>
					<input type="text" name="userid" id="userid" value=""
						placeholder="User ID" autocorrect="off" autocomplete="off"
						autocapitalize="off" /> <input type="password" name="password"
						id="password" value="" placeholder="Password" /> <a href="#home"
						id="signin" data-role="button" data-theme="b"
						data-transition="slideup" data-inline="true"> <img
						src="img/lock.png" alt="Secure Sign In" /> Sign In </a>
				</fieldset>
			</form>
			<footer>
				<h5>
					<a href="#">PayTrack</a>
				</h5>
				<h6>&copy; 2012 Intuit, Inc. All rights reserved.</h6>
			</footer>

		</div>
		<!-- /content -->
	</div>
	<!-- /page: login -->


	<div data-role="dialog" id="exitWarning">
		<div data-role="header" data-theme="b">
			<h1>Full Site</h1>
		</div>
		<!-- /header -->

		<div class="scrollPanel">
			<div data-role="content">

				<p>The full Intuit Health site offers more features but is not
					optimized for your mobile phone.</p>
				<a href="http://www.google.com" data-role="button" rel="external"
					data-theme="b">Open Full Site</a> <a href="#home"
					data-role="button" data-rel="back" data-theme="c"
					data-transition="pop" data-direction="reverse">Cancel</a>
			</div>
			<!-- /content -->
		</div>
	</div>
	<!-- /page: exitWarning -->

	<div data-role="page" id="feedback">
		<div data-role="header" data-theme="b">

			<h1>Feedback</h1>
			<a href="#" data-theme="g" data-rel="back">No, thanks</a> <a
				href="#feedbackThanks" data-theme="g">Submit</a>
		</div>

		<div data-role="content">
			<form id="feedbackForm"
				action="http://surveys.prf.qydc.ie.intuit.net/surveyapp/surveycapture"
				method="get" data-ajax="false" novalidate>
				<div class="formError">Please answer the following question by
					tapping a number.</div>

				<div>
					<div style="padding-bottom: 12px">Please rate this app.</div>
					<div id="stars" name="stars"></div>
				</div>
				<div class="commentContainer">
					<textarea name="F,462,3784,12467" cols="40" rows="5"
						placeholder="Tell us why" style="height: 60px"></textarea>
				</div>
				<div>What should we add next?</div>

				<select name="A,462,3785">
					<option>Choose one</option>
					<option value="462,3785,12468">Lab results</option>
					<option value="462,3785,12469">Pay my bill</option>
					<option value="462,3785,12470">Health records</option>
					<option value="462,3785,12471">Ask a question</option>
					<option value="462,3785,12472">Fillout forms</option>
				</select>
				<div class="moreFeedbackContainer">
					<a id="chkContactMe" href="#" class="checked"> <span>Yes,
							you can email me</span> <input value="462,3786,12473" name="A,462,3786"
						type="hidden">

						<div></div> </a>
				</div>
				<input value="178" name="sourcesystem" type="hidden"> <br>
				<input value="test-user" name="idfromsource" type="hidden">
				<input value="462,3783,12466" name="A,462,3783" type="hidden" /> <input
					value="http://surveys.dev.qydc.ie.intuit.net/thanks.jsp" name="url"
					type="hidden" /> <input type="submit" value="Submit" />
			</form>
		</div>
	</div>

	<div data-role="dialog" id="feedbackThanks">
		<div data-role="header" data-theme="b">
			<h1>Thank You!</h1>

		</div>
		<div data-role="content">
			<p style="color: #000; text-shadow: none">We look forward to
				reviewing your feedback!</p>
			<a href="#login" data-role="button" data-theme="b"
				data-transition="pop" data-direction="reverse">Close</a>
		</div>
	</div>
	<!-- /page: feedbackThanks -->


	<div id="ajaxContent" style="display: none"></div>

</body>
</html>