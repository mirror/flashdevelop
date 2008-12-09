package flash.events
{
	/// A ShaderEvent is dispatched when a shader operation launched from a ShaderJob finishes.
	public class ShaderEvent extends flash.events.Event
	{
		/// Defines the value of the type property of a complete event object.
		public static const COMPLETE:String = "complete";

		/// The BitmapData object that was passed to the ShaderJob.start() method.
		public var bitmapData:flash.display.BitmapData;

		/// The ByteArray object that was passed to the ShaderJob.start() method.
		public var byteArray:flash.utils.ByteArray;

		/// The Vector.&lt;Number&gt; object that was passed to the ShaderJob.start() method.
		public var vector:Vector.<Number>;

		/// [FP10] Creates a ShaderEvent object to pass to event listeners.
		public function ShaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, bitmap:flash.display.BitmapData=null, array:flash.utils.ByteArray=null, vector:Vector.<Number>=null);

		/// [FP10] Creates a copy of the ShaderEvent object and sets the value of each property to match that of the original.
		public function clone():flash.events.Event;

		/// [FP10] Returns a string that contains all the properties of the ShaderEvent object.
		public function toString():String;

	}

}

