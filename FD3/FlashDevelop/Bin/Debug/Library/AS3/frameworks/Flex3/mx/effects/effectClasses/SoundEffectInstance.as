package mx.effects.effectClasses
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.Tween;

include "../../core/Version.as"
	/**
	 *  The SoundEffectInstance class implements the instance class
 *  for the SoundEffect effect.
 *  Flex creates an instance of this class when it plays a SoundEffect effect;
 *  you do not create one yourself.
 *
 *  @see mx.effects.Fade
	 */
	public class SoundEffectInstance extends EffectInstance
	{
		/**
		 *  @private.
		 */
		private var origVolume : Number;
		/**
		 *  @private.
		 */
		private var origPan : Number;
		/**
		 *  @private.
		 */
		private var volumeTween : Tween;
		/**
		 *  @private.
		 */
		private var panTween : Tween;
		/**
		 *  @private.
		 */
		private var soundDuration : Number;
		/**
		 *  @private.
		 */
		private var tweenCount : int;
		/**
		 *  @private.
		 */
		private var intervalID : Number;
		/**
		 *  @private.
		 */
		private var endOnTweens : Boolean;
		/**
		 *  @private.
		 */
		private var pausedPosition : Number;
		/**
		 *  @private.
		 */
		private var resumedPosition : Number;
		/**
		 *  @private.
		 */
		private var pausedTransform : SoundTransform;
		/**
		 *  The SoundEffect class uses an internal Sound object to control
     *  the MP3 file.
	 *  This property specifies the minimum number of milliseconds 
	 *  worth of sound data
	 *  to hold in the Sound object's buffer.
	 *  The Sound object waits until it has at least
	 *  this much data before beginning playback,
	 *  and before resuming playback after a network stall.
	 *  
	 *  @default 1000
		 */
		public var bufferTime : Number;
		/**
		 *	The number of times to play the sound in a loop, where a value of 
	 *  0 means play the effect once, a value of 1 means play the effect twice, 
	 *  and so on. If you repeat the MP3 file, it still uses the setting of the 
	 *  <code>useDuration</code> property to determine the playback time.
	 *
	 *  <p>The <code>duration</code> property takes precedence
	 *  over this property. 
	 *	If the effect duration is not long enough to play the sound at least once, 
	 *  the sound does not loop.</p>
	 *
	 *  @default 0
		 */
		public var loops : int;
		/**
		 *	The easing function for the pan effect.
	 *  This function is used to interpolate between the values
	 *  of <code>panFrom</code> and <code>panTo</code>.
		 */
		public var panEasingFunction : Function;
		/**
		 *	Initial pan of the Sound object.
	 *  The value can range from -1.0 to 1.0, where -1.0 uses only the left channel,
	 *  1.0 uses only the right channel, and 0.0 balances the sound evenly
	 *  between the two channels.
	 *  
	 *  @default 0
		 */
		public var panFrom : Number;
		/**
		 *	Final pan of the Sound object.
	 *  The value can range from -1.0 to 1.0, where -1.0 uses only the left channel,
	 *  1.0 uses only the right channel, and 0.0 balances the sound evenly
	 *  between the two channels.
	 *  
	 *  @default 0
		 */
		public var panTo : Number;
		/**
		 *  @private
	 *  Storage for the soundChannel property.
		 */
		private var _soundChannel : SoundChannel;
		/**
		 *  Reference to the internal Sound object. The SoundEffect uses this
	 *  instance to play the MP3 file.
		 */
		public var sound : Sound;
		/**
		 *  @private
	 *  Storage for the source property.
		 */
		private var _source : Object;
		/**
		 *  The initial position in the MP3 file, in milliseconds, 
	 *  at which playback should start.
	 *
	 *  @default 0
		 */
		public var startTime : Number;
		/**
		 *  If <code>true</code>, stop the effect
	 *  after the time specified by the <code>duration</code> 
	 *  property has elapsed.
	 *  If <code>false</code>, stop the effect
	 *  after the MP3 finishes playing or looping.
	 *  
	 *  @default true
		 */
		public var useDuration : Boolean;
		/**
		 *	The easing function for the volume effect.
	 *  Use this function to interpolate between the values
	 *  of <code>volumeFrom</code> and <code>volumeTo</code>.
		 */
		public var volumeEasingFunction : Function;
		/**
		 *	Initial volume of the Sound object.
	 *  Value can range from 0.0 to 1.0.
	 *  
	 *  @default 1.0
		 */
		public var volumeFrom : Number;
		/**
		 *	Final volume of the Sound object.
	 *  Value can range from 0.0 to 1.0.
	 *  
	 *  @default 1.0
		 */
		public var volumeTo : Number;

		/**
		 *  @private
		 */
		private function get totalDuration () : Number;

		/**
		 *	This property is <code>true</code> if the MP3 has been loaded.
		 */
		public function get isLoading () : Boolean;

		/**
		 *	The SoundChannel object that the MP3 file has been loaded into.
		 */
		public function get soundChannel () : SoundChannel;

		/**
		 *	The URL or class of the MP3 file to play.
	 *  If you have already embedded the MP3 file, using the
	 *  <code>Embed</code> keyword, you can pass the Class object
	 *  of the MP3 file to the <code>source</code> property. 
	 *  Otherwise, specify the full URL to the MP3 file.
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function SoundEffectInstance (target:Object);

		/**
		 *  @private
		 */
		public function play () : void;

		/**
		 *  @private
		 */
		public function pause () : void;

		/**
		 *  @private
		 */
		public function stop () : void;

		/**
		 *  @private
		 */
		public function resume () : void;

		/**
		 *  @private
		 */
		public function end () : void;

		/**
		 *  @private
		 */
		public function finishEffect () : void;

		/**
		 *  @private
		 */
		function onVolumeTweenUpdate (value:Object) : void;

		/**
		 *  @private
		 */
		function onVolumeTweenEnd (value:Object) : void;

		/**
		 *  @private
		 */
		function onPanTweenUpdate (value:Object) : void;

		/**
		 *  @private
		 */
		function onPanTweenEnd (value:Object) : void;

		/**
		 *  @private
		 */
		private function finishTween () : void;

		/**
		 *  @private
		 */
		private function durationEndHandler (event:TimerEvent) : void;

		/**
		 *  @private
		 */
		private function soundCompleteHandler (event:Event) : void;
	}
}
