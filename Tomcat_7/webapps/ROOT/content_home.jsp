<%@page session="false" %>
<%@include file="constants.jsp"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<div id="content-wrap">
	<div id="main">
		<a name="AppServer"></a>
		<h2><%= PRODUCT_NAME %> Info</h2>
		<!--
		<p class="post-by">posted by: <a href="#">Thanh Ba Nguyen</a></p>
		-->
		<p><strong><%= PRODUCT_NAME %> <%= PRODUCT_VERSION %></strong> is an application server built on
		<a href="http://tomcat.apache.org/">Apache Tomcat</a>, customized for Dzit's applications.</p>
		
		<!--
		<p class="post-footer align-left">					
			<a href="index.html" class="readmore">Read more</a> |
			<a href="index.html" class="comments">Comments (7)</a> |
			<span class="date">Nov 04, 2006</span>	
		</p>
		-->
		
		<a name="VersionInfo"></a>
		<h2>Version Info</h2>
		<p><%= PRODUCT_NAME %> <%= PRODUCT_VERSION %></p>
		<h3>Tomcat</h3>
		<ul>
			<li><a href="http://tomcat.apache.org/"><%= org.apache.catalina.util.ServerInfo.getServerInfo() %></a></li>
		</ul>
		<%!
			public void displayDirectory(File directory, javax.servlet.jsp.JspWriter out )
		    {
				File dir = directory;
				try {
					if (dir != null && dir.exists()) {
						out.println("<h3>" + dir.getName() + "</h3>");
		        		out.println("<ul>");				        	
			        	File[] children = dir.listFiles(new LibFileFilter());
			        	Arrays.sort(children, new FileComparator());
			        	if (children != null && children.length > 0) {
			        		for (int i = 0; i < children.length; i++) {			        			
			        			File current = children[i];
					        	if (current.isDirectory()) {					        	
						        	displayDirectory(current, out);
						        } else {
					        		out.println("<li>");
					        		out.println("" + current.getName());
					        		out.println("</li>");
						        }
			        		}		        				
			        	}		
			        	out.println("</ul>");
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
		        
		        }
		%>
		<%! class LibFileFilter implements FileFilter {
			public boolean accept(File file) {
				if (file.getName().toLowerCase().endsWith(".jar") 
						|| (file.isDirectory() && !file.getName().toLowerCase().startsWith(".svn"))) {
					return true;
				}
				return false;			      
			}
		}
		%>
		<%! class FileComparator implements Comparator {
			public int compare(final Object o1, final Object o2) {
				 if (o1 == null || o2 == null || !(o1 instanceof File) || !(o2 instanceof File)) {
					return -1;
				}
				java.io.File file1 = (java.io.File) o1;
				java.io.File file2 = (java.io.File) o2;
				if (file1.isDirectory() && !file2.isDirectory()) {
					return 1;
				}
				if (!file1.isDirectory() && file2.isDirectory()) {
					return -1;
				}		
				return file1.getName().compareTo(file2.getName());
		    }
		}
		%>
		<%		
		String catalinaHome = System.getProperty("catalina.base");
		if (catalinaHome != null) {
			File libDir = new File(catalinaHome + "/lib");
			if (libDir != null && libDir.exists()) {					        	
	        	File[] children = libDir.listFiles(new LibFileFilter());        
	        	if (children != null && children.length > 0) {
	        		for (int i = 0; i < children.length; i++) {			        			
	        			File current = children[i];
			        	if (current.isDirectory()) {					        	
				        	displayDirectory(current, out);
				        } 
	        		}		        				
	        	}		
			}	
		} else {
			out.println("<h3>Cannot find the CATALINA_HOME</h3>");    		
		}
		%>
		
		<a name="RuntimeInfo"></a>
		<h2>Runtime Info</h2>
		<p>
		<%
		Runtime rt = Runtime.getRuntime();
        long freeMem = rt.freeMemory();
        long currentMem = rt.totalMemory();
        long maxMem = rt.maxMemory();
		%>
		<ul>
			<li>Memory: Free = <%= freeMem/1024 %>kb (<%= (long)((double)freeMem/(double)currentMem*100.0) %>%) / Current = <%= currentMem/1024 %>kb / Max = <%= maxMem/1024 %>kb</li>
		</ul>
		</p>
	</div>
	
	<%
	List customMainMenuList = new ArrayList();
	
	Map menuItem = new HashMap();
	menuItem.put("url", "#AppServer");
	menuItem.put("label", PRODUCT_NAME+" Info");
	customMainMenuList.add(menuItem);
	
	menuItem = new HashMap();
	menuItem.put("url", "#VersionInfo");
	menuItem.put("label", "Version Info");
	customMainMenuList.add(menuItem);
	%>
	<%@include file="sidebar.jsp" %>
</div>
