package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.media.Camera;
	import mx.controls.videoClasses.VideoPlayer;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.IRectangularBorder;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.CuePointEvent;
	import mx.events.FlexEvent;
	import mx.events.MetadataEvent;
	import mx.events.VideoEvent;
	import mx.styles.ISimpleStyleClient;
	import mx.utils.LoaderUtil;

include "../styles/metadata/BorderStyles.as"
	/**
	 *  Dispatched when the NetConnection object is closed, whether by timing
 *  out or by calling the <code>close()</code> method.
 *  You use this event when working with Flash Media Server.
 *
 *  @eventType mx.events.VideoEvent.CLOSE
	 */
	[Event(name="close", type="mx.events.VideoEvent")] 

	/**
	 *  Dispatched when the playhead reaches the end of the FLV file.
 *
 *  @eventType mx.events.VideoEvent.COMPLETE
	 */
	[Event(name="complete", type="mx.events.VideoEvent")] 

	/**
	 *  Dispatched when the value of a cue point's <code>time</code> property
 *  is equal to the current playhead location.
 *
 *  @eventType mx.events.CuePointEvent.CUE_POINT
	 */
	[Event(name="cuePoint", type="mx.events.CuePointEvent")] 

	/**
	 *  Dispatched the first time metadata in the FLV file is reached.
 *
 *  @eventType mx.events.MetadataEvent.METADATA_RECEIVED
	 */
	[Event(name="metadataReceived", type="mx.events.MetadataEvent")] 

	/**
	 *  Dispatched continuosly while the video is playing.
 *  The interval between events, in milliseconds, is specified by the 
 *  <code>playheadUpdateInterval</code> property, which defaults to 250 ms.
 *  This event is not dispatched when the video is in a paused or stopped
 *  state.
 *
 *  @eventType mx.events.VideoEvent.PLAYHEAD_UPDATE
	 */
	[Event(name="playheadUpdate", type="mx.events.VideoEvent")] 

	/**
	 *  Dispatched continuously until the FLV file has downloaded completely.
 *
 *  <p>You can use this event to check the number of bytes loaded
 *  or the number of bytes in the buffer.
 *  This event starts getting dispatched when the <code>load()</code> or
 *  <code>play()</code> method is called first and ends when all bytes are
 *  loaded or if there is a network error.</p>
 *
 *  @eventType flash.events.ProgressEvent.PROGRESS
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 

	/**
	 *  Dispatched when the FLV file is loaded and ready to play.
 *
 *  <p>This event is dispatched the first time the VideoDisplay control
 *  enters a responsive state after a new FLV file is loaded by the
 *  <code>load()</code> or <code>play()</code> method.
 *  It is dispatched only once for each FLV file loaded.</p>
 *
 *  @eventType mx.events.VideoEvent.READY
	 */
	[Event(name="ready", type="mx.events.VideoEvent")] 

	/**
	 *  Dispatched when the control autorewinds.
 *
 *  @see #autoRewind
 *
 *  @eventType mx.events.VideoEvent.REWIND
	 */
	[Event(name="rewind", type="mx.events.VideoEvent")] 

	/**
	 *  Dispatched when the state of the control changes.
 *
 *  <p>You can use this event to track when playback enters and leaves
 *  the unresponsive state (for example, in the middle of connecting,
 *  resizing, or rewinding), during which time calls to the
 *  <code>play()</code>, <code>pause()</code>, and <code>stop()</code> methods
 *  and writes to the <code>playHeadTime</code> property are queued, and then
 *  executed when the player enters the responsive state.</p>
 *
 *  @eventType mx.events.VideoEvent.STATE_CHANGE
	 */
	[Event(name="stateChange", type="mx.events.VideoEvent")] 

