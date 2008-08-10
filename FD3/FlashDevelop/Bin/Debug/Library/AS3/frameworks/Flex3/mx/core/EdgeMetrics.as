/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class EdgeMetrics {
		/**
		 * The height, in pixels, of the bottom edge region.
		 */
		public var bottom:Number;
		/**
		 * The width, in pixels, of the left edge region.
		 */
		public var left:Number;
		/**
		 * The width, in pixels, of the right edge region.
		 */
		public var right:Number;
		/**
		 * The height, in pixels, of the top edge region.
		 */
		public var top:Number;
		/**
		 * Constructor.
		 *
		 * @param left              <Number (default = 0)> The width, in pixels, of the left edge region.
		 * @param top               <Number (default = 0)> The height, in pixels, of the top edge region.
		 * @param right             <Number (default = 0)> The width, in pixels, of the right edge region.
		 * @param bottom            <Number (default = 0)> The height, in pixels, of the bottom edge region.
		 */
		public function EdgeMetrics(left:Number = 0, top:Number = 0, right:Number = 0, bottom:Number = 0);
		/**
		 * Returns a copy of this EdgeMetrics object.
		 */
		public function clone():EdgeMetrics;
		/**
		 * An EdgeMetrics object with a value of zero for its
		 *  left, top, right,
		 *  and bottom properties.
		 */
		public static const EMPTY:EdgeMetrics;
	}
}
