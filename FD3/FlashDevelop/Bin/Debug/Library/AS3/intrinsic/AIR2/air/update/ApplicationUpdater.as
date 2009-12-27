package air.update
{
	import air.update.states.HSM;
	import air.update.logging.Logger;
	import flash.events.Event;
	import air.update.core.UpdaterState;
	import flash.filesystem.File;
	import flash.events.TimerEvent;
	import air.update.core.UpdaterHSM;
	import flash.utils.Timer;
	import air.update.events.StatusFileUpdateEvent;
	import air.update.events.UpdateEvent;
	import air.update.core.UpdaterConfiguration;

	/// The ApplicationUpdater class defines the basic functionality of the update framework for Adobe® AIR™ applications, without providing any default user interface.
	public class ApplicationUpdater extends HSM
	{
		/// The location of the configuration file that sets the values for delay and updateURL properties.
		public function get configurationFile () : File;
		public function set configurationFile (value:File) : void;

		/// The internal state of the updater.
		public function get currentState () : String;

		/// The current version of the application.
		public function get currentVersion () : String;

		/// The interval, in days, between periodic checks of new updates.
		public function get delay () : Number;
		public function set delay (value:Number) : void;

		/// Whether this is the first run after a successful update (true) or not (false).
		public function get isFirstRun () : Boolean;

		/// A function that the updater should use to perform version comparisons.
		public function get isNewerVersionFunction () : Function;
		public function set isNewerVersionFunction (value:Function) : void;

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

		/// The constructor function.
		public function ApplicationUpdater ();

		/// Cancels the update process.
		public function cancelUpdate () : void;

		/// Asynchronously downloads and interprets the update descriptor file.
		public function checkForUpdate () : void;

		/// Starts the update process.
		public function checkNow () : void;

		/// Asynchronously downloads the update file.
		public function downloadUpdate () : void;

		/// Initializes the updater.
		public function initialize () : void;

		/// Starts the update process using a local AIR file.
		public function installFromAIRFile (file:File) : void;

		/// Installs the update file.
		public function installUpdate () : void;
	}
}
