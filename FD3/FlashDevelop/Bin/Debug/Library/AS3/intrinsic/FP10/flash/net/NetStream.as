package flash.net
{
	/// The NetStream class opens a one-way streaming connection between Flash Player and Flash Media Server, or between Flash Player and the local file system.
	public class NetStream extends flash.events.EventDispatcher
	{
		/** 
		 * Establishes a listener to respond when a NetStream object has completely played a stream.
		 * @eventType flash.events.
		 */
		[Event(name="onPlayStatus", type="flash.events")]

		/** 
		 * Establishes a listener to respond when an embedded cue point is reached while playing a video file.
		 * @eventType flash.events.
		 */
		[Event(name="onCuePoint", type="flash.events")]

		/** 
		 * Establishes a listener to respond when Flash Player receives text data embedded in a media file that is playing.
		 * @eventType flash.events.
		 */
		[Event(name="onTextData", type="flash.events")]

		/** 
		 * Establishes a listener to respond when Flash Player receives image data as a byte array embedded in a media file that is playing.
		 * @eventType flash.events.
		 */
		[Event(name="onImageData", type="flash.events")]

		/** 
		 * Establishes a listener to respond when Flash Player receives descriptive information embedded in the video being played.
		 * @eventType flash.events.
		 */
		[Event(name="onMetaData", type="flash.events")]

		/** 
		 * Establishes a listener to respond when Flash Player receives information specific to Adobe Extensible Metadata Platform (XMP) embedded in the video being played.
		 * @eventType flash.events.
		 */
		[Event(name="onXMPData", type="flash.events")]

		/** 
		 * Dispatched when a NetStream object is reporting its status or error condition.
		 * @eventType flash.events.NetStatusEvent.NET_STATUS
		 */
		[Event(name="netStatus", type="flash.events.NetStatusEvent")]

		/** 
		 * Dispatched when an input or output error occurs that causes a network operation to fail.
		 * @eventType flash.events.IOErrorEvent.IO_ERROR
		 */
		[Event(name="ioError", type="flash.events.IOErrorEvent")]

		/** 
		 * Dispatched when an exception is thrown asynchronously -- that is, from native asynchronous code.
		 * @eventType flash.events.AsyncErrorEvent.ASYNC_ERROR
		 */
		[Event(name="asyncError", type="flash.events.AsyncErrorEvent")]

		/// Creates a peer-to-peer publisher connection.
		public static const DIRECT_CONNECTIONS:String = "directConnections";

		/// A static object used as a parameter to the constructor for a NetStream instance.
		public static const CONNECT_TO_FMS:String = "connectToFms";

		/// Specifies how long to buffer messages before starting to display the stream.
		public var bufferTime:Number;

		/// Specifies how long to buffer messages during pause mode.
		public var maxPauseBufferTime:Number;

		/// Returns a NetStreamInfo object whose properties contain statistics about the quality of service.
		public var info:flash.net.NetStreamInfo;

		/// The position of the playhead, in seconds.
		public var time:Number;

		/// The number of frames per second being displayed.
		public var currentFPS:Number;

		/// The number of seconds of data currently in the buffer.
		public var bufferLength:Number;

		/// The number of seconds of data in the subscribing stream's buffer in live (unbuffered) mode.
		public var liveDelay:Number;

		/// The number of bytes of data that have been loaded into Flash Player.
		public var bytesLoaded:uint;

		/// The total size in bytes of the file being loaded into Flash Player.
		public var bytesTotal:uint;

		/// Controls sound in this NetStream object.
		public var soundTransform:flash.media.SoundTransform;

		/// Specifies whether Flash Player should try to download a URL policy file from the loaded video file's server before beginning to load the video file.
		public var checkPolicyFile:Boolean;

		/// Specifies the object on which callback methods are invoked to handle streaming or FLV file data.
		public var client:Object;

		/// The object encoding (AMF version) for this NetStream object.
		public var objectEncoding:uint;

		/// The identifier of the far end that is connected to this NetStream instance.
		public var farID:String;

		/// A value chosen substantially by this end of the stream, unique to this connection.
		public var nearNonce:String;

		/// A value chosen substantially by the other end of this stream, unique to this connection.
		public var farNonce:String;

		/// An object that holds all of the subscribing NetStream instances that are listening to this publishing NetStream instance.
		public var peerStreams:Array;

		/// Creates a stream that can be used for playing video files through the specified NetConnection object.
		public function NetStream(connection:flash.net.NetConnection, peerID:String=connectToFMS);

		/// Stops playing all data on the stream, sets the time property to 0, and makes the stream available for another use.
		public function close():void;

		/// Specifies an audio stream sent over the NetStream object, from a Microphone object passed as the source.
		public function attachAudio(microphone:flash.media.Microphone):void;

		/// Starts capturing video from a camera, or stops capturing if theCamera is set to null.
		public function attachCamera(theCamera:flash.media.Camera, snapshotMilliseconds:int=-1):void;

		/// Sends a message on a published stream to all subscribing clients.
		public function send(handlerName:String, ...arguments):void;

		/// Specifies whether incoming audio plays on the stream.
		public function receiveAudio(flag:Boolean):void;

		/// Specifies whether incoming video will play on the stream.
		public function receiveVideo(flag:Boolean):void;

		/// Specifies the frame rate for incoming video.
		public function receiveVideoFPS(FPS:Number):void;

		/// Pauses playback of a video stream.
		public function pause():void;

		/// Resumes playback of a video stream that is paused.
		public function resume():void;

		/// Pauses or resumes playback of a stream.
		public function togglePause():void;

		/// Seeks the keyframe (also called an I-frame in the video industry) closest to the specified location.
		public function seek(offset:Number):void;

		/// Begins playback of video files.
		public function play(...arguments):void;

		/// [FP10] Begins playback of media files, with several options for playback.
		public function play2(param:flash.net.NetStreamPlayOptions):void;

		/// Sends streaming audio, video, and text messages from a client to Flash Media Server, optionally recording the stream during transmission.
		public function publish(name:String=null, type:String=null):void;

		/// [FP10] Invoked when a peer-publishing stream matches a peer-subscribing stream.
		public function onPeerConnect(subscriber:flash.net.NetStream):Boolean;

	}

}

