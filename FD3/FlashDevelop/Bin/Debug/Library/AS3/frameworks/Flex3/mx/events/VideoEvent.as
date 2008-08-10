/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class VideoEvent extends Event {
		/**
		 * The location of the playhead of the VideoDisplay control
		 *  when the event occurs.
		 */
		public var playheadTime:Number;
		/**
		 * The value of the VideoDisplay.state property
		 *  when the event occurs.
		 */
		public var state:String;
		/**
		 * The value of the VideoDisplay.stateResponsive property
		 *  when the event occurs.
		 */
		public function get stateResponsive():Boolean;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with
		 *                            the event can be prevented.
		 * @param state             <String (default = null)> The value of the VideoDisplay.state property
		 *                            when the event occurs.
		 * @param playheadTime      <Number (default = NaN)> The location of the playhead when the event occurs.
		 */
		public function VideoEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, state:String = null, playheadTime:Number = NaN);
		/**
		 * The value of the VideoDisplay.state property
		 *  immediately after a call to the
		 *  play() or load() method.
		 */
		public static const BUFFERING:String = "buffering";
		/**
		 * The VideoEvent.CLOSE constant defines the value of the
		 *  type property of the event object for a close event.
		 */
		public static const CLOSE:String = "close";
		/**
		 * The VideoEvent.COMPLETE constant defines the value of the
		 *  type property of the event object for a complete event.
		 */
		public static const COMPLETE:String = "complete";
		/**
		 * The value of the VideoDisplay.state property
		 *  when the VideoDisplay control was unable to load the video stream.
		 *  This state can occur when there is no connection to a server,
		 *  the video stream is not found, or for other reasons.
		 */
		public static const CONNECTION_ERROR:String = "connectionError";
		/**
		 * The value of the VideoDisplay.state property
		 *  when the video stream has timed out or is idle.
		 */
		public static const DISCONNECTED:String = "disconnected";
		/**
		 * The value of the VideoDisplay.state property
		 *  during execution of queued command.
		 *  There will never be a stateChange event dispatched for
		 *  this state; it is for internal use only.
		 */
		public static const EXEC_QUEUED_CMD:String = "execQueuedCmd";
		/**
		 * The value of the VideoDisplay.state property
		 *  immediately after a call to the
		 *  play() or load() method.
		 */
		public static const LOADING:String = "loading";
		/**
		 * The value of the VideoDisplay.state property
		 *  when an FLV file is loaded, but play is paused.
		 *  This state is entered when you call the pause()
		 *  or load() method.
		 */
		public static const PAUSED:String = "paused";
		/**
		 * The VideoEvent.PLAYHEAD_UPDATE constant defines the value of the
		 *  type property of the event object for a playheadUpdate event.
		 */
		public static const PLAYHEAD_UPDATE:String = "playheadUpdate";
		/**
		 * The value of the VideoDisplay.state property
		 *  when an FLV file is loaded and is playing.
		 *  This state is entered when you call the play()
		 *  method.
		 */
		public static const PLAYING:String = "playing";
		/**
		 * The VideoEvent.READY constant defines the value of the
		 *  type property of the event object for a ready event.
		 */
		public static const READY:String = "ready";
		/**
		 * The value of the VideoDisplay.state property
		 *  when the VideoDisplay control is resizing.
		 */
		public static const RESIZING:String = "resizing";
		/**
		 * The VideoEvent.REWIND constant defines the value of the
		 *  type property of the event object for a rewind event.
		 */
		public static const REWIND:String = "rewind";
		/**
		 * The value of the VideoDisplay.state property
		 *  during an autorewind triggered
		 *  when play stops.  After the rewind completes, the state changes to
		 *  STOPPED.
		 */
		public static const REWINDING:String = "rewinding";
		/**
		 * The value of the VideoDisplay.state property
		 *  for a seek occurring
		 *  due to the VideoDisplay.playHeadTime property being set.
		 */
		public static const SEEKING:String = "seeking";
		/**
		 * The VideoEvent.STATE_CHANGE constant defines the value of the
		 *  type property of the event object for a stateChange event.
		 */
		public static const STATE_CHANGE:String = "stateChange";
		/**
		 * The value of the VideoDisplay.state property
		 *  when an FLV file is loaded but play has stopped.
		 *  This state is entered  when you call the stop() method
		 *  or when the playhead reaches the end of the video stream.
		 */
		public static const STOPPED:String = "stopped";
	}
}
