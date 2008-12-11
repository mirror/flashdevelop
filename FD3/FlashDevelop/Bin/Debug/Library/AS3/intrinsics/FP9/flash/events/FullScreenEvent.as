package flash.events
{
	/// Flash&#xAE; Player dispatches a FullScreenEvent object whenever the Stage enters or leaves full-screen display mode.
	public class FullScreenEvent extends flash.events.ActivityEvent
	{
		/// The FullScreenEvent.FULL_SCREEN constant defines the value of the type property of a fullScreen event object.
		public static const FULL_SCREEN:String = "fullScreen";

		/// Indicates whether the Stage object is in full-screen mode (true) or not (false).
		public var fullScreen:Boolean;

		/// Constructor for FullScreenEvent objects.
		public function FullScreenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, fullScreen:Boolean=false);

		/// Creates a copy of a FullScreenEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// Returns a string that contains all the properties of the FullScreenEvent object.
		public function toString():String;

	}

}

