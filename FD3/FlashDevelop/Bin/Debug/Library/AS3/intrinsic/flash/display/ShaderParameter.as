package flash.display
{
	/// A ShaderParameter instance represents a single input parameter of a shader kernel.
	public class ShaderParameter
	{
		/// The value or values that are passed in as the parameter value to the shader.
		public var value:Array;

		/// The data type of the parameter as defined in the shader.
		public var type:String;

		/// The zero-based index of the parameter.
		public var index:int;

		/// [FP10] Creates a ShaderParameter instance.
		public function ShaderParameter();

	}

}

