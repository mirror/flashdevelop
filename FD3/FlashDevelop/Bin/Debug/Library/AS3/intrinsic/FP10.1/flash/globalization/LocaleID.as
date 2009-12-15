package flash.globalization
{
	public class LocaleID extends Object
	{
		public static const DEFAULT : String;

		public function get lastOperationStatus () : String;

		public function get name () : String;

		public static function determinePreferredLocales (want:Vector.<String>, have:Vector.<String>, keyword:String = "userinterface") : Vector.<String>;

		public function getKeysAndValues () : Object;

		public function getLanguage () : String;

		public function getRegion () : String;

		public function getScript () : String;

		public function getVariant () : String;

		public function isRightToLeft () : Boolean;

		public function LocaleID (name:String);
	}
}
