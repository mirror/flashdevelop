/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.text {
	public class TextLineMetrics {
		/**
		 * The ascent value of the text is the length from the baseline to the top of the line height in pixels. See the
		 *  "Ascent" measurement in the overview diagram for this class.
		 */
		public var ascent:Number;
		/**
		 * The descent value of the text is the length from the baseline to the bottom depth of the line in pixels.
		 *  See the "Descent" measurement in the overview diagram for this class.
		 */
		public var descent:Number;
		/**
		 * The height value of the text of the selected lines (not necessarily the complete text) in pixels. The height of the
		 *  text line does not include the gutter height. See the "Line height" measurement in the overview diagram
		 *  for this class.
		 */
		public var height:Number;
		/**
		 * The leading value is the measurement of the vertical distance between the lines of text.
		 *  See the "Leading" measurement in the overview diagram for this class.
		 */
		public var leading:Number;
		/**
		 * The width value is the width of the text of the selected lines (not necessarily the complete text) in pixels. The width of the
		 *  text line is not the same as the width of the text field. The width of the text line is relative to the
		 *  text field width, minus the gutter width of 4 pixels (2 pixels on each side). See the "Text Line width"
		 *  measurement in the overview diagram for this class.
		 */
		public var width:Number;
		/**
		 * The x value is the left position of the first character in pixels. This value includes the margin,
		 *  indent (if any), and gutter widths. See the "Text Line x-position" in the overview diagram for this class.
		 */
		public var x:Number;
		/**
		 * Creates a TextLineMetrics object.  The TextLineMetrics object contains information about
		 *  the text metrics of a line of text in a text field.  Objects of this class are returned by the
		 *  flash.text.TextField.getLineMetrics() method.
		 *
		 * @param x                 <Number> The left position of the first character in pixels.
		 * @param width             <Number> The width of the text of the selected lines (not necessarily the complete text) in pixels.
		 * @param height            <Number> The height of the text of the selected lines (not necessarily the complete text) in pixels.
		 * @param ascent            <Number> The length from the baseline to the top of the line height in pixels.
		 * @param descent           <Number> The length from the baseline to the bottom depth of the line in pixels.
		 * @param leading           <Number> The measurement of the vertical distance between the lines of text.
		 */
		public function TextLineMetrics(x:Number, width:Number, height:Number, ascent:Number, descent:Number, leading:Number);
	}
}
