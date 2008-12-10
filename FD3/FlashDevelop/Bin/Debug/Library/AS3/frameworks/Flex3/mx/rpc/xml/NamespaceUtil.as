package mx.rpc.xml
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;

	/**
	 * @private
	 */
	public class NamespaceUtil
	{
		public function NamespaceUtil ();
		public static function getLocalName (xmlNode:XMLNode) : String;
		public static function getElementsByLocalName (xmlNode:XMLNode, lname:String) : Array;
	}
}
