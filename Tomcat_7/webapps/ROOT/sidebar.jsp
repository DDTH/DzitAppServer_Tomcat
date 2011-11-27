<%@page session="false" %>
<div id="sidebar">
	<!--
	<h2>Search Box</h2>	
	<form action="#" class="searchform">
		<p>
			<input name="search_query" class="textbox" type="text" />
			<input name="search" class="button" value="Search" type="submit" />
		</p>			
	</form>
	-->
					
	<h2>Menu</h2>
	<ul class="sidemenu">				
		<li><a href="index.jsp">Home</a></li>
		<!-- 
		<li><a href="index.jsp?page=apps">Deployed Apps</a></li>
		-->
		<li><a href="/manager">Manager App</a></li>
		<li><a href="/docs">Tomcat Documentation</a></li>
		<%
		for ( Object o : customMainMenuList ) {
			Map _mi = (Map)o;
			out.println("<li><a href=\""+_mi.get("url")+"\">"+_mi.get("label")+"</a></li>");
		}
		%>
	</ul>
				
	<h2>Links</h2>
	<ul class="sidemenu">
		<li><a href="http://www.ddth.org/">DDTH.ORG</a></li>
	</ul>			
</div>
