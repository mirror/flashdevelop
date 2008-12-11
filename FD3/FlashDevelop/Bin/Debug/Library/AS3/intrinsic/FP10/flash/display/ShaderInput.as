package flash.display
{
	/// A ShaderInput instance represents a single input image for a shader kernel.
	public class ShaderInput
	{
		/// The input data that is used when the shader executes.
		public var input:Object;

		/// The width of the shader input.
		public var width:int;

		/// The height of the shader input.
		public var height:int;

		/// The number of channels that a shader input expects.
		public var channels:int;

		/// The zero-based index of the input in the shader, indicating the order of the input definitions in the shader.
		public var index:int;

		/// [FP10] Creates a ShaderInput instance.
		public function ShaderInput();

	}

}

