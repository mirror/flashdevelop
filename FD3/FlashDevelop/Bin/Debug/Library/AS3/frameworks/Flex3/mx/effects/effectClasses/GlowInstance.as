/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	public class GlowInstance extends TweenEffectInstance {
		/**
		 * Starting transparency level.
		 */
		public var alphaFrom:Number;
		/**
		 * Ending transparency level.
		 */
		public var alphaTo:Number;
		/**
		 * The starting amount of horizontal blur.
		 */
		public var blurXFrom:Number;
		/**
		 * The ending amount of horizontal blur.
		 */
		public var blurXTo:Number;
		/**
		 * The starting amount of vertical blur.
		 */
		public var blurYFrom:Number;
		/**
		 * The ending amount of vertical blur.
		 */
		public var blurYTo:Number;
		/**
		 * The color of the glow.
		 */
		public var color:uint = 0xFFFFFFFF;
		/**
		 * The inner flag of the glow.
		 */
		public var inner:Boolean;
		/**
		 * The knockout flag of the glow.
		 */
		public var knockout:Boolean;
		/**
		 * The strength of the glow.
		 */
		public var strength:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function GlowInstance(target:Object);
	}
}
