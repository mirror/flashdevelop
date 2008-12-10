package mx.rpc.soap.types
{
	import mx.rpc.soap.SOAPDecoder;
	import mx.rpc.soap.SOAPEncoder;
	import mx.rpc.xml.ContentProxy;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;

	/**
	 * Marshalls between an Apache SOAP Document type and ActionScript XML. * @private
	 */
	public class ApacheDocumentType implements ICustomSOAPType
	{
		public function ApacheDocumentType ();
		public function encode (encoder:SOAPEncoder, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		public function decode (decoder:SOAPDecoder, parent:*, name:*, value:*, restriction:XML = null) : void;
	}
}
