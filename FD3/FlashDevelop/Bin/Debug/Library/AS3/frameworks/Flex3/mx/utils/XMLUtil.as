package mx.utils
{
	import flash.xml.XMLDocument;

include "../core/Version.as"
	/**
	 *  The XMLUtil class is an all-static class
 *  with methods for working with XML within Flex.
 *  You do not create instances of XMLUtil;
 *  instead you simply call static methods such as
 *  the <code>XMLUtil.qnamesEqual()</code> method.
	 */
	public class XMLUtil
	{
		/**
		 *  Creates XML out of the specified string, ignoring whitespace.
     *  This method is used to create objects defined in
	 *  <code>&lt;mx:XML&gt;</code> tags and WebService requests,
	 *  although they, in turn, get the <code>firstChild</code>
	 *  of the structure.
	 *
     *  @param str XML string.
	 *
     *  @return New XML object that ignored whitespace.
		 */
		public static function createXMLDocument (str:String) : XMLDocument;

		/**
		 *  Returns <code>true</code> if the two QName parameters have identical
	 *  <code>uri</code> and <code>localName</code> properties.
	 *
	 *  @param qname1 First QName object.
	 *
	 *  @param qname2 Second QName object.
	 *
	 *  @return <code>true</code> if the two QName parameters have identical
	 *  <code>uri</code> and <code>localName</code> properties.
		 */
		public static function qnamesEqual (qname1:QName, qname2:QName) : Boolean;

		/**
		 *  Returns the concatenation of a Qname object's
	 *  <code>uri</code> and <code>localName</code> properties,
	 *  separated by a colon.
	 *  If the object does not have a <code>uri</code> property,
	 *  or the value of <code>uri</code> is the empty string,
	 *  returns the <code>localName</code> property.
	 *
	 *  @param qname QName object.
	 *
	 *  @return Concatenation of a Qname object's
	 *  <code>uri</code> and <code>localName</code> properties,
	 *  separated by a colon.
		 */
		public static function qnameToString (qname:QName) : String;

		/**
		 * Returns the XML value of an attribute matching the given QName
    * 
    * @param xml the XML object being inspected
    * @param attrQName the QName of the attribute to find
    * 
    * @return XMLList of matching attributes or an empty list if none are found.
		 */
		public static function getAttributeByQName (xml:XML, attrQName:QName) : XMLList;
	}
}
