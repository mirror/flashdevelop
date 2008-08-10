/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	public class XMLUtil {
		/**
		 * Creates XML out of the specified string, ignoring whitespace.
		 *  This method is used to create objects defined in
		 *  <mx:XML> tags and WebService requests,
		 *  although they, in turn, get the firstChild
		 *  of the structure.
		 *
		 * @param str               <String> XML string.
		 * @return                  <XMLDocument> New XML object that ignored whitespace.
		 */
		public static function createXMLDocument(str:String):XMLDocument;
		/**
		 * Returns the XML value of an attribute matching the given QName
		 *
		 * @param xml               <XML> the XML object being inspected
		 * @param attrQName         <QName> the QName of the attribute to find
		 * @return                  <XMLList> XMLList of matching attributes or an empty list if none are found.
		 */
		public static function getAttributeByQName(xml:XML, attrQName:QName):XMLList;
		/**
		 * Returns true if the two QName parameters have identical
		 *  uri and localName properties.
		 *
		 * @param qname1            <QName> First QName object.
		 * @param qname2            <QName> Second QName object.
		 * @return                  <Boolean> true if the two QName parameters have identical
		 *                            uri and localName properties.
		 */
		public static function qnamesEqual(qname1:QName, qname2:QName):Boolean;
		/**
		 * Returns the concatenation of a Qname object's
		 *  uri and localName properties,
		 *  separated by a colon.
		 *  If the object does not have a uri property,
		 *  or the value of uri is the empty string,
		 *  returns the localName property.
		 *
		 * @param qname             <QName> QName object.
		 * @return                  <String> Concatenation of a Qname object's
		 *                            uri and localName properties,
		 *                            separated by a colon.
		 */
		public static function qnameToString(qname:QName):String;
	}
}
