package flash.display
{
	/// A ShaderJob instance is used to execute a shader operation in the background.
	public class ShaderJob extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched when the ShaderJob finishes processing the data using the shader.
		 * @eventType flash.events.ShaderEvent.COMPLETE
		 */
		[Event(name="complete", type="flash.events.ShaderEvent")]

		/// The shader that's used for the operation.
		public var shader:flash.display.Shader;

		/// The object into which the result of the shader operation is written.
		public var target:Object;

		/// The width of the result data in the target if it is a ByteArray or Vector.&lt;Number&gt; instance.
		public var width:int;

		/// The height of the result data in the target if it is a ByteArray or Vector.&lt;Number&gt; instance.
		public var height:int;

		/// The progress of a running shader.
		public var progress:Number;

		/// [FP10] A ShaderJob instance is used to execute a shader operation in the background.
		public function ShaderJob(shader:flash.display.Shader=null, target:Object=null, width:int=0, height:int=0);

		/// [FP10] Starts a background shader operation.
		public function start(waitForCompletion:Boolean=false):void;

		/// [FP10] Cancels the currently running shader operation.
		public function cancel():void;

	}

}

