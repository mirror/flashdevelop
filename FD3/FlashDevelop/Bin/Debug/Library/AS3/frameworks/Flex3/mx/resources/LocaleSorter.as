package mx.resources
{
	/**
	 *  @private *  The APIs of the LocaleSorter class provides the sorting functionality  *  of application locales against system preferences.
	 */
	public class LocaleSorter
	{
		/**
		 *  @private     *	Sorts a list of locales using the order specified     *  by the user preferences.	 * 	 * 	@param appLocales An Array of locales supported by the application.     *	 * 	@param systemPreferences The locale chain of user-preferred locales.     *	 * 	@param ultimateFallbackLocale The ultimate fallback locale     *  that will be used when no locale from systemPreference matches 	 * 	a locale from application supported locale list.     *	 * 	@param addAll When true, adds all the non-matching locales     *  at the end of the result list preserving the given order.	 *	 *	@return A locale chain that matches user preferences order.
		 */
		public static function sortLocalesByPreference (appLocales:Array, systemPreferences:Array, ultimateFallbackLocale:String = null, addAll:Boolean = false) : Array;
		/**
		 *  @private
		 */
		private static function trimAndNormalize (list:Array) : Array;
		/**
		 *  @private
		 */
		private static function normalizeLocale (locale:String) : String;
		/**
		 *  @private
		 */
		private static function addUltimateFallbackLocale (preferenceLocales:Array, ultimateFallbackLocale:String) : void;
	}
	/**
	 *  @private *  The APIs of the internal LocaleID class parse a locale string *  according to: *  RFC 4646: http://www.ietf.org/rfc/rfc4646.txt *  RFC 4647: http://www.ietf.org/rfc/rfc4647.txt *  IANA Language Subtag Registry: *  http://www.iana.org/assignments/language-subtag-registry
	 */
	internal class LocaleID
	{
		/**
		 *  @private
		 */
		public static const STATE_PRIMARY_LANGUAGE : int = 0;
		/**
		 *  @private
		 */
		public static const STATE_EXTENDED_LANGUAGES : int = 1;
		/**
		 *  @private
		 */
		public static const STATE_SCRIPT : int = 2;
		/**
		 *  @private
		 */
		public static const STATE_REGION : int = 3;
		/**
		 *  @private
		 */
		public static const STATE_VARIANTS : int = 4;
		/**
		 *  @private
		 */
		public static const STATE_EXTENSIONS : int = 5;
		/**
		 *  @private
		 */
		public static const STATE_PRIVATES : int = 6;
		/**
		 *  @private
		 */
		private var lang : String;
		/**
		 *  @private
		 */
		private var script : String;
		/**
		 *  @private
		 */
		private var region : String;
		/**
		 *  @private
		 */
		private var extended_langs : Array;
		/**
		 *  @private
		 */
		private var variants : Array;
		/**
		 *  @private
		 */
		private var extensions : Object;
		/**
		 *  @private
		 */
		private var privates : Array;
		/**
		 *  @private
		 */
		private var privateLangs : Boolean;

		/**
		 *  @private
		 */
		public static function fromString (str:String) : LocaleID;
		/**
		 *  Constructor.
		 */
		public function LocaleID ();
		/**
		 *  @private
		 */
		public function canonicalize () : void;
		/**
		 *  @private
		 */
		public function toString () : String;
		/**
		 *  @private
		 */
		public function equals (locale:LocaleID) : Boolean;
		/**
		 *  @private
		 */
		public function isSiblingOf (other:LocaleID) : Boolean;
		/**
		 *  @private
		 */
		public function transformToParent () : Boolean;
	}
	/**
	 *  @private
	 */
	internal class LocaleRegistry
	{
		/**
		 *  @private     *  A list of codes representing writing systems, in arbitrary order.     *  For example, "latn" represents the Latin alphabet, used for     *  writing languages such as English, French, Indonesian, and Swahili,     *  and "arab" represents the Arabic script, used for writing     *  Arabic, Persian, Pashto, and Urdu.
		 */
		private static const SCRIPTS : Array;

	}
}
