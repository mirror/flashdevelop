package flash.events
{
	/// Flash&#xAE; Player dispatches ProgressEvent objects when a load operation has begun or a socket has received data.
	public class ProgressEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a progress event object.
		public static const PROGRESS:String = "progress";

		/// Defines the value of the type property of a socketData event object.
		public static const SOCKET_DATA:String = "socketData";

		/// The number of items or bytes loaded when the listener processes the event.
		public var bytesLoaded:Number;

		/// The total number of items or bytes that will be loaded if the loading process succeeds.
		public var bytesTotal:Number;

		/// Constructor for ProgressEvent objects.
		public function ProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:uint=0, bytesTotal:uint=0);

		/// Creates a copy of the ProgressEvent object and sets each property's value to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the ProgressEvent object.
		public function toString():String;

	}

}

