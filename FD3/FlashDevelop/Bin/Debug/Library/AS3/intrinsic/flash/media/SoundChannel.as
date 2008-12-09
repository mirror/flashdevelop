package flash.media
{
	/// The SoundChannel class controls a sound in an application.
	public class SoundChannel extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when a sound has finished playing.
		 * @eventType flash.events.Event.SOUND_COMPLETE
		 */
		[Event(name="soundComplete", type="flash.events.Event")]

		/// When the sound is playing, the position property indicates the current point that is being played in the sound file.
		public var position:Number;

		/// The SoundTransform object assigned to the sound channel.
		public var soundTransform:flash.media.SoundTransform;

		/// The current amplitude (volume) of the left channel, from 0 (silent) to 1 (full amplitude).
		public var leftPeak:Number;

		/// The current amplitude (volume) of the right channel, from 0 (silent) to 1 (full amplitude).
		public var rightPeak:Number;

		/// Stops the sound playing in the channel.
		public function stop():void;

	}

}

