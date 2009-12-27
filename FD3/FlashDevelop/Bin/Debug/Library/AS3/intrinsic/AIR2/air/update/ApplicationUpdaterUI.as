package air.update
{
	import flash.events.EventDispatcher;
	import air.update.logging.Logger;
	import flash.filesystem.File;
	import flash.events.Event;
	import air.update.ui.UpdaterUI;
	import flash.events.ErrorEvent;

	/// The ApplicationUpdaterUI class defines the basic functionality of the update framework for Adobe® AIR™ applications, and it provides a default user interface.
	public class ApplicationUpdaterUI extends EventDispatcher
	{
		/// The location of the configuration file that sets the values for delay and updateURL properties.
		public function get configurationFile () : File;
		public function set configurationFile (value:File) : void;

		/// The current version of the application.
		public function get currentVersion () : String;

		/// The interval, in days, between periodic checks of new updates.
		public function get delay () : Number;
		public function set delay (value:Number) : void;

		/// Enables the visibility of the Check for Update, No Update, and Update Error dialog boxes.
		public function get isCheckForUpdateVisible () : Boolean;
		public function set isCheckForUpdateVisible (value:Boolean) : void;

		/// Enables the visibility of the Download Update dialog box.
		public function get isDownloadProgressVisible () : Boolean;
		public function set isDownloadProgressVisible (value:Boolean) : void;

		/// Enables the visibility of the Download Update dialog box.
		public function get isDownloadUpdateVisible () : Boolean;
		public function set isDownloadUpdateVisible (value:Boolean) : void;

		/// Enables the visibility of the File Update, File No Update, and File Error dialog boxes.
		public function get isFileUpdateVisible () : Boolean;
		public function set isFileUpdateVisible (value:Boolean) : void;

		/// Whether this is the first run after a successful update (true) or not (false).
		public function get isFirstRun () : Boolean;

		/// Enables the visibility of the Install Update dialog box.
		public function get isInstallUpdateVisible () : Boolean;
		public function set isInstallUpdateVisible (value:Boolean) : void;

		/// A function that the updater should use to perform version comparisons.
		public function get isNewerVersionFunction () : Function;
		public function set isNewerVersionFunction (value:Function) : void;

		/// Enables the visibility of the Unexpected Error dialog box.
		public function get isUnexpectedErrorVisible () : Boolean;
		public function set isUnexpectedErrorVisible (value:Boolean) : void;

		/// A Boolean property, which is true if an update is running, false otherwise.
		public function get isUpdateInProgress () : Boolean;

		/// An array defining the locale chain used by the user interface.
		public function get localeChain () : Array;
		public function set localeChain (value:Array) : void;

		/// The previous location of the application storage directory, if it changed after an update.
		public function get previousApplicationStorageDirectory () : File;

		/// The previous version of the application.
		public function get previousVersion () : String;

		/// The content of the update descriptor file downloaded from the update URL.
		public function get updateDescriptor () : XML;

		/// The location of the update descriptor file.
		public function get updateURL () : String;
		public function set updateURL (value:String) : void;

		/// Whether there was a postponed update, even if it failed to install (true); false otherwise.
		public function get wasPendingUpdate () : Boolean;

		/// Dynamically adds a new resource bundle for the specified language.
		public function addResources (lang:String, res:Object) : void;

		/// The constructor function.
		public function ApplicationUpdaterUI ();

		/// Cancels the update process.
		public function cancelUpdate () : void;

		/// Starts the update process.
		public function checkNow () : void;

		/// Initializes the updater.
		public function initialize () : void;

		/// Starts the update process using a local AIR file.
		public function installFromAIRFile (file:File) : void;
	}
}
