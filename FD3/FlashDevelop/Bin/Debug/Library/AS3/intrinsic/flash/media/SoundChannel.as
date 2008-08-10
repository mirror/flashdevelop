/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	import flash.events.EventDispatcher;
	public final  class SoundChannel extends EventDispatcher {
		/**
		 * The current amplitude (volume) of the left channel, from 0 (silent) to 1 (full amplitude).
		 */
		public function get leftPeak():Number;
		/**
		 * When the sound is playing, the position property indicates the current point
		 *  that is being played in the sound file. When the sound is stopped or paused, the
		 *  position property indicates the last point that was played in the sound file.
		 */
		public function get position():Number;
		/**
		 * The current amplitude (volume) of the right channel, from 0 (silent) to 1 (full amplitude).
		 */
		public function get rightPeak():Number;
		/**
		 * The SoundTransform object assigned to the sound channel. A SoundTransform object
		 *  includes properties for setting volume, panning, left speaker assignment, and right
		 *  speaker assignment.
		 */
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		/**
		 * Stops the sound playing in the channel.
		 */
		public function stop():void;
	}
}
