/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.html {
	public final  class HTMLPDFCapability {
		/**
		 * An error was returned by the OS when trying to load the Adobe Reader or Acrobat
		 *  application or one of its necessary libraries.
		 */
		public static const ERROR_CANNOT_LOAD_READER:int = 3204;
		/**
		 * No version of Adobe Reader is detected. An HTMLLoader
		 *  object cannot display PDF content.
		 */
		public static const ERROR_INSTALLED_READER_NOT_FOUND:int = 3201;
		/**
		 * Adobe Reader is detected, but the version is too old. An HTMLLoader
		 *  object cannot display PDF content.
		 */
		public static const ERROR_INSTALLED_READER_TOO_OLD:int = 3202;
		/**
		 * A sufficient version (8.1 or later) of Adobe Reader or Acrobat is detected, but the the version
		 *  of Adobe Reader that is set up to handle PDF content is older than Adobe Reader or Acrobat 8.1.
		 *  An HTMLLoader object cannot display PDF content.
		 */
		public static const ERROR_PREFERRED_READER_TOO_OLD:int = 3203;
		/**
		 * A sufficient version (8.1 or later) of Adobe Reader is detected and PDF content
		 *  can be loaded in an HTMLLoader object.
		 */
		public static const STATUS_OK:int = 0;
	}
}
