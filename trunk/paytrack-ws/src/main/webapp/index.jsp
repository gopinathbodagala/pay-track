<html>
<head>
<title>Developer Guide for Android Push Notification</title>

<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1252">
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
					class="headerimage" src="images/cto-dev.png">
				</a>
			</div>
			<div class="title">Developer Guide for Android Push
				Notification</div>

		</div>
		<div class="content">
			<ul id="steplist">
				<li>Create a new Android Application <b>Project with Google
						APIs (Google Inc.)&nbsp; (API: 15)</b> as Build SDK
				</li>
				<li>Download <a
					href="https://mobile-prototype.intuitlabs.com/DeviceRegGCMClient-0.0.2-SNAPSHOT.jar">DeviceRegGCMClient-0.0.2-SNAPSHOT.jar</a>
					and add to your class path by dropping this jar in to /libs folder
				</li>
				<li>Create a class under your application package called <span
					class="code">GCMIntentService</span> by extending <span
					class="code">com.intuit.mobile.png.plugin.gcm.GCMAbstractIntentService</span>
					<br> <br>
					<ol class="sub">
						<li><span class="code">GCMIntentService.onMessage()</span> is
							called when a push notification received. Implement this method
							as per your need.</li>
						<li>A sample implementation is given below or replace the
							below code</li>
					</ol>
					<p>
						<span class="codecolor"><b>protected void</b></span> <span
							class="codesnippet"> onMessage(Context context, Intent
							intent){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String message =
							intent.getStringExtra(<span class="blue">"message"</span>);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							NotificationManager notificationManager =
							(NotificationManager)context.getSystemService(Context.<span
							class="blue">NOTIFICATION_SERVICE</span>);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							Notification notification = new Notification(android.R.drawable.<span
							class="blue">ic_dialog_info</span>,
							message,System.currentTimeMillis());<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							String title = context.getString(R.string.<span class="blue">app_name</span>);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							Intent notificationIntent = new Intent(context,
							MainActivity.class);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span
							class="comment">// set intent so it does not start a new
								activity</span><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							notificationIntent.setFlags(Intent.<span class="blue">FLAG_ACTIVITY_CLEAR_TOP</span>
							| <span class="blue">Intent.FLAG_ACTIVITY_SINGLE_TOP</span>);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							PendingIntent pendingIntent = PendingIntent.getActivity(context,
							0,notificationIntent, 0); <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							notification.setLatestEventInfo(context, title, message,
							pendingIntent);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							notification.<span class="blue">flags</span> |= Notification.<span
							class="blue">FLAG_AUTO_CANCEL</span>;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							notificationManager.notify(0, notification);<br> }
						</span>
					</p>
				</li>
				<li>Onboard your project to Device Registration Service<br>
					<br>
					<ol class="sub">
						<li>Use <a href="app/gcm/add-project.do">This Url</a> for
							onboarding
						</li>
					</ol>
				</li>
				<li>Modify your MainActivity to make the following changes <br>
					<br>
					<ol class="sub">
						<li>Add the following line to onCreate() method <br>
							<p>
								<span class="codesnippet">GCM.register( <span
									class="codecolor"><b>this</b></span>,<span class="blue">"demo_user_id"</span>,
									<span class="codecolor"><b>new</b></span>
									MyAppGcmParameters());
								</span>
							</p>
						</li>
						<li>Add the following method<br>
							<p>
								<span class="codesnippet"> <span class="codecolor"><b>protected
											void</b></span> onDestroy() {<br>&nbsp;&nbsp;&nbsp;
									super.onDestroy();<br>&nbsp;&nbsp;&nbsp; GCM.onDestroy( <span
									class="codecolor"><b>this</b></span>);<br></span> }<br>
							</p>
						</li>
					</ol>
				</li>
				<li>Add the following lines to AndroidManifest.xml under
					manifest tag <br>
					<p>
						<span class="codesnippet"><span class="green">&lt;permission</span>

							<span class="codecolor">android:name</span>=<span class="blue">"my_app_package.permission.C2D_MESSAGE"</span>

							<span class="codecolor">android:protectionLevel</span>=<span
							class="blue">"signature"</span> <span class="green">/&gt;</span><br>



							<span class="green">&lt;uses-permission</span> <span
							class="codecolor">android:name</span>=<span class="blue">"my_app_package.permission.C2D_MESSAGE"</span>
							<span class="green">/&gt;</span><br> <span class="comment">&lt;!--
								App receives GCM messages. --&gt;</span><br> <span class="green">&lt;uses-permission</span>
							<span class="codecolor">android:name</span>=<span class="blue">"com.google.android.c2dm.permission.RECEIVE"</span>
							<span class="green">/&gt;</span><br> <span class="comment">&lt;!--
								GCM connects to Google Services. --&gt;</span><br> <span
							class="green">&lt;uses-permission</span> <span class="codecolor">android:name</span>=<span
							class="blue">"android.permission.INTERNET"</span> <span
							class="green">/&gt;</span><br> <span class="comment">&lt;!--
								GCM requires a Google account. --&gt;</span><br> <span
							class="green">&lt;uses-permission</span> <span class="codecolor">android:name</span>=<span
							class="blue">"android.permission.GET_ACCOUNTS"</span> <span
							class="green">/&gt;</span><br> <span class="comment">&lt;!--
								Keeps the processor from sleeping when a message is received.
								--&gt;</span><br> <span class="green">&lt;uses-permission</span> <span
							class="codecolor">android:name</span>=<span class="blue">"android.permission.WAKE_LOCK"</span>
							<span class="green">/&gt;</span> <br> </span>
					</p>
				</li>
				<li>Add the following lines to AndroidManifest.xml under
					application tag <br>
					<p>
						<span class="codesnippet"> <span class="green">&lt;receiver</span>
							<span class="codecolor">android:name</span>=<span class="blue">"com.intuit.mobile.png.plugin.gcm.PushBroadcastReceiver"</span>
							<br /> <span class="codecolor">android:permission</span>=<span
							class="blue">"com.google.android.c2dm.permission.SEND"</span> <span
							class="green">&gt;</span> <br> <span class="green">&lt;intent-filter&gt;</span><br>&nbsp;&nbsp;&nbsp;
							<span class="green">&lt;action</span> <span class="codecolor">android:name</span>=<span
							class="blue">"com.google.android.c2dm.intent.RECEIVE"</span> <span
							class="green">/&gt;</span> <br>&nbsp;&nbsp;&nbsp; <span
							class="green">&lt;action</span> <span class="codecolor">android:name</span>=<span
							class="blue">"com.google.android.c2dm.intent.REGISTRATION"</span>
							<span class="green">/&gt;</span> <br>&nbsp;&nbsp;&nbsp; <span
							class="green">&lt;category</span> <span class="codecolor">android:name</span>=<span
							class="blue">"my_app_package"</span> <span class="green">/&gt;</span>
							<br> <span class="green">&lt;/intent-filter&gt;</span><br>
							<span class="green">&lt;/receiver&gt;</span><br> <span
							class="green">&lt;service</span> <span class="codecolor">android:name</span>=<span
							class="blue">".GCMIntentService"</span> <span class="green">/&gt;</span>
							<br>
						</span>
					</p>
				</li>
				<li>Replace <span class="codesnipped"><span class="blue"><b>my_app_package</b></span></span>
					with your application package name
				</li>
				<li>Build Run the your Android Application</li>
				<li>On your application load, the device registration with GCM
					and Device Registration Application will be complete</li>
				<li>Your application is now ready to receive Push Notification</li>
				<li>Testing Push Notifications:
					<ol class="sub">
						<li>Open <a
							href="https://accounts.google.com/o/oauth2/auth?redirect_uri=https://mobile-prototype.intuitlabs.com/devicereg/app/gcm/login.do&response_type=code&client_id=983151159994.apps.googleusercontent.com&approval_prompt=force&scope=https://www.googleapis.com/auth/userinfo.email&state=redirect:/app/gcm/show-send-message.do">This
								Url</a></li>
						<li>Select Project Name, enter Message to push and click on
							Send button</li>
					</ol>
				</li>
				<li>Push Notification Message will be displayed on Android
					Notification Tray</li>
				<li>For more API informations refer <a href="docs">API
						Documentations</a></li>
			</ul>

			<div class="note">
				<b>Note:</b> GCM typically only uses port 5228 that has been blocked
				by Intuit firewall, Hence to try out this you need to be on a
				different internet
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;connection
				other than <b>datawifi, Guest</b>
			</div>
		</div>
		<div class="footer">
			<span class="copyright">&copy; 2012 Intuit, Inc. All rights
				reserved.</span> <span class="footerlogo" id="footerintuitLogo"></span>

		</div>


	</div>

</body>
</html>