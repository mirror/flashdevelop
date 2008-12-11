package flash.geom
{
	/// The Transform class provides access to color adjustment properties and two- or three-dimensional transformation objects that can be applied to a display object.
	public class Transform
	{
		/// A Matrix object containing values that alter the scaling, rotation, and translation of the display object.
		public var matrix:flash.geom.Matrix;

		/// A ColorTransform object containing values that universally adjust the colors in the display object.
		public var colorTransform:flash.geom.ColorTransform;

		/// A Matrix object representing the combined transformation matrixes of the display object and all of its parent objects, back to the root level.
		public var concatenatedMatrix:flash.geom.Matrix;

		/// A ColorTransform object representing the combined color transformations applied to the display object and all of its parent objects, back to the root level.
		public var concatenatedColorTransform:flash.geom.ColorTransform;

		/// A Rectangle object that defines the bounding rectangle of the display object on the stage.
		public var pixelBounds:flash.geom.Rectangle;

		/// Provides access to the Matrix3D object of a three-dimensional display object.
		public var matrix3D:flash.geom.Matrix3D;

		/// Provides access to the PerspectiveProjection object of a three-dimensional display object.
		public var perspectiveProjection:flash.geom.PerspectiveProjection;

		/// [FP10] Returns a Matrix3D object, which can transform the space of a specified display object in relation to the current display object's space.
		public function getRelativeMatrix3D(relativeTo:flash.display.DisplayObject):flash.geom.Matrix3D;

	}

}

