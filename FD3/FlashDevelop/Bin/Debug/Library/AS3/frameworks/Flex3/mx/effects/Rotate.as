/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class Rotate extends TweenEffect {
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
		 * Determines whether the effect should hide the focus ring when starting the
		 *  effect. The target itself is responsible for the actual hiding of the focus ring.
		 */
		public function get hideFocusRing():Boolean;
		public function set hideFocusRing(value:Boolean):void;
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
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function Rotate(target:Object = null);
	}
}
