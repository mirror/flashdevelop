package flash.net
{
	/// The NetStreamPlayTransitions class specifies the valid strings that you can use with the NetStreamPlayOptions.transition property.
	public class NetStreamPlayTransitions extends Object
	{
		/// Adds the stream to a playlist.
		public static const APPEND : String;
		public static const APPEND_AND_WAIT : String;
		/// Clears any previous play calls and plays the specified stream immediately.
		public static const RESET : String;
		public static const RESUME : String;
		/// Stops playing the streams in a playlist.
		public static const STOP : String;
		/// Replaces a content stream with a different content stream and maintains the rest of the playlist.
		public static const SWAP : String;
		/// Switches from playing one stream to another stream, typically with streams of the same content.
		public static const SWITCH : String;

		/// The NetStreamPlayTransitions class specifies the valid strings that you can use with the NetStreamPlayOptions.transition property.
		public function NetStreamPlayTransitions ();
	}
}
