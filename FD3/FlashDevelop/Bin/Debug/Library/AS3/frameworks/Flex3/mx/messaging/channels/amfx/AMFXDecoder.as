package mx.messaging.channels.amfx
{
	import flash.net.getClassByAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.IExternalizable;
	import mx.logging.Log;
	import mx.messaging.errors.ChannelError;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.HexDecoder;

	/**
	 * Decodes an AMFX packet into an ActionScript Object graph. * Headers and the result body are accessed from the returned * AMFXResult. * @private
	 */
	public class AMFXDecoder
	{
		/**
		 *  @private	 *  Storage for the resourceManager getter.	 *  This gets initialized on first access,	 *  not at static initialization time, in order to ensure	 *  that the Singleton registry has already been initialized.
		 */
		private static var _resourceManager : IResourceManager;
		private static const SUPPORTED_VERSIONS : Array = [];
		private static const REGEX_CLOSE_CDATA : RegExp = new RegExp("]]&gt;", "g");

		/**
		 *  @private     *  A reference to the object which manages     *  all of the application's localized resources.     *  This is a singleton instance which implements     *  the IResourceManager interface.
		 */
		private static function get resourceManager () : IResourceManager;

		public function AMFXDecoder ();
		public function decode (xml:XML) : AMFXResult;
		private static function decodePacket (xml:XML, context:AMFXContext) : AMFXResult;
		private static function decodeHeaders (xmlList:XMLList, context:AMFXContext) : Array;
		private static function decodeBody (xml:XML, context:AMFXContext) : Object;
		public static function decodeValue (xml:XML, context:AMFXContext) : Object;
		private static function decodeArray (xml:XML, context:AMFXContext) : Array;
		private static function decodeByteArray (xml:XML) : ByteArray;
		private static function decodeDate (xml:XML, context:AMFXContext) : Date;
		private static function decodeObject (xml:XML, context:AMFXContext) : Object;
		private static function decodeRef (xml:XML, context:AMFXContext) : Object;
		private static function decodeString (xml:XML, context:AMFXContext, isTrait:Boolean = false) : String;
		private static function decodeTraits (xml:XML, className:String, context:AMFXContext) : Object;
		private static function hasEscapedCloseCDATA (xml:XML) : Boolean;
		private static function supportedVersion (ver:uint) : Boolean;
	}
}
