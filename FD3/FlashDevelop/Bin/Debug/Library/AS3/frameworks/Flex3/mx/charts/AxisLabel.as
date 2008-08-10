/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	public class AxisLabel {
		/**
		 * The position, specified as a value between 0 and 1,
		 *  of the label along the axis.
		 *  An AxisLabel with a position of 0 is placed at the minimum value
		 *  of the axis, while an AxisLabel with a position of 1 is placed
		 *  at the maximum value of the axis.
		 */
		public var position:Number;
		/**
		 * The text label that is actually rendered along the axis.
		 */
		public var text:String;
		/**
		 * The value that the label represents.
		 *  The particular type of the value property
		 *  is specific to the axis that generated the label.
		 *  For example, a LinearAxis might generate numeric values,
		 *  while a DateTimeAxis might generate Date instance values.
		 */
		public var value:Object;
		/**
		 * Constructor.
		 *
		 * @param position          <Number (default = 0)> The position, specified as a value between 0 and 1,
		 *                            of the label along the axis.
		 * @param value             <Object (default = null)> The value the label represents.
		 * @param text              <String (default = null)> The text label that is actually rendered along the axis.
		 */
		public function AxisLabel(position:Number = 0, value:Object = null, text:String = null);
	}
}
