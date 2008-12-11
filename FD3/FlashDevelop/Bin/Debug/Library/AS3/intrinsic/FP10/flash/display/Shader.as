package flash.display
{
	/// A Shader instance represents a pixel shader in ActionScript.
	public class Shader
	{
		/// The raw shader bytecode for this Shader instance.
		public var byteCode:flash.utils.ByteArray;

		/// Provides access to parameters, input images, and metadata for the Shader instance.
		public var data:flash.display.ShaderData;

		/// The precision of math operations performed by the shader.
		public var precisionHint:String;

		/// [FP10] Creates a new Shader instance.
		public function Shader(code:flash.utils.ByteArray=null);

	}

}

