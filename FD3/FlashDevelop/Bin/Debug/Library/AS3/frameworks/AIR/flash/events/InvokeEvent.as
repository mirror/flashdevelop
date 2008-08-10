/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	import flash.filesystem.File;
	public class InvokeEvent extends Event {
		/**
		 * The array of string arguments passed during this invocation. If this is a
		 *  command line invocation, the array contains the command line arguments
		 *  (excluding the process name).
		 */
		public function get arguments():Array;
		/**
		 * The directory that should be used to resolve any relative paths in the arguments
		 *  array.
		 */
		public function get currentDirectory():File;
		/**
		 * The constructor function for the InvokeEvent class.
		 *
		 * @param type              <String> The type of the event, accessible as Event.type.
		 * @param bubbles           <Boolean (default = false)> Set to false for an InvokeEvent object.
		 * @param cancelable        <Boolean (default = false)> Set to false for an InvokeEvent object.
		 * @param dir               <File (default = null)> The directory that should be used to resolve any relative paths in
		 *                            the arguments array.
		 * @param argv              <Array (default = null)> An array of arguments (strings) to pass to the application.
		 */
		public function InvokeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, dir:File = null, argv:Array = null);
		/**
		 * Creates a new copy of this event.
		 *
		 * @return                  <Event> The copy of the event.
		 */
		public override function clone():Event;
		/**
		 * The InvokeEvent.INVOKE constant defines the value of the type
		 *  property of an InvokeEvent object.
		 */
		public static const INVOKE:String = "invoke";
	}
}
