<!DOCTYPE html>
<%@page import="com.intuit.mobile.paytrack.jaxb.Client"%>
<%@page import="java.util.List"%>
<%@page import="com.intuit.mobile.paytrack.jaxb.Clients"%>
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

	<div data-role="page" id="addPayment">
		<div data-role="header" data-theme="b" data-position="fixed">
			<h1>PayTrack</h1>
		</div>

		<div class="scrollPanel">
			<div data-role="content">
				<form method="post" action="./save-receipt.do">
					<h2>Client</h2>
					<select name="clientId">
						
						<%Clients clients =  (Clients) request.getAttribute("clients"); 
						List<Client> clientList = (List<Client>)clients.getClients();
						for(int i=0 ;i < clientList.size(); i++){
						%>
						<option value="<%=clientList.get(i).getId()%>"><%= clientList.get(i).getFirstName()%></option>
						<%} %>
						
					</select>
					<h2>From</h2>
					<input type="date" name="from" id="date" value="" />
					<h2>To</h2>
					<input type="date" name="to" id="date" value="" />
					<h2>Amount</h2>
					<input type="text" name="amount" />
					<h2>Payment Date</h2>
					<input type="text" name="date" /> <input type="submit"
						value="Generate Report" />

				</form>
			</div>
			<!-- /content -->
			<a id="addToHome">
				<div>
					<span>Want a shortcut to this app on your home screen? Just
						tap below.</span>
				</div> <img src="img/bubbleArrowDwn.png"> </a>
		</div>
	</div>


	<div id="ajaxContent" style="display: none"></div>

</body>
</html>