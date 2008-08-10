/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	import mx.effects.EffectInstance;
	import flash.media.SoundChannel;
	public class SoundEffectInstance extends EffectInstance {
		/**
		 * The SoundEffect class uses an internal Sound object to control
		 *  the MP3 file.
		 *  This property specifies the minimum number of milliseconds
		 *  worth of sound data
		 *  to hold in the Sound object's buffer.
		 *  The Sound object waits until it has at least
		 *  this much data before beginning playback,
		 *  and before resuming playback after a network stall.
		 */
		public var bufferTime:Number = 1000;
		/**
		 * This property is true if the MP3 has been loaded.
		 */
		public function get isLoading():Boolean;
		/**
		 * The number of times to play the sound in a loop, where a value of
		 *  0 means play the effect once, a value of 1 means play the effect twice,
		 *  and so on. If you repeat the MP3 file, it still uses the setting of the
		 *  useDuration property to determine the playback time.
		 */
		public var loops:int = 0;
		/**
		 * The easing function for the pan effect.
		 *  This function is used to interpolate between the values
		 *  of panFrom and panTo.
		 */
		public var panEasingFunction:Function;
		/**
		 * Initial pan of the Sound object.
		 *  The value can range from -1.0 to 1.0, where -1.0 uses only the left channel,
		 *  1.0 uses only the right channel, and 0.0 balances the sound evenly
		 *  between the two channels.
		 */
		public var panFrom:Number;
		/**
		 * Final pan of the Sound object.
		 *  The value can range from -1.0 to 1.0, where -1.0 uses only the left channel,
		 *  1.0 uses only the right channel, and 0.0 balances the sound evenly
		 *  between the two channels.
		 */
		public var panTo:Number;
		/**
		 * Reference to the internal Sound object. The SoundEffect uses this
		 *  instance to play the MP3 file.
		 */
		public var sound:Sound;
		/**
		 * The SoundChannel object that the MP3 file has been loaded into.
		 */
		public function get soundChannel():SoundChannel;
		/**
		 * The URL or class of the MP3 file to play.
		 *  If you have already embedded the MP3 file, using the
		 *  Embed keyword, you can pass the Class object
		 *  of the MP3 file to the source property.
		 *  Otherwise, specify the full URL to the MP3 file.
		 */
		public function get source():Object;
		public function set source(value:Object):void;
		/**
		 * The initial position in the MP3 file, in milliseconds,
		 *  at which playback should start.
		 */
		public var startTime:Number = 0;
		/**
		 * If true, stop the effect
		 *  after the time specified by the duration
		 *  property has elapsed.
		 *  If false, stop the effect
		 *  after the MP3 finishes playing or looping.
		 */
		public var useDuration:Boolean = true;
		/**
		 * The easing function for the volume effect.
		 *  Use this function to interpolate between the values
		 *  of volumeFrom and volumeTo.
		 */
		public var volumeEasingFunction:Function;
		/**
		 * Initial volume of the Sound object.
		 *  Value can range from 0.0 to 1.0.
		 */
		public var volumeFrom:Number;
		/**
		 * Final volume of the Sound object.
		 *  Value can range from 0.0 to 1.0.
		 */
		public var volumeTo:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function SoundEffectInstance(target:Object);
	}
}
