/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class Zoom extends TweenEffect {
		/**
		 * If true, prevents Flex from dispatching the rollOut
		 *  and rollOver events if the mouse has not moved.
		 *  Set this property to true when you use the Zoom effect to
		 *  toggle the effect target between a big and small size.
		 */
		public var captureRollEvents:Boolean;
		/**
		 * Number that represents the x-position of the zoom origin
		 *  when the effect target is in a container that supports absolute positioning,
		 *  such as the Canvas container. The zoom origin is the position on the target
		 *  around which the Zoom effect is centered.
		 */
		public var originX:Number;
		/**
		 * Number that represents the y-position of the zoom origin
		 *  when the effect target is in a container that supports absolute positioning,
		 *  such as the Canvas container. The zoom origin is the position on the target
		 *  around which the Zoom effect is centered.
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
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function Zoom(target:Object = null);
	}
}
