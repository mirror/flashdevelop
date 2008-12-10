package mx.effects.effectClasses
{
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import mx.core.mx_internal;

	/**
	 *  The BlurInstance class implements the instance class *  for the Blur effect. *  Flex creates an instance of this class when it plays a Blur effect; *  you do not create one yourself. * *  <p>Every effect class that is a subclass of the TweenEffect class  *  supports the following events:</p> *   *  <ul> *    <li><code>tweenEnd</code>: Dispatched when the tween effect ends. </li> *   *    <li><code>tweenUpdate</code>: Dispatched every time a TweenEffect  *      class calculates a new value.</li>  *  </ul> *   *  <p>The event object passed to the event listener for these events is of type TweenEvent.  *  The TweenEvent class  defines the property <code>value</code>, which contains  *  the tween value calculated by the effect.  *  For the Blur effect,  *  the <code>TweenEvent.value</code> property contains a 2-item Array, where: </p> *  <ul> *    <li>value[0]:Number  A value between the values of the <code>Blur.blurXTo</code>  *    and <code>Blur.blurXFrom</code> property, applied to the  *    target's <code>BlurFilter.blurX</code> property.</li>  *   *    <li>value[1]:Number  A value between the values of the <code>Blur.blurYTo</code>  *    and <code>Blur.blurYFrom</code> property, applied to the  *    target's <code>BlurFilter.blurY</code> property.</li> *  </ul> * *  @see mx.effects.Blur *  @see mx.events.TweenEvent
	 */
	public class BlurInstance extends TweenEffectInstance
	{
		/**
		 *  The starting amount of horizontal blur.
		 */
		public var blurXFrom : Number;
		/**
		 *  The ending amount of horizontal blur.
		 */
		public var blurXTo : Number;
		/**
		 *  The starting amount of vertical blur.
		 */
		public var blurYFrom : Number;
		/**
		 *  The ending amount of vertical blur.
		 */
		public var blurYTo : Number;

		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function BlurInstance (target:Object);
		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function onTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		public function onTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		private function setBlurFilter (blurX:Number, blurY:Number) : void;
	}
}
