/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.resources {
	import mx.managers.ISystemManager;
	public class Locale {
		/**
		 * The country code of this Locale instance. [Read-Only]
		 */
		public function get country():String;
		/**
		 * The language code of this Locale instance. [Read-Only]
		 */
		public function get language():String;
		/**
		 * The variant part of this Locale instance. [Read-Only]
		 */
		public function get variant():String;
		/**
		 * Constructor.
		 *
		 * @param localeString      <String> A 1-, 2-, or 3-part locale String,
		 *                            such as "en", "en_US", or "en_US_MAC".
		 *                            The parts are separated by underscore characters.
		 *                            The first part is a two-letter lowercase language code
		 *                            as defined by ISO-639, such as "en" for English.
		 *                            The second part is a two-letter uppercase country code
		 *                            as defined by ISO-3166, such as "US" for the United States.
		 *                            The third part is a variant String, which can be used
		 *                            to optionally distinguish multiple locales for the same language and country.
		 *                            It is sometimes used to indicate the operating system
		 *                            that the locale should be used with, such as "MAC", "WIN", or "UNIX".
		 */
		public function Locale(localeString:String);
		/**
		 * Deprecated Since 3.0: Please Use ResourceManager.localeChain
		 *
		 * @param sm                <ISystemManager> The current SystemManager.
		 */
		public static function getCurrent(sm:ISystemManager):Locale;
		/**
		 * Returns the locale String that was used to construct
		 *  this Locale instance.
		 */
		public function toString():String;
	}
}
