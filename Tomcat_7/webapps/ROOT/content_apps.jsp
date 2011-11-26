<%@page session="false" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*" %>
<div id="content-wrap">
	<div id="main">
		<a name="DDTHServer"></a>
		<h2>Deployed Applications</h2>
		<p><strong>DDTH Server 1.0</strong> is an application server built on
		<a href="http://tomcat.apache.org/">Apache Tomcat</a>, bundled with several open sourced/free libraries,
		include libraries developed by <strong>DDTH.ORG</strong>. It is meant to be used on DDTH's servers.
		However, you can use and distribute it freely for non-commercial purpose.</p>
		
		<!--
		<p class="post-footer align-left">					
			<a href="index.html" class="readmore">Read more</a> |
			<a href="index.html" class="comments">Comments (7)</a> |
			<span class="date">Nov 04, 2006</span>	
		</p>
		-->
		
		<a name="VersionInfo"></a>
		<h2>Version Info</h2>
		<p>DDTH Server v1.0.</p>
		<h3>Tomcat</h3>
		<ul>
			<li><a href="http://tomcat.apache.org/">Apache Tomcat</a> v6.0.28</li>
		</ul>
		
		<h3>DDTH libraries</h3>
		<ul>
			<li>AppConfig v0.2</li>
			<li>Common v0.4</li>
			<li>EhProperties v0.2.beta</li>
			<li>HibernateUtil v0.2.beta</li>
			<li>MLS v0.3</li>
			<li>Panda v1.0.5.1</li>
			<li>WebTemplate v0.4</li>
			<li>XConfig v0.3.beta</li>
		</ul>
		
		<h3>3rd party libraries</h3>
		<ul>
			<li>Logging:
				<ul>
					<li><a href="http://commons.apache.org/logging/">Apache Commons Logging</a> v1.1.1</li>
					<li><a href="http://logging.apache.org/">Apache Log4J</a> v1.2.15</li>
					<li><a href="http://www.slf4j.org/">Simple Logging Facade for Java</a> v1.5.8</li>
				</ul>
			</li>
			<li>JDBC Drivers:
				<ul>
					<li>MySQL v3.1.10</li>
					<li>Postgresql v8.1-404</li>
					<li>Hsqldb v1.8.1.1</li>
				</ul>
			</li>
			<li><a href="http://www.hibernate.org/">Hibernate Core</a> v3.3.2.GA</li>
			<li><a href="http://java.sun.com/products/jsp/jstl/">JSTL</a> v1.2</li>
			<li><a href="http://www.springsource.org/">Spring Framework</a> v3.0.0</li>
			<li><a href="http://www.springsource.org/">Spring Security</a> v3.0.1</li>
			<li><a href="http://www.springsource.org/">Spring LDAP</a> v1.3.0</li>
			<li><a href="http://www.ehcache.org/">EhCache Core</a> v1.7.2</li>
		</ul>
	</div>
	
	<%
	List customMainMenuList = new ArrayList();
	
	Map menuItem = new HashMap();
	menuItem.put("url", "#DDTHServer");
	menuItem.put("label", "DDTH Server Info");
	customMainMenuList.add(menuItem);
	
	menuItem = new HashMap();
	menuItem.put("url", "#VersionInfo");
	menuItem.put("label", "Version Info");
	customMainMenuList.add(menuItem);
	%>
	<%@include file="sidebar.jsp" %>
</div>
