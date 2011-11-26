<%@page session="false" %>
<%@page isErrorPage="true" contentType="text/html; charset=UTF-8"%>
<% String referer = request.getHeader("Http-Referer"); %>
<jsp:forward page="/index.jsp">
	<jsp:param name="page" value="error404" />
	<jsp:param name="url" value="<%= referer %>" />
</jsp:forward>
