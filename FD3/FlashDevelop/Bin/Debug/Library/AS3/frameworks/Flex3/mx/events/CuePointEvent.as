/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class CuePointEvent extends Event {
		/**
		 * The name of the cue point that caused the event.
		 */
		public var cuePointName:String;
		/**
		 * The time of the cue point that caused the event, in seconds.
		 */
		public var cuePointTime:Number;
		/**
		 * The string "actionscript".
		 */
		public var cuePointType:String;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with
		 *                            the event can be prevented.
		 * @param cuePointName      <String (default = null)> The name of the cue point.
		 * @param cuePointTime      <Number (default = NaN)> The time of the cue point, in seconds.
		 * @param cuePointType      <String (default = null)> The string "actionscript".
		 */
		public function CuePointEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, cuePointName:String = null, cuePointTime:Number = NaN, cuePointType:String = null);
		/**
		 * The CuePointEvent.CUE_POINT constant defines the value of the
		 *  type property of the event object for a cuePoint event.
		 */
		public static const CUE_POINT:String = "cuePoint";
	}
}
