package flash.display
{
	/// Defines a shader fill.
	public class GraphicsShaderFill
	{
		/// The shader to use for the fill.
		public var shader:flash.display.Shader;

		/// A matrix object (of the flash.geom.Matrix class), which you can use to define transformations on the shader.
		public var matrix:flash.geom.Matrix;

		/// [FP10] Creates a new GraphicsShaderFill object.
		public function GraphicsShaderFill(shader:flash.display.Shader=null, matrix:flash.geom.Matrix=null);

	}

}

