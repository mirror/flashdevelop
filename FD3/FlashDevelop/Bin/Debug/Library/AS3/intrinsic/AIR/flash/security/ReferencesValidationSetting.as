package flash.security
{
	/// The ReferencesValidationSetting class defines constants used by the referencesValidationSetting property of an XMLSignatureValidator object.
	public class ReferencesValidationSetting extends Object
	{
		/// Never check references.
		public static const NEVER : String;
		/// Only check references if the signing certificate is valid and trusted.
		public static const VALID_IDENTITY : String;
		/// Check references even if the signing certificate is untrusted (does not chain to a known trusted root).
		public static const VALID_OR_UNKNOWN_IDENTITY : String;

		public function ReferencesValidationSetting ();
	}
}
