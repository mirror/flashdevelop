package flash.media
{
	/// The ID3Info class contains properties that reflect ID3 metadata.
	public class ID3Info
	{
		/// The name of the song; corresponds to the ID3 2.0 tag TIT2.
		public var songName:String;

		/// The name of the artist; corresponds to the ID3 2.0 tag TPE1.
		public var artist:String;

		/// The name of the album; corresponds to the ID3 2.0 tag TALB.
		public var album:String;

		/// The year of the recording; corresponds to the ID3 2.0 tag TYER.
		public var year:String;

		/// A comment about the recording; corresponds to the ID3 2.0 tag COMM.
		public var comment:String;

		/// The genre of the song; corresponds to the ID3 2.0 tag TCON.
		public var genre:String;

		/// The track number; corresponds to the ID3 2.0 tag TRCK.
		public var track:String;

	}

}

