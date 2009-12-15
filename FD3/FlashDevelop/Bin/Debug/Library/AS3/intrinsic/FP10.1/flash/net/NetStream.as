package flash.net
{
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.media.Microphone;
	import flash.media.Camera;
	import flash.net.NetStream;
	import flash.net.Responder;
	import flash.net.NetStreamPlayOptions;
	import flash.net.NetStreamInfo;
	import flash.net.NetStreamMulticastInfo;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;

	/// The NetStream class opens a one-way streaming connection between an AIR or Flash Player application and Flash Media Server, or between an AIR or Flash Player application and the local file system.
	public class NetStream extends EventDispatcher
	{
		/// A static object used as a parameter to the constructor for a NetStream instance.
		public static const CONNECT_TO_FMS : String;
		/// Creates a peer-to-peer publisher connection.
		public static const DIRECT_CONNECTIONS : String;

		public function get audioCodec () : uint;

		public function get audioReliable () : Boolean;
		public function set audioReliable (reliable:Boolean) : void;

		public function get audioSampleAccess () : Boolean;
		public function set audioSampleAccess (reliable:Boolean) : void;

		public function get backBufferLength () : Number;

		public function get backBufferTime () : Number;
		public function set backBufferTime (backBufferTime:Number) : void;

		/// The number of seconds of data currently in the buffer.
		public function get bufferLength () : Number;

		/// Specifies how long to buffer messages before starting to display the stream.
		public function get bufferTime () : Number;
		public function set bufferTime (bufferTime:Number) : void;

		public function get bufferTimeMax () : Number;
		public function set bufferTimeMax (bufferTimeMax:Number) : void;

		public function get bytesErased () : Number;

		/// The number of bytes of data that have been loaded into the application.
		public function get bytesLoaded () : uint;

		/// The total size in bytes of the file being loaded into the application.
		public function get bytesTotal () : uint;

		/// Specifies whether the application should try to download a cross-domain policy file from the loaded video file's server before beginning to load the video file.
		public function get checkPolicyFile () : Boolean;
		public function set checkPolicyFile (state:Boolean) : void;

		/// Specifies the object on which callback methods are invoked to handle streaming or FLV file data.
		public function get client () : Object;
		public function set client (object:Object) : void;

		/// The number of frames per second being displayed.
		public function get currentFPS () : Number;

		public function get dataReliable () : Boolean;
		public function set dataReliable (reliable:Boolean) : void;

		public function get decodedFrames () : uint;

		/// The identifier of the far end that is connected to this NetStream instance.
		public function get farID () : String;

		/// A value chosen substantially by the other end of this stream, unique to this connection.
		public function get farNonce () : String;

		public function get inBufferSeek () : Boolean;
		public function set inBufferSeek (value:Boolean) : void;

		/// Returns a NetStreamInfo object whose properties contain statistics about the quality of service.
		public function get info () : NetStreamInfo;

		/// The number of seconds of data in the subscribing stream's buffer in live (unbuffered) mode.
		public function get liveDelay () : Number;

		/// Specifies how long to buffer messages during pause mode, in seconds.
		public function get maxPauseBufferTime () : Number;
		public function set maxPauseBufferTime (pauseBufferTime:Number) : void;

		public function get multicastAvailabilitySendToAll () : Boolean;
		public function set multicastAvailabilitySendToAll (value:Boolean) : void;

		public function get multicastAvailabilityUpdatePeriod () : Number;
		public function set multicastAvailabilityUpdatePeriod (seconds:Number) : void;

		public function get multicastFetchPeriod () : Number;
		public function set multicastFetchPeriod (seconds:Number) : void;

		public function get multicastInfo () : NetStreamMulticastInfo;

		public function get multicastPushNeighborLimit () : Number;
		public function set multicastPushNeighborLimit (neighbors:Number) : void;

		public function get multicastRelayMarginDuration () : Number;
		public function set multicastRelayMarginDuration (seconds:Number) : void;

		public function get multicastWindowDuration () : Number;
		public function set multicastWindowDuration (seconds:Number) : void;

		/// A value chosen substantially by this end of the stream, unique to this connection.
		public function get nearNonce () : String;

		/// The object encoding (AMF version) for this NetStream object.
		public function get objectEncoding () : uint;

		/// An object that holds all of the subscribing NetStream instances that are listening to this publishing NetStream instance.
		public function get peerStreams () : Array;

		/// Controls sound in this NetStream object.
		public function get soundTransform () : SoundTransform;
		public function set soundTransform (sndTransform:SoundTransform) : void;

		/// The position of the playhead, in seconds.
		public function get time () : Number;

		public function get videoCodec () : uint;

		public function get videoReliable () : Boolean;
		public function set videoReliable (reliable:Boolean) : void;

		public function get videoSampleAccess () : Boolean;
		public function set videoSampleAccess (reliable:Boolean) : void;

		public function appendBytes (bytes:ByteArray) : void;

		public function appendBytesAction (netStreamAppendBytesAction:String) : void;

		public function attach (connection:NetConnection) : void;

		/// Specifies an audio stream sent over the NetStream object, from a Microphone object passed as the source.
		public function attachAudio (microphone:Microphone) : void;

		/// Starts capturing video from a camera, or stops capturing if theCamera is set to null.
		public function attachCamera (theCamera:Camera, snapshotMilliseconds:int = -1) : void;

		/// Stops playing all data on the stream, sets the time property to 0, and makes the stream available for another use.
		public function close () : void;

		/// Creates a stream that can be used for playing video files through the specified NetConnection object.
		public function NetStream (connection:NetConnection, peerID:String = "connectToFMS");

		/// Invoked when a peer-publishing stream matches a peer-subscribing stream.
		public function onPeerConnect (subscriber:NetStream) : Boolean;

		/// Pauses playback of a video stream.
		public function pause () : void;

		/// Plays media files.
		public function play (...rest) : void;

		/// Begins playback of media files, with several options for playback.
		public function play2 (param:NetStreamPlayOptions) : void;

		/// Extracts any DRM metadata from a locally stored media file.
		public function preloadEmbeddedData (param:NetStreamPlayOptions) : void;

		/// Sends streaming audio, video, and text messages from a client to Flash Media Server, optionally recording the stream during transmission.
		public function publish (name:String = null, type:String = null) : void;

		/// Specifies whether incoming audio plays on the stream.
		public function receiveAudio (flag:Boolean) : void;

		/// Specifies whether incoming video will play on the stream.
		public function receiveVideo (flag:Boolean) : void;

		/// Specifies the frame rate for incoming video.
		public function receiveVideoFPS (FPS:Number) : void;

		/// Deletes all locally cached digital rights management (DRM) voucher data.
		public static function resetDRMVouchers () : void;

		/// Resumes playback of a video stream that is paused.
		public function resume () : void;

		/// Seeks the keyframe (also called an I-frame in the video industry) closest to the specified location.
		public function seek (offset:Number) : void;

		/// Sends a message on a published stream to all subscribing clients.
		public function send (handlerName:String, ...rest) : void;

		/// Sets the DRM authentication credentials needed for viewing the underlying encrypted content.
		public function setDRMAuthenticationCredentials (userName:String, password:String, type:String) : void;

		public function step (frames:int) : void;

		/// Pauses or resumes playback of a stream.
		public function togglePause () : void;
	}
}
