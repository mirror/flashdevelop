package flash.display 
{
	public final class Scene 
	{
		/// An array of FrameLabel objects for the scene. 
		public function get labels():Array;
		
		/// The name of the scene.
		public function get name():String;
		
		/// The number of frames in the scene.
		public function get numFrames():int;
	}
	
}
