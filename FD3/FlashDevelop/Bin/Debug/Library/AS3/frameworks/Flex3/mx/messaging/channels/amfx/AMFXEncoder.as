package mx.messaging.channels.amfx
{
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.IExternalizable;
	import flash.xml.XMLDocument;
	import mx.logging.Log;
	import mx.utils.HexEncoder;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

	/**
	 * Serializes an arbitrary ActionScript object graph to an XML * representation that is based on Action Message Format (AMF) * version 3. * @private
	 */
	public class AMFXEncoder
	{
		private var settings : Object;
		public static const CURRENT_VERSION : uint = 3;
		public static const NAMESPACE_URI : String = "http://www.macromedia.com/2005/amfx";
		public static const NAMESPACE : Namespace = new Namespace("", NAMESPACE_URI);
		private static const REGEX_CLASSNAME : RegExp = new RegExp("::", "g");
		private static const REGEX_CLOSE_CDATA : RegExp = new RegExp("]]>", "g");
		private static const CLASS_INFO_OPTIONS : Object;
		private const X_FALSE : XML = <false />;
		private static const X_NULL : XML = <null />;
		private static const X_TRUE : XML = <true />;
		private static const X_UNDEFINED : XML = <undefined />;

		public function AMFXEncoder ();
		public function encode (obj:Object, headers:Array = null) : XML;
		private static function encodePacket (xml:XML, obj:Object, headers:Array = null, context:AMFXContext = null) : void;
		private static function encodeHeaders (xml:XML, headers:Array, context:AMFXContext) : void;
		private static function encodeBody (xml:XML, obj:*, context:AMFXContext) : void;
		public static function encodeValue (xml:XML, obj:*, context:AMFXContext) : void;
		private static function encodeArray (xml:XML, array:Array, context:AMFXContext) : void;
		private static function encodeArrayItem (xml:XML, name:String, value:*, context:AMFXContext) : void;
		private static function encodeBoolean (xml:XML, bool:Boolean) : void;
		private static function encodeByteArray (xml:XML, obj:ByteArray) : void;
		private static function encodeDate (xml:XML, date:Date, context:AMFXContext) : void;
		private static function encodeNumber (xml:XML, num:Number) : void;
		private static function encodeObject (xml:XML, obj:*, context:AMFXContext) : void;
		private static function encodeString (xml:XML, str:String, context:AMFXContext, isTrait:Boolean = false) : void;
		private static function encodeTraits (xml:XML, classInfo:Object, context:AMFXContext) : void;
		private static function encodeXML (xml:XML, xmlObject:Object) : void;
		private static function escapeXMLString (str:String) : String;
	}
}
