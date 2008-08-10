/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class HTMLUncaughtScriptExceptionEvent extends Event {
		/**
		 * The result of evaluating the expression in the throw statement that resulted in the
		 *  uncaught exception. The exceptionValue property can be a primitive
		 *  value, a reference to a JavaScript object, or a reference to an ActionScript object.
		 */
		public var exceptionValue:*;
		/**
		 * An array of objects that represent the stack trace at the time the throw statement
		 *  that resulted in the uncaught exception was executed.  Each object in the array has
		 *  three properties:
		 *  sourceURL (a string): The URL of the script of the call stack frame.
		 *  line (a number): The line number in the sourceURL
		 *  resource of the call stack frame.
		 *  functionName (a string): The name of the function for the call stack frame.
		 */
		public var stackTrace:Array;
		/**
		 * Creates an HTMLUncaughtScriptExceptionEvent object to pass as a parameter to event listeners.
		 *
		 * @param exceptionValue    <*> When a JavaScript process throws an uncaught exception, the
		 *                            exceptionValue is the result of evaluating the expression in the throw
		 *                            statement that resulted in the uncaught exception. The exceptionValue
		 *                            property can be a primitive value, a reference to a JavaScript object, or a reference to an
		 *                            ActionScript object.
		 */
		public function HTMLUncaughtScriptExceptionEvent(exceptionValue:*);
		/**
		 * Creates a copy of the HTMLUncaughtScriptExceptionEvent object and sets
		 *  the value of each property to match that of the original.
		 *
		 * @return                  <Event> The copy of the HTMLUncaughtScriptExceptionEvent object.
		 */
		public override function clone():Event;
		/**
		 * The HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION constant
		 *  defines the value of the type property of an
		 *  uncaughtScriptException event object.
		 */
		public static const UNCAUGHT_SCRIPT_EXCEPTION:* = uncaughtScriptException;
	}
}
