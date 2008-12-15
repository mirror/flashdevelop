package flash.display 
{
	public final class Scene 
	{
		/**
		 * An array of FrameLabel objects for the scene. Each FrameLabel object contains
		 *  a frame property, which specifies the frame number corresponding to the
		 *  label, and a name property.
		 */
		public function get labels():Array;
		/**
		 * The name of the scene.
		 */
		public function get name():String;
		/**
		 * The number of frames in the scene.
		 */
		public function get numFrames():int;
	}
	
}
