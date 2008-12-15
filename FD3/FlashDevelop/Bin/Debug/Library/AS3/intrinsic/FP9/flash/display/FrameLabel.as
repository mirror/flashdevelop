package flash.display 
{
	public final class FrameLabel 
	{
		/// The frame number containing the label.
		public function get frame():int;
		
		/// The name of the label.
		public function get name():String;

		/// Create a new FrameLabel instance.
		public function FrameLabel(name:String, frame:uint);
	}
	
}