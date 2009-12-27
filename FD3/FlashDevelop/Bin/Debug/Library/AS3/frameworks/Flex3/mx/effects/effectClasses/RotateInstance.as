package mx.effects.effectClasses
{
	import mx.core.mx_internal;
	import mx.effects.EffectManager;

include "../../core/Version.as"
	/**
	 *  The RotateInstance class implements the instance class
 *  for the Rotate effect.
 *  Flex creates an instance of this class when it plays a Rotate effect;
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
 *  For the Rotate effect, 
 *  the <code>TweenEvent.value</code> property contains a Number between the values of 
 *  the <code>Rotate.angleFrom</code> and 
 *  <code>Rotate.angleTo</code> properties.</p>
 *
 *  @see mx.effects.Rotate
 *  @see mx.events.TweenEvent
	 */
	public class RotateInstance extends TweenEffectInstance
	{
		/**
		 *  @private
	 *  The x coordinate of the absolute point of rotation.
		 */
		private var centerX : Number;
		/**
		 *  @private
	 *  The y coordinate of absolute point of rotation.
		 */
		private var centerY : Number;
		/**
		 *  @private
		 */
		private var newX : Number;
		/**
		 *  @private
		 */
		private var newY : Number;
		/**
		 *  @private
		 */
		private var originalOffsetX : Number;
		/**
		 *  @private
		 */
		private var originalOffsetY : Number;
		/**
		 *  The starting angle of rotation of the target object,
	 *  expressed in degrees.
	 *  Valid values range from 0 to 360.
	 *  
	 *  @default 0
		 */
		public var angleFrom : Number;
		/**
		 *  The ending angle of rotation of the target object,
	 *  expressed in degrees.
	 *  Values can be either positive or negative.
	 *
	 *  <p>If the value of <code>angleTo</code> is less
	 *  than the value of <code>angleFrom</code>,
	 *  then the target rotates in a counterclockwise direction.
	 *  Otherwise, it rotates in clockwise direction.
	 *  If you want the target to rotate multiple times,
	 *  set this value to a large positive or small negative number.</p>
	 *  
	 *  @default 360
		 */
		public var angleTo : Number;
		/**
		 *  The x-position of the center point of rotation.
	 *  The target rotates around this point.
	 *  The valid values are between 0 and the width of the target.
	 *  
	 *  @default 0
		 */
		public var originX : Number;
		/**
		 *  The y-position of the center point of rotation.
	 *  The target rotates around this point.
	 *  The valid values are between 0 and the height of the target.
	 *  
	 *  @default 0
		 */
		public var originY : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function RotateInstance (target:Object);

		/**
		 *  @private
		 */
		public function play () : void;

		/**
		 *  @private
		 */
		public function onTweenUpdate (value:Object) : void;
	}
}
