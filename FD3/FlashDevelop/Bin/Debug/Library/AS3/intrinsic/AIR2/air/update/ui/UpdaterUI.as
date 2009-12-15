package air.update.ui
{
	import air.update.ApplicationUpdater;
	import flash.filesystem.File;
	import air.update.ui.EmbeddedUILoader;
	import flash.events.Event;

	public class UpdaterUI extends ApplicationUpdater
	{
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

		public function get isUnexpectedErrorVisible () : Boolean;
		public function set isUnexpectedErrorVisible (value:Boolean) : void;

		public function get localeChain () : Array;
		public function set localeChain (value:Array) : void;

		public function addResources (lang:String, res:Object) : void;

		public function cancelUpdate () : void;

		public function checkForUpdate () : void;

		public function checkNow () : void;

		public function downloadUpdate () : void;

		public function installFromAIRFile (file:File) : void;

		public function installUpdate () : void;

		public function UpdaterUI ();
	}
}
