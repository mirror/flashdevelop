/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import flash.utils.Dictionary;
	public interface IStackable2 extends IStackable {
		/**
		 * Stacks the series. Normally, a series implements the updateData() method
		 *  to load its data out of the data provider. But a stacking series performs special
		 *  operations because its values are not necessarily stored in its data provider.
		 *  Its values are whatever is stored in its data provider, summed with the values
		 *  that are loaded by the object it stacks on top of.
		 *
		 * @param stackedPosXValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the x values, and the values are the positive
		 *                            x values.
		 * @param stackedNegXValueDictionary<Dictionary> Contains the base values that the series should stack
		 *                            on top of. The keys in the dictionary are the x values, and the values are the negative
		 *                            y values.
		 * @param previousElement   <IStackable2> The previous element in the stack. If, for example, the element
		 *                            is of the same type, you can use access to this property to avoid duplicate effort when
		 *                            rendering.
		 * @return                  <Object> An object representing the maximum and minimum values in the newly stacked series.
		 */
		public function stackAll(stackedPosXValueDictionary:Dictionary, stackedNegXValueDictionary:Dictionary, previousElement:IStackable2):Object;
	}
}
