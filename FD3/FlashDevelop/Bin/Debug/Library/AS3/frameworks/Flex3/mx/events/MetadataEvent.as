/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class MetadataEvent extends Event {
		/**
		 * For events off type ACTION_SCRIPT and CUE_POINT,
		 *  the index of the cue point in the VideoDisplay.cuePoint Array.
		 */
		public var info:Object;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with
		 *                            the event can be prevented.
		 * @param info              <Object (default = null)> For events off type ACTION_SCRIPT and CUE_POINT,
		 *                            the index of the cue point in the VideoDisplay.cuePoint Array.
		 *                            For events off type METADATA_RECEIVED,
		 *                            an object describing the FLV  file,  including any cue points,
		 *                            which is the same information as the VideoDisplay.metadata property.
		 */
		public function MetadataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null);
		/**
		 * The MetadataEvent.ACTION_SCRIPT constant defines the value of the
		 *  type property of the event object for a actionscript event.
		 *  These cue points are not embedded in the FLV file but defined
		 *  using ActionScript at run time.
		 */
		public static const ACTION_SCRIPT:String = "actionscript";
		/**
		 * The MetadataEvent.CUE_POINT constant defines the value of the
		 *  type property of the event object for a cuePoint event.
		 */
		public static const CUE_POINT:String = "cuePoint";
		/**
		 * The MetadataEvent.METADATA_RECEIVED constant defines the value of the
		 *  type property for a metadataReceived event.
		 */
		public static const METADATA_RECEIVED:String = "metadataReceived";
	}
}
