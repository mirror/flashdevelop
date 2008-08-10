/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.effects.effectClasses {
	import mx.effects.effectClasses.TweenEffectInstance;
	public class SeriesEffectInstance extends TweenEffectInstance {
		/**
		 * Specifies the amount of time, in milliseconds, that Flex delays
		 *  the start of the effect on each element in the series.
		 */
		public var elementOffset:Number = 20;
		/**
		 * The current position of each chart item being managed by this effect. This is an array of values between 0 and 1 indicating how far the effect should render each item in the series between its
		 *  starting and ending values. These values are calculated based on the duration, number of elements, element offset, minimum element duration, and easing function.
		 */
		protected var interpolationValues:Array;
		/**
		 * Specifies the amount of time, in milliseconds,
		 *  that an individual element should take to complete the effect.
		 */
		public var minimumElementDuration:Number = 0;
		/**
		 * Specifies the amount of time, in milliseconds,
		 *  that Flex delays the effect.
		 */
		public var offset:Number = 0;
		/**
		 * The series targeted by this instance.
		 */
		protected var targetSeries:Series;
		/**
		 * The type of transition this effect is being used for. Some series effects define different behavior based on whether they are being used during the show or hide portion of
		 *  a chart transition.  The SeriesSlide effect, for example, slides elements from their position off screen when type is set to hide, and on screen when set to show.  This property
		 *  is set automatically by the chart, based on whether the effect is assigned to the ShowDataEffect or HideDataEffect style.
		 */
		public var type:String = "show";
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The target of the effect.
		 */
		public function SeriesEffectInstance(target:Object = null);
		/**
		 * Initializes the tweening calculations and sets up the interpolationValues Array for the number of items equal to the elementCount property. Derived classes should call this function in their play() method.
		 *
		 * @param elementCount      <int> The number of elements to generate interpolation values for.
		 */
		protected function beginTween(elementCount:int):void;
	}
}
