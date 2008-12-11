package flash.display
{
	/// Defines an ordered set of triangles that can be rendered using either (u,v) fill coordinates or a normal fill.
	public class GraphicsTrianglePath
	{
		/// A Vector of integers or indexes, where every three indexes define a triangle.
		public var indices:Vector.<int>;

		/// A Vector of Numbers where each pair of numbers is treated as a point (an x, y pair).
		public var vertices:Vector.<Number>;

		/// A Vector of normalized coordinates used to apply texture mapping.
		public var uvtData:Vector.<Number>;

		/// Specifies whether to render triangles that face in a given direction.
		public var culling:String;

		/// [FP10] Creates a new GraphicsTrianglePath object.
		public function GraphicsTrianglePath(vertices:Vector.<Number>=null, indices:Vector.<int>=null, uvtData:Vector.<Number>=null, culling:String=none);

	}

}

