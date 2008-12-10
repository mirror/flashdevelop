package mx.events
{
	import flash.events.Event;

	/**
	 *  The CuePointEvent class represents the event object passed to the event listener for  *  cue point events dispatched by the VideoDisplay control. * *  @see mx.controls.VideoDisplay
	 */
	public class CuePointEvent extends Event
	{
		/**
		 *  The <code>CuePointEvent.CUE_POINT</code> constant defines the value of the 	 *  <code>type</code> property of the event object for a <code>cuePoint</code> event.	 *      *	<p>The properties of the event object have the following values:</p>	 *  <table class="innertable">	 *     <tr><th>Property</th><th>Value</th></tr>     *     <tr><td><code>bubbles</code></td><td>false</td></tr>     *     <tr><td><code>cancelable</code></td><td>false</td></tr>     *     <tr><td><code>cuePointName</code></td><td>The name of the cue point.</td></tr>     *     <tr><td><code>cuePointTime</code></td><td>The time of the cue point, in seconds.</td></tr>     *     <tr><td><code>cuePointType</code></td><td>The string      *       <code>"actionscript"</code>.</td></tr>     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the      *       event listener that handles the event. For example, if you use      *       <code>myButton.addEventListener()</code> to register an event listener,      *       myButton is the value of the <code>currentTarget</code>. </td></tr>     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;      *       it is not always the Object listening for the event.      *       Use the <code>currentTarget</code> property to always access the      *       Object listening for the event.</td></tr>	 *  </table>	 *	 *  @eventType cuePoint
		 */
		public static const CUE_POINT : String = "cuePoint";
		/**
		 *  The name of the cue point that caused the event.
		 */
		public var cuePointName : String;
		/**
		 *  The time of the cue point that caused the event, in seconds.
		 */
		public var cuePointTime : Number;
		/**
		 *  The string <code>"actionscript"</code>.
		 */
		public var cuePointType : String;

		/**
		 *  Constructor.	 *	 *  @param type The event type; indicates the action that caused the event.	 *	 *  @param bubbles Specifies whether the event can bubble up the display list hierarchy.	 *	 *  @param cancelable Specifies whether the behavior associated with 	 *  the event can be prevented.	 *	 *  @param cuePointName The name of the cue point.	 *	 *  @param cuePointTime The time of the cue point, in seconds.	 *	 *  @param cuePointType The string <code>"actionscript"</code>.
		 */
		public function CuePointEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, cuePointName:String = null, cuePointTime:Number = NaN, cuePointType:String = null);
		/**
		 *  @private
		 */
		public function clone () : Event;
	}
}
