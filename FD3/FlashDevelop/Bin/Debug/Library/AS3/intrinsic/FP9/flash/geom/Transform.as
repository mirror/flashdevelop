package flash.geom 
{
	public class Transform 
	{
		/**
		 * A ColorTransform object containing values that universally adjust the colors in
		 *  the display object.
		 */
		public function get colorTransform():ColorTransform;
		public function set colorTransform(value:ColorTransform):void;
		/**
		 * A ColorTransform object representing the combined color transformations applied to the display object
		 *  and all of its parent objects, back to the root level.
		 *  If different color transformations have been applied at different levels, all of those transformations are
		 *  concatenated into one ColorTransform object
		 *  for this property.
		 */
		public function get concatenatedColorTransform():ColorTransform;
		/**
		 * A Matrix object representing the combined transformation matrixes of the
		 *  display object and all of its parent objects, back to the root level.
		 *  If different transformation matrixes have been applied at different levels,
		 *  all of those matrixes are concatenated into one matrix
		 *  for this property.
		 */
		public function get concatenatedMatrix():Matrix;
		/**
		 * A Matrix object containing values that affect the scaling, rotation,
		 *  and translation of the display object.
		 */
		public function get matrix():Matrix;
		public function set matrix(value:Matrix):void;
		/**
		 * A Rectangle object that defines the bounding rectangle of the display object on the Stage.
		 */
		public function get pixelBounds():Rectangle;
	}
	
}
