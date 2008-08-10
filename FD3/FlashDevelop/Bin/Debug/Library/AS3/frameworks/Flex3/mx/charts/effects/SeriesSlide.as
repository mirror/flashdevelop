/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.effects {
	import mx.effects.IEffectInstance;
	public class SeriesSlide extends SeriesEffect {
		/**
		 * Defines the location from which the series slides.
		 *  Valid values are "left", "right",
		 *  "up", and "down".
		 *  The default value is "left".
		 */
		public var direction:String = "left";
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> The target of the effect.
		 */
		public function SeriesSlide(target:Object = null);
		/**
		 * Copies properties of the effect to the effect instance.
		 *
		 * @param instance          <IEffectInstance> The effect instance to initialize.
		 */
		protected override function initInstance(instance:IEffectInstance):void;
	}
}
