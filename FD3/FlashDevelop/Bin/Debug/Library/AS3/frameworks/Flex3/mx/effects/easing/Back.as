/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.easing {
	public class Back {
		/**
		 * The easeIn() method starts
		 *  the motion by backtracking,
		 *  then reversing direction and moving toward the target.
		 *
		 * @param t                 <Number> Specifies time.
		 * @param b                 <Number> Specifies the initial position of a component.
		 * @param c                 <Number> Specifies the total change in position of the component.
		 * @param d                 <Number> Specifies the duration of the effect, in milliseconds.
		 * @param s                 <Number (default = 0)> Specifies the amount of overshoot, where the higher the value,
		 *                            the greater the overshoot.
		 * @return                  <Number> Number corresponding to the position of the component.
		 */
		public static function easeIn(t:Number, b:Number, c:Number, d:Number, s:Number = 0):Number;
		/**
		 * The easeInOut() method combines the motion
		 *  of the easeIn() and easeOut() methods
		 *  to start the motion by backtracking, then reversing direction and
		 *  moving toward target, overshooting target slightly, reversing direction again, and
		 *  then moving back toward the target.
		 *
		 * @param t                 <Number> Specifies time.
		 * @param b                 <Number> Specifies the initial position of a component.
		 * @param c                 <Number> Specifies the total change in position of the component.
		 * @param d                 <Number> Specifies the duration of the effect, in milliseconds.
		 * @param s                 <Number (default = 0)> Specifies the amount of overshoot, where the higher the value,
		 *                            the greater the overshoot.
		 * @return                  <Number> Number corresponding to the position of the component.
		 */
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number, s:Number = 0):Number;
		/**
		 * The easeOut() method starts the motion by
		 *  moving towards the target, overshooting it slightly,
		 *  and then reversing direction back toward the target.
		 *
		 * @param t                 <Number> Specifies time.
		 * @param b                 <Number> Specifies the initial position of a component.
		 * @param c                 <Number> Specifies the total change in position of the component.
		 * @param d                 <Number> Specifies the duration of the effect, in milliseconds.
		 * @param s                 <Number (default = 0)> Specifies the amount of overshoot, where the higher the value,
		 *                            the greater the overshoot.
		 * @return                  <Number> Number corresponding to the position of the component.
		 */
		public static function easeOut(t:Number, b:Number, c:Number, d:Number, s:Number = 0):Number;
	}
}
