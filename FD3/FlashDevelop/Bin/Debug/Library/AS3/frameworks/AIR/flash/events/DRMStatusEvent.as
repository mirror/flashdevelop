/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class DRMStatusEvent extends Event {
		/**
		 * A string explaining the context of the status event.
		 */
		public function get detail():String;
		/**
		 * Indicates whether the content, protected with digital rights management (DRM) encryption, is available
		 *  without requiring a user to provide authentication credentials, in which case the value is
		 *  true. Otherwise, the value is false, and a user must provide a username
		 *  and password that matches the one known and expected by the content provider.
		 */
		public function get isAnonymous():Boolean;
		/**
		 * Indicates whether the content, protected with digital rights management (DRM) encryption, is available
		 *  offline, in which case the value is true. Otherwise, the value is false.
		 */
		public function get isAvailableOffline():Boolean;
		/**
		 * The remaining number of days that content can be viewed offline.
		 */
		public function get offlineLeasePeriod():uint;
		/**
		 * A custom object of the DRM status event.
		 */
		public function get policies():Object;
		/**
		 * The absolute date on which the voucher expires and the content can no longer be viewed by users.
		 */
		public function get voucherEndDate():Date;
		/**
		 * Creates an Event object that contains specific information about DRM status events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String (default = NaN)> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of DRMAuthenticate event: DRMAuthenticateEvent.DRM_AUTHENTICATE.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param inPolicies        <Object (default = null)> The custom object that contains custom DRM properties.
		 * @param inDetail          <String (default = "")> The context of the Event.
		 * @param inAvailableOffline<Boolean (default = false)> Indicates if content can be viewed offline.
		 * @param inAnonymous       <Boolean (default = false)> Indicates whether content is accessible to anonymous users.
		 * @param inVoucherEndDate  <int (default = 0)> The date when the content voucher expires, expressed as an epoch value.
		 * @param inOfflineLeasePeriod<int (default = 0)> The number of days remaining for user to view content offline.
		 */
		public function DRMStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inPolicies:Object = null, inDetail:String = "", inAvailableOffline:Boolean = false, inAnonymous:Boolean = false, inVoucherEndDate:int = 0, inOfflineLeasePeriod:int = 0);
		/**
		 * Creates a copy of the DRMStatusEvent object and sets the value of each property to match
		 *  that of the original.
		 *
		 * @return                  <Event> A new DRMStatusEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the DRMStatusEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the DRMStatusEvent object.
		 */
		public override function toString():String;
		/**
		 * The DRMStatusEvent.DRM_STATUS constant defines the value of the
		 *  type property of a drmStatus event object.
		 */
		public static const DRM_STATUS:String = "drmStatus";
	}
}
