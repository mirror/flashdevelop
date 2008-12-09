package flash.geom
{
	/// The Matrix3D class represents a transformation matrix that determines the position and orientation of the three-dimensional display object.
	public class Matrix3D
	{
		/// A Vector of 16 Numbers, where every four elements can be a row or a column of a 4x4 matrix.
		public var rawData:Vector.<Number>;

		/// A Vector3D object that holds the position, the three-dimensional coordinate (x,y,z) of a display object within the transformation's frame of reference.
		public var position:flash.geom.Vector3D;

		/// A Number that determines whether a matrix is invertible.
		public var determinant:Number;

		/// [FP10] Creates a Matrix3D object.
		public function Matrix3D(v:Vector.<Number>=null);

		/// [FP10] Returns a new Matrix3D object that is an exact copy of the current Matrix3D object.
		public function clone():flash.geom.Matrix3D;

		/// [FP10] Appends the matrix by multiplying another Matrix3D object by the current Matrix3D object.
		public function append(lhs:flash.geom.Matrix3D):void;

		/// [FP10] Prepends a matrix by multiplying the current Matrix3D object by another Matrix3D object.
		public function prepend(rhs:flash.geom.Matrix3D):void;

		/// [FP10] Inverts the current matrix.
		public function invert():Boolean;

		/// [FP10] Converts the current matrix to an identity or unit matrix.
		public function identity():void;

		/// [FP10] Returns the transformation matrix's translation, rotation, and scale settings as a Vector of three Vector3D objects.
		public function decompose(orientationStyle:String=eulerAngles):Vector.<flash.geom.Vector>3D;

		/// [FP10] Sets the transformation matrix's translation, rotation, and scale settings.
		public function recompose(components:Vector.<flash.geom.Vector>3D, orientationStyle:String=eulerAngles):Boolean;

		/// [FP10] Appends an incremental translation, a repositioning along the x, y, and z axes, to a Matrix3D object.
		public function appendTranslation(x:Number, y:Number, z:Number):void;

		/// [FP10] Appends an incremental rotation to a Matrix3D object.
		public function appendRotation(degrees:Number, axis:flash.geom.Vector3D, pivotPoint:flash.geom.Vector3D=null):void;

		/// [FP10] Appends an incremental scale change along the x, y, and z axes to a Matrix3D object.
		public function appendScale(xScale:Number, yScale:Number, zScale:Number):void;

		/// [FP10] Prepends an incremental translation, a repositioning along the x, y, and z axes, to a Matrix3D object.
		public function prependTranslation(x:Number, y:Number, z:Number):void;

		/// [FP10] Prepends an incremental rotation to a Matrix3D object.
		public function prependRotation(degrees:Number, axis:flash.geom.Vector3D, pivotPoint:flash.geom.Vector3D=null):void;

		/// [FP10] Prepends an incremental scale change along the x, y, and z axes to a Matrix3D object.
		public function prependScale(xScale:Number, yScale:Number, zScale:Number):void;

		/// [FP10] Uses the transformation matrix to transform a Vector3D object from one space coordinate to another.
		public function transformVector(v:flash.geom.Vector3D):flash.geom.Vector3D;

		/// [FP10] Uses the transformation matrix without its translation elements to transform a Vector3D object from one space coordinate to another.
		public function deltaTransformVector(v:flash.geom.Vector3D):flash.geom.Vector3D;

		/// [FP10] Uses the transformation matrix to transform a Vector of Numbers from one coordinate space to another.
		public function transformVectors(vin:Vector.<Number>, vout:Vector.<Number>):void;

		/// [FP10] Converts the current Matrix3D object to a matrix where the rows and columns are swapped.
		public function transpose():void;

		/// [FP10] Rotates the display object so that it faces a specified position.
		public function pointAt(pos:flash.geom.Vector3D, at:flash.geom.Vector3D=null, up:flash.geom.Vector3D=null):void;

		/// [FP10] Interpolates a display object a percent point closer to a target display object.
		public static function interpolate(thisMat:flash.geom.Matrix3D, toMat:flash.geom.Matrix3D, percent:Number):flash.geom.Matrix3D;

		/// [FP10] Interpolates the display object's matrix a percent closer to a target's matrix.
		public function interpolateTo(toMat:flash.geom.Matrix3D, percent:Number):void;

	}

}

