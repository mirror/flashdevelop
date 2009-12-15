package flash.desktop
{
	import flash.events.EventDispatcher;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.display.NativeWindow;
	import flash.display.NativeMenu;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.desktop.InteractiveIcon;

	/**
	 * Dispatched when the operating system detects mouse or keyboard activity after an idle period.
	 * @eventType flash.events.Event.USER_PRESENT
	 */
	[Event(name="userPresent", type="flash.events.Event")] 

	/**
	 * Dispatched when the user has been idle for the period of time specified by the idleThreshold property.
	 * @eventType flash.events.Event.USER_IDLE
	 */
	[Event(name="userIdle", type="flash.events.Event")] 

	/**
	 * Dispatched when either a new network connection becomes available or an existing network connection is lost.
	 * @eventType flash.events.Event.NETWORK_CHANGE
	 */
	[Event(name="networkChange", type="flash.events.Event")] 

	/**
	 * Dispatched when the application exit sequence is started.
	 * @eventType flash.events.Event.EXITING
	 */
	[Event(name="exiting", type="flash.events.Event")] 

	/**
	 * Dispatched when the desktop focus is switched to a different application.
	 * @eventType flash.events.Event.DEACTIVATE
	 */
	[Event(name="deactivate", type="flash.events.Event")] 

	/**
	 * Dispatched when this application becomes the active desktop application.
	 * @eventType flash.events.Event.ACTIVATE
	 */
	[Event(name="activate", type="flash.events.Event")] 

	/**
	 * Dispatched when an application is invoked.
	 * @eventType flash.events.InvokeEvent.INVOKE
	 */
	[Event(name="invoke", type="flash.events.InvokeEvent")] 

	/// The NativeApplication class represents this AIR application.
	public class NativeApplication extends EventDispatcher
	{
		/// The active application window.
		public function get activeWindow () : NativeWindow;

		/// The contents of the application descriptor file for this AIR application.
		public function get applicationDescriptor () : XML;

		/// The application ID of this application.
		public function get applicationID () : String;

		/// Specifies whether the application should automatically terminate when all windows have been closed.
		public function get autoExit () : Boolean;
		public function set autoExit (value:Boolean) : void;

		/// The application icon.
		public function get icon () : InteractiveIcon;

		/// The number of seconds that must elapse without keyboard or mouse input before a userIdle event is dispatched.
		public function get idleThreshold () : int;
		public function set idleThreshold (value:int) : void;

		/// The application menu.
		public function get menu () : NativeMenu;
		public function set menu (menu:NativeMenu) : void;

		/// The singleton instance of the NativeApplication object.
		public static function get nativeApplication () : NativeApplication;

		/// An array containing all the open native windows of this application.
		public function get openedWindows () : Array;

		/// The publisher ID of this application.
		public function get publisherID () : String;

		/// The patch level of the runtime hosting this application.
		public function get runtimePatchLevel () : uint;

		/// The version number of the runtime hosting this application.
		public function get runtimeVersion () : String;

		/// Specifies whether this application is automatically launched whenever the current user logs in.
		public function get startAtLogin () : Boolean;
		public function set startAtLogin (startAtLogin:Boolean) : void;

		/// Indicates whether AIR supports application dock icons on the current operating system.
		public static function get supportsDockIcon () : Boolean;

		/// Specifies whether the current operating system supports a global application menu bar.
		public static function get supportsMenu () : Boolean;

		/// Specifies whether AIR supports system tray icons on the current operating system.
		public static function get supportsSystemTrayIcon () : Boolean;

		/// The time, in seconds, since the last mouse or keyboard input.
		public function get timeSinceLastUserInput () : int;

		/// Activates this application.
		public function activate (window:NativeWindow = null) : void;

		/// Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

		/// Invokes an internal delete command on the focused display object.
		public function clear () : Boolean;

		/// Invokes an internal copy command on the focused display object.
		public function copy () : Boolean;

		/// Invokes an internal cut command on the focused display object.
		public function cut () : Boolean;

		/// Dispatches an event into the event flow.
		public function dispatchEvent (event:Event) : Boolean;

		/// Terminates this application.
		public function exit (errorCode:int = 0) : void;

		/// Gets the default application for opening files with the specified extension.
		public function getDefaultApplication (extension:String) : String;

		/// Specifies whether this application is currently the default application for opening files with the specified extension.
		public function isSetAsDefaultApplication (extension:String) : Boolean;

		public function NativeApplication ();

		/// Invokes an internal paste command on the focused display object.
		public function paste () : Boolean;

		public function redo () : Boolean;

		/// Removes this application as the default for opening files with the specified extension.
		public function removeAsDefaultApplication (extension:String) : void;

		/// Removes a listener from the EventDispatcher object.
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;

		/// Invokes an internal selectAll command on the focused display object.
		public function selectAll () : Boolean;

		/// Sets this application as the default application for opening files with the specified extension.
		public function setAsDefaultApplication (extension:String) : void;

		public function undo () : Boolean;
	}
}
