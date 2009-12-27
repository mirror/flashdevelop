﻿package mx.resources
{
	import mx.managers.ISystemManager;

include "../core/Version.as"
	/**
	 *  The Locale class can be used to parse a locale String such as <code>"en_US_MAC"</code>
 *  into its three parts: a language code, a country code, and a variant.
 *
 *  <p>The localization APIs in the IResourceManager and IResourceBundle
 *  interfaces use locale Strings rather than Locale instances,
 *  so this class is seldom used in an application.</p>
 *
 *  @see mx.resources.IResourceBundle
 *  @see mx.resources.IResourceManager
	 */
	public class Locale
	{
		/**
		 *  @private
		 */
		private static var currentLocale : Locale;
		/**
		 *  @private
		 */
		private var localeString : String;
		/**
		 *  @private
     *  Storage for the language property.
		 */
		private var _language : String;
		/**
		 *  @private
     *  Storage for the country property.
		 */
		private var _country : String;
		/**
		 *  @private
     *  Storage for the variant property.
		 */
		private var _variant : String;

		/**
		 *  The language code of this Locale instance. [Read-Only]
     *
     *  <pre>
     *  var locale:Locale = new Locale("en_US_MAC");
     *  trace(locale.language); // outputs "en"
     *  </pre>
		 */
		public function get language () : String;

		/**
		 *  The country code of this Locale instance. [Read-Only]
     *
     *  <pre>
     *  var locale:Locale = new Locale("en_US_MAC");
     *  trace(locale.country); // outputs "US"
     *  </pre>
		 */
		public function get country () : String;

		/**
		 *  The variant part of this Locale instance. [Read-Only]
     *
     *  <pre>
     *  var locale:Locale = new Locale("en_US_MAC");
     *  trace(locale.variant); // outputs "MAC"
     *  </pre>
		 */
		public function get variant () : String;

		/**
		 *  Returns a Locale object, if you compiled your application 
     *  for a single locale. Otherwise, it returns <code>null</code>.
     *  
     *  <p>This method has been deprecated because the Flex framework
     *  now supports having resource bundles for multiple locales
     *  in the same application.
     *  You can use the <code>getLocale()</code> method of IResourceManager
     *  to find out which locales the ResourceManager has resource bundles for.
     *  You can use the <code>localeChain</code> property of IResourceManager
     *  to determine which locales the ResourceManager searches for
     *  resources.</p>
     * 
     *  @param sm The current SystemManager.
     *
     *  @return Returns a Locale object.
		 */
		public static function getCurrent (sm:ISystemManager) : Locale;

		/**
		 *  Constructor.
     *
     *  @param localeString A 1-, 2-, or 3-part locale String,
     *  such as <code>"en"</code>, <code>"en_US"</code>, or <code>"en_US_MAC"</code>.
     *  The parts are separated by underscore characters.
     *  The first part is a two-letter lowercase language code
     *  as defined by ISO-639, such as <code>"en"</code> for English.
     *  The second part is a two-letter uppercase country code
     *  as defined by ISO-3166, such as <code>"US"</code> for the United States.
     *  The third part is a variant String, which can be used 
     *  to optionally distinguish multiple locales for the same language and country.
     *  It is sometimes used to indicate the operating system
     *  that the locale should be used with, such as <code>"MAC"</code>, <code>"WIN"</code>, or <code>"UNIX"</code>.
		 */
		public function Locale (localeString:String);

		/**
		 *  Returns the locale String that was used to construct
     *  this Locale instance. For example:
     *
     *  <pre>
     *  var locale:Locale = new Locale("en_US_MAC");
     *  trace(locale.toString()); // outputs "en_US_MAC"
     *  </pre>
     *
     *  @return Returns the locale String that was used to
     *  construct this Locale instance.
		 */
		public function toString () : String;
	}
}
