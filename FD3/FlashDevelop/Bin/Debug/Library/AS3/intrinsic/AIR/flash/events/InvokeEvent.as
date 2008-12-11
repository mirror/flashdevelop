package flash.events
{
	/// The NativeApplication object of an AIR application dispatches an invoke event when the application is invoked.
	public class InvokeEvent extends flash.events.Event
	{
		/// [AIR] The InvokeEvent.INVOKE constant defines the value of the type property of an InvokeEvent object.
		public static const INVOKE:String = "invoke";

		/// [AIR] The directory that should be used to resolve any relative paths in the arguments array.
		public var currentDirectory:flash.filesystem.File;

		/// [AIR] The array of string arguments passed during this invocation.
		public var arguments:Array;

		/// [AIR] The constructor function for the InvokeEvent class.
		public function InvokeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, dir:flash.filesystem.File=null, argv:Array=null);

		/// [AIR] Creates a new copy of this event.
		public function clone():flash.events.Event;

	}

}

