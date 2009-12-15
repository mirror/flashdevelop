package air.update.utils
{
	public class VersionUtils extends Object
	{
		public static function getApplicationID () : String;

		public static function getApplicationVersion () : String;

		public static function isNewerVersion (currentVersion:String, newVersion:String) : Boolean;

		public function VersionUtils ();
	}
}
