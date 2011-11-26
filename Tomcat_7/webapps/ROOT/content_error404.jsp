<%@page session="false" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*" %>
<div id="content-wrap">
	<div id="main">
		<%
		/*
		String url = request.getParameter("url");
		if ( url == null ) {
			url = "";
		}
		url = url.replaceAll("&", "&amp;")
			.replaceAll("\"", "&quot;")
			.replaceAll("<", "&lt;")
			.replaceAll(">", "&gt;");
		*/
		%>
		<a name="DDTHServer"></a>
		<h2>Error: Page not found!</h2>
		<p>The page you are looking for is not found on the server!
		Please check if you spell the page name correctly, or use the search feature.</p>		
	</div>
	
	<%
	List customMainMenuList = new ArrayList();
	%>
	<%@include file="sidebar.jsp" %>
</div>
