package mx.resources
{
include "../core/Version.as"
	/**
	 *  @private
 *  The APIs of the LocaleSorter class provides the sorting functionality 
 *  of application locales against system preferences.
	 */
	public class LocaleSorter
	{
		/**
		 *  @private
     *	Sorts a list of locales using the order specified
     *  by the user preferences.
	 * 
	 * 	@param appLocales An Array of locales supported by the application.
     *
	 * 	@param systemPreferences The locale chain of user-preferred locales.
     *
	 * 	@param ultimateFallbackLocale The ultimate fallback locale
     *  that will be used when no locale from systemPreference matches 
	 * 	a locale from application supported locale list.
     *
	 * 	@param addAll When true, adds all the non-matching locales
     *  at the end of the result list preserving the given order.
	 *
	 *	@return A locale chain that matches user preferences order.
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
	 *  @private
 *  The APIs of the internal LocaleID class parse a locale string
 *  according to:
 *  RFC 4646: http://www.ietf.org/rfc/rfc4646.txt
 *  RFC 4647: http://www.ietf.org/rfc/rfc4647.txt
 *  IANA Language Subtag Registry:
 *  http://www.iana.org/assignments/language-subtag-registry
	 */
	private class LocaleID
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
		private static function appendElements (dest:Array, src:Array) : void;

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
	private class LocaleRegistry
	{
		/**
		 *  @private
     *  A list of codes representing writing systems, in arbitrary order.
     *  For example, "latn" represents the Latin alphabet, used for
     *  writing languages such as English, French, Indonesian, and Swahili,
     *  and "arab" represents the Arabic script, used for writing
     *  Arabic, Persian, Pashto, and Urdu.
		 */
		private static const SCRIPTS : Array;
		/**
		 *  @private
     *  The inverse of the SCRIPT Array.
     *  Maps a script code (like "jpan" for Japanese)
     *  to its index in the SCRIPT Array.
		 */
		private static const SCRIPT_BY_ID : Object;
		/**
		 *  @private
     *  This table maps a language and a script to the most
     *  prominent region where that combination is used.
     *
     *  Note: "is" must be quoted because it is a reserved word.
		 */
		private static const DEFAULT_REGION_BY_LANG_AND_SCRIPT : Object;
		/**
		 *  @private
     *  This table maps a language to a script.
     *  It was derived from the entries at
     *  http://www.iana.org/assignments/language-subtag-registry
     *  which have a Suppress-Script property.
     *
     *  Note: "as", "in", and "is" must be quoted
     *  because they are reserved words.
		 */
		private static const SCRIPT_ID_BY_LANG : Object;
		/**
		 *  @private
     *  This table maps a language-as-spoken-in-a-region
     *  to the script used to write it.
     *
     *  Chinese in China -> Simplified Chinese
     *  Chinese in Singapore -> Simplified Chinese
     *  Chinese in Taiwan -> Traditional Chinese
     *  Chinese in Hong Kong -> Traditional Chinese 
     *  Chinese in Macao -> Traditional Chinese 
     *  Mongolian in China -> Mongolian
     *  Mongolian in Singapore -> Cyrillic
     *  Punjabi in Pakistan -> Arabic
     *  Punjabi in India -> Punjabi
     *  Hausa in Ghana -> Latin
     *  Hausa in Niger -> Latin
		 */
		private static const SCRIPT_ID_BY_LANG_AND_REGION : Object;

		/**
		 *  @private
     *  Given a language and a region, returns the script system
     *  used to write the language there.
     *
     *  Examples:
     *  lang zh (Chinese), region cn (China) -> hans (Simplified Chinese)
     *  lang zh (Chinese), region tw (Taiwan) -> hast (Traditional Chinese)
		 */
		public static function getScriptByLangAndRegion (lang:String, region:String) : String;

		/**
		 *  @private
     *  Given a language, returns the script generally used to write it.
     *
     *  Examples:
     *  lang bg (Bulgarian) -> cyrl (Cyrillic)
		 */
		public static function getScriptByLang (lang:String) : String;

		/**
		 *  @private
     *  Given a language and a script used for writing it,
     *  returns the most prominent region where that combination is used.
     *
     *  Examples:
		 */
		public static function getDefaultRegionForLangAndScript (lang:String, script:String) : String;
	}
}
