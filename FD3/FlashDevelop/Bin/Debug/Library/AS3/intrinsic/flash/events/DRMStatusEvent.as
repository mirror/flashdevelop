package flash.events
{
	/// A NetStream object dispatches a DRMStatusEvent object when the content protected using digital rights management (DRM) begins playing successfully (when the voucher is verified, and when the user is authenticated and authorized to view the content).
	public class DRMStatusEvent extends flash.events.Event
	{
		/// [AIR] The DRMStatusEvent.DRM_STATUS constant defines the value of the type property of a drmStatus event object.
		public static const DRM_STATUS:String = "drmStatus";

		/// [AIR] Indicates whether the content, protected with digital rights management (DRM) encryption, is available offline, in which case the value is true.
		public var isAvailableOffline:Boolean;

		/// [AIR] Indicates whether the content, protected with digital rights management (DRM) encryption, is available without requiring a user to provide authentication credentials, in which case the value is true.
		public var isAnonymous:Boolean;

		/// [AIR] The absolute date on which the voucher expires and the content can no longer be viewed by users.
		public var voucherEndDate:Date;

		/// [AIR] The remaining number of days that content can be viewed offline.
		public var offlineLeasePeriod:uint;

		/// [AIR] A custom object of the DRM status event.
		public var policies:Object;

		/// [AIR] A string explaining the context of the status event.
		public var detail:String;

		/// [AIR] Creates an Event object that contains specific information about DRM status events.
		public function DRMStatusEvent(type:String=unknown, bubbles:Boolean=false, cancelable:Boolean=false, inPolicies:Object=null, inDetail:String, inAvailableOffline:Boolean=false, inAnonymous:Boolean=false, inVoucherEndDate:int=0, inOfflineLeasePeriod:int=0);

		/// [AIR] Creates a copy of the DRMStatusEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// [AIR] Returns a string that contains all the properties of the DRMStatusEvent object.
		public function toString():String;

	}

}

