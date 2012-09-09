<%@page session="false" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*" %>
<div id="content-wrap">
	<div id="main">
		<h2>2012-09-09: v1.1</h2>
		<ul>
			<li>Upgrade <a href="http://activemq.apache.org/new-features-in-56.html">ActiveMQ to v5.6.0</a>.</li>
			<li>Update installer Ant script: ActiveMQ now can be enabled/disabled during installation.</li>
		</ul>
	
		<h2>2012-09-08: pre v1.1</h2>
		<ul>
			<li>Moved to <a href="https://github.com/DDTH/DzitAppServer_Tomcat">GitHub</a>.</li>
		</ul>
	
		<h2>2011: v1.0</h2>
		<p>LateToo lazy at that time to track the date.</p>
	</div>
	
	<%
	List customMainMenuList = new ArrayList();
	/*
	Map menuItem = new HashMap();
	menuItem.put("url", "#DDTHServer");
	menuItem.put("label", "DDTH Server Info");
	customMainMenuList.add(menuItem);
	
	menuItem = new HashMap();
	menuItem.put("url", "#VersionInfo");
	menuItem.put("label", "Version Info");
	customMainMenuList.add(menuItem);
	*/
	%>
	<%@include file="sidebar.jsp" %>
</div>
