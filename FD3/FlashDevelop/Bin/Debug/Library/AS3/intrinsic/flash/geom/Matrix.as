/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.geom {
	public class Matrix {
		/**
		 * The value that affects the positioning of pixels
		 *  along the x axis when scaling or rotating an image.
		 */
		public var a:Number;
		/**
		 * The value that affects the positioning of pixels
		 *  along the y axis when rotating or skewing an image.
		 */
		public var b:Number;
		/**
		 * The value that affects the positioning of pixels
		 *  along the x axis when rotating or skewing an image.
		 */
		public var c:Number;
		/**
		 * The value that affects the positioning of pixels
		 *  along the y axis when scaling or rotating an image.
		 */
		public var d:Number;
		/**
		 * The distance by which to translate each point along the x axis.
		 */
		public var tx:Number;
		/**
		 * The distance by which to translate each point along the y axis.
		 */
		public var ty:Number;
		/**
		 * Creates a new Matrix object with the specified parameters.
		 *
		 * @param a                 <Number (default = 1)> The value that affects the positioning of pixels
		 *                            along the x axis when scaling or rotating an image.
		 * @param b                 <Number (default = 0)> The value that affects the positioning of pixels
		 *                            along the y axis when rotating or skewing an image.
		 * @param c                 <Number (default = 0)> The value that affects the positioning of pixels
		 *                            along the x axis when rotating or skewing an image.
		 * @param d                 <Number (default = 1)> The value that affects the positioning of pixels
		 *                            along the y axis when scaling or rotating an image..
		 * @param tx                <Number (default = 0)> The distance by which to translate each point along the x axis.
		 * @param ty                <Number (default = 0)> The distance by which to translate each point along the y axis.
		 */
		public function Matrix(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0);
		/**
		 * Returns a new Matrix object that is a clone of this
		 *  matrix, with an exact copy of the contained object.
		 *
		 * @return                  <Matrix> A Matrix object.
		 */
		public function clone():Matrix;
		/**
		 * Concatenates a matrix with the current matrix, effectively combining the
		 *  geometric effects of the two. In mathematical terms, concatenating two matrixes
		 *  is the same as combining them using matrix multiplication.
		 *
		 * @param m                 <Matrix> The matrix to be concatenated to the source matrix.
		 */
		public function concat(m:Matrix):void;
		/**
		 * Includes parameters for scaling,
		 *  rotation, and translation. When applied to a matrix it sets the matrix's values
		 *  based on those parameters.
		 *
		 * @param scaleX            <Number> The factor by which to scale horizontally.
		 * @param scaleY            <Number> The factor by which scale vertically.
		 * @param rotation          <Number (default = 0)> The amount to rotate, in radians.
		 * @param tx                <Number (default = 0)> The number of pixels to translate (move) to the right along the x axis.
		 * @param ty                <Number (default = 0)> The number of pixels to translate (move) down along the y axis.
		 */
		public function createBox(scaleX:Number, scaleY:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0):void;
		/**
		 * Creates the specific style of matrix expected by the beginGradientFill() and
		 *  lineGradientStyle() methods of the Graphics class. Width and height are scaled to
		 *  a scaleX/scaleY pair and the tx/ty
		 *  values are offset by half the width and height.
		 *
		 * @param width             <Number> The width of the gradient box.
		 * @param height            <Number> The height of the gradient box.
		 * @param rotation          <Number (default = 0)> The amount to rotate, in radians.
		 * @param tx                <Number (default = 0)> The distance, in pixels, to translate to the right along the x axis.
		 *                            This value is offset by half of the width parameter.
		 * @param ty                <Number (default = 0)> The distance, in pixels, to translate down along the y axis.
		 *                            This value is offset by half of the height parameter.
		 */
		public function createGradientBox(width:Number, height:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0):void;
		/**
		 * Given a point in the pretransform coordinate space, returns the coordinates of
		 *  that point after the transformation occurs. Unlike the standard transformation applied using
		 *  the transformPoint() method, the deltaTransformPoint() method's
		 *  transformation does not consider the translation parameters tx and ty.
		 *
		 * @param point             <Point> The point for which you want to get the result of the matrix transformation.
		 * @return                  <Point> The point resulting from applying the matrix transformation.
		 */
		public function deltaTransformPoint(point:Point):Point;
		/**
		 * Sets each matrix property to a value that causes a null transformation. An object transformed
		 *  by applying an identity matrix will be identical to the original.
		 */
		public function identity():void;
		/**
		 * Performs the opposite transformation
		 *  of the original matrix. You can apply an inverted matrix to an object to undo the transformation
		 *  performed when applying the original matrix.
		 */
		public function invert():void;
		/**
		 * Applies a rotation transformation to the Matrix object.
		 *
		 * @param angle             <Number> The rotation angle in radians.
		 */
		public function rotate(angle:Number):void;
		/**
		 * Applies a scaling transformation to the matrix. The x axis is multiplied
		 *  by sx, and the y axis it is multiplied by sy.
		 *
		 * @param sx                <Number> A multiplier used to scale the object along the x axis.
		 * @param sy                <Number> A multiplier used to scale the object along the y axis.
		 */
		public function scale(sx:Number, sy:Number):void;
		/**
		 * Returns a text value listing the properties of the Matrix object.
		 *
		 * @return                  <String> A string containing the values of the properties of the Matrix object: a, b, c,
		 *                            d, tx, and ty.
		 */
		public function toString():String;
		/**
		 * Returns the result of applying the geometric transformation represented by the Matrix object to the
		 *  specified point.
		 *
		 * @param point             <Point> The point for which you want to get the result of the Matrix transformation.
		 * @return                  <Point> The point resulting from applying the Matrix transformation.
		 */
		public function transformPoint(point:Point):Point;
		/**
		 * Translates the matrix along the x and y axes, as specified by the dx
		 *  and dy parameters.
		 *
		 * @param dx                <Number> The amount of movement along the x axis to the right, in pixels.
		 * @param dy                <Number> The amount of movement down along the y axis, in pixels.
		 */
		public function translate(dx:Number, dy:Number):void;
	}
}
