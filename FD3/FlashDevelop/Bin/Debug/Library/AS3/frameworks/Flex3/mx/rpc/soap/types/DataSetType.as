package mx.rpc.soap.types
{
	import mx.rpc.soap.SOAPConstants;
	import mx.rpc.soap.SOAPDecoder;
	import mx.rpc.soap.SOAPEncoder;
	import mx.rpc.xml.ContentProxy;
	import mx.rpc.xml.Schema;
	import mx.rpc.xml.SchemaConstants;
	import mx.rpc.xml.TypeIterator;
	import mx.rpc.xml.XMLDecoder;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;

	/**
	 * Marshalls between a .NET DataSet diffgram and ActionScript. * @private
	 */
	public class DataSetType implements ICustomSOAPType
	{
		private var schemaConstants : SchemaConstants;

		public function DataSetType ();
		public function encode (encoder:SOAPEncoder, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		/**
		 * Decode a response part that contains a serialized DataSet.     *      * @param SOAPDecoder the decoder instance     * @param * parent object (content proxy)     * @param name ignored     * @param value the top level XML node. Must have two child elements, schema and diffgram.     * @param restriction ignored     *      * @private
		 */
		public function decode (decoder:SOAPDecoder, parent:*, name:*, value:*, restriction:XML = null) : void;
		/**
		 * Parse table information out of the inline schema
		 */
		private function processTables (schemaXML:XML) : Object;
		/**
		 * Parse column definitions out of a table definition
		 */
		private function processColumns (decoder:SOAPDecoder, tableXML:XML) : *;
	}
}
