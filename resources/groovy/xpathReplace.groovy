import org.w3c.dom.*;

//parsing parameters
String filename = "";
String xpath = "";
String value = "";

for ( int i=0; i<args.length; i++ ) {
	if ( args[i].startsWith("filename=") ) {
		filename = args[i].replace("filename=", "")
	}
	if ( args[i].startsWith("xpath=") ) {
		xpath = args[i].replace("xpath=", "")
	}
	if ( args[i].startsWith("value=") ) {
		value = args[i].replace("value=", "")
	}
}

xpathReplace(filename, xpath, value);

private void xpathReplace(String filename, String xpath, String value) {
	try {
		Document doc = DomHelper.getDoc(filename);
		DomHelper.writeValueXpath(doc, xpath, value);
		DomHelper.writeDoc(doc, filename);
	} catch ( Exception e ) {
		//ignore
	}
}
