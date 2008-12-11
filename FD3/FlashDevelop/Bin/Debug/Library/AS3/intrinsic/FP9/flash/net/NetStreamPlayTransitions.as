package flash.net
{
	/// The NetStreamPlayTransitions class specifies the valid strings that you can use with the NetStreamPlayOptions.transition property.
	public class NetStreamPlayTransitions
	{
		/// Adds the stream to a playlist.
		public static const APPEND:*;

		/// Clears any previous play calls and plays the specified stream immediately.
		public static const RESET:*;

		/// Switches from playing one stream to another stream, typically with streams of the same content.
		public static const SWITCH:*;

		/// Replaces a content stream with a different content stream and maintains the rest of the playlist.
		public static const SWAP:*;

		/// Stops playing the streams in a playlist.
		public static const STOP:*;

		/// The NetStreamPlayTransitions class specifies the valid strings that you can use with the NetStreamPlayOptions.transition property.
		public function NetStreamPlayTransitions();

	}

}

