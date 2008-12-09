package flash.display
{
	/// The MovieClip class inherits from the following classes: Sprite, DisplayObjectContainer, InteractiveObject, DisplayObject, and EventDispatcher.
	public class MovieClip extends flash.display.Sprite
	{
		/// Specifies the number of the frame in which the playhead is located in the timeline of the MovieClip instance.
		public var currentFrame:int;

		/// The number of frames that are loaded from a streaming SWF file.
		public var framesLoaded:int;

		/// The total number of frames in the MovieClip instance.
		public var totalFrames:int;

		/// Indicates whether other display objects that are SimpleButton or MovieClip objects can receive mouse release events.
		public var trackAsMenu:Boolean;

		/// An array of Scene objects, each listing the name, the number of frames, and the frame labels for a scene in the MovieClip instance.
		public var scenes:Array;

		/// The current scene in which the playhead is located in the timeline of the MovieClip instance.
		public var currentScene:flash.display.Scene;

		/// The current label in which the playhead is located in the timeline of the MovieClip instance.
		public var currentLabel:String;

		/// The label at the current frame in the timeline of the MovieClip instance.
		public var currentFrameLabel:String;

		/// Returns an array of FrameLabel objects from the current scene.
		public var currentLabels:Array;

		/// A Boolean value that indicates whether a movie clip is enabled.
		public var enabled:Boolean;

		/// Creates a new MovieClip instance.
		public function MovieClip();

		/// Moves the playhead in the timeline of the movie clip.
		public function play():void;

		/// Stops the playhead in the movie clip.
		public function stop():void;

		/// Sends the playhead to the next frame and stops it.
		public function nextFrame():void;

		/// Sends the playhead to the previous frame and stops it.
		public function prevFrame():void;

		/// Starts playing the SWF file at the specified frame.
		public function gotoAndPlay(frame:Object, scene:String=null):void;

		/// Brings the playhead to the specified frame of the movie clip and stops it there.
		public function gotoAndStop(frame:Object, scene:String=null):void;

		/// Moves the playhead to the previous scene of the MovieClip instance.
		public function prevScene():void;

		/// Moves the playhead to the next scene of the MovieClip instance.
		public function nextScene():void;

	}

}

