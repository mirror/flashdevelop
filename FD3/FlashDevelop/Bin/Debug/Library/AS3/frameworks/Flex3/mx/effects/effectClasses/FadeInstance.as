package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

include "../../core/Version.as"
	/**
	 *  The FadeInstance class implements the instance class
 *  for the Fade effect.
 *  Flex creates an instance of this class when it plays a Fade effect;
 *  you do not create one yourself.
 *
 *  <p>Every effect class that is a subclass of the TweenEffect class 
 *  supports the following events:</p>
 *  
 *  <ul>
 *    <li><code>tweenEnd</code>: Dispatched when the tween effect ends. </li>
 *  
 *    <li><code>tweenUpdate</code>: Dispatched every time a TweenEffect 
 *      class calculates a new value.</li> 
 *  </ul>
 *  
 *  <p>The event object passed to the event listener for these events is of type TweenEvent. 
 *  The TweenEvent class defines the property <code>value</code>, which contains 
 *  the tween value calculated by the effect. 
 *  For the Fade effect, 
 *  the <code>TweenEvent.value</code> property contains a Number between the values of the 
 *  <code>Fade.alphaFrom</code> and <code>Fade.alphaTo</code> properties.</p>
 *
 *  @see mx.effects.Fade
 *  @see mx.events.TweenEvent
	 */
	public class FadeInstance extends TweenEffectInstance
	{
		/**
		 *  @private
	 *  The original transparency level.
		 */
		private var origAlpha : Number;
		/**
		 *  @private
		 */
		private var restoreAlpha : Boolean;
		/**
		 *  Initial transparency level between 0.0 and 1.0, 
	 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaFrom : Number;
		/**
		 *  Final transparency level between 0.0 and 1.0, 
	 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaTo : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function FadeInstance (target:Object);

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
	}
}
