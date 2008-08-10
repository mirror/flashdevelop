/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	import flash.events.EventDispatcher;
	public class Tween extends EventDispatcher {
		/**
		 * Duration of the animation, in milliseconds.
		 */
		public var duration:Number = 3000;
		/**
		 * Sets the easing function for the animation.
		 *  The easing function is used to interpolate between
		 *  the startValue value and the endValue.
		 *  A trivial easing function does linear interpolation,
		 *  but more sophisticated easing functions create the illusion of
		 *  acceleration and deceleration, which makes the animation seem
		 *  more natural.
		 */
		public function set easingFunction(value:Function):void;
		/**
		 * Object that is notified at each interval of the animation.
		 */
		public var listener:Object;
		/**
		 * Constructor.
		 *
		 * @param listener          <Object> Object that is notified at each interval
		 *                            of the animation. You typically pass the this
		 *                            keyword as the value.
		 *                            The listener must define the
		 *                            onTweenUpdate() method and optionally the
		 *                            onTweenEnd() method.
		 *                            The former method is invoked for each interval of the animation,
		 *                            and the latter is invoked just after the animation finishes.
		 * @param startValue        <Object> Initial value(s) of the animation.
		 *                            Either a number or an array of numbers.
		 *                            If a number is passed, the Tween interpolates
		 *                            between this number and the number passed
		 *                            in the endValue parameter.
		 *                            If an array of numbers is passed,
		 *                            each number in the array is interpolated.
		 * @param endValue          <Object> Final value(s) of the animation.
		 *                            The type of this argument must match the startValue
		 *                            parameter.
		 * @param duration          <Number (default = -1)> Duration of the animation, expressed in milliseconds.
		 * @param minFps            <Number (default = -1)> Minimum number of times that the
		 *                            onTweenUpdate() method should be called every second.
		 *                            The tween code tries to call the onTweenUpdate()
		 *                            method as frequently as possible (up to 100 times per second).
		 *                            However, if the frequency falls below minFps,
		 *                            the duration of the animation automatically increases.
		 *                            As a result, an animation that temporarily freezes
		 *                            (because it is not getting any CPU cycles) begins again
		 *                            where it left off, instead of suddenly jumping ahead.
		 * @param updateFunction    <Function (default = null)> Specifies an alternative update callback
		 *                            function to be used instead of listener.OnTweenUpdate()
		 * @param endFunction       <Function (default = null)> Specifies an alternative end callback function
		 *                            to be used instead of listener.OnTweenEnd()
		 */
		public function Tween(listener:Object, startValue:Object, endValue:Object, duration:Number = -1, minFps:Number = -1, updateFunction:Function = null, endFunction:Function = null);
		/**
		 * Interrupt the tween, jump immediately to the end of the tween,
		 *  and invoke the onTweenEnd() callback function.
		 */
		public function endTween():void;
		/**
		 * Pauses the effect until you call the resume() method.
		 */
		public function pause():void;
		/**
		 * Resumes the effect after it has been paused
		 *  by a call to the pause() method.
		 */
		public function resume():void;
		/**
		 * Plays the effect in reverse,
		 *  starting from the current position of the effect.
		 */
		public function reverse():void;
		/**
		 * Advances the tween effect to the specified position.
		 *
		 * @param playheadTime      <Number> The position, in milliseconds, between 0
		 *                            and the value of the duration property.
		 */
		public function seek(playheadTime:Number):void;
		/**
		 * By default, the Tween class invokes the
		 *  mx.effects.effectClasses.TweenEffectInstance.onTweenUpdate()
		 *  callback function on a regular interval on the effect instance
		 *  for the duration of the effect, and the optional
		 *  mx.effects.effectClasses.TweenEffectInstance.onTweenEnd()
		 *  callback function at the end of the effect duration.
		 *
		 * @param updateFunction    <Function> Specifies the update callback function.
		 * @param endFunction       <Function> Specifies the end callback function.
		 */
		public function setTweenHandlers(updateFunction:Function, endFunction:Function):void;
		/**
		 * Stops the tween, ending it without dispatching an event or calling
		 *  endFunction or onTweenEnd().
		 */
		public function stop():void;
	}
}
