package air.update
{
	import flash.events.EventDispatcher;
	import air.update.logging.Logger;
	import flash.filesystem.File;
	import flash.events.Event;
	import air.update.ui.UpdaterUI;
	import flash.events.ErrorEvent;

	/**
	 * Dispatched when an error occurred either during initialization or during the update process (if something unexpected happens).
	 * @eventType flash.events.ErrorEvent.ERROR
	 */
	[Event(name="error", type="flash.events.ErrorEvent")] 

	/**
	 * Dispatched after the initialization is complete.
	 * @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 

	/**
	 * Dispatched when an error occurs validating the file passed as the airFile parameter in a call to the installFromAIRFile() method.
	 * @eventType flash.events.StatusFileUpdateErrorEvent.FILE_UPDATE_ERROR
	 */
	[Event(name="fileUpdateError", type="flash.events.StatusFileUpdateErrorEvent")] 

	/**
	 * Dispatched after the updater successfully validates the file in the call to the installFromAIRFile() method.
	 * @eventType flash.events.StatusFileUpdateEvent.FILE_UPDATE_STATUS
	 */
	[Event(name="fileUpdateStatus", type="flash.events.StatusFileUpdateEvent")] 

	/**
	 * Dispatched if there is an error while connecting or downloading the update file.
	 * @eventType flash.events.DownloadErrorEvent.DOWNLOAD_ERROR
	 */
	[Event(name="downloadError", type="flash.events.DownloadErrorEvent")] 

	/**
	 * Dispatched if an error occurs while trying to download or parse the update descriptor file.
	 * @eventType flash.events.StatusUpdateErrorEvent.UPDATE_ERROR
	 */
	[Event(name="updateError", type="flash.events.StatusUpdateErrorEvent")] 

	/**
	 * Dispatched after the updater successfully downloads and interprets the update descriptor file.
	 * @eventType flash.events.StatusUpdateEvent.UPDATE_STATUS
	 */
	[Event(name="updateStatus", type="flash.events.StatusUpdateEvent")] 

	/**
	 * Dispatched just before installing the update, after the installUpdate() method was called.
	 * @eventType flash.events.UpdateEvent.BEFORE_INSTALL
	 */
	[Event(name="beforeInstall", type="flash.events.UpdateEvent")] 

	/**
	 * Dispatched when the download of the update file is complete.
	 * @eventType flash.events.UpdateEvent.DOWNLOAD_COMPLETE
	 */
	[Event(name="downloadComplete", type="flash.events.UpdateEvent")] 

	/**
	 * Dispatched after a call to the downloadUpdate() method and the connection to the server is established.
	 * @eventType flash.events.UpdateEvent.DOWNLOAD_START
	 */
	[Event(name="downloadStart", type="flash.events.UpdateEvent")] 

	/**
	 * Dispatched before the update process begins, just before the updater tries to download the update descriptor file.
	 * @eventType flash.events.UpdateEvent.CHECK_FOR_UPDATE
	 */
	[Event(name="checkForUpdate", type="flash.events.UpdateEvent")] 

	/**
	 * Dispatched after the initialization is complete.
	 * @eventType flash.events.UpdateEvent.INITIALIZED
	 */
	[Event(name="initialized", type="flash.events.UpdateEvent")] 

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
