/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class Glow extends TweenEffect {
		/**
		 * Starting transparency level between 0.0 and 1.0,
		 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaFrom:Number;
		/**
		 * Ending transparency level between 0.0 and 1.0,
		 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaTo:Number;
		/**
		 * The starting amount of horizontal blur.
		 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurXFrom:Number;
		/**
		 * The ending amount of horizontal blur.
		 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurXTo:Number;
		/**
		 * The starting amount of vertical blur.
		 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurYFrom:Number;
		/**
		 * The ending amount of vertical blur.
		 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurYTo:Number;
		/**
		 * The color of the glow.
		 *  The default value is the value of the themeColor style
		 *  property of the application.
		 */
		public var color:uint = 0xFFFFFFFF;
		/**
		 * Specifies whether the glow is an inner glow.
		 *  A value of true indicates an inner glow within
		 *  the outer edges of the object.
		 *  The default value is false, to specify
		 *  an outer glow around the outer edges of the object.
		 */
		public var inner:Boolean;
		/**
		 * Specifies whether the object has a knockout effect.
		 *  A value of true makes the object's fill color transparent
		 *  to reveal the background color of the underlying object.
		 *  The default value is false to specify no knockout effect.
		 */
		public var knockout:Boolean;
		/**
		 * The strength of the imprint or spread.
		 *  The higher the value, the more color is imprinted and the stronger the
		 *  contrast between the glow and the background.
		 *  Valid values are from 0 to 255.
		 */
		public var strength:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function Glow(target:Object = null);
	}
}
