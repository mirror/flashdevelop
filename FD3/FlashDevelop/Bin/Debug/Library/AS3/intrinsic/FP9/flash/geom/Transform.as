package flash.geom
{
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;

	/// The Transform class provides access to color adjustment properties and two- or three-dimensional transformation objects that can be applied to a display object.
	public class Transform extends Object
	{
		/// A ColorTransform object containing values that universally adjust the colors in the display object.
		public function get colorTransform () : ColorTransform;
		public function set colorTransform (value:ColorTransform) : void;

		/// A ColorTransform object representing the combined color transformations applied to the display object and all of its parent objects, back to the root level.
		public function get concatenatedColorTransform () : ColorTransform;

		/// A Matrix object representing the combined transformation matrixes of the display object and all of its parent objects, back to the root level.
		public function get concatenatedMatrix () : Matrix;

		/// A Matrix object containing values that alter the scaling, rotation, and translation of the display object.
		public function get matrix () : Matrix;
		public function set matrix (value:Matrix) : void;

		/// A Rectangle object that defines the bounding rectangle of the display object on the stage.
		public function get pixelBounds () : Rectangle;

		public function Transform (displayObject:DisplayObject);
	}
}
