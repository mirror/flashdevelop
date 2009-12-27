﻿package mx.effects.effectClasses
{
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.Tween;
	import mx.events.TweenEvent;

include "../../core/Version.as"
	/**
	 *
 *  The TweenEffectInstance class implements the instance class
 *  for the TweenEffect.
 *  Flex creates an instance of this class when it plays a TweenEffect;
 *  you do not create one yourself.
 *
 *  @see mx.effects.Tween
 *  @see mx.effects.TweenEffect
	 */
	public class TweenEffectInstance extends EffectInstance
	{
		/**
		 *  @private
		 */
		var needToLayout : Boolean;
		/**
		 *  @private.
	 *  Used internally to hold the value of the new playhead position
	 *  if the tween doesn't currently exist.
		 */
		private var _seekTime : Number;
		/**
		 *  The easing function for the animation.
	 *  By default, effects use the same easing function
	 *  as the TweenEffect class.
	 *
	 *  @see mx.effects.TweenEffect#easingFunction
		 */
		public var easingFunction : Function;
		/**
		 *  The Tween object, which determines the animation.
	 *  To create an effect, you must create a Tween instance
	 *  in the override of the <code>EffectInstance.play()</code> method
	 *  and assign it to the <code>tween</code> property. 
	 *  Use the <code>createTween()</code> method to create your Tween object.
		 */
		public var tween : Tween;

		/**
		 *  @private
		 */
		function set playReversed (value:Boolean) : void;

		/**
		 *  The current position of the effect, in milliseconds. 
	 *  This value is between 0 and the value of the
	 *  <code>duration</code> property.
	 *  Use the <code>seek()</code> method to change the position of the effect.
		 */
		public function get playheadTime () : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function TweenEffectInstance (target:Object);

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
		public function reverse () : void;

		/**
		 *  Advances the effect to the specified position. 
  	 *
  	 *  @param playheadTime The position, in milliseconds, between 0
	 *  and the value of the <code>duration</code> property.
		 */
		public function seek (playheadTime:Number) : void;

		/**
		 *  Interrupts an effect that is currently playing,
	 *  and immediately jumps to the end of the effect.
	 *  Calls the <code>Tween.endTween()</code> method
	 *  on the <code>tween</code> property. 
     *  This method implements the method of the superclass. 
	 *
	 *  <p>If you create a subclass of TweenEffectInstance,
	 *  you can optionally override this method.</p>
     *
	 *  <p>The effect dispatches the <code>effectEnd</code> event.</p>
	 *
	 *  @see mx.effects.EffectInstance#end()
		 */
		public function end () : void;

		/**
		 *  Creates a Tween instance,
	 *  assigns it the start, end, and duration values. If an easing function has 
	 *  been specified, then it is assigned to the Tween instance. The Tween instance is assigned 
	 *  event listeners for the TweenEvents: <code>tweenStart</code>, <code>tweenUpdate</code>, 
	 *  and <code>tweenEnd</code>.
	 *  Typically, you call this method from your override of 
	 *  the <code>EffectInstance.play()</code> method 
	 *  which effectively starts the animation timer. 
	 *
	 *  @param listener Object that is notified at each interval
	 *  of the animation. You typically pass the <code>this</code> 
	 *  keyword as the value.
	 *  The <code>listener</code> must define the 
	 *  <code>onTweenUpdate()</code> method and optionally the  
	 *  <code>onTweenEnd()</code> method.
	 *  The <code>onTweenUpdate()</code> method is invoked for each interval of the animation,
	 *  and the <code>onTweenEnd()</code> method is invoked just after the animation finishes.
	 *
	 *  @param startValue Initial value(s) of the animation.
	 *  Either a number or an Array of numbers.
	 *  If a number is passed, the Tween interpolates
	 *  between this number and the number passed
	 *  in the <code>endValue</code> parameter.
	 *  If an Array of numbers is passed, 
	 *  each number in the Array is interpolated.
	 *
	 *  @param endValue Final value(s) of the animation.
	 *  The type of this argument must match the <code>startValue</code>
	 *  parameter.
	 *
	 *  @param duration Duration of the animation, in milliseconds.
	 *
	 *  @param minFps Minimum number of times that the
	 *  <code>onTweenUpdate()</code> method should be called every second.
	 *  The tween code tries to call the <code>onTweenUpdate()</code>
	 *  method as frequently as possible (up to 100 times per second).
	 *  However, if the frequency falls below <code>minFps</code>, 
	 *  the duration of the animation automatically increases.
	 *  As a result, an animation that temporarily freezes
	 *  (because it is not getting any CPU cycles) begins again
	 *  where it left off, instead of suddenly jumping ahead. 
	 *
	 *  @return The newly created Tween instance.
		 */
		protected function createTween (listener:Object, startValue:Object, endValue:Object, duration:Number = -1, minFps:Number = -1) : Tween;

		function applyTweenStartValues () : void;

		private function tweenEventHandler (event:TweenEvent) : void;

		/**
		 *  Callback method that is called when the target should be updated
	 *  by the effect.
	 *  The Tween class uses the easing function and the
	 *  <code>Tween.startValue</code>, <code>Tween.endValue</code>
	 *  and <code>Tween.duration</code> properties to calculate
	 *  the value of the <code>value</code> argument.
	 *  The <code>value</code> argument can be either a Number
	 *  or an Array of Numbers. 
	 *
	 *  <p>All subclasses must override this method.
	 *  It is not necessary to call the super version of this function
	 *  when overriding this method.</p>
	 *
 	 *  @param value The value of the <code>value</code> argument
	 *  is an interpolated value determined by the
	 *  <code>Tween.startValue</code> property,
	 *  <code>Tween.endValue</code> property, and interpolation function 
	 *  specified by the implementation of the effect in its 
	 *  <code>play()</code> method.
	 *  The <code>play()</code> method uses these values to create
	 *  a Tween object that plays the effect over a time period.
	 *  The <code>value</code> argument can be either a Number
	 *  or an Array of Numbers.
		 */
		public function onTweenUpdate (value:Object) : void;

		/**
		 *  Callback method that is called when the target should be updated
	 *  by the effect for the last time. 
	 *  The Tween class passes <code>Tween.endValue</code> as the value 
	 *  of the <code>value</code> argument. 
	 *  The <code>value</code> argument can be either a Number
	 *  or an Array of Numbers. 
	 * 
	 *  <p>Overriding this function is optional. 
	 *  You must also call the super version of this method
	 *  from the end of your override, <code>super.onTweenEnd(val)</code>,
	 *  after your logic.</p>
	 *
	 *  @param value The value of the <code>value</code> argument
	 *  is an interpolated value determined by the
	 *  <code>Tween.startValue</code> property, 
	 *  <code>Tween.endValue</code> property, and interpolation function 
	 *  specified by the implementation of the effect in its 
	 *  <code>play()</code> method.
	 *  The <code>play()</code> method  uses these values to create
	 *  a Tween object that plays the effect over a time period. 
     *  The <code>value</code> argument can be either a Number
	 *  or an Array of Numbers.
		 */
		public function onTweenEnd (value:Object) : void;
	}
}
