<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="com.intuit.mobile.paytrack.jaxb.Client"%>
<%@page import="java.util.Map"%>
<%@page import="com.intuit.mobile.paytrack.jaxb.Receipt"%>
<%@page import="java.util.List"%>
<%@page import="com.intuit.mobile.paytrack.jaxb.Receipts"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link media="all" type="text/css" href="styles/default.css"
	rel="stylesheet">
<title>Receipts</title>
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
			<table>
				<thead>
					<th>Client</th>
					<th>Email Id</th>
					<th>From Date</th>
					<th>To Date</th>
					<th>Amount</th>
					<th>Payment Date</th>
				</thead>
				<tbody>
					<%
						Map<Long, List<Receipt>> clientIdReceiptMap = (Map<Long, List<Receipt>>) request
								.getAttribute("clientIdReceiptMap");
						Map<Long, Client> clientIdClientMap = (Map<Long, Client>) request
								.getAttribute("clientIdClientMap");

						if (clientIdReceiptMap.size() > 0) {
							Set<Long> clientIdSet = clientIdReceiptMap.keySet();
							Iterator iterator = clientIdSet.iterator();
							while (iterator.hasNext()) {
								Long clientId = (Long) iterator.next();
								List<Receipt> receipts = clientIdReceiptMap.get(clientId);
								Client client = clientIdClientMap.get(clientId);
								for (int i = 0; i < receipts.size(); i++) {
					%>
					<tr>
						<td><%=client.getFirstName()%></td>
						<td><%=client.getEmail()%></td>
						<td><%=receipts.get(i).getFrom()%></td>
						<td><%=receipts.get(i).getTo()%></td>
						<td><%=receipts.get(i).getAmount()%></td>
						<td><%=receipts.get(i).getDate()%></td>
					</tr>
					<%
						}
							}

						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="footer">
		<span class="copyright">&copy; 2012 Intuit, Inc. All rights
			reserved.</span> <span class="footerlogo" id="footerintuitLogo"></span>

	</div>
</body>
</html>