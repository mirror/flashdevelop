package mx.effects.effectClasses
{
	import mx.core.mx_internal;
	import mx.effects.Tween;

include "../../core/Version.as"
	/**
	 *  The AnimatePropertyInstance class implements the instance class
 *  for the AnimateProperty effect.
 *  Flex creates an instance of this class when it plays an AnimateProperty
 *  effect; you do not create one yourself.
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
 *  For the AnimateProperty effect, 
 *  the <code>TweenEvent.value</code> property contains a Number between the values of 
 *  the <code>AnimateProperty.fromValue</code> and 
 *  <code>AnimateProperty.toValue</code> properties, for the target 
 *  property specified by <code>AnimateProperty.property</code>.</p>
 *
 *  @see mx.effects.AnimateProperty
 *  @see mx.events.TweenEvent
	 */
	public class AnimatePropertyInstance extends TweenEffectInstance
	{
		/**
		 *  The ending value for the effect.
	 *  The default value is the target's current property value.
		 */
		public var toValue : Number;
		/**
		 *  If <code>true</code>, the property attribute is a style and you
	 *  set it by using the <code>setStyle()</code> method. 
	 *  
	 *  @default false
		 */
		public var isStyle : Boolean;
		/**
		 *  The name of the property on the target to animate.
	 *  This attribute is required.
		 */
		public var property : String;
		/**
		 *  If <code>true</code>, round off the interpolated tweened value
	 *  to the nearest integer. 
	 *  This property is useful if the property you are animating
	 *  is an int or uint.
	 *  
	 *  @default false
		 */
		public var roundValue : Boolean;
		/**
		 *  The starting value of the property for the effect.
	 *  The default value is the target's current property value.
		 */
		public var fromValue : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function AnimatePropertyInstance (target:Object);

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
		private function getCurrentValue () : Number;
	}
}
