package flash.events
{
	import flash.net.drm.DRMContentData;
	import flash.net.drm.DRMVoucher;
	import flash.events.Event;

	/// A NetStream object dispatches a DRMStatusEvent object when the content protected using digital rights management (DRM) begins playing successfully (when the voucher is verified, and when the user is authenticated and authorized to view the content).
	public class DRMStatusEvent extends Event
	{
		/// [AIR] The DRMStatusEvent.DRM_STATUS constant defines the value of the type property of a drmStatus event object.
		public static const DRM_STATUS : String = "drmStatus";

		public function get contentData () : DRMContentData;
		public function set contentData (value:DRMContentData) : void;

		/// [AIR] A string explaining the context of the status event.
		public function get detail () : String;
		public function set detail (value:String) : void;

		/// [AIR] Indicates whether the content, protected with digital rights management (DRM) encryption, is available without requiring a user to provide authentication credentials, in which case the value is true.
		public function get isAnonymous () : Boolean;
		public function set isAnonymous (value:Boolean) : void;

		/// [AIR] Indicates whether the content, protected with digital rights management (DRM) encryption, is available offline, in which case the value is true.
		public function get isAvailableOffline () : Boolean;
		public function set isAvailableOffline (value:Boolean) : void;

		public function get isLocal () : Boolean;
		public function set isLocal (value:Boolean) : void;

		/// [AIR] The remaining number of days that content can be viewed offline.
		public function get offlineLeasePeriod () : uint;
		public function set offlineLeasePeriod (value:uint) : void;

		/// [AIR] A custom object of the DRM status event.
		public function get policies () : Object;
		public function set policies (value:Object) : void;

		public function get voucher () : DRMVoucher;
		public function set voucher (value:DRMVoucher) : void;

		/// [AIR] The absolute date on which the voucher expires and the content can no longer be viewed by users.
		public function get voucherEndDate () : Date;
		public function set voucherEndDate (value:Date) : void;

		/// [AIR] Creates a copy of the DRMStatusEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// [AIR] Creates an Event object that contains specific information about DRM status events.
		public function DRMStatusEvent (type:String = "drmStatus", bubbles:Boolean = false, cancelable:Boolean = false, inPolicies:Object = null, inDetail:String = "", inAvailableOffline:Boolean = false, inAnonymous:Boolean = false, inVoucherEndDate:int = 0, inOfflineLeasePeriod:int = 0, inMetadata:DRMContentData = null, inVoucher:DRMVoucher = null, inLocal:Boolean = false);

		/// [AIR] Returns a string that contains all the properties of the DRMStatusEvent object.
		public function toString () : String;
	}
}
