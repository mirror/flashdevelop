package flash.events
{
	import flash.filesystem.File;
	import flash.events.Event;

	/// The NativeApplication object of an AIR application dispatches an invoke event when the application is invoked.
	public class InvokeEvent extends Event
	{
		/// The InvokeEvent.INVOKE constant defines the value of the type property of an InvokeEvent object.
		public static const INVOKE : String = "invoke";

		/// The array of string arguments passed during this invocation.
		public function get arguments () : Array;

		/// The directory that should be used to resolve any relative paths in the arguments array.
		public function get currentDirectory () : File;

		public function get reason () : String;

		/// Creates a new copy of this event.
		public function clone () : Event;

		/// The constructor function for the InvokeEvent class.
		public function InvokeEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, dir:File = null, argv:Array = null, reason:String = "standard");
	}
}
