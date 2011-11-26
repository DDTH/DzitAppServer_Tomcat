import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;
import org.apache.xml.serialize.*;

/*
 * DOM Helper utilities
 */
public class DomHelper {
	/*
	 * Loads a XML document as a DOM
	 */
	public static Document getDoc(String fileName)
	{
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		Document doc = factory.newDocumentBuilder().parse(new File(fileName));
		return doc;
	}
	
	/*
	 * Writes a DOM to XML file.
	 */
	public static void writeDoc(doc, String fileName)
	{
		writeDoc (doc, fileName, false);
	}
	
	/*
	 * Writes a DMP to XML file.
	 */
	public static void writeDoc(Document doc, String fileName, boolean omitComments)
	{
		OutputFormat format = new OutputFormat(doc);
		format.setLineWidth(80);
		format.setIndenting(true);
		format.setIndent(4);
		format.setOmitComments(omitComments);
		FileOutputStream fos = new FileOutputStream(new File(fileName))
		new XMLSerializer(fos, format).serialize(doc);
	}
	
	/*
	 * Writes a value to the location specified by a XPath.
	 */
	public static void writeValueXpath(Document doc, String xpath, String value) {
		if ( xpath.matches(".*\\/@\\w+\$") ) {
			writeAttributeValueXpath(doc, xpath, value);
		}
	}

	private static void writeAttributeValueXpath(Document doc, String xpath, value) {
		NodeList nodes = findNodes(doc, xpath);
		if ( nodes != null ) {
			// found the attribute, change its value
			Node node = nodes.item(0);
			node.setNodeValue(value);
		}
	}
	
	private static NodeList findNodes(Document doc, String xpath) {
		XPath xpathObj = XPathFactory.newInstance().newXPath();
		XPathExpression expr = xpathObj.compile(xpath);
		NodeList nodes = (NodeList)expr.evaluate(doc, XPathConstants.NODESET);
		return nodes;
	}
}
