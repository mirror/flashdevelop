package flash.events
{
	/// Flash&#xAE; Player dispatches SyncEvent objects when a remote SharedObject instance has been updated by the server.
	public class SyncEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a sync event object.
		public static const SYNC:String = "sync";

		/// An array of objects; each object contains properties that describe the changed members of a remote shared object.
		public var changeList:Array;

		/// Constructor for SyncEvent objects.
		public function SyncEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, changeList:Array=null);

		/// Creates a copy of the SyncEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the SyncEvent object.
		public function toString():String;

	}

}

