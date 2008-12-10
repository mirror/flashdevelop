package mx.effects
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.TweenEvent;

	/**
	 *  The Tween class defines a tween, a property animation performed *  on a target object over a period of time. *  That animation can be a change in position, such as performed by *  the Move effect; a change in size, as performed by the Resize or *  Zoom effects; a change in visibility, as performed by the Fade or *  Dissolve effects; or other types of animations. * *  <p>When defining tween effects, you typically create an instance *  of the Tween class within your override of the  *  <code>EffectInstance.play()</code> method. *  A Tween instance accepts the <code>startValue</code>, *  <code>endValue</code>, and <code>duration</code> properties,  *  and an optional easing function to define the animation.</p>  * *  <p>The Tween object invokes the *  <code>mx.effects.effectClasses.TweenEffectInstance.onTweenUpdate()</code>  *  callback function on a regular interval on the effect instance *  for the duration of the effect, passing to the *  <code>onTweenUpdate()</code> method an interpolated value  *  between the <code>startValue</code> and <code>endValue</code>. *  Typically, the callback function updates some property of the target object,  *  causing that object to animate over the duration of the effect.</p> * *  <p>When the effect ends, the Tween objects invokes the  *  <code>mx.effects.effectClasses.TweenEffectInstance.onTweenEnd()</code> *  callback function, if you defined one. </p> * *  @see mx.effects.TweenEffect *  @see mx.effects.effectClasses.TweenEffectInstance
	 */
	public class Tween extends EventDispatcher
	{
		/**
		 *  @private
		 */
		static var activeTweens : Array;
		/**
		 *  @private
		 */
		private static var interval : Number;
		/**
		 *  @private
		 */
		private static var timer : Timer;
		/**
		 *  @private         *  Used by effects to get the current effect time tick.
		 */
		static var intervalTime : Number;
		/**
		 *  @private
		 */
		local var needToLayout : Boolean;
		/**
		 *  @private
		 */
		private var id : int;
		/**
		 *  @private
		 */
		private var maxDelay : Number;
		/**
		 *  @private
		 */
		private var arrayMode : Boolean;
		/**
		 *  @private
		 */
		private var _doSeek : Boolean;
		/**
		 *  @private
		 */
		private var _isPlaying : Boolean;
		/**
		 *  @private
		 */
		private var _doReverse : Boolean;
		/**
		 *  @private
		 */
		local var startTime : Number;
		/**
		 *  @private
		 */
		private var previousUpdateTime : Number;
		/**
		 *  @private
		 */
		private var userEquation : Function;
		/**
		 *  @private
		 */
		private var updateFunction : Function;
		/**
		 *  @private
		 */
		private var endFunction : Function;
		/**
		 *  @private     *  Final value(s) of the animation.     *  This can be a Number of an Array of Numbers.
		 */
		private var endValue : Object;
		/**
		 *  @private     *  Initial value(s) of the animation.     *  This can be a Number of an Array of Numbers.
		 */
		private var startValue : Object;
		/**
		 *  @private
		 */
		private var started : Boolean;
		/**
		 *  Duration of the animation, in milliseconds.
		 */
		public var duration : Number;
		/**
		 *  Object that is notified at each interval of the animation.
		 */
		public var listener : Object;
		/**
		 *  @private     *  Storage for the playheadTime property.
		 */
		private var _playheadTime : Number;
		/**
		 *  @private     *  Storage for the playReversed property.
		 */
		private var _invertValues : Boolean;

		/**
		 *  @private     *  The current millisecond position in the tween.     *  This value is between 0 and duration.      *  Use the seek() method to change the position of the tween.
		 */
		function get playheadTime () : Number;
		/**
		 *  @private     *  Starts playing reversed from start of tween.     *  Setting this property to <code>true</code>     *  inverts the values returned by the tween.     *  Using reverse inverts the values and only plays     *  for as much time that has already elapsed.
		 */
		function get playReversed () : Boolean;
		/**
		 *  @private
		 */
		function set playReversed (value:Boolean) : void;
		/**
		 *  Sets the easing function for the animation.     *  The easing function is used to interpolate between     *  the <code>startValue</code> value and the <code>endValue</code>.     *  A trivial easing function does linear interpolation,     *  but more sophisticated easing functions create the illusion of     *  acceleration and deceleration, which makes the animation seem     *  more natural.     *     *  <p>If no easing function is specified, an easing function based     *  on the <code>Math.sin()</code> method is used.</p>     *     *  <p>The easing function follows the function signature     *  popularized by Robert Penner.     *  The function accepts four arguments.     *  The first argument is the "current time",     *  where the animation start time is 0.     *  The second argument is a the initial value     *  at the beginning of the animation (a Number).     *  The third argument is the ending value     *  minus the initial value.     *  The fourth argument is the duration of the animation.     *  The return value is the interpolated value for the current time     *  (usually a value between the initial value and the ending value).</p>     *     *  <p>Flex includes a set of easing functions     *  in the mx.effects.easing package.</p>     *     *  @param easingFunction Function that implements the easing equation.
		 */
		public function set easingFunction (value:Function) : void;

		/**
		 *  @private
		 */
		private static function addTween (tween:Tween) : void;
		/**
		 *  @private
		 */
		private static function removeTweenAt (index:int) : void;
		/**
		 *  @private
		 */
		static function removeTween (tween:Tween) : void;
		/**
		 *  @private
		 */
		private static function timerHandler (event:TimerEvent) : void;
		/**
		 *  Constructor.     *     *  <p>When the constructor is called, the animation automatically     *  starts playing.</p>     *     *  @param listener Object that is notified at each interval     *  of the animation. You typically pass the <code>this</code>      *  keyword as the value.     *  The <code>listener</code> must define the      *  <code>onTweenUpdate()</code> method and optionally the       *  <code>onTweenEnd()</code> method.     *  The former method is invoked for each interval of the animation,     *  and the latter is invoked just after the animation finishes.     *     *  @param startValue Initial value(s) of the animation.     *  Either a number or an array of numbers.     *  If a number is passed, the Tween interpolates     *  between this number and the number passed     *  in the <code>endValue</code> parameter.     *  If an array of numbers is passed,      *  each number in the array is interpolated.     *     *  @param endValue Final value(s) of the animation.     *  The type of this argument must match the <code>startValue</code>     *  parameter.     *     *  @param duration Duration of the animation, expressed in milliseconds.     *     *  @param minFps Minimum number of times that the     *  <code>onTweenUpdate()</code> method should be called every second.     *  The tween code tries to call the <code>onTweenUpdate()</code>     *  method as frequently as possible (up to 100 times per second).     *  However, if the frequency falls below <code>minFps</code>,      *  the duration of the animation automatically increases.     *  As a result, an animation that temporarily freezes     *  (because it is not getting any CPU cycles) begins again     *  where it left off, instead of suddenly jumping ahead.      *     *  @param updateFunction Specifies an alternative update callback      *  function to be used instead of <code>listener.OnTweenUpdate()</code>     *     *  @param endFunction Specifies an alternative end callback function     *  to be used instead of <code>listener.OnTweenEnd()</code>
		 */
		public function Tween (listener:Object, startValue:Object, endValue:Object, duration:Number = -1, minFps:Number = -1, updateFunction:Function = null, endFunction:Function = null);
		/**
		 *  By default, the Tween class invokes the      *  <code>mx.effects.effectClasses.TweenEffectInstance.onTweenUpdate()</code>      *  callback function on a regular interval on the effect instance     *  for the duration of the effect, and the optional      *  <code>mx.effects.effectClasses.TweenEffectInstance.onTweenEnd()</code>     *  callback function at the end of the effect duration.      *     *  <p>This method lets you specify different methods      *  as the update and the end callback functions.</p>     *     *  @param updateFunction Specifies the update callback function.     *     *  @param endFunction Specifies the end callback function.
		 */
		public function setTweenHandlers (updateFunction:Function, endFunction:Function) : void;
		/**
		 *  Interrupt the tween, jump immediately to the end of the tween,      *  and invoke the <code>onTweenEnd()</code> callback function.
		 */
		public function endTween () : void;
		/**
		 *  @private     *  Returns true if the tween has ended.
		 */
		function doInterval () : Boolean;
		/**
		 *  @private
		 */
		function getCurrentValue (currentTime:Number) : Object;
		/**
		 *  @private
		 */
		private function defaultEasingFunction (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 *  Advances the tween effect to the specified position.      *     *  @param playheadTime The position, in milliseconds, between 0     *  and the value of the <code>duration</code> property.
		 */
		public function seek (playheadTime:Number) : void;
		/**
		 *  Plays the effect in reverse,     *  starting from the current position of the effect.
		 */
		public function reverse () : void;
		/**
		 *  Pauses the effect until you call the <code>resume()</code> method.
		 */
		public function pause () : void;
		/**
		 *  Stops the tween, ending it without dispatching an event or calling     *  the Tween's endFunction or <code>onTweenEnd()</code>.
		 */
		public function stop () : void;
		/**
		 *  Resumes the effect after it has been paused      *  by a call to the <code>pause()</code> method.
		 */
		public function resume () : void;
	}
}
