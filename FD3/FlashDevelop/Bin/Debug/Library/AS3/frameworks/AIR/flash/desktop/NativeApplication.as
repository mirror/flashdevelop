/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.desktop {
	import flash.events.EventDispatcher;
	import flash.display.NativeWindow;
	import flash.display.NativeMenu;
	import flash.events.Event;
	public final  class NativeApplication extends EventDispatcher {
		/**
		 * The active application window.
		 */
		public function get activeWindow():NativeWindow;
		/**
		 * The contents of the application descriptor file for this AIR application.
		 */
		public function get applicationDescriptor():XML;
		/**
		 * The application ID of this application.
		 */
		public function get applicationID():String;
		/**
		 * Specifies whether the application should automatically terminate when
		 *  all windows have been closed.
		 */
		public function get autoExit():Boolean;
		public function set autoExit(value:Boolean):void;
		/**
		 * The application icon.
		 */
		public function get icon():InteractiveIcon;
		/**
		 * The number of seconds that must elapse without keyboard or mouse input
		 *  before a presenceChange event is dispatched.
		 */
		public function get idleThreshold():int;
		public function set idleThreshold(value:int):void;
		/**
		 * The application menu.
		 */
		public function get menu():NativeMenu;
		public function set menu(value:NativeMenu):void;
		/**
		 * The singleton instance of the NativeApplication object.
		 */
		public static function get nativeApplication():NativeApplication;
		/**
		 * An array containing all the open native windows of this application.
		 */
		public function get openedWindows():Array;
		/**
		 * The publisher ID of this application.
		 */
		public function get publisherID():String;
		/**
		 * The patch level of the runtime hosting this application.
		 */
		public function get runtimePatchLevel():uint;
		/**
		 * The version number of the runtime hosting this application.
		 */
		public function get runtimeVersion():String;
		/**
		 * Specifies whether this application is automatically launched whenever the
		 *  current user logs in.
		 */
		public function get startAtLogin():Boolean;
		public function set startAtLogin(value:Boolean):void;
		/**
		 * Indicates whether AIR supports application dock icons on the current operating system.
		 */
		public static function get supportsDockIcon():Boolean;
		/**
		 * Specifies whether the current operating system supports a global application menu bar.
		 */
		public static function get supportsMenu():Boolean;
		/**
		 * Specifies whether AIR supports system tray icons on the current operating system.
		 */
		public static function get supportsSystemTrayIcon():Boolean;
		/**
		 * The time, in seconds, since the last mouse or keyboard input.
		 */
		public function get timeSinceLastUserInput():int;
		/**
		 * Activates this application.
		 *
		 * @param window            <NativeWindow (default = null)> The NativeWindow object of the window to activate along with the application.
		 */
		public function activate(window:NativeWindow = null):void;
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener
		 *  receives notification of an event. You can register event listeners on all nodes in the
		 *  display list for a specific type of event, phase, and priority.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener function that processes the event. This function must accept
		 *                            an Event object as its only parameter and must return nothing, as this example shows:
		 *                            function(evt:Event):void
		 *                            The function can have any name.
		 * @param useCapture        <Boolean (default = false)> Determines whether the listener works in the capture phase or the
		 *                            target and bubbling phases. If useCapture is set to true,
		 *                            the listener processes the event only during the capture phase and not in the
		 *                            target or bubbling phase. If useCapture is false, the
		 *                            listener processes the event only during the target or bubbling phase. To listen for
		 *                            the event in all three phases, call addEventListener twice, once with
		 *                            useCapture set to true, then again with
		 *                            useCapture set to false.
		 * @param priority          <int (default = 0)> The priority level of the event listener. The priority is designated by
		 *                            a signed 32-bit integer. The higher the number, the higher the priority. All listeners
		 *                            with priority n are processed before listeners of priority n-1. If two
		 *                            or more listeners share the same priority, they are processed in the order in which they
		 *                            were added. The default priority is 0.
		 * @param useWeakReference  <Boolean (default = false)> Determines whether the reference to the listener is strong or
		 *                            weak. A strong reference (the default) prevents your listener from being garbage-collected.
		 *                            A weak reference does not. Class-level member functions are not subject to garbage
		 *                            collection, so you can set useWeakReference to true for
		 *                            class-level member functions without subjecting them to garbage collection. If you set
		 *                            useWeakReference to true for a listener that is a nested inner
		 *                            function, the function will be garbage-collected and no longer persistent. If you create
		 *                            references to the inner function (save it in another variable) then it is not
		 *                            garbage-collected and stays persistent.
		 */
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		/**
		 * Invokes an internal delete command on the focused display object.
		 *
		 * @return                  <Boolean> true.
		 */
		public function clear():Boolean;
		/**
		 * Invokes an internal copy command on the focused display object.
		 */
		public function copy():Boolean;
		/**
		 * Invokes an internal cut command on the focused display object.
		 *
		 * @return                  <Boolean> true.
		 */
		public function cut():Boolean;
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher
		 *  object upon which the dispatchEvent() method is called.
		 *
		 * @param event             <Event> The Event object that is dispatched into the event flow.
		 *                            If the event is being redispatched, a clone of the event is created automatically.
		 *                            After an event is dispatched, its target property cannot be changed, so you
		 *                            must create a new copy of the event for redispatching to work.
		 * @return                  <Boolean> A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called
		 *                            on the event.
		 */
		public override function dispatchEvent(event:Event):Boolean;
		/**
		 * Terminates this application.
		 *
		 * @param errorCode         <int (default = 0)> The exit code reported to the operating system when this application exits.
		 */
		public function exit(errorCode:int = 0):void;
		/**
		 * Gets the default application for opening files with the specified extension.
		 *
		 * @param extension         <String> A String containing the extension of the file type of interest (without the ".").
		 * @return                  <String> The path of the default application.
		 */
		public function getDefaultApplication(extension:String):String;
		/**
		 * Specifies whether this application is currently the default application
		 *  for opening files with the specified extension.
		 *
		 * @param extension         <String> A String containing the extension of the file type of interest (without the ".").
		 * @return                  <Boolean> true if this application is the default.
		 */
		public function isSetAsDefaultApplication(extension:String):Boolean;
		/**
		 * Invokes an internal paste command on the focused display object.
		 *
		 * @return                  <Boolean> true.
		 */
		public function paste():Boolean;
		/**
		 * Removes this application as the default for opening files with the specified extension.
		 *
		 * @param extension         <String> A String containing the extension of the file type of interest
		 *                            (without the ".").
		 */
		public function removeAsDefaultApplication(extension:String):void;
		/**
		 * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener object to remove.
		 * @param useCapture        <Boolean (default = false)> Specifies whether the listener was registered for the capture phase or the
		 *                            target and bubbling phases. If the listener was registered for both the capture phase and the
		 *                            target and bubbling phases, two calls to removeEventListener() are required
		 *                            to remove both, one call with useCapture() set to true, and another
		 *                            call with useCapture() set to false.
		 */
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		/**
		 * Invokes an internal selectAll command on the focused display object.
		 *
		 * @return                  <Boolean> true.
		 */
		public function selectAll():Boolean;
		/**
		 * Sets this application as the default application for opening files with the specified extension.
		 *
		 * @param extension         <String> A String containing the extension of the file type of interest (without the ".").
		 */
		public function setAsDefaultApplication(extension:String):void;
	}
}
