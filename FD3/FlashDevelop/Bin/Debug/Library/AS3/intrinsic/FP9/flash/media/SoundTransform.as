package flash.media
{
	/// The SoundTransform class contains properties for volume and panning.
	public class SoundTransform
	{
		/// The volume, ranging from 0 (silent) to 1 (full volume).
		public var volume:Number;

		/// A value, from 0 (none) to 1 (all), specifying how much of the left input is played in the left speaker.
		public var leftToLeft:Number;

		/// A value, from 0 (none) to 1 (all), specifying how much of the left input is played in the right speaker.
		public var leftToRight:Number;

		/// A value, from 0 (none) to 1 (all), specifying how much of the right input is played in the right speaker.
		public var rightToRight:Number;

		/// A value, from 0 (none) to 1 (all), specifying how much of the right input is played in the left speaker.
		public var rightToLeft:Number;

		/// The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right).
		public var pan:Number;

		/// Creates a SoundTransform object.
		public function SoundTransform(vol:Number=1, panning:Number=0);

	}

}

