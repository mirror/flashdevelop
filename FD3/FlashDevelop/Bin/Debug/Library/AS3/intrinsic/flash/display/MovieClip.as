/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/*** Manually fixed 'currentLabels' [philippe]          ***/
/**********************************************************/
package flash.display {
	public dynamic  class MovieClip extends Sprite {
		/**
		 * Specifies the number of the frame in which the playhead is located in the timeline of
		 *  the MovieClip instance. If the movie clip has multiple scenes, this value is the
		 *  frame number in the current scene.
		 */
		public function get currentFrame():int;
		/**
		 * The current label in which the playhead is located in the timeline of the MovieClip instance.
		 *  If the current frame has no label, currentLabel is set to the name of the previous frame
		 *  that includes a label. If the current frame and previous frames do not include a label,
		 *  currentLabel returns null.
		 */
		public function get currentLabel():String;
		/**
		 * Returns an array of FrameLabel objects from the current scene. If the MovieClip instance does
		 *  not use scenes, the array includes all frame labels from the entire MovieClip instance.
		 */
		public function get currentLabels():/*FrameLabel*/Array;
		/**
		 * The current scene in which the playhead is located in the timeline of the MovieClip instance.
		 */
		public function get currentScene():Scene;
		/**
		 * A Boolean value that indicates whether a movie clip is enabled. The default value of enabled
		 *  is true. If enabled is set to false, the movie clip's
		 *  Over, Down, and Up frames are disabled. The movie clip
		 *  continues to receive events (for example, mouseDown,
		 *  mouseUp, keyDown, and keyUp).
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * The number of frames that are loaded from a streaming SWF file. You can use the framesLoaded
		 *  property to determine whether the contents of a specific frame and all the frames before it
		 *  loaded and are available locally in the browser. You can also use it to monitor the downloading
		 *  of large SWF files. For example, you might want to display a message to users indicating that
		 *  the SWF file is loading until a specified frame in the SWF file finishes loading.
		 */
		public function get framesLoaded():int;
		/**
		 * An array of Scene objects, each listing the name, the number of frames,
		 *  and the frame labels for a scene in the MovieClip instance.
		 */
		public function get scenes():Array;
		/**
		 * The total number of frames in the MovieClip instance.
		 */
		public function get totalFrames():int;
		/**
		 * Indicates whether other display objects that are SimpleButton or MovieClip objects can receive
		 *  mouse release events. The trackAsMenu property lets you create menus. You
		 *  can set the trackAsMenu property on any SimpleButton or MovieClip object.
		 *  The default value of the trackAsMenu property is false.
		 */
		public function get trackAsMenu():Boolean;
		public function set trackAsMenu(value:Boolean):void;
		/**
		 * Creates a new MovieClip instance. After creating the MovieClip, call the
		 *  addChild() or addChildAt() method of a
		 *  display object container that is onstage.
		 */
		public function MovieClip();
		/**
		 * Starts playing the SWF file at the specified frame.  This happens after all
		 *  remaining actions in the frame have finished executing.  To specify a scene
		 *  as well as a frame, specify a value for the scene parameter.
		 *
		 * @param frame             <Object> A number representing the frame number, or a string representing the label of the
		 *                            frame, to which the playhead is sent. If you specify a number, it is relative to the
		 *                            scene you specify. If you do not specify a scene, the current scene determines the global frame number to play. If you do specify a scene, the playhead
		 *                            jumps to the frame number in the specified scene.
		 * @param scene             <String (default = null)> The name of the scene to play. This parameter is optional.
		 */
		public function gotoAndPlay(frame:Object, scene:String = null):void;
		/**
		 * Brings the playhead to the specified frame of the movie clip and stops it there.  This happens after all
		 *  remaining actions in the frame have finished executing.  If you want to specify a scene in addition to a frame,
		 *  specify a scene parameter.
		 *
		 * @param frame             <Object> A number representing the frame number, or a string representing the label of the
		 *                            frame, to which the playhead is sent. If you specify a number, it is relative to the
		 *                            scene you specify. If you do not specify a scene, the current scene determines the global frame number at which to go to and stop. If you do specify a scene,
		 *                            the playhead goes to the frame number in the specified scene and stops.
		 * @param scene             <String (default = null)> The name of the scene. This parameter is optional.
		 */
		public function gotoAndStop(frame:Object, scene:String = null):void;
		/**
		 * Sends the playhead to the next frame and stops it.  This happens after all
		 *  remaining actions in the frame have finished executing.
		 */
		public function nextFrame():void;
		/**
		 * Moves the playhead to the next scene of the MovieClip instance.  This happens after all
		 *  remaining actions in the frame have finished executing.
		 */
		public function nextScene():void;
		/**
		 * Moves the playhead in the timeline of the movie clip.
		 */
		public function play():void;
		/**
		 * Sends the playhead to the previous frame and stops it.  This happens after all
		 *  remaining actions in the frame have finished executing.
		 */
		public function prevFrame():void;
		/**
		 * Moves the playhead to the previous scene of the MovieClip instance.  This happens after all
		 *  remaining actions in the frame have finished executing.
		 */
		public function prevScene():void;
		/**
		 * Stops the playhead in the movie clip.
		 */
		public function stop():void;

		// NON-DOCUMENTED (MANUAL ADDITION)
		/**
		 * Attach a callback method to a frame. Note that this will replace any timeline code or 
		 *  previously attached callback.
		 *  The callback method should not expect any parameter.
		 * @param frame             <uint> Target frame number (starting from 0).
		 * @param notify            <Function> Callback method to attach.
		 */
		public function addFrameScript(frame:uint, notify:Function):void;
	}
}
