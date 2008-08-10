/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.events {
	public class DRMErrorEvent extends ErrorEvent {
		/**
		 * An error ID that indicates more detailed information about the underlying problem.
		 */
		public function get subErrorID():int;
		/**
		 * Creates an Event object that contains specific information about DRM error events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String (default = NaN)> The type of the event. Event listeners can access this information through the inherited type property. There is only one type of DRMAuthenticate event: DRMAuthenticateEvent.DRM_AUTHENTICATE.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling stage of the event flow. Event listeners can access this information through the inherited bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can access this information through the inherited cancelable property.
		 * @param inErrorDetail     <String (default = "")> Where applicable, the specific syntactical details of the error.
		 * @param inErrorCode       <int (default = 0)> The major error code.
		 * @param insubErrorID      <int (default = 0)> The minor error ID.
		 */
		public function DRMErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inErrorDetail:String = "", inErrorCode:int = 0, insubErrorID:int = 0);
		/**
		 * Creates a copy of the DRMErrorEvent object and sets the value of each property to match
		 *  that of the original.
		 *
		 * @return                  <Event> A new DRMErrorEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the DRMErrorEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the DRMErrorEvent object.
		 */
		public override function toString():String;
		/**
		 * The DRMErrorEvent.DRM_ERROR constant defines the value of the
		 *  type property of a drmError event object.
		 */
		public static const DRM_ERROR:String = "drmError";
	}
}
