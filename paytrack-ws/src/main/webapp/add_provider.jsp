<!DOCTYPE html> 
<html> 
<head> 
	<title>PayTrack</title>
	<meta name="viewport" content="width=device-width, user-scalable=0, initial-scale=1.0, maximum-scale=1.0"/>
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
    
	<link rel="apple-touch-startup-image" media="(max-device-width: 480px) and not (-webkit-min-device-pixel-ratio: 2)" href="img/startup-320x460.png">
    <link rel="apple-touch-startup-image" media="(max-device-width: 480px) and (-webkit-min-device-pixel-ratio: 2)" href="img/startup-640x920.png">
	<link rel="apple-touch-icon" href="img/apple-touch-icon.png" />

	<link rel="apple-touch-icon" sizes="114x114" href="img/apple-touch-icon-114x114.png">
	
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" />
	<link rel="stylesheet" href="css/mobile.css" />
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
	<script type="text/javascript">
		// configure jQMobile settings before auto-init which occurrs when the script loads
	    $(document).bind("mobileinit", function() {
			$.mobile.touchOverflowEnabled = false;
		});
	</script>
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>

</head> 
<body> 

<div data-role="page" id="home">
	<div data-role="header" data-theme="b" data-position="fixed">
		<h1>PayTrack</h1>
	</div>
    
    <div class="scrollPanel">
	<div data-role="content">
		<form method="post" action="./save-provider.do"> 
		<h2>First Name</h2>
		<input type="text" name="firstName"/>
		<h2>Last Name</h2>
		<input type="text" name="lastName"/>
		<h2>Email Id</h2>
		<input type="text" name="email"/>
		<h2>Phone Number</h2>
		<input type="text" name="mobile"/>
		<h2>Address</h2>
		<textarea name="address"></textarea>
		<h2>Service Name</h2>
		<input type="text" name="serviceName"/>
		<input type="submit" value="Save"/>
	</form>
	</div><!-- /content -->
	<a id="addToHome">
	    <div><span>Want a shortcut to this app on your home screen? Just tap below.</span></div>
	    <img src="img/bubbleArrowDwn.png">
	</a>
	</div>
</div><!-- /page: home -->


<div id="ajaxContent" style="display:none"></div>

</body>
</html>