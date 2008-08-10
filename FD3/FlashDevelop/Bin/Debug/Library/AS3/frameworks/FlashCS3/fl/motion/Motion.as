package fl.motion
{
import flash.geom.ColorTransform;
import flash.utils.*;
import flash.filters.*;
import flash.utils.getQualifiedClassName;

/**
* The Motion class stores a keyframe animation sequence that can be applied to a visual object. * The animation data includes position, scale, rotation, skew, color, filters, and easing. * The Motion class has methods for retrieving data at specific points in time, and * interpolating values between keyframes automatically.  * @playerversion Flash 9.0.28.0 * @langversion 3.0 * @keyword Motion, Copy Motion as ActionScript     * @see ../../motionXSD.html Motion XML Elements
*/
public class Motion
{
	/**
	* An object that stores information about the context in which the motion was created,     * such as framerate, dimensions, transformation point, and initial position, scale, rotation and skew.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript
	*/
		public var source : Source;
	/**
	* An array of keyframes that define the motion's behavior over time.     * This property is a sparse array, where a keyframe is placed at an index in the array     * that matches its own index. A motion object with keyframes at 0 and 5 has      * a keyframes array with a length of 6.       * Indices 0 and 5 in the array each contain a keyframe,      * and indices 1 through 4 have null values.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript
	*/
		public var keyframes : Array;
	/**
	* @private
	*/
		private var _keyframesCompact : Array;
	/**
	* @private
	*/
		private var _duration : int;
	/**
	*  @private
	*/
		private static var typeCache : Object;

	/**
	* A compact array of keyframes, where each index is occupied by a keyframe.      * By contrast, a sparse array has empty indices (as in the <code>keyframes</code> property).      * In the compact array, no <code>null</code> values are used to fill indices between keyframes.     * However, the index of a keyframe in <code>keyframesCompact</code> likely does not match its index in the <code>keyframes</code> array.     * <p>This property is primarily used for compatibility with the Flex MXML compiler,     * which generates a compact array from the motion XML.</p>     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript      * @see #keyframes
	*/
		public function get keyframesCompact () : Array;

	/**
	* @private (setter)
	*/
		public function set keyframesCompact (compactArray:Array) : Void;

	/**
	* Controls the Motion instance's length of time, measured in frames.     * The duration cannot be less than the time occupied by the Motion instance's keyframes.     * @default 0     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript
	*/
		public function get duration () : int;

	/**
	* @private (setter)
	*/
		public function set duration (value:int) : Void;

	/**
	* Constructor for Motion instances.     * By default, one initial keyframe is created automatically, with default transform properties.     *     * @param xml Optional E4X XML object defining a Motion instance.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript
	*/
		internal function Motion (xml:XML =null);
	/**
	* @private
	*/
		private function indexOutOfRange (index:int) : Boolean;
	/**
	* Retrieves the keyframe that is currently active at a specific frame in the Motion instance.	 * A frame that is not a keyframe derives its values from the keyframe that preceded it.  	 * 	 * <p>This method can also filter values by the name of a specific tweenables property.	 * You can find the currently active keyframe for <code>x</code>, which may not be	 * the same as the currently active keyframe in general.</p>	 * 	 * @param index The index of a frame in the Motion instance, as an integer greater than or equal to zero.	 *      * @param tweenableName Optional name of a tweenable's property (like <code>"x"</code> or <code>"rotation"</code>).	 * 	 * @return The closest matching keyframe at or before the supplied frame index.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript           * @see fl.motion.Tweenables
	*/
		public function getCurrentKeyframe (index:int, tweenableName:String ='') : Keyframe;
	/**
	* Retrieves the next keyframe after a specific frame in the Motion instance.	 * If a frame is not a keyframe, and is in the middle of a tween, 	 * this method derives its values from both the preceding keyframe and the following keyframe.	 * 	 * <p>This method can also filter by the name of a specific tweenables property.     * This allows you to find the next keyframe for <code>x</code>, which may not be	 * the same as the next keyframe in general.</p>	 * 	 * @param index The index of a frame in the Motion instance, as an integer greater than or equal to zero.	 *      * @param tweenableName Optional name of a tweenable's property (like <code>"x"</code> or <code>"rotation"</code>).	 * 	 * @return The closest matching keyframe after the supplied frame index.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript           * @see fl.motion.Tweenables
	*/
		public function getNextKeyframe (index:int, tweenableName:String ='') : Keyframe;
	/**
	* Sets the value of a specific tweenables property at a given time index in the Motion instance.     * If a keyframe doesn't exist at the index, one is created automatically.     *	 * @param index The time index of a frame in the Motion instance, as an integer greater than zero.	 * If the index is zero, no change is made. 	 * Because the transform properties are relative to the starting transform of the target object,	 * the first frame's values are always default values and should not be changed.     *     * @param tweenableName The name of a tweenable's property (like <code>"x"</code> or <code>"rotation"</code>).     *     * @param value The new value of the tweenable property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript           * @see fl.motion.Tweenables
	*/
		public function setValue (index:int, tweenableName:String, value:Number) : void;
	/**
	* Retrieves an interpolated ColorTransform object at a specific time index in the Motion instance.     *	 * @param index The time index of a frame in the Motion instance, as an integer greater than or equal to zero.     *     * @return The interpolated ColorTransform object.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript       * @see flash.geom.ColorTransform
	*/
		public function getColorTransform (index:int) : ColorTransform;
	/**
	* Retrieves an interpolated array of filters at a specific time index in the Motion instance.     *	 * @param index The time index of a frame in the Motion, as an integer greater than or equal to zero.     *     * @return The interpolated array of filters.      * If there are no applicable filters, returns an empty array.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript       * @see flash.filters
	*/
		public function getFilters (index:Number) : Array;
	/**
	* Retrieves the value for an animation property at a point in time.     *	 * @param index The time index of a frame in the Motion instance, as an integer greater than or equal to zero.     *     * @param tweenableName The name of a tweenable's property (like <code>"x"</code> or <code>"rotation"</code>).     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript       * @see fl.motion.Tweenables
	*/
		public function getValue (index:Number, tweenableName:String) : Number;
	/**
	* Adds a keyframe object to the Motion instance.      *     * @param newKeyframe A keyframe object with an index property already set.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript       * @see fl.motion.Keyframe
	*/
		public function addKeyframe (newKeyframe:Keyframe) : void;
	/**
	* @private
	*/
		private function parseXML (xml:XML) : Motion;
	/**
	* A method needed to create a Motion instance from a string of XML.     *     * @param xmlString A string of motion XML.     *     * @return A new Motion instance.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript
	*/
		public static function fromXMLString (xmlString:String) : Motion;
	/**
	* Blends filters smoothly from one array of filter objects to another.     *      * @param fromFilters The starting array of filter objects.     *     * @param toFilters The ending array of filter objects.     *     * @param progress The percent of the transition as a decimal, where <code>0</code> is the start and <code>1</code> is the end.     *      * @return The interpolated array of filter objects.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript       * @see flash.filters
	*/
		public static function interpolateFilters (fromFilters:Array, toFilters:Array, progress:Number) : Array;
	/**
	* Blends filters smoothly from one filter object to another.     *      * @param fromFilters The starting filter object.     *     * @param toFilters The ending filter object.     *     * @param progress The percent of the transition as a decimal, where <code>0</code> is the start and <code>1</code> is the end.     *      * @return The interpolated filter object.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Motion, Copy Motion as ActionScript       * @see flash.filters
	*/
		public static function interpolateFilter (fromFilter:BitmapFilter, toFilter:BitmapFilter, progress:Number) : BitmapFilter;
	/**
	* @private
	*/
		private static function getTypeInfo (o:*) : XML;
}
}
