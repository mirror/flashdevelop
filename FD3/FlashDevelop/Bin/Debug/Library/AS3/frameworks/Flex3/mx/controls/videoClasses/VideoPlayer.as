package mx.controls.videoClasses
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.events.MetadataEvent;
	import mx.events.VideoEvent;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import mx.controls.videoClasses.VideoPlayer;

	/**
	 *  Dispatched when the <code>NetConnection</code> is closed, *  whether by being timed out or by calling the <code>close()</code> method. *  This event is only dispatched with RTMP streams, never HTTP. * *  @eventType mx.events.VideoEvent.CLOSE *  @helpid 3482 *  @tiptext close event
	 */
	[Event(name="close", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when playing completes by reaching the end of the FLV. *  This event not dispatched if the method <code>stop()</code> or *  <code>pause()</code> are called. * *  <p>When using progressive download and not setting totalTime *  explicitly and downloading an FLV with no metadata duration, *  the totalTime will be set to an approximate total value, now *  that we have played the whole file we can make a guess. *  That value is set by the time this event is dispatched.</p> * *  @eventType mx.events.VideoEvent.COMPLETE *  @helpid 3482 *  @tiptext complete event
	 */
	[Event(name="complete", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when a cue point is reached. * *  @eventType mx.events.MetadataEvent.CUE_POINT *  @helpid 3483 *  @tiptext cuePoint event
	 */
	[Event(name="cuePoint", type="mx.events.MetadataEvent")] 
	/**
	 *  Dispatched the first time the FLV metadata is reached. * *  @eventType mx.events.MetadataEvent.METADATA_RECEIVED *  @tiptext metadata event
	 */
	[Event(name="metadataReceived", type="mx.events.MetadataEvent")] 
	/**
	 *  Dispatched every 0.25 seconds while the video is playing. *  This event is not dispatched when it is paused or stopped, *  unless a seek occurs. * *  @eventType mx.events.VideoEvent.PLAYHEAD_UPDATE *  @helpid 3480 *  @tiptext change event
	 */
	[Event(name="playheadUpdate", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched every 0.25 seconds while the video is downloading. * *  <p>Indicates progress made in number of bytes downloaded. *  You can use this event to check the number of bytes loaded *  or the number of bytes in the buffer. *  This event starts when <code>load</code> is called and ends *  when all bytes are loaded or if there is a network error.</p> * *  @eventType flash.events.ProgressEvent.PROGRESS *  @helpid 3485 *  @tiptext progress event
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	/**
	 *  Dispatched when the video is loaded and ready to display. * *  <p>This event is dispatched the first time the VideoPlayer *  enters a responsive state after a new FLV is loaded *  with the <code>play()</code> or <code>load()</code> method. *  It is dispatched once for each FLV loaded.</p> * *  @eventType mx.events.VideoEvent.READY
	 */
	[Event(name="ready", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when the video autorewinds. * *  @eventType mx.events.VideoEvent.REWIND
	 */
	[Event(name="rewind", type="mx.events.VideoEvent")] 
	/**
	 *  Dispatched when the playback state changes. * *  <p>This event can be used to track when playback enters and leaves *  unresponsive states (for example in the middle of connecting, *  resizing or rewinding) during which times the method *  <code>play()</code>, <code>pause()</code>, <code>stop()</code> *  and <code>seek()</code> will queue the requests to be executed *  when the player enters a responsive state.</p> * *  @eventType mx.events.VideoEvent.STATE_CHANGE
	 */
	[Event(name="stateChange", type="mx.events.VideoEvent")] 

	/**
	 *  @private *  VideoPlayer is an easy to use wrapper for Video, NetConnection, *  NetStream, etc. that makes playing FLV easy.  It supports streaming *  from Flash Communication Server (FCS) and http download of FLVs. * *  <p>VideoPlayer extends Video.</p> * *  @tiptext    VideoPlayer: FLV player *  @helpid ???
	 */
	public class VideoPlayer extends Video
	{
		/**
		 *  <p>State constant.  This is the state when the VideoPlayer is     *  constructed and when the stream is closed by a call to     *  <code>close()</code> or timed out on idle.</p>     *     *  <p>This is a responsive state.</p>     *     *  @see #state     *  @see #stateResponsive     *  @see #connected     *  @see #idleTimeout     *  @see #close()
		 */
		public static const DISCONNECTED : String = "disconnected";
		/**
		 *  <p>State constant.  FLV is loaded and play is stopped.  This state     *  is entered when <code>stop()</code> is called and when the     *  playhead reaches the end of the stream.</p>     *     *  <p>This is a responsive state.</p>     *     *  @see #state     *  @see #stateResponsive     *  @see #stop()
		 */
		public static const STOPPED : String = "stopped";
		/**
		 *  <p>State constant.  FLV is loaded and is playing.     *  This state is entered when <code>play()</code>     *  is called.</p>     *     *  <p>This is a responsive state.</p>     *     *  @see #state     *  @see #stateResponsive     *  @see #play()
		 */
		public static const PLAYING : String = "playing";
		/**
		 *  <p>State constant.  FLV is loaded, but play is paused.     *  This state is entered when <code>pause()</code> is     *  called or when <code>load()</code> is called.</p>     *     *  <p>This is a responsive state.</p>     *     *  @see #state     *  @see #stateResponsive     *  @see #pause()     *  @see #load()
		 */
		public static const PAUSED : String = "paused";
		/**
		 *  <p>State constant.  State entered immediately after     *  <code>play()</code> or <code>load()</code> is called.</p>     *     *  <p>This is a responsive state.</p>     *     *  @see #state     *  @see #stateResponsive
		 */
		public static const BUFFERING : String = "buffering";
		/**
		 *  <p>State constant.  State entered immediately after     *  <code>play()</code> or <code>load()</code> is called.</p>     *     *  <p>This is a unresponsive state.</p>     *     *  @see #state     *  @see #stateResponsive     *  @see #load()     *  @see #play()
		 */
		public static const LOADING : String = "loading";
		/**
		 *  <p>State constant.  Stream attempted to load was unable to load     *  for some reason.  Could be no connection to server, stream not     *  found, etc.</p>     *     *  <p>This is a unresponsive state.</p>     *     *  @see #state       *  @see #stateResponsive
		 */
		public static const CONNECTION_ERROR : String = "connectionError";
		/**
		 *  <p>State constant.  State entered during a autorewind triggered     *  by a stop.  After rewind is complete, the state will be     *  <code>STOPPED</code>.</p>     *     *  <p>This is a unresponsive state.</p>     *     *  @see #state       *  @see #autoRewind     *  @see #stateResponsive
		 */
		public static const REWINDING : String = "rewinding";
		/**
		 *  <p>State constant.  State entered after <code>seek()</code>     *  is called.</p>     *     *  <p>This is a unresponsive state.</p>     *     *  @see #state       *  @see #stateResponsive     *  @see #seek()
		 */
		public static const SEEKING : String = "seeking";
		/**
		 *  <p>State constant.  State entered during autoresize.</p>     *     *  <p>This is a unresponsive state.</p>     *     *  @see #state     *  @see #stateResponsive
		 */
		public static const RESIZING : String = "resizing";
		/**
		 *  <p>State constant.  State during execution of queued command.     *  There will never get a "stateChange" event notification with     *  this state; it is internal only.</p>     *     *  <p>This is a unresponsive state.</p>     *     *  @see #state     *  @see #stateResponsive
		 */
		public static const EXEC_QUEUED_CMD : String = "execQueuedCmd";
		/**
		 *  @private
		 */
		private static const BUFFER_EMPTY : String = "bufferEmpty";
		/**
		 *  @private
		 */
		private static const BUFFER_FULL : String = "bufferFull";
		/**
		 *  @private     *  use this full plus state to work around bug where sometimes     *  empty full messages coming in quick succession come in wrong     *  order
		 */
		private static const BUFFER_FLUSH : String = "bufferFlush";
		public static const DEFAULT_UPDATE_TIME_INTERVAL : Number = 250;
		public static const DEFAULT_UPDATE_PROGRESS_INTERVAL : Number = 250;
		public static const DEFAULT_IDLE_TIMEOUT_INTERVAL : Number = 300000;
		public static const AUTO_RESIZE_INTERVAL : Number = 100;
		public static const AUTO_RESIZE_PLAYHEAD_TIMEOUT : Number = .5;
		public static const AUTO_RESIZE_METADATA_DELAY_MAX : Number = 5;
		public static const FINISH_AUTO_RESIZE_INTERVAL : Number = 250;
		public static const RTMP_DO_STOP_AT_END_INTERVAL : Number = 500;
		public static const RTMP_DO_SEEK_INTERVAL : Number = 100;
		public static const HTTP_DO_SEEK_INTERVAL : Number = 250;
		public static const HTTP_DO_SEEK_MAX_COUNT : Number = 4;
		public static const CLOSE_NS_INTERVAL : Number = .25;
		public static const HTTP_DELAYED_BUFFERING_INTERVAL : Number = 100;
		/**
		 *  <p>Set this property to the name of your custom class to     *  make all VideoPlayer objects created use that class as the     *  default INCManager implementation.  The default value is     *  "mx.controls.videoClasses.NCManager".</p>
		 */
		public static var DEFAULT_INCMANAGER : Class;
		/**
		 *  @private     *  See VideoDisplay's autoBandWidthDetection
		 */
		public var autoBandWidthDetection : Boolean;
		/**
		 *  @private
		 */
		private var cachedState : String;
		/**
		 *  @private
		 */
		private var bufferState : String;
		/**
		 *  @private
		 */
		private var sawPlayStop : Boolean;
		/**
		 *  @private
		 */
		private var cachedPlayheadTime : Number;
		/**
		 *  @private
		 */
		private var startingPlay : Boolean;
		/**
		 *  @private
		 */
		private var invalidSeekRecovery : Boolean;
		/**
		 *  @private
		 */
		private var invalidSeekTime : Boolean;
		/**
		 *  @private
		 */
		private var readyDispatched : Boolean;
		/**
		 *  @private
		 */
		private var lastUpdateTime : Number;
		/**
		 *  @private
		 */
		private var sawSeekNotify : Boolean;
		/**
		 *  @private
		 */
		public var ncMgrClassName : Class;
		/**
		 *  @private
		 */
		private var ns : VideoPlayerNetStream;
		/**
		 *  @private
		 */
		private var currentPos : Number;
		/**
		 *  @private
		 */
		private var atEnd : Boolean;
		/**
		 *  @private
		 */
		private var streamLength : Number;
		/**
		 *  @private     *  <p>If true, then video plays immediately, if false waits for     *  <code>play</code> to be called.  Set to true if stream is     *  loaded with call to <code>play()</code>, false if loaded     *  by call to <code>load()</code>.</p>     *     *  <p>Even if <code>autoPlay</code> is set to false, we will start     *  loading the video after <code>initialize()</code> is called.     *  In the case of FCS, this means creating the stream and loading     *  the first frame to display (and loading more if     *  <code>autoSize</code> or <code>aspectRatio</code> is true).  In     *  the case of HTTP download, we will start downloading the stream     *  and show the first frame.</p>
		 */
		private var autoPlay : Boolean;
		/**
		 *  @private     *  The bytes loaded at the prior sample.     *  Used to determine whether to dispatch a progress event.
		 */
		private var _priorBytesLoaded : int;
		/**
		 *  @private     *  Internally used for sizing
		 */
		private var internalVideoWidth : Number;
		private var internalVideoHeight : Number;
		private var prevVideoWidth : Number;
		private var prevVideoHeight : Number;
		/**
		 *  @private     *  Timers
		 */
		private var updateTimeTimer : Timer;
		private var updateProgressTimer : Timer;
		private var idleTimeoutTimer : Timer;
		private var autoResizeTimer : Timer;
		private var rtmpDoStopAtEndTimer : Timer;
		private var rtmpDoSeekTimer : Timer;
		private var httpDoSeekTimer : Timer;
		private var finishAutoResizeTimer : Timer;
		private var delayedBufferingTimer : Timer;
		/**
		 *  @private     *  Count for httpDoSeekTimer
		 */
		private var httpDoSeekCount : Number;
		/**
		 *  @private     *  queues up Objects describing queued commands to be run later     *  QueuedCommand defined at the end of this file
		 */
		private var cmdQueue : Array;
		/**
		 *  @private     *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _visible : Boolean;
		/**
		 *  @private
		 */
		private var _autoRewind : Boolean;
		/**
		 *  @private
		 */
		private var _url : String;
		/**
		 *  @private
		 */
		private var _volume : Number;
		/**
		 *  @private
		 */
		private var _soundTransform : SoundTransform;
		/**
		 *  @private
		 */
		private var _isLive : Boolean;
		/**
		 *  @private
		 */
		private var _state : String;
		/**
		 *  @private
		 */
		private var _bufferTime : Number;
		/**
		 *  @private
		 */
		private var _ncMgr : INCManager;
		/**
		 *  @private
		 */
		private var _metadata : Object;

		/**
		 *  100 is standard scale     *     *  @see #setScale()     *  @tiptext Specifies the horizontal scale factor     *  @helpid 3974
		 */
		public function set scaleX (xs:Number) : void;
		/**
		 *  100 is standard scale     *     *  @see #setScale()     *  @tiptext Specifies the vertical scale factor     *  @helpid 3975
		 */
		public function set scaleY (ys:Number) : void;
		/**
		 *  <p>Width of video instance.  Not same as Video.width, that is videoWidth.</p>     *     *  @see #setSize()     *  @see #videoWidth     *  @helpid 0
		 */
		public function set width (value:Number) : void;
		/**
		 *  <p>Height of video.  Not same as Video.height, that is videoHeight.</p>     *     *  @see #setSize()     *  @see #videoHeight     *  @helpid 0
		 */
		public function set height (value:Number) : void;
		/**
		 *  <p>Source width of loaded FLV file.  Read only.  Returns     *  undefined if no information available yet.</p>     *     *  @see #width
		 */
		public function get videoWidth () : int;
		/**
		 *  <p>Source height of loaded FLV file.  Read only.  Returns     *  undefined if no information available yet.</p>     *     *  @see #height
		 */
		public function get videoHeight () : int;
		/**
		 * <p>Use this instead of <code>_visible</code> because we     * sometimes do internal visibility management when doing an     * autoresize.</p>
		 */
		public function get visible () : Boolean;
		/**
		 *  @private
		 */
		public function set visible (v:Boolean) : void;
		/**
		 *  <p>Determines whether the FLV is rewound to the first frame     *  when play stops, either by calling <code>stop()</code> or by     *  reaching the end of the stream.  Meaningless for live streams.</p>     *     *  @helpid 0
		 */
		public function get autoRewind () : Boolean;
		/**
		 *  @private
		 */
		public function set autoRewind (flag:Boolean) : void;
		/**
		 *  <p>The current playhead time in seconds.  Setting does a seek     *  and has all the restrictions of a seek.</p>     *     *  <p>The event "playheadUpdate" is dispatched when the playhead     *  time changes, including every .25 seconds while the FLV is     *  playing.</p>     *     *  @return The playhead position, measured in seconds since the start.  Will return a fractional value.     *     *  @tiptext Current position of the playhead in seconds     *  @helpid 3463     *  @see #seek()
		 */
		public function get playheadTime () : Number;
		/**
		 *  @private
		 */
		public function set playheadTime (position:Number) : void;
		/**
		 *  <p>url of currently loaded (or loading) stream. Will be url     *  last sent to <code>play()</code> or <code>load()</code>, <code>null</code>     *  if no stream is loaded.</p>     *     *  @tiptext Holds the relative path and filename of the media to be streamed     *  @helpid 3457
		 */
		public function get url () : String;
		/**
		 *  <p>Volume control in range from 0 to 1.</p>     *     *  @return The most recent volume setting     *     *  @tiptext The volume setting in value range from 0 to 1.     *  @helpid 3468     *  @see #soundTransform
		 */
		public function get volume () : Number;
		/**
		 *  @private
		 */
		public function set volume (aVol:Number) : void;
		/**
		 *  <p>Provides direct access to the     *  <code>flash.media.SoundTransform</code> object to expose     *  more sound control.  Must set property for changes to take     *  effect, get property just to get a copy of the current     *  settings to tweak.     *     *  @see #volume
		 */
		public function get soundTransform () : SoundTransform;
		/**
		 *  @private
		 */
		public function set soundTransform (s:SoundTransform) : void;
		/**
		 * True if stream is RTMP download (streaming from Flash     * Communication Server), read only.
		 */
		public function get isRTMP () : Boolean;
		/**
		 * <p>True if stream is live, read only.  isLive only makes sense when     * streaming from FVSS or FCS, value is ignored when doing http     * download.</p>
		 */
		public function get isLive () : Boolean;
		/**
		 * Get state.  Read only.  Set with <code>load</code>,     * <code>play()</code>, <code>stop()</code>,     * <code>pause()</code> and <code>seek()</code>.
		 */
		public function get state () : String;
		/**
		 *  Read only. Gets whether state is responsive.  If state is     *  unresponsive, calls to APIs <code>play()</code>,     *  <code>load()</code>, <code>stop()</code>,     *  <code>pause()</code> and <code>seek()</code> will queue the     *  requests for later, when the state changes to a responsive     *  one.     *     *  @see #connected     *  @see #MAX_RESPONSIVE_STATE     *  @see #DISCONNECTED     *  @see #STOPPED     *  @see #PLAYING     *  @see #PAUSED     *  @see #LOADING     *  @see #RESIZING     *  @see #CONNECTION_ERROR     *  @see #REWINDING
		 */
		public function get stateResponsive () : Boolean;
		/**
		 *  <p>property bytesLoaded, read only.  Returns -1 when there     *  is no stream, when the stream is FCS or if the information     *  is not yet available.  Return value only useful for HTTP     *  download.</p>     *     *  @tiptext Number of bytes already loaded     *  @helpid 3455
		 */
		public function get bytesLoaded () : int;
		/**
		 *  <p>property bytesTotal, read only.  Returns -1 when there     *  is no stream, when the stream is FCS or if the information     *  is not yet available.  Return value only useful for HTTP     *  download.</p>     *     *  @tiptext Number of bytes to be loaded     *  @helpid 3456
		 */
		public function get bytesTotal () : int;
		/**
		 *  <p>property totalTime.  read only.  -1 means that property     *  was not pass into <code>play()</code> or     * <code>load()</code> and was unable to detect automatically,     *  or have not yet.     *     *  @return The total running time of the FLV in seconds     *  @tiptext The total length of the FLV in seconds     *  @helpid 3467
		 */
		public function get totalTime () : Number;
		/**
		 * <p>Sets number of seconds to buffer in memory before playing     * back stream.  For slow connections streaming over rtmp, it is     * important to increase this from the default.  Default is     * 0.1</p>
		 */
		public function get bufferTime () : Number;
		/**
		 *  @private
		 */
		public function set bufferTime (aTime:Number) : void;
		/**
		 * <p>Property idleTimeout, which is amount of time in     * milliseconds before connection is idle (playing is paused     * or stopped) before connection to the FCS server is     * terminated.  Has no effect to HTTP download of FLV.</p>     *     * <p>If set when stream already idle, restarts idle timeout with     * new value.</p>
		 */
		public function get idleTimeout () : uint;
		/**
		 *  @private
		 */
		public function set idleTimeout (aTime:uint) : void;
		/**
		 * <p>Property playheadUpdateInterval, which is amount of time     * in milliseconds between each "playheadUpdate" event.</p>     *     * <p>If set when stream is playing, will restart timer.</p>
		 */
		public function get playheadUpdateInterval () : uint;
		/**
		 *  @private
		 */
		public function set playheadUpdateInterval (aTime:uint) : void;
		/**
		 * <p>Property progressInterval, which is amount of time     * in milliseconds between each "progress" event.</p>     *     * <p>If set when stream is playing, will restart timer.</p>
		 */
		public function get progressInterval () : uint;
		/**
		 *  @private
		 */
		public function set progressInterval (aTime:uint) : void;
		/**
		 * <p>Access to instance of the class implementing     * <code>INCManager</code>.  Read only.</p>     *     * <p>One use case for this is that a custom     * <code>INCManager</code> implementation may require custom     * initialization.</p>
		 */
		public function get ncMgr () : INCManager;
		/**
		 *  <p>Read only.  Object received by call to onMetaData callback.     *  null if onMetaData callback has not been called since the last     *  load or play call.  Always null with FLVs with no onMetaData     *  packet.</p>     *     *  @see #load()     *  @see #play()
		 */
		public function get metadata () : Object;

		/**
		 *  <p>Constructor.</p>     *  @private     *  Constructor.     *  @helpid 0     *  @see INCManager     *  @see NCManager
		 */
		public function VideoPlayer (width:uint, height:uint, ncMgrClassName:Class = null);
		/**
		 *  <p>set width and height simultaneously.  Since setting either     *  one can trigger an autoresize, this can be better than invoking     *  set width and set height individually.</p>     *     *  <p>If autoSize is true then this has no effect, since the player     *  sets its own dimensions.  If maintainAspectRatio is true and     *  autoSize is false, then changing width or height will trigger     *  an autoresize.</p>     *     *  @param width     *  @param height     *  @see width     *  @see height
		 */
		public function setSize (w:Number, h:Number) : void;
		/**
		 *  <p>set scaleX and scaleY simultaneously.  Since setting either     *  one can trigger an autoresize, this can be better than invoking     *  set width and set height individually.</p>     *     *  <p>If autoSize is true then this has no effect, since the player     *  sets its own dimensions.  If maintainAspectRatio is true and     *  autoSize is false, then changing scaleX or scaleY will trigger an     *  autoresize.</p>     *     *  @param scaleX     *  @param scaleY     *  @see scaleX     *  @see scaleY
		 */
		public function setScale (xs:Number, ys:Number) : void;
		/**
		 *  <p>Causes the video to play.  Can be called while the video is     *  paused, stopped, or while the video is already playing.  Call this     *  method with no arguments to play an already loaded video or pass     *  in a url to load a new stream.</p>     *     *  <p>If player is in an unresponsive state, queues the request.</p>     *     *  <p>Throws an exception if called with no args and no stream     *  is connected.  Use "stateChange" event and     *  <code>connected</code> property to determine when it is     *  safe to call this method.</p>     *     *  @param url Pass in a url string if you want to load and play a     *  new FLV.  If you have already loaded an FLV and want to continue     *  playing it, pass in <code>null</code>.     *  @param isLive Pass in true if streaming a live feed from FCS.     *  Defaults to false.     *  @param totalTime Pass in length of FLV.  Pass in -1      *  to automatically detect length from metadata, server     *  or xml.  If <code>INCManager.streamLength</code> is not -1 when     *  <code>ncConnected</code> is called, then     *  that value will trump this one in any case.  Default is -1.     *      *  @see #connected     *  @see #stateResponsive     *  @see #load()
		 */
		public function play (url:String = null, isLive:Boolean = false, totalTime:Number = -1) : void;
		/**
		 *  <p>Similar to play, but causes the FLV to be loaded without     *  playing.  Autoresizing will occur if appropriate and the first     *  frame of FLV will be shown (except for maybe not in the live case).     *  After initial load and autoresize, state will be <code>PAUSED</code>.</p>     *     *  <p>Takes same arguments as <code>play()</code>, but unlike that     *  method it is never acceptable to call <code>load()</code> with     *  no url.  If you do, an <code>Error</code> will be thrown.</p>     *     *  <p>If player is in an unresponsive state, queues the request.</p>     *     *  @param url Pass in a url string for the FLV you want to load.     *  @param isLive Pass in true if streaming a live feed from FCS.     *  Defaults to false.     *  @param totalTime Pass in length of FLV.  Pass in -1 to     *  automatically detect length from metadata, server or xml.     *  If <code>INCManager.streamLength</code> is not -1 when     *  <code>ncConnected</code> is called, then that value will     *  trump this one in any case.  Default is -1.     *  @see #connected     *  @see #play()
		 */
		public function load (url:String, isLive:Boolean = false, totalTime:Number = -1) : void;
		/**
		 *  <p>Pauses video playback.  If video is paused or stopped, has     *  no effect.  To start playback again, call <code>play()</code>.     *  Takes no parameters</p>     *     *  <p>If player is in an unresponsive state, queues the request.</p>     *     *  <p>Throws an exception if called when no stream is     *   connected.  Use "stateChange" event and     *  <code>connected</code> property to determine when it is     *  safe to call this method.</p>     *     *  <p>If state is already stopped, pause is does nothing and state     *  remains stopped.</p>     *     *  @see #connected     *  @see #stateResponsive     *  @see #play()
		 */
		public function pause () : void;
		/**
		 *  <p>Stops video playback.  If <code>autoRewind</code> is set to     *  <code>true</code>, rewinds to first frame.  If video is already     *  stopped, has no effect.  To start playback again, call     *  <code>play()</code>.  Takes no parameters</p>     *     *  <p>If player is in an unresponsive state, queues the request.</p>     *     *  <p>Throws an exception if called when no stream is     *  connected.  Use "stateChange" event and     *  <code>connected</code> property to determine when it is     *  safe to call this method.</p>     *     *  @see #connected     *  @see #stateResponsive     *  @see #autoRewind     *  @see #play()
		 */
		public function stop () : void;
		/**
		 *  <p>Seeks to given second in video.  If video is playing,     *  continues playing from that point.  If video is paused, seek to     *  that point and remain paused.  If video is stopped, seek to     *  that point and enters paused state.  Has no effect with live     *  streams.</p>     *     *  <p>If time is less than 0 or NaN, throws exeption.  If time     *  is past the end of the stream, or past the amount of file     *  downloaded so far, then will attempt seek and when fails     *  will recover.</p>     *     *  <p>If player is in an unresponsive state, queues the request.</p>     *     *  <p>Throws an exception if called when no stream is     *  connected.  Use "stateChange" event and     *  <code>connected</code> property to determine when it is     *  safe to call this method.</p>     *     *  @param time seconds     *  @throws VideoError if time is < 0     *  @see #connected     *  @see #stateResponsive
		 */
		public function seek (time:Number) : void;
		/**
		 *  <p>Forces close of video stream and FCS connection.  Triggers     *  "close" event.  Typically calling this directly is not necessary     *  because the idle timeout functionality will take care of this.</p>     *     *  @see idleTimeout
		 */
		public function close () : void;
		/**
		 *  @private     *  <p>Called by <code>Timer updateTimeTimer</code> to send     *  "playheadUpdate" events.  Events only sent when playhead is     *  moving, sent every .25 seconds (see     *  <code>_updateTimeInterval</code>).
		 */
		public function doUpdateTime (event:Event) : void;
		/**
		 *  @private     *  <p>Called by <code>Timer _updateProgressTimer</code> to send     *  "progress" events.  Event dispatch starts when     *  <code>_load</code> is called, ends when all bytes downloaded or     *  a network error of some kind occurs, dispatched every .25     *  seconds.
		 */
		public function doUpdateProgress (event:Event) : void;
		/**
		 *  @private     *  <p><code>NetStream.onStatus</code> callback for rtmp.  Handles     *  automatic resizing, autorewind and buffering messaging.</p>
		 */
		public function rtmpOnStatus (event:NetStatusEvent) : void;
		/**
		 *  @private     *  <p><code>NetStream.onStatus</code> callback for http.  Handles     *  autorewind.</p>
		 */
		public function httpOnStatus (event:NetStatusEvent) : void;
		/**
		 *  @private      *  <p>Called by INCManager after when connection complete or     *  failed after call to <code>INCManager.connectToURL</code>.     *  If connection failed, set <code>INCManager.netConnection = null</code>     *  before calling.</p>     *     *  @see #ncReconnected()     *  @see INCManager#connectToURL     *  @see NCManager#connectToURL
		 */
		public function ncConnected () : void;
		/**
		 *  @private          *  <p>Called by INCManager after when reconnection complete or     *  failed after call to <code>INCManager.reconnect</code>.  If     *  connection failed, set <code>INCManager.netConnection = null</code>     *  before calling.</p>     *     *  @see #ncConnected()     *  @see INCManager#reconnect     *  @see NCManager#reconnect
		 */
		public function ncReconnected () : void;
		/**
		 *  handles NetStream.onMetaData callback     *     *  @private
		 */
		public function onMetaData (info:Object) : void;
		/**
		 *  handles NetStream.onCuePoint callback     *     *  @private
		 */
		public function onCuePoint (info:Object) : void;
		/**
		 *  @private     *  does loading work for play and load
		 */
		private function _load (url:String, isLive:Boolean, totalTime:Number) : void;
		/**
		 *  @private     *  sets state, dispatches event, execs queued commands.  Always try to call     *  this AFTER you do your work, because the state might change again after     *  you call this if you set it to a responsive state becasue of the call     *  to exec queued commands.  If you set this to a responsive state and     *  then do more state based logic, check _state to make sure it did not     *  change out from under you.
		 */
		private function setState (s:String) : void;
		/**
		 *  @private     *  Sets state to _cachedState if the _cachedState is PLAYING,     *  PAUSED or BUFFERING, otherwise sets state to STOPPED.
		 */
		private function setStateFromCachedState () : void;
		/**
		 * @private     * Helper used when an invalid seek occurs. We reset     * our player state and seek back to a valid playhead      * location.
		 */
		private function recoverInvalidSeek () : void;
		/**
		 *  @private     *  creates our implementatino of the <code>INCManager</code>.     *  We put this off until we need to do it to give time for the     *  user to customize the <code>DEFAULT_INCMANAGER</code>     *  static variable.
		 */
		private function createINCManager () : void;
		/**
		 *  @private     *  <p>ONLY CALL THIS WITH RTMP STREAMING</p>     *     *  <p>Has the logic for what to do when we decide we have come to     *  a stop by coming to the end of an rtmp stream.  There are a few     *  different ways we decide this has happened, and we sometimes     *  even set an interval that calls this function repeatedly to     *  check if the time is still changing, which is why it has its     *  own special function.</p>
		 */
		private function rtmpDoStopAtEnd (event:TimerEvent) : void;
		/**
		 *  @private     *  <p>ONLY CALL THIS WITH RTMP STREAMING</p>     *     *  <p>Wait until time goes back to zero to leave rewinding state.</p>
		 */
		private function rtmpDoSeek () : void;
		/**
		 *  @private     *  <p>ONLY CALL THIS WITH HTTP PROGRESSIVE DOWNLOAD</p>     *     *  <p>Call this when playing stops by hitting the end.</p>
		 */
		private function httpDoStopAtEnd () : void;
		/**
		 *  @private     *  <p>If we get an onStatus callback indicating a seek is over,     *  but the playheadTime has not updated yet, then we wait on a     *  timer before moving forward.</p>
		 */
		private function doSeek (event:Event) : void;
		/**
		 *  @private     *  <p>Wrapper for <code>NetStream.close()</code>.  Never call     *  <code>NetStream.close()</code> directly, always call this     *  method because it does some other housekeeping.</p>
		 */
		private function closeNS (updateCurrentPos:Boolean = true) : void;
		/**
		 *  @private     *  <p>We do a brief timer before entering BUFFERING state to avoid     *  quick switches from BUFFERING to PLAYING and back.</p>
		 */
		private function doDelayedBuffering (event:Event) : void;
		/**
		 *  @private     *  Wrapper for <code>NetStream.pause()</code> and <code>NetStream.resume()</code>.     *  Never call these NetStream methods directly; always call this     *  method because it does some other housekeeping.
		 */
		private function _pause (doPause:Boolean) : void;
		/**
		 *  @private     *  Wrapper for <code>NetStream.play()</code>.  Never call     *  <code>NetStream.play()</code> directly, always call this     *  method because it does some other housekeeping.
		 */
		private function _play (...rest) : void;
		/**
		 *  @private     *  Wrapper for <code>NetStream.seek()</code>.  Never call     *  <code>NetStream.seek()</code> directly, always call     *  this method because it does some other housekeeping.
		 */
		private function _seek (time:Number) : void;
		/**
		 *  @private     *  Gets whether connected to a stream.  If not, then calls to APIs     *  <code>play() with no args</code>, <code>stop()</code>,     *  <code>pause()</code> and <code>seek()</code> will throw     *  exceptions.     *     *  @see #stateResponsive
		 */
		private function isXnOK () : Boolean;
		/**
		 *  @private     *  <p>Does the actual work of resetting the width and height.</p>     *     *  <p>Called on a timer which is stopped when width and height     *  of the <code>Video</code> object are not zero.  Finishing the     *  resize is done in another method which is either called on a     *  timer set up here for live streams or on a     *  NetStream.Play.Stop event in <code>rtmpOnStatus</code> after     *  stream is rewound if it is not a live stream.  Still need to     *  get a http solution.</p>
		 */
		private function doAutoResize (event:Event) : void;
		/**
		 * <p>Makes video visible, turns on sound and starts     * playing if live or autoplay.</p>
		 */
		private function finishAutoResize (event:Event) : void;
		/**
		 *  @private     *  <p>Creates <code>NetStream</code> and does some basic     *  initialization.</p>
		 */
		private function createStream () : void;
		/**
		 *  @private     *  <p>Does initialization after first connecting to the server     *  and creating the stream.  Will get the stream duration from     *  the <code>INCManager</code> if it has it for us.</p>     *     *  <p>Starts resize if necessary, otherwise starts playing if     *  necessary, otherwise loads first frame of video.  In http case,     *  starts progressive download in any case.</p>
		 */
		private function setUpStream () : void;
		/**
		 *  @private     *  <p>ONLY CALL THIS WITH RTMP STREAMING</p>     *     *  <p>Only used for rtmp connections.  When we pause or stop,     *  setup a timer to call this after a delay (see property     *  <code>idleTimeout</code>).  We do this to spare the server from     *  having a bunch of extra xns hanging around, although this needs     *  to be balanced with the load that creating connections puts on     *  the server, and keep in mind that FCS can be configured to     *  terminate idle connections on its own, which is a better way to     *  manage the issue.</p>
		 */
		private function doIdleTimeout (event:Event) : void;
		/**
		 *  @private     *  Dumps all queued commands without executing them
		 */
		private function flushQueuedCmds () : void;
		/**
		 *  @private     *  Executes as many queued commands as possible, obviously     *  stopping when state becomes unresponsive.
		 */
		private function execQueuedCmds () : void;
		private function queueCmd (type:uint, url:String = null, isLive:Boolean = false, time:Number = 0) : void;
	}
	/**
	 *  @private *  This subclass of NetStream handles onMetaData() and onCuePoint() *  calls from the server and forwards them to the VideoPlayer.
	 */
	internal dynamic class VideoPlayerNetStream extends NetStream
	{
		/**
		 *  @private
		 */
		private var videoPlayer : VideoPlayer;

		/**
		 *  Constructor.
		 */
		public function VideoPlayerNetStream (connection:NetConnection, videoPlayer:VideoPlayer);
		/**
		 *  @private     *  Called by the server.
		 */
		public function onMetaData (info:Object, ...rest) : void;
		/**
		 *  @private     *  Called by the server.
		 */
		public function onCuePoint (info:Object, ...rest) : void;
		/**
		 *  @private
		 */
		public function onPlayStatus (...rest) : void;
	}
}
