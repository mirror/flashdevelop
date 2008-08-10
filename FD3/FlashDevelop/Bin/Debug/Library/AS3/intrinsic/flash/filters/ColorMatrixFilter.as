/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.filters {
	public final  class ColorMatrixFilter extends BitmapFilter {
		/**
		 * An array of 20 items for 4 x 5 color transform. The matrix property cannot
		 *  be changed by directly modifying its value (for example, myFilter.matrix[2] = 1;).
		 *  Instead, you must get a reference to the array, make the change to the reference, and reset the
		 *  value.
		 */
		public function get matrix():Array;
		public function set matrix(value:Array):void;
		/**
		 * Initializes a new ColorMatrixFilter instance with the specified parameters.
		 *
		 * @param matrix            <Array (default = null)> An array of 20 items arranged as a 4 x 5 matrix.
		 */
		public function ColorMatrixFilter(matrix:Array = null);
		/**
		 * Returns a copy of this filter object.
		 *
		 * @return                  <BitmapFilter> A new ColorMatrixFilter instance with all of the same properties as the original
		 *                            one.
		 */
		public override function clone():BitmapFilter;
	}
}
