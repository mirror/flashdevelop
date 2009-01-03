package flash.events
{
	import flash.filesystem.File;
	import flash.events.Event;

	/// The NativeApplication object of an AIR application dispatches an invoke event when the application is invoked.
	public class InvokeEvent extends Event
	{
		/// [AIR] The InvokeEvent.INVOKE constant defines the value of the type property of an InvokeEvent object.
		public static const INVOKE : String = "invoke";

		/// [AIR] The array of string arguments passed during this invocation.
		public function get arguments () : Array;

		/// [AIR] The directory that should be used to resolve any relative paths in the arguments array.
		public function get currentDirectory () : File;

		/// [AIR] Creates a new copy of this event.
		public function clone () : Event;
	}
}
