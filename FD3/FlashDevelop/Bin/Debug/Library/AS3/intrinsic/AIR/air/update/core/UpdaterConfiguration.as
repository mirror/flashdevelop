package air.update.core
{
	import air.update.logging.Logger;
	import air.update.descriptors.ConfigurationDescriptor;
	import flash.filesystem.File;

	public class UpdaterConfiguration extends Object
	{
		public function get configurationFile () : File;
		public function set configurationFile (value:File) : void;

		public function get delay () : Number;
		public function set delay (value:Number) : void;

		public function get delayAsMilliseconds () : Number;

		public function get isCheckForUpdateVisible () : Boolean;
		public function set isCheckForUpdateVisible (value:Boolean) : void;

		public function get isDownloadProgressVisible () : Boolean;
		public function set isDownloadProgressVisible (value:Boolean) : void;

		public function get isDownloadUpdateVisible () : Boolean;
		public function set isDownloadUpdateVisible (value:Boolean) : void;

		public function get isFileUpdateVisible () : Boolean;
		public function set isFileUpdateVisible (value:Boolean) : void;

		public function get isInstallUpdateVisible () : Boolean;
		public function set isInstallUpdateVisible (value:Boolean) : void;

		public function get isNewerVersionFunction () : Function;
		public function set isNewerVersionFunction (value:Function) : void;

		public function get isUnexpectedErrorVisible () : Boolean;
		public function set isUnexpectedErrorVisible (value:Boolean) : void;

		public function get updateURL () : String;
		public function set updateURL (value:String) : void;

		public function UpdaterConfiguration ();

		public function validate () : void;
	}
}
