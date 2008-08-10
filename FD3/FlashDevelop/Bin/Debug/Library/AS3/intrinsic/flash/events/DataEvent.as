/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.events {
	public class DataEvent extends TextEvent {
		/**
		 * The raw data loaded into Flash Player or Adobe AIR.
		 */
		public function get data():String;
		public function set data(value:String):void;
		/**
		 * Creates an event object that contains information about data events.
		 *  Event objects are passed as parameters to event listeners.
		 *
		 * @param type              <String> The type of the event. Event listeners can access this information through the
		 *                            inherited type property. There is only one type of data event:
		 *                            DataEvent.DATA.
		 * @param bubbles           <Boolean (default = false)> Determines whether the Event object participates in the bubbling phase of the
		 *                            event flow. Event listeners can access this information through the inherited
		 *                            bubbles property.
		 * @param cancelable        <Boolean (default = false)> Determines whether the Event object can be canceled. Event listeners can
		 *                            access this information through the inherited cancelable property.
		 * @param data              <String (default = "")> The raw data loaded into Flash Player or Adobe AIR. Event listeners can access this information
		 *                            through the data property.
		 */
		public function DataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:String = "");
		/**
		 * Creates a copy of the DataEvent object and sets the value of each property to match that of the
		 *  original.
		 *
		 * @return                  <Event> A new DataEvent object with property values that match those of the original.
		 */
		public override function clone():Event;
		/**
		 * Returns a string that contains all the properties of the DataEvent object.
		 *
		 * @return                  <String> A string that contains all the properties of the DataEvent object.
		 */
		public override function toString():String;
		/**
		 * Defines the value of the type property of a data event object.
		 */
		public static const DATA:String = "data";
		/**
		 * Defines the value of the type property of an uploadCompleteData event object.
		 */
		public static const UPLOAD_COMPLETE_DATA:String = "uploadCompleteData";
	}
}
