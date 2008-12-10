package mx.effects.easing
{
	/**
	 *  The Quintic class defines three easing functions to implement  *  motion with Flex effect classes. The acceleration of motion for a Quintic easing *  equation is greater than for a Quadratic, Cubic, or Quartic easing equation. * *  For more information, see http://www.robertpenner.com/profmx.
	 */
	public class Quintic
	{
		/**
		 *  The <code>easeIn()</code> method starts motion from zero velocity,      *  and then accelerates motion as it executes.      *     *  @param t Specifies time.	 *     *  @param b Specifies the initial position of a component.	 *     *  @param c Specifies the total change in position of the component.	 *     *  @param d Specifies the duration of the effect, in milliseconds.     *     *  @return Number corresponding to the position of the component.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 *  The <code>easeOut()</code> method starts motion fast,      *  and then decelerates motion to a zero velocity as it executes.      *     *  @param t Specifies time.	 *     *  @param b Specifies the initial position of a component.	 *     *  @param c Specifies the total change in position of the component.	 *     *  @param d Specifies the duration of the effect, in milliseconds.     *     *  @return Number corresponding to the position of the component.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number) : Number;
		/**
		 *  The <code>easeInOut()</code> method combines the motion     *  of the <code>easeIn()</code> and <code>easeOut()</code> methods	 *  to start the motion from a zero velocity, accelerate motion, 	 *  then decelerate to a zero velocity.      *     *  @param t Specifies time.	 *     *  @param b Specifies the initial position of a component.	 *     *  @param c Specifies the total change in position of the component.	 *     *  @param d Specifies the duration of the effect, in milliseconds.     *     *  @return Number corresponding to the position of the component.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number) : Number;
	}
}
