package flash.events
{
	/// AIR dispatches a DRMErrorEvent object when a NetStream object, trying to play a digital rights management (DRM) encrypted file, encounters a DRM-related error.
	public class DRMErrorEvent extends flash.events.ErrorEvent
	{
		/// [AIR] The DRMErrorEvent.DRM_ERROR constant defines the value of the type property of a drmError event object.
		public static const DRM_ERROR:String = "drmError";

		/// [AIR] An error ID that indicates more detailed information about the underlying problem.
		public var subErrorID:int;

		/// [AIR] Creates an Event object that contains specific information about DRM error events.
		public function DRMErrorEvent(type:String=unknown, bubbles:Boolean=false, cancelable:Boolean=false, inErrorDetail:String, inErrorCode:int=0, insubErrorID:int=0);

		/// [AIR] Creates a copy of the DRMErrorEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// [AIR] Returns a string that contains all the properties of the DRMErrorEvent object.
		public function toString():String;

	}

}

