package flash.desktop
{
	/// The NativeApplication class represents this AIR application.
	public class NativeApplication extends flash.events.EventDispatcher
	{
		/** 
		 * [AIR] Dispatched when the operating system detects mouse or keyboard activity after an idle period.
		 * @eventType flash.events.Event.USER_PRESENT
		 */
		[Event(name="userPresent", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when the user has been idle for the period of time specified by the idleThreshold property.
		 * @eventType flash.events.Event.USER_IDLE
		 */
		[Event(name="userIdle", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when either a new network connection becomes available or an existing network connection is lost.
		 * @eventType flash.events.Event.NETWORK_CHANGE
		 */
		[Event(name="networkChange", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when the application exit sequence is started.
		 * @eventType flash.events.Event.EXITING
		 */
		[Event(name="exiting", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when the desktop focus is switched to a different application.
		 * @eventType flash.events.Event.DEACTIVATE
		 */
		[Event(name="deactivate", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when this application becomes the active desktop application.
		 * @eventType flash.events.Event.ACTIVATE
		 */
		[Event(name="activate", type="flash.events.Event")]

		/** 
		 * [AIR] Dispatched when an application is invoked.
		 * @eventType flash.events.InvokeEvent.INVOKE
		 */
		[Event(name="invoke", type="flash.events.InvokeEvent")]

		/// [AIR] The singleton instance of the NativeApplication object.
		public var nativeApplication:flash.desktop.NativeApplication;

		/// [AIR] The version number of the runtime hosting this application.
		public var runtimeVersion:String;

		/// [AIR] The patch level of the runtime hosting this application.
		public var runtimePatchLevel:uint;

		/// [AIR] The application ID of this application.
		public var applicationID:String;

		/// [AIR] The publisher ID of this application.
		public var publisherID:String;

		/// [AIR] The contents of the application descriptor file for this AIR application.
		public var applicationDescriptor:XML;

		/// [AIR] The application menu.
		public var menu:flash.display.NativeMenu;

		/// [AIR] Specifies whether the application should automatically terminate when all windows have been closed.
		public var autoExit:Boolean;

		/// [AIR] The application icon.
		public var icon:flash.desktop.InteractiveIcon;

		/// [AIR] Specifies whether the current operating system supports a global application menu bar.
		public var supportsMenu:Boolean;

		/// [AIR] Indicates whether AIR supports application dock icons on the current operating system.
		public var supportsDockIcon:Boolean;

		/// [AIR] Specifies whether AIR supports system tray icons on the current operating system.
		public var supportsSystemTrayIcon:Boolean;

		/// [AIR] Specifies whether this application is automatically launched whenever the current user logs in.
		public var startAtLogin:Boolean;

		/// [AIR] The active application window.
		public var activeWindow:flash.display.NativeWindow;

		/// [AIR] An array containing all the open native windows of this application.
		public var openedWindows:Array;

		/// [AIR] The time, in seconds, since the last mouse or keyboard input.
		public var timeSinceLastUserInput:int;

		/// [AIR] The number of seconds that must elapse without keyboard or mouse input before a presenceChange event is dispatched.
		public var idleThreshold:int;

		/// [AIR] Terminates this application.
		public function exit(errorCode:int=0):void;

		/// [AIR] Activates this application.
		public function activate(window:flash.display.NativeWindow=null):void;

		/// [AIR] Invokes an internal copy command on the focused display object.
		public function copy():Boolean;

		/// [AIR] Invokes an internal cut command on the focused display object.
		public function cut():Boolean;

		/// [AIR] Invokes an internal paste command on the focused display object.
		public function paste():Boolean;

		/// [AIR] Invokes an internal delete command on the focused display object.
		public function clear():Boolean;

		/// [AIR] Invokes an internal selectAll command on the focused display object.
		public function selectAll():Boolean;

		/// [AIR] Gets the default application for opening files with the specified extension.
		public function getDefaultApplication(extension:String):String;

		/// [AIR] Specifies whether this application is currently the default application for opening files with the specified extension.
		public function isSetAsDefaultApplication(extension:String):Boolean;

		/// [AIR] Sets this application as the default application for opening files with the specified extension.
		public function setAsDefaultApplication(extension:String):void;

		/// [AIR] Removes this application as the default for opening files with the specified extension.
		public function removeAsDefaultApplication(extension:String):void;

		/// [AIR] Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void;

		/// [AIR] Removes a listener from the EventDispatcher object.
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void;

		/// [AIR] Dispatches an event into the event flow.
		public function dispatchEvent(event:flash.events.Event):Boolean;

	}

}

