/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	import mx.effects.EffectInstance;
	public class TweenEffectInstance extends EffectInstance {
		/**
		 * The easing function for the animation.
		 *  By default, effects use the same easing function
		 *  as the TweenEffect class.
		 */
		public var easingFunction:Function;
		/**
		 * The current position of the effect, in milliseconds.
		 *  This value is between 0 and the value of the
		 *  duration property.
		 *  Use the seek() method to change the position of the effect.
		 */
		public function get playheadTime():Number;
		/**
		 * The Tween object, which determines the animation.
		 *  To create an effect, you must create a Tween instance
		 *  in the override of the EffectInstance.play() method
		 *  and assign it to the tween property.
		 *  Use the createTween() method to create your Tween object.
		 */
		public var tween:Tween;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function TweenEffectInstance(target:Object);
		/**
		 * Creates a Tween instance,
		 *  assigns it the start, end, and duration values. If an easing function has
		 *  been specified, then it is assigned to the Tween instance. The Tween instance is assigned
		 *  event listeners for the TweenEvents: tweenStart, tweenUpdate,
		 *  and tweenEnd.
		 *  Typically, you call this method from your override of
		 *  the EffectInstance.play() method
		 *  which effectively starts the animation timer.
		 *
		 * @param listener          <Object> Object that is notified at each interval
		 *                            of the animation. You typically pass the this
		 *                            keyword as the value.
		 *                            The listener must define the
		 *                            onTweenUpdate() method and optionally the
		 *                            onTweenEnd() method.
		 *                            The onTweenUpdate() method is invoked for each interval of the animation,
		 *                            and the onTweenEnd() method is invoked just after the animation finishes.
		 * @param startValue        <Object> Initial value(s) of the animation.
		 *                            Either a number or an Array of numbers.
		 *                            If a number is passed, the Tween interpolates
		 *                            between this number and the number passed
		 *                            in the endValue parameter.
		 *                            If an Array of numbers is passed,
		 *                            each number in the Array is interpolated.
		 * @param endValue          <Object> Final value(s) of the animation.
		 *                            The type of this argument must match the startValue
		 *                            parameter.
		 * @param duration          <Number (default = -1)> Duration of the animation, in milliseconds.
		 * @param minFps            <Number (default = -1)> Minimum number of times that the
		 *                            onTweenUpdate() method should be called every second.
		 *                            The tween code tries to call the onTweenUpdate()
		 *                            method as frequently as possible (up to 100 times per second).
		 *                            However, if the frequency falls below minFps,
		 *                            the duration of the animation automatically increases.
		 *                            As a result, an animation that temporarily freezes
		 *                            (because it is not getting any CPU cycles) begins again
		 *                            where it left off, instead of suddenly jumping ahead.
		 * @return                  <Tween> The newly created Tween instance.
		 */
		protected function createTween(listener:Object, startValue:Object, endValue:Object, duration:Number = -1, minFps:Number = -1):Tween;
		/**
		 * Interrupts an effect that is currently playing,
		 *  and immediately jumps to the end of the effect.
		 *  Calls the Tween.endTween() method
		 *  on the tween property.
		 *  This method implements the method of the superclass.
		 */
		public override function end():void;
		/**
		 * Callback method that is called when the target should be updated
		 *  by the effect for the last time.
		 *  The Tween class passes Tween.endValue as the value
		 *  of the value argument.
		 *  The value argument can be either a Number
		 *  or an Array of Numbers.
		 *
		 * @param value             <Object> The value of the value argument
		 *                            is an interpolated value determined by the
		 *                            Tween.startValue property,
		 *                            Tween.endValue property, and interpolation function
		 *                            specified by the implementation of the effect in its
		 *                            play() method.
		 *                            The play() method  uses these values to create
		 *                            a Tween object that plays the effect over a time period.
		 *                            The value argument can be either a Number
		 *                            or an Array of Numbers.
		 */
		public function onTweenEnd(value:Object):void;
		/**
		 * Callback method that is called when the target should be updated
		 *  by the effect.
		 *  The Tween class uses the easing function and the
		 *  Tween.startValue, Tween.endValue
		 *  and Tween.duration properties to calculate
		 *  the value of the value argument.
		 *  The value argument can be either a Number
		 *  or an Array of Numbers.
		 *
		 * @param value             <Object> The value of the value argument
		 *                            is an interpolated value determined by the
		 *                            Tween.startValue property,
		 *                            Tween.endValue property, and interpolation function
		 *                            specified by the implementation of the effect in its
		 *                            play() method.
		 *                            The play() method uses these values to create
		 *                            a Tween object that plays the effect over a time period.
		 *                            The value argument can be either a Number
		 *                            or an Array of Numbers.
		 */
		public function onTweenUpdate(value:Object):void;
		/**
		 * Advances the effect to the specified position.
		 *
		 * @param playheadTime      <Number> The position, in milliseconds, between 0
		 *                            and the value of the duration property.
		 */
		public function seek(playheadTime:Number):void;
	}
}
