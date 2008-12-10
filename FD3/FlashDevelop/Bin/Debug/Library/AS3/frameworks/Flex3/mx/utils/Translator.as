package mx.utils
{
	import flash.utils.getQualifiedClassName;
	import mx.resources.ResourceBundle;
	import mx.utils.StringUtil;

	/**
	 *  @private
	 */
	public class Translator
	{
		/**
		 *  @private
		 */
		private static const TRANSLATORS : Object;
		/**
		 *  @private
		 */
		private var messagingBundle : ResourceBundle;
		/**
		 *  @private
		 */
		private static var rpcBundle : ResourceBundle;
		/**
		 *  @private
		 */
		private var bundleName : String;
		/**
		 *  @private
		 */
		private var bundle : ResourceBundle;

		/**
		 *  Assumes the bundle name is the name of the second package	 *  (e.g foo in mx.foo).
		 */
		public static function getDefaultInstanceFor (source:Class) : Translator;
		/**
		 *  @private
		 */
		public static function getInstanceFor (bundleName:String) : Translator;
		/**
		 *  @private
		 */
		public static function getMessagingInstance () : Translator;
		/**
		 *  Constructor
		 */
		public function Translator (bundleName:String);
		/**
		 *  @private
		 */
		public function textOf (key:String, ...rest) : String;
	}
}
