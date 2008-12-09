package flash.media
{
	/// The SoundMixer class contains static properties and methods for global sound controlin the SWF file.
	public class SoundMixer
	{
		/// The number of seconds to preload an embedded streaming sound into a buffer before it starts to stream.
		public var bufferTime:int;

		/// The SoundTransform object that controls global sound properties.
		public var soundTransform:flash.media.SoundTransform;

		/// Stops all sounds currently playing.
		public static function stopAll():void;

		/// Takes a snapshot of the current sound wave and places it into the specified ByteArray object.
		public static function computeSpectrum(outputArray:flash.utils.ByteArray, FFTMode:Boolean=false, stretchFactor:int=0):void;

		/// Determines whether any sounds are not accessible due to security restrictions.
		public static function areSoundsInaccessible():Boolean;

	}

}

