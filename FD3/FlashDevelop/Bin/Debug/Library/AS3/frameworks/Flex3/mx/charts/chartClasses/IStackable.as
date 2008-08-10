/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.utils.Dictionary;
	public interface IStackable {
		/**
		 * The StackedSeries associated with this series.
		 *  The stacker manages the series's stacking behavior.
		 */
		public function get stacker():StackedSeries;
		public function set stacker(value:StackedSeries):void;
		/**
		 * The stack totals for the series.
		 */
		public function set stackTotals(value:Dictionary):void;
		/**
		 * Stacks the series. Normally, a series implements the updateData() method
		 *  to load its data out of the data provider. But a stacking series performs special
		 *  operations because its values are not necessarily stored in its data provider.
		 *  Its values are whatever is stored in its data provider, summed with the values
		 *  that are loaded by the object it stacks on top of.
		 *
		 * @param stackedXValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the y values, and the values are the x values.
		 * @param previousElement   <IStackable> The previous element in the stack. If, for example, the element
		 *                            is of the same type, you can use access to this property to avoid duplicate effort when
		 *                            rendering.
		 * @return                  <Number> The maximum value in the newly stacked series.
		 */
		public function stack(stackedXValueDictionary:Dictionary, previousElement:IStackable):Number;
	}
}
