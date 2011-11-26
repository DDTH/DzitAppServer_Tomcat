<%@page session="false" %>
<%@include file="constants.jsp"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<%
	String REQUESTED_URL = request.getRequestURL().toString();
	%>
	<base href="<%= REQUESTED_URL %>" />
	<meta name="Description" content="<%= PRODUCT_NAME %>" />
	<meta name="Keywords" content="" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="Distribution" content="Global" />
	<meta name="Robots" content="index,follow" />
	<link rel="stylesheet" href="css/CoolWater.css" type="text/css" />
	<title>Welcome to <%= PRODUCT_NAME %> <%= PRODUCT_VERSION %></title>
</head>
<body>

<!-- wrap starts here -->
<div id="wrap">
	<!--header -->
	<jsp:include page="el_header.jsp" />

	<!-- navigation -->
	<jsp:include page="el_menubar.jsp" />

	<!-- content-wrap starts here -->
	<c:choose>
		<c:when test="${param.page=='apps'}">
			<jsp:include page="content_apps.jsp" />
		</c:when>
		<c:when test="${param.page=='error404'}">
			<jsp:include page="content_error404.jsp" />
		</c:when>
		<c:otherwise>
			<jsp:include page="content_home.jsp" />
		</c:otherwise>
	</c:choose>
	<!-- content-wrap ends here -->

	<!--footer starts here-->
	<jsp:include page="el_footer.jsp"/>
</div>
<!-- wrap ends here -->

</body>
</html>
