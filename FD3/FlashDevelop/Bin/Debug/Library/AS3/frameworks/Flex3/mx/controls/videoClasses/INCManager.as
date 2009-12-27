package mx.controls.videoClasses
{
	import flash.net.NetConnection;

	/**
	 *  @private
 *  Creates <code>NetConnection</code> for <code>VideoPlayer</code>,
 *  a helper class for that user facing class.
	 */
	public interface INCManager
	{
		/**
		 *  The bandwidth to be used to switch between multiple streams,
	 *  in bits per second.
		 */
		public function get bitrate () : Number;
		/**
		 *  @private
		 */
		public function set bitrate (b:Number) : void;

		/**
		 *  Read-only <code>NetConnection</code>.
		 */
		public function get netConnection () : NetConnection;

		/**
		 *  Read-only height of stream.
	 *  After <code>VideoPlayer.ncConnected()</code> is called,
	 *  if this is NaN or less than 0, that indicates to the VideoPlayer
	 *  that we have determined no stream height information.
	 *  If the VideoPlayer has autoSize or maintainAspectRatio set to true,
	 *  then this value will be used and the resizing will happen instantly,
	 *  rather than waiting.
	 *
	 *  VideoPlayer#ncConnected()
	 *  VideoPlayer#autoSize
	 *  VideoPlayer#maintainAspectRatio
		 */
		public function get streamHeight () : Number;

		/**
		 *  Read-only length of stream.
	 *  After <code>VideoPlayer.ncConnected()</code> is called,
	 *  if this is NaN or less than 0, that indicates to the VideoPlayer
	 *  that we have determined no stream length information.
	 *  Any stream length information that is returned will be assumed
	 *  to trump any other, including that set via the <code>totalTime</code>
	 *  parameter of the <code>VideoPlayer.play()</code> or
	 *  <code>VideoPlayer.load()</code> method or from FLV metadata.
	 *
	 *  VideoPlayer#ncConnected()
	 *  VideoPlayer#play()
	 *  VideoPlayer#load()
		 */
		public function get streamLength () : Number;

		/**
		 *  Read-only stream name to be passed into <code>NetStream.play</code>.
		 */
		public function get streamName () : String;

		/**
		 *  Read-only width of stream.
	 *  After <code>VideoPlayer.ncConnected()</code> is called,
	 *  if this is NaN or less than 0, that indicates to the VideoPlayer
	 *  that we have determined no stream width information.
	 *  If the VideoPlayer has autoSize or maintainAspectRatio set to true,
	 *  then this value will be used and the resizing will happen instantly,
	 *  rather than waiting.
	 *
	 *  VideoPlayer#ncConnected()
	 *  VideoPlayer#autoSize
	 *  VideoPlayer#maintainAspectRatio
		 */
		public function get streamWidth () : Number;

		/**
		 *  Timeout after which we give up on connection, in milliseconds.
		 */
		public function get timeout () : uint;
		/**
		 *  @private
		 */
		public function set timeout (t:uint) : void;

		/**
		 *  The <code>VideoPlayer</code> object which owns this object.
		 */
		public function get videoPlayer () : VideoPlayer;
		/**
		 *  @private
		 */
		public function set videoPlayer (v:VideoPlayer) : void;

		/**
		 *  Called by <code>VideoPlayer</code> to ask for connection to URL.
	 *  Once connection is either successful or failed,
	 *  call <code>VideoPlayer.ncConnected()</code>.
	 *  If connection failed, set <code>nc = null</code> before calling.
	 *
	 *  @return true if connection made synchronously;
	 *  false attempt made asynchronously so caller should expect
	 *  a "connected" event coming.
	 *
	 *  @see #netConnection
	 *  @see #reconnect()
	 *  @see VideoPlayer#ncConnected()
		 */
		public function connectToURL (url:String) : Boolean;

		/**
		 *  Called by <code>VideoPlayer</code> if connection successfully
	 *  made but stream not found.
	 *  If multiple alternate interpretations of the RTMP URL are possible,
	 *  it should retry to connect to the server with a different URL
	 *  and hand back a
	 *  different stream name.
	 *
	 *  <p>This can be necessary in cases where the URL is something
	 *  like rtmp://servername/path1/path2/path3.
	 *  The user could be passing in an application name and an instance
	 *  name, so the NetConnection should be opened with
	 *  rtmp://servername/path1/path2, or they might want to use the default
	 *  instance so the stream should be opened with path2/path3.
	 *  In general this is possible whenever there are more than two parts
	 *  to the path, but not possible if there are only two.
	 *  There should never only be one.</p>
	 *
	 *  @return true if will attempt to make another connection;
	 *  false if already made attempt or no additional attempts
	 *  are merited.
	 *
	 *  @see #connectToURL()
	 *  @see VideoPlayer#rtmpOnStatus()
		 */
		public function connectAgain () : Boolean;

		/**
		 *  Called by <code>VideoPlayer</code> to ask for reconnection
	 *  after connection is lost.
	 *  Once connection is either successful or failed,
	 *  call <code>VideoPlayer.ncReonnected()</code>.
	 *  If connection failed, set <code>nc = null</code> before calling.
	 *
	 *  @see #netConnection
	 *  @see #connect()
	 *  @see VideoPlayer#idleTimeout
	 *  @see VideoPlayer#ncReonnected()
		 */
		public function reconnect () : void;

		/**
		 *  Close the NetConnection
		 */
		public function close () : void;

		/**
		 *  Whether URL is for RTMP streaming from Flash Communication
	 *  Server or progressive download.
	 *
	 *  @returns true if stream is rtmp streaming from FCS,
	 *  false if progressive download of HTTP, local or other file.
		 */
		public function isRTMP () : Boolean;
	}
}
