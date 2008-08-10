/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.core.EdgeMetrics;
	import flash.media.Camera;
	public class VideoDisplay extends UIComponent {
		/**
		 * Specifies whether the VideoDisplay control should use the built-in
		 *  automatic bandwidth detection feature.
		 *  When false, you do not require a main.asc file
		 *  on Flash Media Server (FMS) 2 to connect to FMS.
		 *  When true, you need to implement a main.asc
		 *  and store it in the directory structure of FMS.
		 *  The main.
		 */
		public function get autoBandWidthDetection():Boolean;
		public function set autoBandWidthDetection(value:Boolean):void;
		/**
		 * Specifies whether the video should start playing immediately when the
		 *  source property is set.
		 *  If true, the video file immediately begins to buffer and
		 *  play.
		 */
		public function get autoPlay():Boolean;
		public function set autoPlay(value:Boolean):void;
		/**
		 * Specifies whether the FLV file should be rewound to the first frame
		 *  when play stops, either by calling the stop() method or by
		 *  reaching the end of the stream.
		 *  This property has no effect for live streaming video.
		 */
		public function get autoRewind():Boolean;
		public function set autoRewind(value:Boolean):void;
		/**
		 * The border object for the control.
		 */
		protected var border:IFlexDisplayObject;
		/**
		 * Returns an EdgeMetrics object that has four properties:
		 *  left, top, right,
		 *  and bottom.
		 *  The value of each property is equal to the thickness of one side
		 *  of the border around the control, in pixels.
		 */
		public function get borderMetrics():EdgeMetrics;
		/**
		 * Number of seconds of video to buffer in memory before starting to play
		 *  the video file.
		 *  For slow connections streaming over RTMP, it is important to increase
		 *  this property from the default.
		 */
		public function get bufferTime():Number;
		public function set bufferTime(value:Number):void;
		/**
		 * Number of bytes already loaded that are available for playing.
		 *  The value is only useful for media loaded using HTTP.
		 */
		public function get bytesLoaded():int;
		/**
		 * Total number of bytes to load.
		 *  The value is only useful for media loaded using HTTP.
		 */
		public function get bytesTotal():int;
		/**
		 * The instance of the CuePointManager class associated with
		 *  the VideoPlayer control.
		 *  You can use this object to control cue points, or use the
		 *  cuePoints property.
		 */
		public function get cuePointManager():Object;
		/**
		 * Cue point manager to use.
		 *  Set this to mx.controls.videoClasses.CuePointManager to enable cue
		 *  point management.
		 */
		public function get cuePointManagerClass():Class;
		public function set cuePointManagerClass(value:Class):void;
		/**
		 * The Array of cue points associated with the control.
		 *  You can use this property to control cue points, or use the
		 *  cuePointManager property.
		 */
		public function get cuePoints():Array;
		public function set cuePoints(value:Array):void;
		/**
		 * Specifies the amount of time, in milliseconds, that the connection is
		 *  idle (playing is paused or stopped) before the connection to the Flash
		 *  Media Server is stopped.
		 *  This property has no effect on the HTTP download of FLV files.
		 *  If this property is set when the stream is already idle,
		 *  it restarts the idle timeout with a new value.
		 */
		public function get idleTimeout():int;
		public function set idleTimeout(value:int):void;
		/**
		 * Specifies whether the control is streaming a live feed.
		 *  Set this property to true when streaming a
		 *  live feed from Flash Media Server.
		 */
		public function get live():Boolean;
		public function set live(value:Boolean):void;
		/**
		 * Specifies whether the control should maintain the original aspect ratio
		 *  while resizing the video.
		 */
		public function get maintainAspectRatio():Boolean;
		public function set maintainAspectRatio(value:Boolean):void;
		/**
		 * An object that contains a metadata information packet that is received from a call to
		 *  the NetSteam.onMetaData() callback method, if available.
		 *  Ready when the metadataReceived event is dispatched.
		 */
		public function get metadata():Object;
		/**
		 * Playhead position, measured in seconds, since the video starting
		 *  playing.
		 *  The event object for many of the VideoPlay events include the playhead
		 *  position so that you can determine the location in the video file where
		 *  the event occurred.
		 */
		public function get playheadTime():Number;
		public function set playheadTime(value:Number):void;
		/**
		 * Specifies the amount of time, in milliseconds,
		 *  between each playheadUpdate event.
		 */
		public function get playheadUpdateInterval():int;
		public function set playheadUpdateInterval(value:int):void;
		/**
		 * If true, the media is currently playing.
		 */
		public function get playing():Boolean;
		/**
		 * Specifies the amount of time, in milliseconds,
		 *  between each progress event.
		 *  The progress event occurs continuously
		 *  until the video file downloads completely.
		 */
		public function get progressInterval():int;
		public function set progressInterval(value:int):void;
		/**
		 * Relative path and filename of the FLV file to stream.
		 */
		public function get source():String;
		public function set source(value:String):void;
		/**
		 * The current state of the VideoDisplay control.
		 *  You set this property by calls to the load(),
		 *  play(), stop(), and pause()
		 *  methods, and setting the playHeadTime property.
		 */
		public function get state():String;
		/**
		 * Specifies whether the VideoDisplay control is in a responsive state,
		 *  true, or in the unresponsive state, false.
		 *  The control enters the unresponsive state when video is being loaded
		 *  or is rewinding.
		 */
		public function get stateResponsive():Boolean;
		/**
		 * Total length of the media, in seconds.
		 *  For FLV 1.0 video files, you manually set this property.
		 *  For FLV 1.1 and later, the control calculates this value automatically.
		 */
		public function get totalTime():Number;
		public function set totalTime(value:Number):void;
		/**
		 * Height of the loaded FLV file.
		 *  -1 if no FLV file loaded yet.
		 */
		public function get videoHeight():int;
		/**
		 * Width of the loaded FLV file.
		 *  -1 if no FLV file loaded yet.
		 */
		public function get videoWidth():int;
		/**
		 * The volume level, specified as an value between 0 and 1.
		 */
		public function get volume():Number;
		public function set volume(value:Number):void;
		/**
		 * Constructor.
		 */
		public function VideoDisplay();
		/**
		 * Specifies whether to play a video stream from a camera.
		 *  The video is displayed within the boundaries of the
		 *  control in the application window.
		 *
		 * @param camera            <Camera> A Camera object that
		 *                            is capturing video data.
		 */
		public function attachCamera(camera:Camera):void;
		/**
		 * Forces the close of an input stream and connection to Flash Media
		 *  Server.
		 *  Calling this method dispatches the close event.
		 *  Typically calling this method directly is not necessary
		 *  because the connection is automatically closed when the idle period
		 *  times out, as defined by the idleTimeout property.
		 */
		public function close():void;
		/**
		 * Creates the border for this component.
		 *  Normally the border is determined by the
		 *  borderStyle and borderSkin styles.
		 *  It must set the border property to the instance of the border.
		 */
		protected function createBorder():void;
		/**
		 * Responds to size changes by setting the positions and sizes of
		 *  the borders.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected function layoutChrome(unscaledWidth:Number, unscaledHeight:Number):void;
		/**
		 * Loads the media file without playing it.
		 */
		public function load():void;
		/**
		 * Pauses playback without moving the playhead.
		 *  If playback is already is paused or is stopped, this method has no
		 *  effect.
		 */
		public function pause():void;
		/**
		 * Plays the media file.
		 *  If the file has not been loaded, it loads it.
		 *  You can call this method while playback is paused, stopped, or while
		 *  the control is playing.
		 */
		public function play():void;
		/**
		 * Stops playback.
		 *  If the autoRewind property is set to
		 *  true, rewind to the first frame.
		 */
		public function stop():void;
	}
}
