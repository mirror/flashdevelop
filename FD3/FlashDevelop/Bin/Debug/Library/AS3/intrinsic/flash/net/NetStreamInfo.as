package flash.net
{
	/// The NetStreamInfo class specifies the various Quality of Service (QOS) statistics related to a NetStream object and the underlying streaming buffer for audio, video, and data.
	public class NetStreamInfo
	{
		/// Specifies the rate at which the NetStream buffer is filled in bytes per second.
		public var currentBytesPerSecond:Number;

		/// Specifies the total number of bytes that have arrived into the queue, regardless of how many have been played or flushed.
		public var byteCount:Number;

		/// Specifies the maximum rate at which the NetStream buffer is filled in bytes per second.
		public var maxBytesPerSecond:Number;

		/// Specifies the rate at which the NetStream audio buffer is filled in bytes per second.
		public var audioBytesPerSecond:Number;

		/// Specifies the total number of audio bytes that have arrived in the queue, regardless of how many have been played or flushed.
		public var audioByteCount:Number;

		/// Specifies the rate at which the NetStream video buffer is filled in bytes per second.
		public var videoBytesPerSecond:Number;

		/// Specifies the total number of video bytes that have arrived in the queue, regardless of how many have been played or flushed.
		public var videoByteCount:Number;

		/// Specifies the rate at which the NetStream data buffer is filled in bytes per second.
		public var dataBytesPerSecond:Number;

		/// Specifies the total number of bytes of data messages that have arrived in the queue, regardless of how many have been played or flushed.
		public var dataByteCount:Number;

		/// Returns the stream playback rate in bytes per second.
		public var playbackBytesPerSecond:Number;

		/// Returns the number of video frames dropped in the current NetStream playback session.
		public var droppedFrames:Number;

		/// Provides the NetStream audio buffer size in bytes.
		public var audioBufferByteLength:Number;

		/// Provides the NetStream video buffer size in bytes.
		public var videoBufferByteLength:Number;

		/// Provides the NetStream data buffer size in bytes.
		public var dataBufferByteLength:Number;

		/// Provides NetStream audio buffer size in seconds.
		public var audioBufferLength:Number;

		/// Provides NetStream video buffer size in seconds.
		public var videoBufferLength:Number;

		/// Provides NetStream data buffer size in seconds.
		public var dataBufferLength:Number;

		/// Specifies the Smooth Round Trip Time for the NetStream session.
		public var SRTT:Number;

		/// Specifies the audio loss for the NetStream session.
		public var audioLossRate:Number;

		/// For internal use only; not recommended for use.
		public function NetStreamInfo(curBPS:Number, byteCount:Number, maxBPS:Number, audioBPS:Number, audioByteCount:Number, videoBPS:Number, videoByteCount:Number, dataBPS:Number, dataByteCount:Number, playbackBPS:Number, droppedFrames:Number, audioBufferByteLength:Number, videoBufferByteLength:Number, dataBufferByteLength:Number, audioBufferLength:Number, videoBufferLength:Number, dataBufferLength:Number, srtt:Number, audioLossRate:Number);

		/// [FP10] Returns a text value listing the properties of this NetStreamInfo object.
		public function toString():String;

	}

}

