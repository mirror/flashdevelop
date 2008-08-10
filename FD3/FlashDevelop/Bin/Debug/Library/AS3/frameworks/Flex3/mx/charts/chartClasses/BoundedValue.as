/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	public class BoundedValue {
		/**
		 * The margin, in pixels, required below the value
		 *  in order to render properly.
		 */
		public var lowerMargin:Number;
		/**
		 * The margin, in pixels, required above the value
		 *  in order to render properly.
		 */
		public var upperMargin:Number;
		/**
		 * The value to be rendered.
		 */
		public var value:Number;
		/**
		 * Constructor.
		 *
		 * @param value             <Number> The value to be rendered.
		 * @param lowerMargin       <Number (default = 0)> The lower margin.
		 * @param upperMargin       <Number (default = 0)> The upper margin.
		 */
		public function BoundedValue(value:Number, lowerMargin:Number = 0, upperMargin:Number = 0);
	}
}
