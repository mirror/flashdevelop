/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	public class ZoomInstance extends TweenEffectInstance {
		/**
		 * Prevents the rollOut and rollOver events
		 *  from being dispatched if the mouse has not moved.
		 *  Set this value to true in situations where the target
		 *  toggles between a big and small state without moving the mouse.
		 */
		public var captureRollEvents:Boolean;
		/**
		 * Number that represents the x-position of the zoom origin,
		 *  or registration point.
		 *  The default value is target.width / 2,
		 *  which is the center of the target.
		 */
		public var originX:Number;
		/**
		 * Number that represents the y-position of the zoom origin,
		 *  or registration point.
		 *  The default value is target.height / 2,
		 *  which is the center of the target.
		 */
		public var originY:Number;
		/**
		 * Number that represents the scale at which to start the height zoom,
		 *  as a percent between 0.01 and 1.0.
		 *  The default value is 0.01, which is very small.
		 */
		public var zoomHeightFrom:Number;
		/**
		 * Number that represents the scale at which to complete the height zoom,
		 *  as a percent between 0.01 and 1.0.
		 *  The default value is 1.0, which is the object's normal size.
		 */
		public var zoomHeightTo:Number;
		/**
		 * Number that represents the scale at which to start the width zoom,
		 *  as a percent between 0.01 and 1.0.
		 *  The default value is 0.01, which is very small.
		 */
		public var zoomWidthFrom:Number;
		/**
		 * Number that represents the scale at which to complete the width zoom,
		 *  as a percent between 0.01 and 1.0.
		 *  The default value is 1.0, which is the object's normal size.
		 */
		public var zoomWidthTo:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function ZoomInstance(target:Object);
	}
}
