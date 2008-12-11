package flash.display
{
	/// The DisplayObject class is the base class for all objects that can be placed on the display list.
	public class DisplayObject extends flash.events.EventDispatcher
	{
		/** 
		 * [broadcast event] Dispatched when the display list is about to be updated and rendered.
		 * @eventType flash.events.Event.RENDER
		 * @eventType flash.events.Event.RENDER
		 */
		[Event(name="render", type="flash.events.Event")]

		/** 
		 * Dispatched when a display object is about to be removed from the display list, either directly or through the removal of a sub tree in which the display object is contained.
		 * @eventType flash.events.Event.REMOVED_FROM_STAGE
		 * @eventType flash.events.Event.REMOVED_FROM_STAGE
		 */
		[Event(name="removedFromStage", type="flash.events.Event")]

		/** 
		 * Dispatched when a display object is about to be removed from the display list.
		 * @eventType flash.events.Event.REMOVED
		 * @eventType flash.events.Event.REMOVED
		 */
		[Event(name="removed", type="flash.events.Event")]

		/** 
		 * [broadcast event] Dispatched when the playhead is exiting the current frame.
		 * @eventType flash.events.Event.EXIT_FRAME
		 * @eventType flash.events.Event.EXIT_FRAME
		 */
		[Event(name="exitFrame", type="flash.events.Event")]

		/** 
		 * [broadcast event] Dispatched after the constructors of frame display objects have run but before frame scripts have run.
		 * @eventType flash.events.Event.FRAME_CONSTRUCTED
		 * @eventType flash.events.Event.FRAME_CONSTRUCTED
		 */
		[Event(name="frameConstructed", type="flash.events.Event")]

		/** 
		 * [broadcast event] Dispatched when the playhead is entering a new frame.
		 * @eventType flash.events.Event.ENTER_FRAME
		 * @eventType flash.events.Event.ENTER_FRAME
		 */
		[Event(name="enterFrame", type="flash.events.Event")]

		/** 
		 * Dispatched when a display object is added to the on stage display list, either directly or through the addition of a sub tree in which the display object is contained.
		 * @eventType flash.events.Event.ADDED_TO_STAGE
		 * @eventType flash.events.Event.ADDED_TO_STAGE
		 */
		[Event(name="addedToStage", type="flash.events.Event")]

		/** 
		 * Dispatched when a display object is added to the display list.
		 * @eventType flash.events.Event.ADDED
		 * @eventType flash.events.Event.ADDED
		 */
		[Event(name="added", type="flash.events.Event")]

		/// For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.
		public var root:flash.display.DisplayObject;

		/// The Stage of the display object.
		public var stage:flash.display.Stage;

		/// Indicates the instance name of the DisplayObject.
		public var name:String;

		/// Indicates the DisplayObjectContainer object that contains this display object.
		public var parent:flash.display.DisplayObjectContainer;

		/// The calling display object is masked by the specified mask object.
		public var mask:flash.display.DisplayObject;

		/// Whether or not the display object is visible.
		public var visible:Boolean;

		/// Indicates the x coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
		public var x:Number;

		/// Indicates the y coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
		public var y:Number;

		/// Indicates the horizontal scale (percentage) of the object as applied from the registration point.
		public var scaleX:Number;

		/// Indicates the vertical scale (percentage) of an object as applied from the registration point of the object.
		public var scaleY:Number;

		/// Indicates the x coordinate of the mouse position, in pixels.
		public var mouseX:Number;

		/// Indicates the y coordinate of the mouse position, in pixels.
		public var mouseY:Number;

		/// Indicates the rotation of the DisplayObject instance, in degrees, from its original orientation.
		public var rotation:Number;

		/// Indicates the x-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
		public var rotationX:Number;

		/// Indicates the y-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
		public var rotationY:Number;

		/// Indicates the alpha transparency value of the object specified.
		public var alpha:Number;

		/// Indicates the width of the display object, in pixels.
		public var width:Number;

		/// Indicates the height of the display object, in pixels.
		public var height:Number;

		/// If set to true, Flash Player caches an internal bitmap representation of the display object.
		public var cacheAsBitmap:Boolean;

		/// Specifies whether the display object is opaque with a certain background color.
		public var opaqueBackground:Object;

		/// The scroll rectangle bounds of the display object.
		public var scrollRect:flash.geom.Rectangle;

		/// An indexed array that contains each filter object currently associated with the display object.
		public var filters:Array;

		/// A value from the BlendMode class that specifies which blend mode to use.
		public var blendMode:String;

		/// An object with properties pertaining to a display object's matrix, color transform, and pixel bounds.
		public var transform:flash.geom.Transform;

		/// The current scaling grid that is in effect.
		public var scale9Grid:flash.geom.Rectangle;

		/// Returns a LoaderInfo object containing information about loading the file to which this display object belongs.
		public var loaderInfo:flash.display.LoaderInfo;

		/// The current accessibility options for this display object.
		public var accessibilityProperties:flash.accessibility.AccessibilityProperties;

		/// Sets a shader that is used for blending the foreground and background.
		public var blendShader:flash.display.Shader;

		/// Converts the point object from Stage (global) coordinates to the display object's (local) coordinates.
		public function globalToLocal(point:flash.geom.Point):flash.geom.Point;

		/// Converts the point object from the display object's (local) coordinates to the Stage (global) coordinates.
		public function localToGlobal(point:flash.geom.Point):flash.geom.Point;

		/// Returns a rectangle that defines the area of the display object relative to the coordinate system of the targetCoordinateSpace object.
		public function getBounds(targetCoordinateSpace:flash.display.DisplayObject):flash.geom.Rectangle;

		/// Returns a rectangle that defines the boundary of the display object, based on the coordinate system defined by the targetCoordinateSpace parameter, excluding any strokes on shapes.
		public function getRect(targetCoordinateSpace:flash.display.DisplayObject):flash.geom.Rectangle;

		/// Evaluates the display object to see if it overlaps or intersects with the display object passed as a parameter.
		public function hitTestObject(obj:flash.display.DisplayObject):Boolean;

		/// Evaluates the display object to see if it overlaps or intersects with a point specified by x and y.
		public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean=false):Boolean;

	}

}