include "../core/Version.as"
	/**
	 *  The VideoDisplay control lets you play an FLV file in a Flex application. 
 *  It supports progressive download over HTTP, streaming from the Flash Media
 *  Server, and streaming from a Camera object.
 * 
 *  @mxml
 *
 *  <p>The <code>&lt;mx:VideoDisplay&gt;</code> tag inherits all the tag
 *  attributes of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:VideoDisplay
 *    <strong>Properties</strong>
 *    autoBandWidthDetection="false|true"
 *    autoPlay="true|false"
 *    autoRewind="true|false"
 *    bufferTime="0.1"
 *    cuePointManagerClass=""
 *    cuePoints=""
 *    idleTimeout="300000"
 *    live="false|true"
 *    maintainAspectRatio="true|false"
 *    playheadTime=""
 *    playheadUpdateInterval="250"
 *    progressInterval="250"
 *    source=""
 *    totalTime=""
 *    volume="0.75"
 *  
 *    <b>Styles</b>
 *    backgroundAlpha="1.0"
 *    backgroundColor="0x000000"
 *    backgroundImage="undefined"
 *    backgroundSize="undefined"
 *    borderColor="undefined"
 *    borderSides="left top right bottom"
 *    borderSkin="ClassReference('mx.skins.halo.HaloBorder')"
 *    borderStyle="none"
 *    borderThickness="1"
 *    cornerRadius="0"
 *    dropShadowColor="0x000000"
 *    dropShadowEnabled="false|true"
 *    shadowDirection="center"
 *    shadowDistance="2"
 *  
 *    <strong>Events</strong>
 *    close="<i>No default</i>"
 *    complete="<i>No default</i>"
 *    cuePoint="<i>No default</i>"
 *    playheadUpdate="<i>No default</i>"
 *    progress="<i>No default</i>"
 *    ready="<i>No default</i>"
 *    rewind="<i>No default</i>"
 *    stateChange="<i>No default</i>"
 *
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/VideoDisplayExample.mxml
 *
	 */
	public class VideoDisplay extends UIComponent
	{
		/**
		 *  @private
     *  Internal VideoPlayer instance.
		 */
		var videoPlayer : VideoPlayer;
		/**
		 *  @private
     *  Internal CuePointManager instance associated with the VideoPlayer.
		 */
		private var _cuePointManager : Object;
		/**
		 *  @private
     *  Flag indicating whether the value of source changed.  Checked in
     *  play()
		 */
		private var sourceChanged : Boolean;
		/**
		 *  @private
     *  Flag indicating whether close has been called. Checked in
     *  play()
		 */
		private var closeCalled : Boolean;
		/**
		 *  @private
		 */
		private var makeVideoVisibleOnLayout : Boolean;
		/**
		 *  @private
     *  The default width if none is specified and no width information is
     *  available from the video.
		 */
		private static const DEFAULT_WIDTH : Number = 10;
		/**
		 *  @private
     *  The default height if none is specified and no height information is
     *  available from the video.
		 */
		private static const DEFAULT_HEIGHT : Number = 10;
		/**
		 *  The border object for the control.
		 */
		protected var border : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var asCuePointIndexResetPending : Boolean;
		/**
		 *  @private
		 */
		private var creationCompleted : Boolean;
		private var _autoBandWidthDetection : Boolean;
		/**
		 *  @private
     *  Storage for autoRewind property.
		 */
		private var _autoRewind : Boolean;
		/**
		 *  @private
     *  Storage for bufferTime property.
		 */
		private var _bufferTime : Number;
		/**
		 *  @private
     *  Storage for autoPlay property.
		 */
		private var _autoPlay : Boolean;
		/**
		 *  @private
     *  Storage for cuePointManagerClass property.
		 */
		private var _cuePointManagerClass : Class;
		/**
		 *  @private
     *  Storage for cuePoints property.
		 */
		private var _cuePoints : Array;
		/**
		 *  @private
     *  Storage for idleTimeout property.
		 */
		private var _idleTimeout : int;
		/**
		 *  @private
     *  Storage for live property.
		 */
		private var _live : Boolean;
		/**
		 *  @private
     *  Storage for maintainAspectRatio property.
		 */
		private var _maintainAspectRatio : Boolean;
		/**
		 *  @private
     *  Storage for ncManagerClass property.
		 */
		private var _ncManagerClass : Class;
		/**
		 *  @private
     *  Storage for playheadTime property.
		 */
		private var _playheadTime : Number;
		/**
		 *  @private
     *  Storage for playheadUpdateInterval property.
		 */
		private var _playheadUpdateInterval : int;
		/**
		 *  @private
     *  Storage for progressInterval property.
		 */
		private var _progressInterval : int;
		/**
		 *  @private
     *  Storage for totalTime property.
		 */
		private var _totalTime : Number;
		/**
		 *  @private
     *  Storage for source property.
		 */
		private var _source : String;
		/**
		 *  @private
     *  Storage for volume property.
		 */
		private var _volume : Number;

		/**
		 *  Specifies whether the VideoDisplay control should use the built-in
     *  automatic bandwidth detection feature.
     *
     *  When <code>false</code>, you do not require a main.asc file 
     *  on Flash Media Server (FMS) 2 to connect to FMS. 
     *  When <code>true</code>, you need to implement a main.asc 
     *  and store it in the directory structure of FMS. 
     *  The main.asc file must define the following functions:
     *
     *  <ul>
     *  <li><pre>
     *  application.onConnect = function(p_client, p_autoSenseBW)
     *  {
     *    //Add security code here.     
     *    this.acceptConnection(p_client);      
     *    if (p_autoSenseBW)
     *      this.calculateClientBw(p_client);
     *    else
     *      p_client.call("onBWDone");
     *  }</pre></li>
     *
     *  <li><pre>
     *  application.calculateClientBw = function(p_client)
     *  {
     *    // Add code to set the clients BandWidth.
     *    // Use p_client.getStats() which returns bytes_in 
     *    // and bytes_Out and check your bandWidth using 
     *    // p_client.call("onBWCheck", result, p_client.payload).
     *    p_client.call("onBWDone");
     *  }
     *  </pre>
     *  </li>
     *
     *  <li><pre>
     *  Client.prototype.getStreamLength = function(p_streamName)
     *  {
     *    return Stream.length(p_streamName);
     *  }</pre>
     *  </li>
     *  </ul>
     *  
     *  For more information on writing main.asc, see the FMS documentation.
     *
     *  @default false
		 */
		public function get autoBandWidthDetection () : Boolean;
		/**
		 *  @private
		 */
		public function set autoBandWidthDetection (value:Boolean) : void;

		/**
		 *  Specifies whether the FLV file should be rewound to the first frame
     *  when play stops, either by calling the <code>stop()</code> method or by
     *  reaching the end of the stream.
     *
     *  This property has no effect for live streaming video.
     *
     *  @default true
		 */
		public function get autoRewind () : Boolean;
		/**
		 *  @private
		 */
		public function set autoRewind (value:Boolean) : void;

		/**
		 *  Returns an EdgeMetrics object that has four properties:
     *  <code>left</code>, <code>top</code>, <code>right</code>,
     *  and <code>bottom</code>.
     *  The value of each property is equal to the thickness of one side
     *  of the border around the control, in pixels.
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Number of seconds of video to buffer in memory before starting to play
     *  the video file.
     *  For slow connections streaming over RTMP, it is important to increase
     *  this property from the default.  
     *
     *  @default 0.1
		 */
		public function get bufferTime () : Number;
		/**
		 *  @private
		 */
		public function set bufferTime (value:Number) : void;

		/**
		 *  Specifies whether the video should start playing immediately when the
     *  <code>source</code> property is set.
     *  If <code>true</code>, the video file immediately begins to buffer and
     *  play.
     *
     *  <p>Even if <code>autoPlay</code> is set to <code>false</code>, Flex
     *  starts loading the video after the <code>initialize()</code> method is
     *  called.
     *  For Flash Media Server, this means creating the stream and loading
     *  the first frame to display (and loading more if
     *  <code>autoSize</code> or <code>aspectRatio</code> is set to
     *  <code>true</code>).  
     *  In the case of an HTTP download, Flex starts downloading the stream
     *  and shows the first frame.</p>
     *  
     *  @default true
		 */
		public function get autoPlay () : Boolean;
		/**
		 *  @private
		 */
		public function set autoPlay (value:Boolean) : void;

		/**
		 *  Number of bytes already loaded that are available for playing.
     *  The value is only useful for media loaded using HTTP.
     *
     *  <p>Contains -1 when there
     *  is no input stream, when the stream is from Flash Media Server, 
     *  or if the information is not yet available. </p>
		 */
		public function get bytesLoaded () : int;

		/**
		 *  Total number of bytes to load.
     *  The value is only useful for media loaded using HTTP.
     *
     *  <p>Contains -1 when there
     *  is no input stream, when the stream is from Flash Media Server, 
     *  or if the information is not yet available. </p>
		 */
		public function get bytesTotal () : int;

		/**
		 *  The instance of the CuePointManager class associated with 
     *  the VideoPlayer control.
     *  You can use this object to control cue points, or use the 
     *  <code>cuePoints</code> property.
     *
     *  <p>You use cue points to trigger <code>cuePoint</code> events when the
     *  playback of your video reaches a specified location.
     *  To set cue points, you use methods of the CuePointManager class. </p>
     * 
     * <p>Cue points embedded in the FLV are not available via <code>cuePoints</code> or 
     * <code>cuePointManager</code>.  In order to retrieve them, you can access the 
     * <code>metadata</code> property or the <code>metadataReceived</code> event.</p>
     *
     *  @see mx.controls.videoClasses.CuePointManager
		 */
		public function get cuePointManager () : Object;

		/**
		 *  Cue point manager to use.
     *  Set this to mx.controls.videoClasses.CuePointManager to enable cue
     *  point management.
     *
     *  @see mx.controls.videoClasses.CuePointManager
		 */
		public function get cuePointManagerClass () : Class;
		/**
		 *  @private
		 */
		public function set cuePointManagerClass (value:Class) : void;

		/**
		 *  The Array of cue points associated with the control.
     *  You can use this property to control cue points, or use the 
     *  <code>cuePointManager</code> property.
     *
     *  <p>You use cue points to trigger <code>cuePoint</code> events when the
     *  playback of your video reaches a specified location.
     *  To set cue points, you pass an Array to the <code>cuePoints</code>
     *  property. </p>
     * 
     * <p>Cue points embedded in the FLV are not available via <code>cuePoints</code> or 
     * <code>cuePointManager</code>.  In order to retrieve them, you can access the 
     * <code>metadata</code> property or the <code>metadataReceived</code> event.</p>
     *
     *  <p>Each element of the Array contains two fields:</p>
     *  <ul>
     *    <li>The <code>name</code> field 
     *      contains an arbitrary name of the cue point.</li>
     *    <li>The <code>time</code> field 
     *      contains the playhead location, in seconds, of the VideoDisplay
     *      control with which the cue point is associated.</li>
     *  </ul>
		 */
		public function get cuePoints () : Array;
		/**
		 *  @private
		 */
		public function set cuePoints (value:Array) : void;

		/**
		 *  Specifies the amount of time, in milliseconds, that the connection is
     *  idle (playing is paused or stopped) before the connection to the Flash
     *  Media Server is stopped.
     *  This property has no effect on the HTTP download of FLV files.
     *
     *  If this property is set when the stream is already idle, 
     *  it restarts the idle timeout with a new value.
     *
     *  @default 300000 (five minutes)
		 */
		public function get idleTimeout () : int;
		/**
		 *  @private
		 */
		public function set idleTimeout (value:int) : void;

		/**
		 *  Specifies whether the control is streaming a live feed.
     *  Set this property to <code>true</code> when streaming a 
     *  live feed from Flash Media Server. 
     *
     *  @default false
		 */
		public function get live () : Boolean;
		/**
		 *  @private
		 */
		public function set live (value:Boolean) : void;

		/**
		 *  Specifies whether the control should maintain the original aspect ratio
     *  while resizing the video.
     *
     *  @default true
		 */
		public function get maintainAspectRatio () : Boolean;
		/**
		 *  @private
		 */
		public function set maintainAspectRatio (value:Boolean) : void;

		/**
		 * An object that contains a metadata information packet that is received from a call to 
     * the <code>NetSteam.onMetaData()</code> callback method, if available.  
     * Ready when the <code>metadataReceived</code> event is dispatched.
     * 
     * <p>If the FLV file is encoded with the Flash 8 encoder, the <code>metadata</code> 
     * property contains the following information. Older FLV files contain 
     * only the <code>height</code>, <code>width</code>, and <code>duration</code> values.</p>
     * 
     * <table class="innertable" width="100%">
     *  <tr><th><b>Parameter</b></th><th><b>Description</b></th></tr>
     *      <tr><td><code>canSeekToEnd</code></td><td>A Boolean value that is <code>true</code> if the FLV file is encoded with a keyframe on the last frame that allows seeking to the end of a progressive download movie clip. It is <code>false</code> if the FLV file is not encoded with a keyframe on the last frame.</td></tr>
     *      <tr><td><code>cuePoints</code></td><td>An Array of objects, one for each cue point embedded in the FLV file. Value is undefined if the FLV file does not contain any cue points. Each object has the following properties:
     *      
     *          <ul>
     *              <li><code>type</code>&#x2014;A String that specifies the type of cue point as either "navigation" or "event".</li>
     *              <li><code>name</code>&#x2014;A String that is the name of the cue point.</li>
     *              <li><code>time</code>&#x2014;A Number that is the time of the cue point in seconds with a precision of three decimal places (milliseconds).</li>
     *              <li><code>parameters</code>&#x2014;An optional Object that has name-value pairs that are designated by the user when creating the cue points.</li>
     *          </ul>
     *      </td></tr>
     * <tr><td><code>audiocodecid</code></td><td>A Number that indicates the audio codec (code/decode technique) that was used.</td></tr>
     * <tr><td><code>audiodelay</code></td><td> A Number that represents time <code>0</code> in the source file from which the FLV file was encoded. 
     * <p>Video content is delayed for the short period of time that is required to synchronize the audio. For example, if the <code>audiodelay</code> value is <code>.038</code>, the video that started at time <code>0</code> in the source file starts at time <code>.038</code> in the FLV file.</p> 
     * <p>Note that the VideoDisplay class compensates for this delay in its time settings. This means that you can continue to use the time settings that you used in your the source file.</p>
</td></tr>
     * <tr><td><code>audiodatarate</code></td><td>A Number that is the kilobytes per second of audio.</td></tr>
     * <tr><td><code>videocodecid</code></td><td>A Number that is the codec version that was used to encode the video.</td></tr>
     * <tr><td><code>framerate</code></td><td>A Number that is the frame rate of the FLV file.</td></tr>
     * <tr><td><code>videodatarate</code></td><td>A Number that is the video data rate of the FLV file.</td></tr>
     * <tr><td><code>height</code></td><td>A Number that is the height of the FLV file.</td></tr>
     * <tr><td><code>width</code></td><td>A Number that is the width of the FLV file.</td></tr>
     * <tr><td><code>duration</code></td><td>A Number that specifies the duration of the FLV file in seconds.</td></tr>
     * </table>
		 */
		public function get metadata () : Object;

		/**
		 *  @private    
     *  Name of the INCManager implementation class to use to
     *  download the video. The default value is <code>"mx.controls.videoClasses.NCManager"</code>.
		 */
		private function get ncManagerClass () : Class;
		/**
		 *  @private
		 */
		private function set ncManagerClass (value:Class) : void;

		/**
		 *  Playhead position, measured in seconds, since the video starting
     *  playing. 
     *  The event object for many of the VideoPlay events include the playhead
     *  position so that you can determine the location in the video file where
     *  the event occurred.
     * 
     *  <p>Setting this property to a value in seconds performs a seek
     *  operation. 
     *  If the video is currently playing,
     *  it continues playing from the new playhead position.  
     *  If the video is paused, it seeks to
     *  the new playhead position and remains paused.  
     *  If the video is stopped, it seeks to
     *  the new playhead position and enters the paused state.  
     *  Setting this property has no effect with live video streams.</p>
     *
     *  <p>If the new playhead position is less than 0 or NaN, 
     *  the control throws an exception. If the new playhead position
     *  is past the end of the video, or past the amount of the video file
     *  downloaded so far, then the control still attempts the seek.</p>
     *
     *  <p>For an FLV file, setting the <code>playheadTime</code> property seeks 
     *  to the keyframe closest to the specified position, where 
     *  keyframes are specified in the FLV file at the time of encoding. 
     *  Therefore, you might not seek to the exact time if there 
     *  is no keyframe specified at that position.</p>
     *
     *  <p>If player is in an unresponsive state, it queues the request.</p>
     *
     *  <p>This property throws an exception if set when no stream is
     *  connected.  Use the <code>stateChange</code> event and the
     *  <code>connected</code> property to determine when it is
     *  safe to set this property.</p>
     *
     *  @default NaN
		 */
		public function get playheadTime () : Number;
		/**
		 *  @private
		 */
		public function set playheadTime (value:Number) : void;

		/**
		 *  Specifies the amount of time, in milliseconds,
     *  between each <code>playheadUpdate</code> event.
     *
     *  <p>If you set this property when the video is playing, 
     *  the timer restarts at 0, and the next <code>playheadUpdate</code> 
     *  event occurs after the new time interval.</p>
     *
     *  @default 250
		 */
		public function get playheadUpdateInterval () : int;
		/**
		 *  @private
		 */
		public function set playheadUpdateInterval (value:int) : void;

		/**
		 *  If <code>true</code>, the media is currently playing.
		 */
		public function get playing () : Boolean;

		/**
		 *  Specifies the amount of time, in milliseconds,
     *  between each <code>progress</code> event. 
     *  The <code>progress</code> event occurs continuously 
     *  until the video file downloads completely.
     *
     *  <p>If you set this property when the video is downloading, 
     *  the timer restarts at 0, and the next <code>progress</code> 
     *  event occurs after the new time interval.</p>
     *
     *  @default 250
		 */
		public function get progressInterval () : int;
		/**
		 *  @private
		 */
		public function set progressInterval (value:int) : void;

		/**
		 *  The current state of the VideoDisplay control. 
     *  You set this property by calls to the <code>load()</code>,
     *  <code>play()</code>, <code>stop()</code>, and <code>pause()</code>
     *  methods, and setting the <code>playHeadTime</code> property.
     *
     *  <p>This property can have the following values defined in the
     *  VideoEvent class: 
     *  <code>VideoEvent.BUFFERING</code>,
     *  <code>VideoEvent.CONNECTION_ERROR</code>, 
     *  <code>VideoEvent.DISCONNECTED</code>,
     *  <code>VideoEvent.EXEC_QUEUED_CMD</code>, 
     *  <code>VideoEvent.LOADING</code>, <code>VideoEvent.PAUSED</code>, 
     *  <code>VideoEvent.PLAYING</code>, <code>VideoEvent.RESIZING</code>, 
     *  <code>VideoEvent.REWINDING</code>, <code>VideoEvent.SEEKING</code>, 
     *  and <code>VideoEvent.STOPPED</code>. </p>
     *
     *  @default VideoEvent.DISCONNECTED
     *
     *  @see mx.events.VideoEvent
		 */
		public function get state () : String;

		/**
		 *  Specifies whether the VideoDisplay control is in a responsive state, 
     *  <code>true</code>, or in the unresponsive state, <code>false</code>. 
     *  The control enters the unresponsive state when video is being loaded
     *  or is rewinding.
     *  
     *  <p>The control is also in a responsive state when the
     *  <code>state</code> property is: 
     *  <code>VideoEvent.CONNECTION_ERROR</code>, 
     *  <code>VideoEvent.EXEC_QUEUED_CMD</code>, 
     *  <code>VideoEvent.RESIZING</code>, or 
     *  <code>VideoEvent.SEEKING</code>. </p>
     *  
     *  <p>If the control is unresponsive, calls to the 
     *  <code>play()</code>, <code>load()</code>, <code>stop()</code>,
     *  and <code>pause()</code> methods are queued, 
     *  and then executed when the control changes to the responsive state.</p>
		 */
		public function get stateResponsive () : Boolean;

		/**
		 *  Total length of the media, in seconds.
     *  For FLV 1.0 video files, you manually set this property.
     *  For FLV 1.1 and later, the control calculates this value automatically.
		 */
		public function get totalTime () : Number;
		/**
		 *  @private
		 */
		public function set totalTime (value:Number) : void;

		/**
		 *  Relative path and filename of the FLV file to stream.
		 */
		public function get source () : String;
		/**
		 *  @private
		 */
		public function set source (value:String) : void;

		/**
		 *  Height of the loaded FLV file.
     *  <code>-1</code> if no FLV file loaded yet.
		 */
		public function get videoHeight () : int;

		/**
		 *  Width of the loaded FLV file.
     *  <code>-1</code> if no FLV file loaded yet.
		 */
		public function get videoWidth () : int;

		/**
		 *  The volume level, specified as an value between 0 and 1.
     * 
     *  @default 0.75
		 */
		public function get volume () : Number;
		/**
		 *  @private
		 */
		public function set volume (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function VideoDisplay ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  Specifies whether to play a video stream from a camera. 
     *  The video is displayed within the boundaries of the 
     *  control in the application window. 
     *
     *  @param camera A Camera object that 
     *  is capturing video data.
		 */
		public function attachCamera (camera:Camera) : void;

		/**
		 *  Forces the close of an input stream and connection to Flash Media
     *  Server.  
     *  Calling this method dispatches the <code>close</code> event.
     *  Typically calling this method directly is not necessary
     *  because the connection is automatically closed when the idle period
     *  times out, as defined by the <code>idleTimeout</code> property.
		 */
		public function close () : void;

		/**
		 *  Loads the media file without playing it.
     *
     *  <p>This method is similar to the <code>play()</code> method, 
     *  but it causes the file to be loaded without
     *  playing.  Autoresizing will occur if appropriate.
     *  After the load and autoresize, the state of the control is set to 
     *  <code>VideoEvent.PAUSED</code>.</p>
		 */
		public function load () : void;

		/**
		 *  Pauses playback without moving the playhead. 
     *  If playback is already is paused or is stopped, this method has no
     *  effect.  
     *
     *  <p>To start playback again, call the <code>play()</code> method.</p>
     *
     *  <p>If the control is in an unresponsive state, the request is queued.</p>
		 */
		public function pause () : void;

		/**
		 *  Plays the media file.
     *  If the file has not been loaded, it loads it.
     *  You can call this method while playback is paused, stopped, or while
     *  the control is playing.  
     *
     *  <p>If the control is in an unresponsive state, the request is
     *  queued.</p>
		 */
		public function play () : void;

		/**
		 *  Stops playback.
     *  If the <code>autoRewind</code> property is set to
     *  <code>true</code>, rewind to the first frame.  
     *
     *  <p>To start playback again, call the <code>play()</code> method.</p>
     *
     *  <p>If playback is already stopped, this method has no effect.
     *  If the control is in an unresponsive state, the request is queued.</p>
		 */
		public function stop () : void;

		/**
		 *  Responds to size changes by setting the positions and sizes of
     *  the borders.
     *
     *  <p>The <code>VideoDisplay.layoutChrome()</code> method sets the
     *  position and size of the VideoDisplay's border.
     *  In every subclass of VideoDisplay, the subclass's
     *  <code>layoutChrome()</code> method should call the
     *  <code>super.layoutChrome()</code> method, so that the border is
     *  positioned properly.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  Creates the border for this component.
     *  Normally the border is determined by the
     *  <code>borderStyle</code> and <code>borderSkin</code> styles.
     *  It must set the border property to the instance of the border.
		 */
		protected function createBorder () : void;

		private function getActualURL (url:String) : String;

		/**
		 *  Returns TRUE if a border is needed for this component based
     *  on the borderStyle and whether or not there is a background
     *  for the component.
		 */
		private function isBorderNeeded () : Boolean;

		/**
		 *  @private
		 */
		private function createVideoPlayer () : void;

		/**
		 *  @private
		 */
		private function autoPlaying () : void;

		/**
		 *  @private
		 */
		private function resizeVideo () : void;

		/**
		 *  @private
     *  Creates and populates an array of cue points.
     *
     *  @param cuePoints Array of cue points.
		 */
		private function setCuePoints (cuePoints:Array) : void;

		/**
		 *  @private
     *  Handler for "creationComplete" of this object.
		 */
		private function creationCompleteHandler (event:FlexEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_playheadUpdateHandler (event:VideoEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_completeHandler (event:VideoEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_cuePointHandler (event:MetadataEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_metadataHandler (event:MetadataEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_progressHandler (event:ProgressEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_readyHandler (event:VideoEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_rewindHandler (event:VideoEvent) : void;

		/**
		 *  @private
		 */
		private function videoPlayer_stateChangeHandler (event:VideoEvent) : void;
	}
}
