package flash.events
{
	/// Flash&#xAE; Player dispatches NetStatusEvent objects when a NetConnection, NetStream, orSharedObject object reports its status.
	public class NetStatusEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a netStatus event object.
		public static const NET_STATUS:String = "netStatus";

		/// An object with properties that describe the object's status or error condition.
		public var info:Object;

		/// Constructor for NetStatusEvent objects.
		public function NetStatusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, info:Object=null);

		/// Creates a copy of the NetStatusEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the NetStatusEvent object.
		public function toString():String;

	}

}

