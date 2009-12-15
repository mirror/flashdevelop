package flash.events
{
	import flash.events.Event;

	/// An HTMLLoader object dispatches an HTMLUncaughtScriptExceptionEvent object whenever a JavaScript exception is thrown and not handled with a catch statement.
	public class HTMLUncaughtScriptExceptionEvent extends Event
	{
		/// The result of evaluating the expression in the throw statement that resulted in the uncaught exception.
		public var exceptionValue : *;
		/// The HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION constant defines the value of the type property of an uncaughtScriptException event object.
		public static const UNCAUGHT_SCRIPT_EXCEPTION : *;

		/// An array of objects that represent the stack trace at the time the throw statement that resulted in the uncaught exception was executed.
		public function get stackTrace () : Array;
		public function set stackTrace (newValue:Array) : void;

		/// Creates a copy of the HTMLUncaughtScriptExceptionEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Creates an HTMLUncaughtScriptExceptionEvent object to pass as a parameter to event listeners.
		public function HTMLUncaughtScriptExceptionEvent (exceptionValue:*);
	}
}
