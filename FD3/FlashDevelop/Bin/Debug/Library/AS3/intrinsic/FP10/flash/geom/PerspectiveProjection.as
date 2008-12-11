package flash.geom
{
	/// The PerspectiveProjection class provides an easy way to assign or modify the perspective transformations of a display object and all of its children.
	public class PerspectiveProjection
	{
		/// Specifies an angle, as a degree between 0 and 180, for the field of view in three dimensions.
		public var fieldOfView:Number;

		/// A two-dimensional point representing the center of the projection, the vanishing point for the display object.
		public var projectionCenter:flash.geom.Point;

		/// The distance between the eye or the viewpoint's origin (0,0,0) and the display object located in the z axis.
		public var focalLength:Number;

		/// [FP10] Creates an instance of a PerspectiveProjection object.
		public function PerspectiveProjection();

		/// [FP10] Returns the underlying Matrix3D object of the display object.
		public function toMatrix3D():flash.geom.Matrix3D;

	}

}

