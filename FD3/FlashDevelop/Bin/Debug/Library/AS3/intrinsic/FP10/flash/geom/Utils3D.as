package flash.geom
{
	/// The Utils3D class contains static methods that simplify the implementation of certain three-dimensional matrix operations.
	public class Utils3D
	{
		/// [FP10] Using a projection Matrix3D object, projects a Vector3D object from one space coordinate to another.
		public static function projectVector(m:flash.geom.Matrix3D, v:flash.geom.Vector3D):flash.geom.Vector3D;

		/// [FP10] Projects a Vector of three-dimensional space coordinates to a Vector of two-dimensional space coordinates.
		public static function projectVectors(m:flash.geom.Matrix3D, verts:Vector.<Number>, projectedVerts:Vector.<Number>, uvts:Vector.<Number>):void;

		/// [FP10] Interpolates the orientation of an object toward a position.
		public static function pointTowards(percent:Number, mat:flash.geom.Matrix3D, pos:flash.geom.Vector3D, at:flash.geom.Vector3D=null, up:flash.geom.Vector3D=null):flash.geom.Matrix3D;

	}

}

