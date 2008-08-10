package fl.motion
{
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.ColorTransform;

/**
* The Animator class applies an XML description of a motion tween to a display object. * The properties and methods of the Animator class control the playback of the motion, * and Flash Player broadcasts events in response to changes in the motion's status. * The Animator class is primarily used by the Copy Motion as ActionScript command in * Flash CS3. You can then edit the ActionScript using the application programming interface * (API) or construct your own custom animation. * <p>If you plan to call methods of the Animator class within a function, declare the Animator  * instance outside of the function so the scope of the object is not restricted to the  * function itself. If you declare the instance within a function, Flash Player deletes the  * Animator instance at the end of the function as part of Flash Player's routine "garbage collection" * and the target object will not animate.</p> *  * @internal <p><strong>Note:</strong> If you're not using Flash CS3 to compile your SWF file, you ne
*/
public class Animator extends EventDispatcher
{
	/**
	* @private
	*/
		private var _motion : Motion;
	/**
	* Sets the position of the display object along the motion path. If set to <code>true</code>     * the baseline of the display object orients to the motion path; otherwise the registration     * point orients to the motion path.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword orientToPath, orientation
	*/
		public var orientToPath : Boolean;
	/**
	* The point of reference for rotating or scaling a display object. The transformation point is      * relative to the display object's bounding box.     * The point's coordinates must be scaled to a 1px x 1px box, where (1, 1) is the object's lower-right corner,      * and (0, 0) is the object's upper-left corner.       * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword transformationPoint
	*/
		public var transformationPoint : Point;
	/**
	* Sets the animation to restart after it finishes.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword autoRewind, loop
	*/
		public var autoRewind : Boolean;
	/**
	* The Matrix object that applies an overall transformation to the motion path.      * This matrix allows the path to be shifted, scaled, skewed or rotated,      * without changing the appearance of the display object.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword positionMatrix
	*/
		public var positionMatrix : Matrix;
	/**
	*  Number of times to repeat the animation.     *  Possible values are any integer greater than or equal to <code>0</code>.     *  A value of <code>1</code> means to play the animation once.     *  A value of <code>0</code> means to play the animation indefinitely     *  until explicitly stopped (by a call to the <code>end()</code> method, for example).     *     * @default 1     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword repeatCount, repetition, loop        * @see #end()
	*/
		public var repeatCount : int;
	/**
	* @private
	*/
		private var _isPlaying : Boolean;
	/**
	* @private
	*/
		private var _target : DisplayObject;
	/**
	* @private
	*/
		private var _lastRenderedTime : int;
	/**
	* @private
	*/
		private var _time : int;
	/**
	* @private
	*/
		private var playCount : int;
	/**
	* @private
	*/
		private static var enterFrameBeacon : MovieClip;
	/**
	* @private
	*/
		private var targetState : Object;

	/**
	* The object that contains the motion tween properties for the animation.      * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword motion
	*/
		public function get motion () : Motion;

	/**
	* @private (setter)
	*/
		public function set motion (value:Motion) : Void;

	/**
	* Indicates whether the animation is currently playing.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword isPlaying
	*/
		public function get isPlaying () : Boolean;

	/**
	* The display object being animated.      * Any subclass of flash.display.DisplayObject can be used, such as a <code>MovieClip</code>, <code>Sprite</code>, or <code>Bitmap</code>.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword target     * @see flash.display.DisplayObject
	*/
		public function get target () : DisplayObject;

	/**
	* @private (setter)
	*/
		public function set target (value:DisplayObject) : Void;

	/**
	* A zero-based integer that indicates and controls the time in the current animation.      * At the animation's first frame <code>time</code> is <code>0</code>.      * If the animation has a duration of 10 frames, at the last frame <code>time</code> is <code>9</code>.      * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword time
	*/
		public function get time () : int;

	/**
	* @private (setter)
	*/
		public function set time (newTime:int) : Void;

	/**
	* Creates an Animator object to apply the XML-based motion tween description to a display object.     *     * @param xml An E4X object containing an XML-based motion tween description.     *     * @param target The display object using the motion tween.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Animator     * @see ../../motionXSD.html Motion XML Elements
	*/
		internal function Animator (xml:XML =null, target:DisplayObject =null);
	/**
	* Creates an Animator object from a string of XML.      * This method is an alternative to using the Animator constructor, which accepts an E4X object instead.     *     * @param xmlString A string of XML describing the motion tween.     *     * @param target The display object using the motion tween.     *     * @return An Animator instance that applies the specified <code>xmlString</code> to the specified <code>target</code>.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword createFromXMLString, Animator     * @see ../../motionXSD.html Motion XML Elements
	*/
		public static function fromXMLString (xmlString:String, target:DisplayObject =null) : Animator;
	/**
	* Advances Flash Player to the next frame in the animation sequence.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword nextFrame
	*/
		public function nextFrame () : void;
	/**
	*  Begins the animation. Call the <code>end()</code> method      *  before you call the <code>play()</code> method to ensure that any previous      *  instance of the animation has ended before you start a new one.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword play, begin     * @see #end()
	*/
		public function play () : void;
	/**
	*  Stops the animation and Flash Player goes immediately to the last frame in the animation sequence.      *  If the <code>autoRewind</code> property is set to <code>true</code>, Flash Player goes to the first     * frame in the animation sequence.      * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword end, stop     * @see #autoRewind
	*/
		public function end () : void;
	/**
	*  Stops the animation and Flash Player goes back to the first frame in the animation sequence.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword stop, end     * @see #end()
	*/
		public function stop () : void;
	/**
	*  Pauses the animation until you call the <code>resume()</code> method.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword pause     * @see #resume()
	*/
		public function pause () : void;
	/**
	*  Resumes the animation after it has been paused      *  by the <code>pause()</code> method.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword resume     * @see #pause()
	*/
		public function resume () : void;
	/**
	* Sets Flash Player to the first frame of the animation.      * If the animation was playing, it continues playing from the first frame.      * If the animation was stopped, it remains stopped at the first frame.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword rewind
	*/
		public function rewind () : void;
	/**
	* @private
	*/
		private function handleLastFrame () : void;
	/**
	* @private
	*/
		private function enterFrameHandler (event:Event) : void;
}
}
