package mx.rpc.soap.types
{
	import flash.utils.ByteArray;
	import mx.rpc.soap.SOAPDecoder;
	import mx.rpc.soap.SOAPEncoder;
	import mx.rpc.xml.ContentProxy;
	import mx.rpc.xml.SchemaDatatypes;
	import mx.rpc.xml.SchemaConstants;
	import mx.rpc.xml.SchemaMarshaller;
	import mx.utils.object_proxy;

	/**
	 * Marshalls between the SOAP representation of a java.util.Map and * ActionScript. * @private
	 */
	public class MapType implements ICustomSOAPType
	{
		public static var itemQName : QName;
		public static var keyQName : QName;
		public static var valueQName : QName;

		public function MapType ();
		public function encode (encoder:SOAPEncoder, parent:XML, name:QName, value:*, restriction:XML = null) : void;
		public function decode (decoder:SOAPDecoder, parent:*, name:*, value:*, restriction:XML = null) : void;
	}
}
