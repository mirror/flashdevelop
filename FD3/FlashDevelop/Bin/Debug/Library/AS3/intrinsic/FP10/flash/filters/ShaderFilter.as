package flash.filters
{
	/// The ShaderFilter class applies a filter by executing a shader on the object being filtered.
	public class ShaderFilter extends flash.filters.BitmapFilter
	{
		/// The shader to use for this filter.
		public var shader:flash.display.Shader;

		/// The growth in pixels on the left side of the target object.
		public var leftExtension:int;

		/// The growth in pixels on the top side of the target object.
		public var topExtension:int;

		/// The growth in pixels on the right side of the target object.
		public var rightExtension:int;

		/// The growth in pixels on the bottom side of the target object.
		public var bottomExtension:int;

		/// [FP10] Creates a new shader filter.
		public function ShaderFilter(shader:flash.display.Shader=null);

	}

}

