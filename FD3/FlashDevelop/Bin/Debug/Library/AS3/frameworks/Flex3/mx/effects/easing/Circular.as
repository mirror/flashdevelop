﻿package mx.effects.easing
{
include "../../core/Version.as"
	/**
	 *  The Circular class defines three easing functions to implement 
 *  circular motion with Flex effect classes. 
 *
 *  For more information, see http://www.robertpenner.com/profmx.
	 */
	public class Circular
	{
		/**
		 *  The <code>easeIn()</code> method starts motion slowly, 
     *  and then accelerates motion as it executes. 
     *
     *  @param t Specifies time.
	 *
     *  @param b Specifies the initial position of a component.
	 *
     *  @param c Specifies the total change in position of the component.
	 *
     *  @param d Specifies the duration of the effect, in milliseconds.
     *
     *  @return Number corresponding to the position of the component.
		 */
		public static function easeIn (t:Number, b:Number, c:Number, d:Number) : Number;

		/**
		 *  The <code>easeOut()</code> method starts motion fast, 
     *  and then decelerates motion as it executes. 
     *
     *  @param t Specifies time.
	 *
     *  @param b Specifies the initial position of a component.
	 *
     *  @param c Specifies the total change in position of the component.
	 *
     *  @param d Specifies the duration of the effect, in milliseconds.
     *
     *  @return Number corresponding to the position of the component.
		 */
		public static function easeOut (t:Number, b:Number, c:Number, d:Number) : Number;

		/**
		 *  The <code>easeInOut()</code> method combines the motion
     *  of the <code>easeIn()</code> and <code>easeOut()</code> methods
	 *  to start the motion slowly, accelerate motion, then decelerate. 
     *
     *  @param t Specifies time.
	 *
     *  @param b Specifies the initial position of a component.
	 *
     *  @param c Specifies the total change in position of the component.
	 *
     *  @param d Specifies the duration of the effect, in milliseconds.
     *
     *  @return Number corresponding to the position of the component.
		 */
		public static function easeInOut (t:Number, b:Number, c:Number, d:Number) : Number;
	}
}
