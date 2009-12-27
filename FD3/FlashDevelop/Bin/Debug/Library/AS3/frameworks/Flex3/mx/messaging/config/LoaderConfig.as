package mx.messaging.config
{
	import mx.core.mx_internal;

include "../../core/Version.as"
	/**
	 *  This class acts as a context for the messaging framework so that it
 *  has access the URL and arguments of the SWF without needing
 *  access to the root MovieClip's LoaderInfo or Flex's Application
 *  class.
	 */
	public class LoaderConfig
	{
		/**
		 *  @private
	 *  Storage for the parameters property.
		 */
		static var _parameters : Object;
		static var _swfVersion : uint;
		/**
		 *  @private
	 *  Storage for the url property.
		 */
		static var _url : String;

		/**
		 *  If the LoaderConfig has been initialized, this
     *  should represent the top-level MovieClip's parameters.
		 */
		public static function get parameters () : Object;

		/**
		 *  If the LoaderConfig has been initialized, this should represent the
     *  top-level MovieClip's swfVersion.
		 */
		public static function get swfVersion () : uint;

		/**
		 *  If the LoaderConfig has been initialized, this
     *  should represent the top-level MovieClip's URL.
		 */
		public static function get url () : String;

		/**
		 *  Constructor.
	 *
	 *  <p>One instance of LoaderConfig is created by the SystemManager. 
	 *  You should not need to construct your own.</p>
		 */
		public function LoaderConfig ();
	}
}
