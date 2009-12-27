package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import mx.core.ApplicationGlobals;
	import mx.core.mx_internal;
	import mx.core.Singleton;
	import mx.events.BrowserChangeEvent;
	import mx.managers.BrowserManager;
	import mx.managers.IHistoryManagerClient;
	import mx.managers.HistoryManagerGlobals;

include "../core/Version.as"
include "../core/Version.as"
	/**
	 *  @private
	 */
	public class HistoryManagerImpl implements IHistoryManager
	{
		/**
		 *  @private
	 *  The interval between handshake attempts.
		 */
		private static const HANDSHAKE_INTERVAL : int = 500;
		/**
		 *  @private
	 *  The maximum number of handshake attempts.
		 */
		private static const MAX_HANDSHAKE_TRIES : int = 100;
		/**
		 *  @private
	 *  The separator between the object identifier (the crc of its path)
	 *  and the property name.
		 */
		private static const ID_NAME_SEPARATOR : String = "-";
		/**
		 *  @private
	 *  The separator between the property name and the property value.
		 */
		private static const NAME_VALUE_SEPARATOR : String = "=";
		/**
		 *  @private
	 *  The separator between consecutive object/property/value triples.
		 */
		private static const PROPERTY_SEPARATOR : String = "&";
		/**
		 *  @private
		 */
		private static var systemManager : ISystemManager;
		/**
		 *  @private
		 */
		private static var instance : IHistoryManager;
		/**
		 *  @private
	 *  CRC for the app.
		 */
		private static var appID : String;
		/**
		 *  @private
	 *  URL for history frame.
	 *  This is passed to the SWF via the FlashStatic Vars in the HTML wrapper,
	 *  and is currently "/dev/flex-internal?action=history_html".
		 */
		private static var historyURL : String;
		/**
		 *  @Private
	 *  An Array of objects that will save and load state information.
	 *  Each object must implement the IHistoryManagerClient interface.
		 */
		private var registeredObjects : Array;
		/**
		 *  @private
	 *  A map from a registed object's path to its RegistrationInfo
	 *  (path crc and path depth).
		 */
		private var registrationMap : Dictionary;
		/**
		 *  @private
	 *  Pending states for deferred restoration.
		 */
		private var pendingStates : Object;
		/**
		 *  @private
	 *  Pending query string to be sent to history.swf.
		 */
		private var pendingQueryString : String;

		/**
		 *  @private
		 */
		public static function getInstance () : IHistoryManager;

		/**
		 *  @private
		 */
		public function HistoryManagerImpl ();

		/**
		 *  Registers an object with the HistoryManager.
	 *  The object must implement the IHistoryManagerClient interface.
	 *
	 *  @param obj Object to register.
	 *
	 *  @see mx.managers.IHistoryManagerClient
		 */
		public function register (obj:IHistoryManagerClient) : void;

		/**
		 *  @private
		 */
		private function getPath (obj:IHistoryManagerClient) : String;

		/**
		 *  @private
	 *  Function to calculate a cyclic rendundancy checksum (CRC).
	 *  This returns a 4-character hex string representing a 16-bit uint
	 *  calculated from the specified string using the CRC-CCITT mask.
	 *  In http://www.joegeluso.com/software/articles/ccitt.htm,
	 *  the following sample input and output is given to check
	 *  this implementation:
	 *  "" -> "1D0F"
	 *  "A" -> "9479"
	 *  "123456789" -> "E5CC"
	 *  "AA...A" (256 A's) ->"E938"
		 */
		private function calcCRC (s:String) : String;

		/**
		 *  @private
		 */
		private function updateCRC (crc:uint, byte:uint) : uint;

		/**
		 *  @private
		 */
		private function calcDepth (path:String) : int;

		/**
		 *  @private
		 */
		private function depthCompare (a:Object, b:Object) : int;

		/**
		 *  @private
		 */
		private function getRegistrationInfo (obj:IHistoryManagerClient) : RegistrationInfo;

		/**
		 *  Unregisters an object with the HistoryManager.
	 *
	 *  @param obj Object to unregister.
		 */
		public function unregister (obj:IHistoryManagerClient) : void;

		/**
		 *  Saves the application's current state so it can be restored later.
	 *  This method is automatically called by navigator containers
	 *  whenever their navigation state changes.
	 *  If you registered an interface with the HistoryManager,
	 *  you are responsible for calling the <code>save()</code> method
	 *  when the application state changes.
		 */
		public function save () : void;

		/**
		 *  @private
	 *  Reloads the _history iframe with the history SWF.
		 */
		private function submitQuery () : void;

		/**
		 *  @private
	 *  Loads state information.
	 *  Called by the registered() method of history.swf
	 *  after we have returned its handshake.
	 *
	 *  @param stateVars State information.
		 */
		public function browserURLChangeHandler (event:BrowserChangeEvent) : void;

		private function parseString (s:String) : Object;

		public function registered () : void;

		public function registerHandshake () : void;

		public function load (stateVars:Object) : void;

		public function loadInitialState () : void;
	}
	/**
	 *  @private
	 */
	private class RegistrationInfo
	{
		/**
		 *  @private
		 */
		public var crc : String;
		/**
		 *  @private
		 */
		public var depth : int;

		/**
		 *  Constructor.
		 */
		public function RegistrationInfo (crc:String, depth:int);
	}
}
