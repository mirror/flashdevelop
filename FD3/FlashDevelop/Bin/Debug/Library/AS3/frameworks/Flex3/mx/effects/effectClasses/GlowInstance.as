package mx.effects.effectClasses
{
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import mx.core.Application;
	import mx.core.mx_internal;
	import mx.styles.StyleManager;

	/**
	 *  The GlowInstance class implements the instance class *  for the Glow effect. *  Flex creates an instance of this class when it plays a Glow effect; *  you do not create one yourself. * *  <p>Every effect class that is a subclass of the TweenEffect class  *  supports the following events:</p> *   *  <ul> *    <li><code>tweenEnd</code>: Dispatched when the tween effect ends. </li> *   *    <li><code>tweenUpdate</code>: Dispatched every time a TweenEffect  *      class calculates a new value.</li>  *  </ul> *   *  <p>The event object passed to the event listener for these events is of type TweenEvent.  *  The TweenEvent class defines the property <code>value</code>, which contains  *  the tween value calculated by the effect.  *  For the Glow effect,  *  the <code>TweenEvent.value</code> property contains a 4-item Array, where: </p> *  <ul> *    <li>value[0]:uint  The value of the target's <code>GlowFilter.color</code> property.</li>  *   *    <li>value[1]:Number  A value between the values of the <code>Glow.alphaFrom</code>  *    and <code>Glow.alphaTo</code> property.</li> *   *    <li>value[2]:Number  A value between the values of the <code>Glow.blurXFrom</code>  *    and <code>Glow.blurXTo</code> property.</li> *   *    <li>value[3]:Number  A value between the values of the <code>Glow.blurYFrom</code>  *    and <code>Glow.blurYTo</code> property.</li> *  </ul> * *  @see mx.effects.Glow *  @see mx.events.TweenEvent
	 */
	public class GlowInstance extends TweenEffectInstance
	{
		/**
		 *  Starting transparency level.
		 */
		public var alphaFrom : Number;
		/**
		 *  Ending transparency level.
		 */
		public var alphaTo : Number;
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
		 *  The color of the glow.
		 */
		public var color : uint;
		/**
		 *  The inner flag of the glow.
		 */
		public var inner : Boolean;
		/**
		 *  The knockout flag of the glow.
		 */
		public var knockout : Boolean;
		/**
		 *  The strength of the glow.
		 */
		public var strength : Number;

		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function GlowInstance (target:Object);
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
		private function setGlowFilter (color:uint, alpha:Number, blurX:Number, blurY:Number) : void;
	}
}
