/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.xml {
	import flash.xml.XMLNode;
	public class SimpleXMLEncoder {
		/**
		 * @param rawDate           <Date> 
		 * @param dateType          <String> 
		 */
		public static function encodeDate(rawDate:Date, dateType:String):String;
		/**
		 * parentNode - optional, an XMLNode under which to
		 *  put the encoded value.  If this is present, we
		 *  will be able to use namespace prefixes already
		 *  defined above the encoded object - if not,
		 *  a well-formed XML document
		 *  including all NS declarations necessary is returned.
		 *
		 * @param obj               <Object> 
		 * @param qname             <QName> 
		 * @param parentNode        <XMLNode> 
		 */
		public function encodeValue(obj:Object, qname:QName, parentNode:XMLNode):XMLNode;
	}
}
