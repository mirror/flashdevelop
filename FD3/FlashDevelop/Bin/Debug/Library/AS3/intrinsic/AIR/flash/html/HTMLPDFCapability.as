package flash.html
{
	/// The HTMLPDFCapability class contains possible values of the pdfCapability property of an HTMLLoader object.
	public class HTMLPDFCapability extends Object
	{
		/// [AIR] An error was returned by the OS when trying to load the Adobe Reader or Acrobat application or one of its necessary libraries.
		public static const ERROR_CANNOT_LOAD_READER : int;
		/// [AIR] No version of Adobe Reader is detected.
		public static const ERROR_INSTALLED_READER_NOT_FOUND : int;
		/// [AIR] Adobe Reader is detected, but the version is too old.
		public static const ERROR_INSTALLED_READER_TOO_OLD : int;
		/// [AIR] A sufficient version (8.1 or later) of Adobe Reader or Acrobat is detected, but the the version of Adobe Reader that is set up to handle PDF content is older than Adobe Reader or Acrobat 8.1.
		public static const ERROR_PREFERRED_READER_TOO_OLD : int;
		/// [AIR] A sufficient version (8.1 or later) of Adobe Reader is detected and PDF content can be loaded in an HTMLLoader object.
		public static const STATUS_OK : int;

		public function HTMLPDFCapability ();
	}
}
