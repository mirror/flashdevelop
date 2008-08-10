package fl.motion
{
import flash.utils.*;
import flash.geom.ColorTransform;
import flash.filters.BitmapFilter;
import flash.display.BlendMode;

/**
* The Keyframe class defines the visual state at a specific time in a motion tween. * The primary animation properties are <code>position</code>, <code>scale</code>, <code>rotation</code>, <code>skew</code>, and <code>color</code>. * A keyframe can, optionally, define one or more of these properties. * For instance, one keyframe may affect only position,  * while another keyframe at a different point in time may affect only scale. * Yet another keyframe may affect all properties at the same time. * Within a motion tween, each time index can have only one keyframe.  * A keyframe also has other properties like <code>blend mode</code>, <code>filters</code>, and <code>cacheAsBitmap</code>, * which are always available. For example, a keyframe always has a blend mode.    * @playerversion Flash 9.0.28.0 * @langversion 3.0 * @keyword Keyframe, Copy Motion as ActionScript     * @see ../../motionXSD.html Motion XML Elements
*/
public class Keyframe
{
	/**
	* @private
	*/
		private var _index : int;
	/**
	* The horizontal position of the target object's transformation point in its parent's coordinate space.     * A value of <code>NaN</code> means that the keyframe does not affect this property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var x : Number;
	/**
	* The vertical position of the target object's transformation point in its parent's coordinate space.     * A value of <code>NaN</code> means that the keyframe does not affect this property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var y : Number;
	/**
	* Indicates the horizontal scale as a percentage of the object as applied from the transformation point.     * A value of <code>1</code> is 100% of normal size.     * A value of <code>NaN</code> means that the keyframe does not affect this property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var scaleX : Number;
	/**
	* Indicates the vertical scale as a percentage of the object as applied from the transformation point.     * A value of <code>1</code> is 100% of normal size.     * A value of <code>NaN</code> means that the keyframe does not affect this property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var scaleY : Number;
	/**
	* Indicates the horizontal skew angle of the target object in degrees as applied from the transformation point.     * A value of <code>NaN</code> means that the keyframe does not affect this property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var skewX : Number;
	/**
	* Indicates the vertical skew angle of the target object in degrees as applied from the transformation point.     * A value of <code>NaN</code> means that the keyframe does not affect this property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var skewY : Number;
	/**
	* An array that contains each tween object to be applied to the target object at a particular keyframe.     * One tween can target all animation properties (as with standard tweens on the Flash authoring tool's timeline),     * or multiple tweens can target individual properties (as with separate custom easing curves).     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var tweens : Array;
	/**
	* An array that contains each filter object to be applied to the target object at a particular keyframe.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var filters : Array;
	/**
	* A color object that adjusts the color transform in the target object.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var color : fl.motion.Color;
	/**
	* A string used to describe the keyframe.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var label : String;
	/**
	* A flag that controls whether scale will be interpolated during a tween.     * If <code>false</code>, the display object will stay the same size during the tween, until the next keyframe.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var tweenScale : Boolean;
	/**
	* Stores the value of the Snap checkbox for motion tweens, which snaps the object to a motion guide.      * This property is used in the Copy and Paste Motion feature in Flash CS3      * but does not affect motion tweens defined using ActionScript.      * It is included here for compatibility with the Flex 2 compiler.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var tweenSnap : Boolean;
	/**
	* Stores the value of the Sync checkbox for motion tweens, which affects graphic symbols only.      * This property is used in the Copy and Paste Motion feature in Flash CS3      * but does not affect motion tweens defined using ActionScript.      * It is included here for compatibility with the Flex 2 compiler.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var tweenSync : Boolean;
	/**
	* Stores the value of the Loop checkbox for motion tweens, which affects graphic symbols only.      * This property is used in the Copy and Paste Motion feature in Flash CS3      * but does not affect motion tweens defined using ActionScript.      * It is included here for compatibility with the Flex 2 compiler.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var loop : String;
	/**
	* Stores the name of the first frame for motion tweens, which affects graphic symbols only.      * This property is used in the Copy and Paste Motion feature in Flash CS3      * but does not affect motion tweens defined using ActionScript.      * It is included here for compatibility with the Flex 2 compiler.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var firstFrame : String;
	/**
	* If set to <code>true</code>, Flash Player caches an internal bitmap representation of the display object.     * Using this property often allows faster rendering than the default use of vectors.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var cacheAsBitmap : Boolean;
	/**
	* A value from the BlendMode class that specifies how Flash Player      * mixes the display object's colors with graphics underneath it.     *      * @see flash.display.BlendMode     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var blendMode : String;
	/**
	* Controls how the target object rotates during a motion tween,     * with a value from the RotateDirection class.	 *     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript              * @see fl.motion.RotateDirection
	*/
		public var rotateDirection : String;
	/**
	* Adds rotation to the target object during a motion tween, in addition to any existing rotation.     * This rotation is dependent on the value of the <code>rotateDirection</code> property,     * which must be set to <code>RotateDirection.CW</code> or <code>RotateDirection.CCW</code>.      * The <code>rotateTimes</code> value must be an integer that is equal to or greater than zero.     *      * <p>For example, if the object would normally rotate from 0 to 40 degrees,     * setting <code>rotateTimes</code> to <code>1</code> and <code>rotateDirection</code> to <code>RotateDirection.CW</code>     * will add a full turn, for a total rotation of 400 degrees.</p>     *      * If <code>rotateDirection</code> is set to <code>RotateDirection.CCW</code>,     * 360 degrees will be <i>subtracted</i> from the normal rotation,     * resulting in a counterclockwise turn of 320 degrees.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var rotateTimes : uint;
	/**
	* If set to <code>true</code>, this property causes the target object to rotate automatically      * to follow the angle of its path.      * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var orientToPath : Boolean;
	/**
	* Indicates that the target object should not be displayed on this keyframe.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public var blank : Boolean;

	/**
	* The keyframe's unique time value in the motion tween. The first frame in a motion tween has an index of <code>0</code>.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public function get index () : int;

	/**
	* @private (setter)
	*/
		public function set index (value:int) : Void;

	/**
	* Indicates the rotation of the target object in degrees      * from its original orientation as applied from the transformation point.     * A value of <code>NaN</code> means that the keyframe does not affect this property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public function get rotation () : Number;

	/**
	* @private (setter)
	*/
		public function set rotation (value:Number) : Void;

	/**
	* Constructor for keyframe instances.     *     * @param xml Optional E4X XML object defining a keyframe in Motion XML format.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		internal function Keyframe (xml:XML =null);
	/**
	* @private
	*/
		private function setDefaults () : void;
	/**
	* Retrieves the value of a specific tweenable property on the keyframe.     *     * @param tweenableName The name of a tweenable property, such as <code>"x"</code>     * or <code>"rotation"</code>.     *     * @return The numerical value of the tweenable property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public function getValue (tweenableName:String) : Number;
	/**
	* Changes the value of a specific tweenable property on the keyframe.     *     * @param tweenableName The name of a tweenable property, such as  <code>"x"</code>     * or <code>"rotation"</code>.     *     * @param newValue A numerical value to assign to the tweenable property.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public function setValue (tweenableName:String, newValue:Number) : void;
	/**
	* @private
	*/
		private function parseXML (xml:XML =null) : Keyframe;
	/**
	* @private
	*/
		private static function splitNumber (valuesString:String) : Array;
	/**
	* @private
	*/
		private static function splitUint (valuesString:String) : Array;
	/**
	* @private
	*/
		private static function splitInt (valuesString:String) : Array;
	/**
	* Retrieves an ITween object for a specific animation property.     *     * @param target The name of the property being tweened.     * @see fl.motion.ITween#target     *     * @return An object that implements the ITween interface.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public function getTween (target:String ='') : ITween;
	/**
	* Indicates whether the keyframe has an influence on a specific animation property.	 *      * @param tweenableName The name of a tweenable property, such as  <code>"x"</code>     * or <code>"rotation"</code>.     * @playerversion Flash 9.0.28.0     * @langversion 3.0     * @keyword Keyframe, Copy Motion as ActionScript
	*/
		public function affectsTweenable (tweenableName:String ='') : Boolean;
}
}
