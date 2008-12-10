package mx.controls.videoClasses
{
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	import flash.utils.Timer;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  @private *  Creates <code>NetConnection</code> for <code>VideoPlayer</code>, a *  helper class for that user facing class.
	 */
	public class NCManager implements INCManager
	{
		/**
		 *  Default connection timeout in milliseconds.     *     *  @see #timeout
		 */
		public static const DEFAULT_TIMEOUT : Number = 60000;
		/**
		 *  @private
		 */
		private static const DEFAULT_NC_TIMEOUT : uint = 1500;
		/**
		 *  @private     *  List of connections tried by connectRTMP, in order tried.
		 */
		private static var RTMP_CONN : Array;
		/**
		 * <p>fallbackServerName is exposed in two ways:</p>     *      * <p>User can supply second <meta base> in smil and that base     * attr will be taken as the fallbackServerName (note that only     * the server name will be taken from this and not the application     * name or anything else).</p>     *     * <p>The second way is the user can directly set this by     * accessing the ncMgr property in FLVPlayback or VideoPlayer and     * set fallbackServerName property directly.</p>
		 */
		public var fallbackServerName : String;
		/**
		 *  @private     *  Reference to the VideoPlayer instance associated with this INCManager.
		 */
		private var owner : VideoPlayer;
		/**
		 *  @private     *  The path to the content.
		 */
		private var contentPath : String;
		/**
		 *  @private
		 */
		private var protocol : String;
		/**
		 *  @private     *  The host name portion of the URL.
		 */
		private var serverName : String;
		/**
		 *  @private     *  The port number portion of the URL.
		 */
		private var portNumber : String;
		/**
		 *  @private
		 */
		private var wrappedURL : String;
		/**
		 *  @private
		 */
		private var appName : String;
		/**
		 *  @private     *  Multiple streams for multiple bandwidths.
		 */
		private var streams : Array;
		/**
		 *  @private     *  Whether the protocol is RTMP.     *   -1: undefined     *    0: no     *    1: yes
		 */
		private var _isRTMP : int;
		/**
		 *  @private     *  Timer for connection timeout.
		 */
		private var connectionTimer : Timer;
		/**
		 *  @private
		 */
		private var autoSenseBW : Boolean;
		/**
		 *  @private     *  Bandwidth detection stuff.
		 */
		public var payload : uint;
		/**
		 *  @private     *  Value of the NetConnection instance's uri property.  This is saved upon     *  connection and reused for reconnecting.
		 */
		private var ncURI : String;
		/**
		 *  @private
		 */
		private var ncConnected : Boolean;
		/**
		 *  @private     *  Info on multiple connections we try.
		 */
		public var tryNC : Array;
		/**
		 *  @private
		 */
		private var tryNCTimer : Timer;
		/**
		 *  @private     *  Counter that tracks the next type to try in RTMP_CONN.
		 */
		private var connTypeCounter : uint;
		/**
		 *  @private	 *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private     *  Storage for timeout property.
		 */
		private var _timeout : uint;
		/**
		 *  @private     *  Storage for bitrate property.
		 */
		private var _bitrate : Number;
		/**
		 *  @private
		 */
		private var _netConnection : NetConnection;
		/**
		 *  @private     *  Storage for streamName property.
		 */
		private var _streamName : String;
		/**
		 *  @private     *  Storage for streamLength property.
		 */
		private var _streamLength : Number;
		/**
		 *  @private     *  Storage for streamWidth property.
		 */
		private var _streamWidth : Number;
		/**
		 *  @private     *  Storage for streamHeight property.
		 */
		private var _streamHeight : Number;

		/**
		 *  @see INCManager#timeout
		 */
		public function get timeout () : uint;
		public function set timeout (t:uint) : void;
		/**
		 *  For RTMP streams, returns value calculated from autodetection,     *  not value set via bitrate.     *     *  @see INCManager#bitrate
		 */
		public function get bitrate () : Number;
		/**
		 *  This value is only used with progressive download (HTTP), with     *  RTMP streaming uses autodetection.     *     *  @see INCManager#bitrate
		 */
		public function set bitrate (b:Number) : void;
		/**
		 *  @see INCManager#videoPlayer
		 */
		public function get videoPlayer () : VideoPlayer;
		/**
		 *  @private
		 */
		public function set videoPlayer (value:VideoPlayer) : void;
		/**
		 *  @see INCManagernetConnection
		 */
		public function get netConnection () : NetConnection;
		/**
		 *  @see INCManager#streamName
		 */
		public function get streamName () : String;
		/**
		 *  @see INCManager#streamLength
		 */
		public function get streamLength () : Number;
		/**
		 *  @see INCManager#streamWidth
		 */
		public function get streamWidth () : Number;
		/**
		 *  @see INCManager#streamHeight
		 */
		public function get streamHeight () : Number;

		/**
		 *  @private     *  Constructor.
		 */
		public function NCManager ();
		/**
		 *  @see INCManager#isRTMP
		 */
		public function isRTMP () : Boolean;
		/**
		 *  @see INCManager#connectToURL()
		 */
		public function connectToURL (url:String) : Boolean;
		/**
		 *  @see INCManager#connectAgain()
		 */
		public function connectAgain () : Boolean;
		/**
		 * INCManager#reconnect
		 */
		public function reconnect () : void;
		/**
		 *  @see INCManager#close
		 */
		public function close () : void;
		/**
		 *  @private     *  Initialization.
		 */
		private function initNCInfo () : void;
		private function initOtherInfo () : void;
		/**
		 *  matches bitrate with stream     *     *  @private
		 */
		private function bitrateMatch () : void;
		/**
		 *  <p>Parses URL to determine if it is http or rtmp.  If it is rtmp,     *  breaks it into pieces to extract server URL and port, application     *  name and stream name.  If .flv is at the end of an rtmp URL, it     *  will be stripped off.</p>     *     *  @private
		 */
		private function parseURL (url:String) : Object;
		/**
		 *  @private     *  <p>Handles creating <code>NetConnection</code> instance for     *  progressive download of FLV via http.</p>
		 */
		private function connectHTTP () : Boolean;
		/**
		 *  @private     *  <p>Top level function for creating <code>NetConnection</code>     *  instance for streaming playback of FLV via rtmp.  Actually     *  tries to create several different connections using different     *  protocols and ports in a pipeline, so multiple connection     *  attempts may be occurring simultaneously, and will use the     *  first one that connects successfully.</p>
		 */
		private function connectRTMP () : Boolean;
		/**
		 *  @private     *  <p>Does work of trying to open rtmp connections.  Called either     *  by <code>connectRTMP</code> or <code>Timer</code> set up in     *  that method.</p>     *     *  <p>For creating rtmp connections.</p>     *      *  @see #connectRTMP()
		 */
		private function nextConnect (event:Event) : void;
		/**
		 *  @private     *  <p>Stops all timers, closes all unneeded connections, and other     *  cleanup related to the <code>connectRTMP</code> strategy of     *  pipelining connection attempts to different protocols and     *  ports.</p>     *     *  <p>For creating rtmp connections.</p>     *     *  @see #connectRTMP()
		 */
		private function cleanConns () : void;
		/**
		 *  @private     *  <p>Starts another pipelined connection attempt with     *  <code>connectRTMP</code> with the fallback server.</p>     *     *  <p>For creating rtmp connections.</p>     *     *  @see #connectRTMP()
		 */
		private function tryFallBack () : void;
		/**
		 *  @private     *  dispatches reconnect event, called by     *  <code>NetConnection.onBWDone</code>
		 */
		public function onReconnected () : void;
		/**
		 *  @private     *  <p>Starts another pipelined connection attempt with     *  <code>connectRTMP</code> with the fallback server.</p>     *     *  <p>For creating rtmp connections.</p>     *     *  @see #connectRTMP()
		 */
		public function onConnected (p_nc:NetConnection, p_bw:Number) : void;
		/**
		 *  @private     *  netStatus event listener when connecting
		 */
		public function connectOnStatus (event:NetStatusEvent) : void;
		/**
		 *  @private     *  netStatus event listener when reconnecting
		 */
		public function reconnectOnStatus (event:NetStatusEvent) : void;
		/**
		 *  @private     *  netStatus event listener for disconnecting extra     *  NetConnections that were opened in parallel
		 */
		public function disconnectOnStatus (event:NetStatusEvent) : void;
		/**
		 *  @private     *  Responder function to receive streamLength result from     *  server after making rpc
		 */
		private function getStreamLengthResult (length:Number) : void;
		/**
		 *  @private     *  Responder function to receive status messages for rpc to     *  get streamLength
		 */
		private function getStreamLengthStatus (item:Object) : void;
		/**
		 *  @private     *  <p>Called by timer to timeout all connection attempts.</p>     *     *  <p>For creating rtmp connections.</p>     *     *  @see #connectRTMP()
		 */
		private function onFCSConnectTimeOut (event:Event) : void;
		/**
		 *  @private          *  <p>Compares connection info with previous NetConnection,     *  will reuse existing connection if possible.
		 */
		private function canReuseOldConnection (parseResults:Object) : Boolean;
	}
}
