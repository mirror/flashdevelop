/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class AnimateProperty extends TweenEffect {
		/**
		 * The starting value of the property for the effect.
		 *  The default value is the target's current property value.
		 */
		public var fromValue:Number;
		/**
		 * If true, the property attribute is a style and you set
		 *  it by using the setStyle() method.
		 */
		public var isStyle:Boolean = false;
		/**
		 * The name of the property on the target to animate.
		 *  This attribute is required.
		 */
		public var property:String;
		/**
		 * If true, round off the interpolated tweened value
		 *  to the nearest integer.
		 *  This property is useful if the property you are animating
		 *  is an int or uint.
		 */
		public var roundValue:Boolean = false;
		/**
		 * The ending value for the effect.
		 *  The default value is the target's current property value.
		 */
		public var toValue:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function AnimateProperty(target:Object = null);
	}
}
