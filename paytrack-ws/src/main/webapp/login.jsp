<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Provider Login</title>
<link media="all" type="text/css" href="styles/default.css"
	rel="stylesheet">
</head>
<body>
	<div class="main">
		<div id="header_logo">
			<span id="intuitLogo" class="global-sprite"></span>
		</div>
		<div class="header">

			<div id="" class="ctologo">
				<a href="index.jsp" class="titlehipher" title="Intuit"> <img
					class="headerimage" src="images/cto-dev.png"> </a>
			</div>
			<div class="title">PayTrack</div>

		</div>
		<div class="content">
			<form class="loginClass" action="./receipts.do" method="post">
				<table>
					<tr>
						<td>Provider Email Id</td>
						<td><input type="text" name="emailId">
						</td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" /></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="Login"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<div class="footer">
		<span class="copyright">&copy; 2012 Intuit, Inc. All rights
			reserved.</span> <span class="footerlogo" id="footerintuitLogo"></span>

	</div>
</body>
</html>