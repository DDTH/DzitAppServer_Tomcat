<%@page session="false" pageEncoding="UTF-8"
%><%@page import="java.io.*"
%><%@page import="java.util.*"
%><%@page import="java.util.concurrent.*"
%><%@page import="java.util.zip.*"
%><%!
/* 3rd party configuration settings */
final static Map<String, FileEntry> CACHE_RESOURCE_CONTENT = new ConcurrentHashMap<String, FileEntry>();

final static Map<String, String> THIRDPARTY_NAME_MAPPING = new HashMap<String, String>();
static {
	THIRDPARTY_NAME_MAPPING.put("dojo", "/thirdparty/dojo-1.8.1.zip");
	THIRDPARTY_NAME_MAPPING.put("dojo-1.7.2", "/thirdparty/dojo-1.7.2.zip");
	THIRDPARTY_NAME_MAPPING.put("dojo-1.8.1", "/thirdparty/dojo-1.8.1.zip");
	
	THIRDPARTY_NAME_MAPPING.put("bootstrap", "/thirdparty/bootstrap-2.0.4.zip");
	THIRDPARTY_NAME_MAPPING.put("bootstrap-2.0.4", "/thirdparty/bootstrap-2.0.4.zip");
	
	THIRDPARTY_NAME_MAPPING.put("jquery", "/thirdparty/jquery-1.7.2.zip");
	THIRDPARTY_NAME_MAPPING.put("jquery-1.7.2", "/thirdparty/jquery-1.7.2.zip");
	
	THIRDPARTY_NAME_MAPPING.put("fontawesome", "/thirdparty/fontawesome-2.0.zip");
	THIRDPARTY_NAME_MAPPING.put("fontawesome-2.0", "/thirdparty/fontawesome-2.0.zip");
}
	
class FileEntry {
	private String mimeType;
	private long size;
	private byte[] content;
	private long time;
	
	public FileEntry(String mimeType, long size, byte[] content, long time) {
		this.mimeType = mimeType;
		this.size = size;
		this.content = content;
		this.time = time;
	}
	
	public String getMimeType() {
		return this.mimeType;
	}
	
	public long getSize() {
		return this.size;
	}
	
	public byte[] getContent() {
		return this.content;
	}
	
	public long getTime() {
		return this.time;
	}
}

FileEntry getFileEntry(String zipFilename, String resourceName) throws Exception {
	if ( zipFilename == null ) {
		return null;
	}
	File zipFile = new File(zipFilename);
	if ( !zipFile.exists() || !zipFile.isFile() || !zipFile.canRead() ) {
		return null;
	}
	ZipFile zip = new ZipFile(zipFile);
	try {
		ZipEntry zipEntry = zip.getEntry(resourceName);
		if ( zipEntry == null || zipEntry.isDirectory() ) {
			return null;
		}
		long filesize = zipEntry.getSize();
		long filetime = System.currentTimeMillis();
		String filename = zipEntry.getName();
		String mimetype = "application/octet-stream";
		if ( filename.toLowerCase().endsWith(".htm") || filename.toLowerCase().endsWith(".html") ) {
			mimetype = "text/html";
		} else if ( filename.toLowerCase().endsWith(".xml") ) {
			mimetype = "text/xml";
		} else if ( filename.toLowerCase().endsWith(".xml") ) {
			mimetype = "text/xml";
		} else if ( filename.toLowerCase().endsWith(".js") ) {
			mimetype = "text/javascript";
		} else if ( filename.toLowerCase().endsWith(".css") ) {
			mimetype = "text/css";
		} else if ( filename.toLowerCase().endsWith(".gif") ) {
			mimetype = "image/gif";
		} else if ( filename.toLowerCase().endsWith(".png") ) {
			mimetype = "image/png";
		} else if ( filename.toLowerCase().endsWith(".jpg") || filename.toLowerCase().endsWith(".jpeg") ) {
			mimetype = "image/jpeg";
		}
		InputStream is = zip.getInputStream(zipEntry);
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int bytesRead = is.read(buffer);
			while ( bytesRead != -1 ) {
				baos.write(buffer, 0, bytesRead);
				bytesRead = is.read(buffer);
			}
			byte[] filecontent = baos.toByteArray();
			FileEntry fileEntry = new FileEntry(mimetype, filesize, filecontent, filetime);
			return fileEntry;
		} finally {
			is.close();
		}
	} finally {
		if ( zip != null ) {
			zip.close();
		}
	}
}
%><%
String uri = request.getRequestURI();
uri = uri.replaceAll("^\\/+", "").replaceAll("\\/+$", "");
String[] tokens = uri.split("[\\/]+");
String thirdPartyName = tokens.length > 1 ? tokens[1] : null;
if ( thirdPartyName == null ) {
	response.sendError(404);
	return;
}

StringBuilder resourceName = new StringBuilder();
for ( int i = 2; i < tokens.length; i++ ) {
	if ( resourceName.length() > 0 ) {
		resourceName.append("/");
	}
	resourceName.append(tokens[i]);
}

String cacheKey = thirdPartyName + "/" + resourceName.toString();
FileEntry cacheEntry = CACHE_RESOURCE_CONTENT.get(cacheKey);
if ( cacheEntry == null ) {
	String zipFilename = THIRDPARTY_NAME_MAPPING.get(thirdPartyName);
	if ( zipFilename != null ) {
		cacheEntry = getFileEntry(getServletContext().getRealPath(zipFilename), resourceName.toString());
	}
	if ( cacheEntry != null ) {
		CACHE_RESOURCE_CONTENT.put(cacheKey, cacheEntry);
	}
}
if ( cacheEntry == null ) {
	response.sendError(404);
	return;
}
response.setContentLength((int)cacheEntry.getSize());
response.setContentType(cacheEntry.getMimeType());
response.setDateHeader("Last-Modified", cacheEntry.getTime());
response.setDateHeader("Expires", cacheEntry.getTime() + 3600000L);
response.getOutputStream().write(cacheEntry.getContent());
%>