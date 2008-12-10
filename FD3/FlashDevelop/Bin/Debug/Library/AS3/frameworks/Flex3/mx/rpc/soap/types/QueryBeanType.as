package mx.rpc.soap.types
{
	import mx.rpc.soap.SOAPDecoder;
	import mx.rpc.soap.SOAPEncoder;
	import mx.rpc.xml.ContentProxy;
	import mx.rpc.xml.TypeIterator;
	import mx.rpc.xml.XMLDecoder;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;

	/**
	 * Marshalls between the SOAP representation of a ColdFusion Query (aka a * "Query Bean") and ActionScript. * @private
	 */
	public class QueryBeanType implements ICustomSOAPType
	{
		public function QueryBeanType ();
		public function encode (encoder:SOAPEncoder, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		public function decode (decoder:SOAPDecoder, parent:*, name:*, value:*, restriction:XML = null) : void;
	}
}
