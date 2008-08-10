/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.easing {
	public class Elastic {
		/**
		 * The easeIn() method starts motion slowly,
		 *  and then accelerates motion as it executes.
		 *
		 * @param t                 <Number> Specifies time.
		 * @param b                 <Number> Specifies the initial position of a component.
		 * @param c                 <Number> Specifies the total change in position of the component.
		 * @param d                 <Number> Specifies the duration of the effect, in milliseconds.
		 * @param a                 <Number (default = 0)> Specifies the amplitude of the sine wave.
		 * @param p                 <Number (default = 0)> Specifies the period of the sine wave.
		 * @return                  <Number> Number corresponding to the position of the component.
		 */
		public static function easeIn(t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0):Number;
		/**
		 * The easeInOut() method combines the motion
		 *  of the easeIn() and easeOut() methods
		 *  to start the motion slowly, accelerate motion, then decelerate.
		 *
		 * @param t                 <Number> Specifies time.
		 * @param b                 <Number> Specifies the initial position of a component.
		 * @param c                 <Number> Specifies the total change in position of the component.
		 * @param d                 <Number> Specifies the duration of the effect, in milliseconds.
		 * @param a                 <Number (default = 0)> Specifies the amplitude of the sine wave.
		 * @param p                 <Number (default = 0)> Specifies the period of the sine wave.
		 * @return                  <Number> Number corresponding to the position of the component.
		 */
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0):Number;
		/**
		 * The easeOut() method starts motion fast,
		 *  and then decelerates motion as it executes.
		 *
		 * @param t                 <Number> Specifies time.
		 * @param b                 <Number> Specifies the initial position of a component.
		 * @param c                 <Number> Specifies the total change in position of the component.
		 * @param d                 <Number> Specifies the duration of the effect, in milliseconds.
		 * @param a                 <Number (default = 0)> Specifies the amplitude of the sine wave.
		 * @param p                 <Number (default = 0)> Specifies the period of the sine wave.
		 * @return                  <Number> Number corresponding to the position of the component.
		 */
		public static function easeOut(t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0):Number;
	}
}
