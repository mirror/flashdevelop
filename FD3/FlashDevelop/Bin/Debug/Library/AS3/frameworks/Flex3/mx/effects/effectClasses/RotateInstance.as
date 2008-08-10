/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	public class RotateInstance extends TweenEffectInstance {
		/**
		 * The starting angle of rotation of the target object,
		 *  expressed in degrees.
		 *  Valid values range from 0 to 360.
		 */
		public var angleFrom:Number = 0;
		/**
		 * The ending angle of rotation of the target object,
		 *  expressed in degrees.
		 *  Values can be either positive or negative.
		 */
		public var angleTo:Number = 360;
		/**
		 * The x-position of the center point of rotation.
		 *  The target rotates around this point.
		 *  The valid values are between 0 and the width of the target.
		 */
		public var originX:Number;
		/**
		 * The y-position of the center point of rotation.
		 *  The target rotates around this point.
		 *  The valid values are between 0 and the height of the target.
		 */
		public var originY:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function RotateInstance(target:Object);
	}
}
