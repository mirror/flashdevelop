package fl.video
{
import flash.events.Event;

/**
* Flash<sup>&#xAE;</sup> Player dispatches a VideoEvent object when the user      * plays a video.     *     * @tiptext VideoEvent class     * @langversion 3.0     * @playerversion Flash 9.0.28.0
*/
public class VideoEvent extends Event implements IVPEvent
{
	/**
	* Defines the value of the <code>type</code> property of an <code>autoRewound</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState          * @eventType autoRewound         * @langver
	*/
		public static const AUTO_REWOUND : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>bufferingStateEntered</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState          * @eventType bufferingStateEntered
	*/
		public static const BUFFERING_STATE_ENTERED : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>close</code> 		 * event object.         *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState          * @eventType close         * @langversion 3.0
	*/
		public static const CLOSE : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>complete</code> event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState          * @eventType complete         * @langversion 3.0
	*/
		public static const COMPLETE : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>fastForward</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType fastForward         * @langversi
	*/
		public static const FAST_FORWARD : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>pausedStateEntered</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState          * @eventType pausedStateEntered
	*/
		public static const PAUSED_STATE_ENTERED : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>playheadUpdate</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState          * @eventType playheadUpdate         * @la
	*/
		public static const PLAYHEAD_UPDATE : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>playingStateEntered</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState          * @eventType playingStateEntered         * @lang
	*/
		public static const PLAYING_STATE_ENTERED : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>ready</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType ready         * @langversion 3.0         * @playe
	*/
		public static const READY : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>rewind</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType rewind         * @langversion 3.0         * @pla
	*/
		public static const REWIND : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>scrubFinish</code> 		 * event object.          *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType scrubFinish         * @langversion 3.0
	*/
		public static const SCRUB_FINISH : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>scrubStart</code> 		 * event object.         *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType scrubStart         * @langversion 3.0
	*/
		public static const SCRUB_START : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>seeked</code> event object.         *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType seeked         * @langversion 3.0         * @playervers
	*/
		public static const SEEKED : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>skinLoaded</code> event object.         *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType skinLoaded         * @langversion 3.0         * @pl
	*/
		public static const SKIN_LOADED : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>stateChange</code> event object.         *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          *             class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType stateChange         * @langversion 3.0
	*/
		public static const STATE_CHANGE : String;
	/**
	* Defines the value of the <code>type</code> property of a <code>stoppedStateEntered</code> 		 * event object.         *         * <p>This event has the following properties:</p>         * <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>         *     <tr><td><code>state</code></td><td>A string identifying the constant from the VideoState          * class that describes the playback state of the component.</td></tr>         *     <tr><td><code>playheadTime</code></td><td>A number that is the current playhead time or position.</td></tr>         *     <tr><td><code>vp</code></td><td>The index of the VideoPlayer object.</td></tr>         * </table>         *         * @see VideoState         * @eventType stoppedStateEntered         * @langve
	*/
		public static const STOPPED_STATE_ENTERED : String;
		private var _state : String;
		private var _playheadTime : Number;
		private var _vp : uint;

	/**
	* A string identifying the constant from the VideoState          * class that describes the playback state of the component. This property is set by the          * <code>load()</code>, <code>play()</code>, <code>stop()</code>, <code>pause()</code>,          * and <code>seek()</code> methods.          *          * <p>The possible values for the state property are: <code>buffering</code>, <code>connectionError</code>,          * <code>disconnected</code>, <code>loading</code>, <code>paused</code>, <code>playing</code>, 		 * <code>rewinding</code>, <code>seeking</code>, and <code>stopped</code>. You can use the properties of  		 * the FLVPlayback class to test for these states. </p>         *         * @see VideoState#DISCONNECTED         * @see VideoState#STOPPED         * @see VideoState#PLAYING         * @see VideoState#PAUSED         * @see VideoState#BUFFERING         * @see VideoState#LOADING         * @see VideoState#CONNECTION_ERROR         * @see VideoState#REWINDING
	*/
		public function get state () : String;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set state (s:String) : Void;

	/**
	* A number that is the current playhead time or position, measured in seconds,          * which can be a fractional value. Setting this property triggers a seek and          * has all the restrictions of a seek.         *          * <p>When the playhead time changes, which occurs once every .25 seconds          * while the FLV file plays, the component dispatches the <code>playheadUpdate</code>         * event.</p>         *          * <p>For several reasons, the <code>playheadTime</code> property might not have the expected          * value immediately after you call one of the seek methods or set <code>playheadTime</code>          * to cause seeking. First, for a progressive download, you can seek only to a          * keyframe, so a seek takes you to the time of the first keyframe after the          * specified time. (When streaming, a seek always goes to the precise specified          * time even if the source FLV file doesn't have a keyframe there.) Second,          * seeking is as
	*/
		public function get playheadTime () : Number;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set playheadTime (t:Number) : Void;

	/**
	* The index of the VideoPlayer object involved in this event.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get vp () : uint;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set vp (n:uint) : Void;

	/**
	* Creates an Event object that contains information about video events.          * Event objects are passed as parameters to event listeners.         *          * @param type The type of the event. Event listeners can access this information          * through the inherited <code>type</code> property. Possible values are 		 * <code>VideoEvent.AUTO_REWOUND</code>, <code>VideoEvent.BUFFERING_STATE_ENTERED</code>, 		 * <code>VideoEvent.CLOSE</code>, <code>VideoEvent.COMPLETE</code>, <code>VideoEvent.FAST_FORWARD</code>,          * <code>VideoEvent.PAUSED_STATE_ENTERED</code>, <code>VideoEvent.PLAYHEAD_UPDATE</code>, 		 * <code>VideoEvent.PLAYING_STATE_ENTERED</code>, <code>VideoEvent.READY</code>, 		 * <code>VideoEvent.REWIND</code>, <code>VideoEvent.SCRUB_FINISH</code>, <code>VideoEvent.SCRUB_START</code>,          * <code>VideoEvent.SEEKED</code>, <code>VideoEvent.SKIN_LOADED</code>, <code>VideoEvent.STATE_CHANGE</code>, 		 * <code>VideoEvent.STOPPED_STATE_ENTERED</code>, and <code>VideoEv
	*/
		public function VideoEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, state:String =null, playheadTime:Number =NaN, vp:uint =0);
	/**
	*  @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function clone () : Event;
}
}
