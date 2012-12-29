<%@page session="false" pageEncoding="UTF-8"%><%@page import="com.hazelcast.core.*"
    %><%@page import="com.hazelcast.config.*"%><%!
/**
 * {@inheritDoc}
 */
@Override
public void init() throws ServletException {
     super.init();
     //ServletConfig servletConfig = getServletConfig();     
     HazelcastInstance instance = Hazelcast.getDefaultInstance();
}
%>
<%
%>