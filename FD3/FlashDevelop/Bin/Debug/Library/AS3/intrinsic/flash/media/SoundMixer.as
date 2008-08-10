/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	import flash.utils.ByteArray;
	public final  class SoundMixer {
		/**
		 * The number of seconds to preload an embedded streaming sound into a buffer before it starts
		 *  to stream. The data in a loaded sound, including its buffer time,
		 *  cannot be accessed by code in a file that is in a different domain
		 *  unless you implement a cross-domain policy file. However, in the application sandbox
		 *  in an AIR application, code can access data in sound files from any source.
		 *  For more information about security and sound, see the Sound class description.
		 */
		public static function get bufferTime():int;
		public function set bufferTime(value:int):void;
		/**
		 * The SoundTransform object that controls global sound properties. A SoundTransform object
		 *  includes properties for setting volume, panning, left speaker assignment, and right
		 *  speaker assignment. The SoundTransform object used in this property provides final sound settings
		 *  that are applied to all sounds after any individual sound settings are applied.
		 */
		public static function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		/**
		 * Determines whether any sounds are not accessible due to security restrictions. For example,
		 *  a sound loaded from a domain other than that of the content calling this method is not accessible if
		 *  the server for the sound has no cross-domain policy file that grants access to
		 *  the domain of that domain. The sound can still be loaded and played, but low-level
		 *  operations, such as getting ID3 metadata for the sound, cannot be performed on
		 *  inaccessible sounds.
		 *
		 * @return                  <Boolean> The string representation of the boolean.
		 */
		public static function areSoundsInaccessible():Boolean;
		/**
		 * Takes a snapshot of the current sound wave and places it into the specified ByteArray object.
		 *  The values are formatted as normalized floating-point values, in the range -1.0 to 1.0.
		 *  The ByteArray object passed to the outputArray parameter is overwritten with the new values.
		 *  The size of the ByteArray object created is fixed to 512 floating-point values, where the
		 *  first 256 values represent the left channel, and the second 256 values represent
		 *  the right channel.
		 *
		 * @param outputArray       <ByteArray> A ByteArray object that holds the values associated with the sound.
		 *                            If any sounds are not available due to security restrictions
		 *                            (areSoundsInaccessible == true), the outputArray object
		 *                            is left unchanged. If all sounds are stopped, the outputArray object is
		 *                            filled with zeros.
		 * @param FFTMode           <Boolean (default = false)> A Boolean value indicating whether a Fourier transformation is performed
		 *                            on the sound data first. Setting this parameter to true causes the method to return a
		 *                            frequency spectrum instead of the raw sound wave. In the frequency spectrum, low frequencies
		 *                            are represented on the left and high frequencies are on the right.
		 * @param stretchFactor     <int (default = 0)> The resolution of the sound samples.
		 *                            If you set the stretchFactor value to 0, data is sampled at 44.1 KHz;
		 *                            with a value of 1, data is sampled at 22.05 KHz; with a value of 2, data is sampled 11.025 KHz;
		 *                            and so on.
		 */
		public static function computeSpectrum(outputArray:ByteArray, FFTMode:Boolean = false, stretchFactor:int = 0):void;
		/**
		 * Stops all sounds currently playing.
		 */
		public static function stopAll():void;
	}
}
