package air.update.descriptors
{
	public class ConfigurationDescriptor extends Object
	{
		public static const DIALOG_CHECK_FOR_UPDATE : String;
		public static const DIALOG_DOWNLOAD_PROGRESS : String;
		public static const DIALOG_DOWNLOAD_UPDATE : String;
		public static const DIALOG_FILE_UPDATE : String;
		public static const DIALOG_INSTALL_UPDATE : String;
		public static const DIALOG_UNEXPECTED_ERROR : String;
		public static const NAMESPACE_CONFIGURATION_1_0 : Namespace;

		public function get checkInterval () : Number;

		public function get defaultUI () : Array;

		public function get url () : String;

		public function ConfigurationDescriptor (xml:XML);

		public static function isThisVersion (ns:Namespace) : Boolean;

		public function validate () : void;
	}
}
