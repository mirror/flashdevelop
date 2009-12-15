package mx.resources
{
	import mx.resources.IResourceBundle;
	import flash.system.ApplicationDomain;
	import mx.resources.ResourceBundle;

	public class ResourceBundle extends Object implements IResourceBundle
	{
		public var _bundleName : String;
		public var _locale : String;
		public static var backupApplicationDomain : ApplicationDomain;
		public static var locale : String;
		public static const VERSION : String;

		public function get bundleName () : String;

		public function get content () : Object;

		public function get locale () : String;

		public function getBoolean (key:String, defaultValue:Boolean = true) : Boolean;

		public function getNumber (key:String) : Number;

		public function getObject (key:String) : Object;

		public static function getResourceBundle (baseName:String, currentDomain:ApplicationDomain = null) : ResourceBundle;

		public function getString (key:String) : String;

		public function getStringArray (key:String) : Array;

		public function ResourceBundle (locale:String = null, bundleName:String = null);
	}
}
