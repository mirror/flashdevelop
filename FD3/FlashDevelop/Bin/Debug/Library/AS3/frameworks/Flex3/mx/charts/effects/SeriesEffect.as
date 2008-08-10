/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.effects {
	import mx.effects.TweenEffect;
	public class SeriesEffect extends TweenEffect {
		/**
		 * Specifies the amount of time, in milliseconds, that Flex delays
		 *  the start of the effect on each element in the series.
		 */
		public var elementOffset:Number = 20;
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
		 * The type of transition this effect is being used for. Some series effects define different behavior based on whether they are being used during the show or hide portion of
		 *  a chart transition. The SeriesSlide effect, for example, slides elements from their position off screen when this property is set to hide, and on screen when this property is set to show. This property
		 *  is set by the chart, based on whether the effect as assigned to the ShowDataEffect or HideDataEffect style.
		 */
		public var type:String = "show";
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The target of the effect.
		 */
		public function SeriesEffect(target:Object);
	}
}
