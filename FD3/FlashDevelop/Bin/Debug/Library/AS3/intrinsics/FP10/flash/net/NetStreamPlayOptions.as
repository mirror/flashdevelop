package flash.net
{
	/// The NetStreamPlayOptions class specifies the various options that can be passed to the NetStream.play2() method.
	public class NetStreamPlayOptions extends flash.events.EventDispatcher
	{
		/// The name of the new stream to transition to or to play.
		public var streamName:String;

		/// The name of the old stream or the stream to transition from.
		public var oldStreamName:String;

		/// The start time, in seconds, for streamName.
		public var start:Number;

		/// The duration of playback, in seconds, for the stream specified in streamName.
		public var len:Number;

		/// The mode in which streamName is played or transitioned to.
		public var transition:String;

		/// [FP10] Creates a NetStreamPlayOptions object to specify the options that are passed to the NetStream.play2() method.
		public function NetStreamPlayOptions();

	}

}

