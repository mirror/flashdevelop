/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	import flash.events.EventDispatcher;
	import flash.accessibility.AccessibilityProperties;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.geom.Point;
	public class DisplayObject extends EventDispatcher implements IBitmapDrawable {
		/**
		 * The current accessibility options for this display object. If you modify the accessibilityProperties
		 *  property or any of the fields within accessibilityProperties, you must call
		 *  the Accessibility.updateProperties() method to make your changes take effect.
		 */
		public function get accessibilityProperties():AccessibilityProperties;
		public function set accessibilityProperties(value:AccessibilityProperties):void;
		/**
		 * Indicates the alpha transparency value of the object specified.
		 *  Valid values are 0 (fully transparent) to 1 (fully opaque).
		 *  The default value is 1. Display objects with alpha
		 *  set to 0 are active, even though they are invisible.
		 */
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		/**
		 * A value from the BlendMode class that specifies which blend mode to use.
		 *  A bitmap can be drawn internally in two ways. If you have a blend mode enabled or an
		 *  external clipping mask, the bitmap is drawn by adding a bitmap-filled square shape to the vector
		 *  render. If you attempt to set this property to an invalid value, Flash Player or Adobe AIR sets the value
		 *  to BlendMode.NORMAL.
		 */
		public function get blendMode():String;
		public function set blendMode(value:String):void;
		/**
		 * If set to true, Flash Player or Adobe AIR caches an internal bitmap representation of the
		 *  display object. This caching can increase performance for display objects that contain complex
		 *  vector content.
		 */
		public function get cacheAsBitmap():Boolean;
		public function set cacheAsBitmap(value:Boolean):void;
		/**
		 * An indexed array that contains each filter object currently associated with the display object.
		 *  The flash.filters package contains several classes that define specific filters you can
		 *  use.
		 */
		public function get filters():Array;
		public function set filters(value:Array):void;
		/**
		 * Indicates the height of the display object, in pixels. The height is calculated based on the bounds of the content of the display object.
		 */
		public function get height():Number;
		public function set height(value:Number):void;
		/**
		 * Returns a LoaderInfo object containing information about loading the file
		 *  to which this display object belongs. The loaderInfo property is defined only
		 *  for the root display object of a SWF file or for a loaded Bitmap (not for a Bitmap that is drawn
		 *  with ActionScript). To find the loaderInfo object associated with the SWF file that contains
		 *  a display object named myDisplayObject, use myDisplayObject.root.loaderInfo.
		 */
		public function get loaderInfo():LoaderInfo;
		/**
		 * The calling display object is masked by the specified mask object.
		 *  To ensure that masking works when the Stage is scaled, the mask display object
		 *  must be in an active part of the display list. The mask object itself is not drawn.
		 *  Set mask to null to remove the mask.
		 */
		public function get mask():DisplayObject;
		public function set mask(value:DisplayObject):void;
		/**
		 * Indicates the x coordinate of the mouse position, in pixels.
		 */
		public function get mouseX():Number;
		/**
		 * Indicates the y coordinate of the mouse position, in pixels.
		 */
		public function get mouseY():Number;
		/**
		 * Indicates the instance name of the DisplayObject. The object can be identified in
		 *  the child list of its parent display object container by calling the
		 *  getChildByName() method of the display object container.
		 */
		public function get name():String;
		public function set name(value:String):void;
		/**
		 * Specifies whether the display object is opaque with a certain background color.
		 *  A transparent bitmap contains alpha
		 *  channel data and is drawn transparently. An opaque bitmap has no alpha channel (and renders faster
		 *  than a transparent bitmap). If the bitmap is opaque, you specify its own background color to use.
		 */
		public function get opaqueBackground():Object;
		public function set opaqueBackground(value:Object):void;
		/**
		 * Indicates the DisplayObjectContainer object that contains this display object. Use the parent
		 *  property to specify a relative path to display objects that are above the
		 *  current display object in the display list hierarchy.
		 */
		public function get parent():DisplayObjectContainer;
		/**
		 * For a display object in a loaded SWF file, the root property is the
		 *  top-most display object in the portion of the display list's tree structure represented by that SWF file.
		 *  For a Bitmap object representing a loaded image file, the root property is the Bitmap object
		 *  itself. For the instance of the main class of the first SWF file loaded, the root property is the
		 *  display object itself. The root property of the Stage object is the Stage object itself. The root
		 *  property is set to null for any display object that has not been added to the display list, unless
		 *  it has been added to a display object container that is off the display list but that is a child of the
		 *  top-most display object in a loaded SWF file.
		 */
		public function get root():DisplayObject;
		/**
		 * Indicates the rotation of the DisplayObject instance, in degrees, from its original orientation. Values from 0 to 180 represent
		 *  clockwise rotation; values from 0 to -180 represent counterclockwise rotation. Values outside this range are added to or
		 *  subtracted from 360 to obtain a value within the range. For example, the statement my_video.rotation = 450 is the
		 *  same as  my_video.rotation = 90.
		 */
		public function get rotation():Number;
		public function set rotation(value:Number):void;
		/**
		 * The current scaling grid that is in effect. If set to null,
		 *  the entire display object is scaled normally when any scale transformation is
		 *  applied.
		 */
		public function get scale9Grid():Rectangle;
		public function set scale9Grid(value:Rectangle):void;
		/**
		 * Indicates the horizontal scale (percentage) of the object as applied from the registration point. The default
		 *  registration point is (0,0). 1.0 equals 100% scale.
		 */
		public function get scaleX():Number;
		public function set scaleX(value:Number):void;
		/**
		 * Indicates the vertical scale (percentage) of an object as applied from the registration point of the object. The
		 *  default registration point is (0,0). 1.0 is 100% scale.
		 */
		public function get scaleY():Number;
		public function set scaleY(value:Number):void;
		/**
		 * The scroll rectangle bounds of the display object. The display object is cropped to the size
		 *  defined by the rectangle, and it scrolls within the rectangle when you change the
		 *  x and y properties of the scrollRect object.
		 */
		public function get scrollRect():Rectangle;
		public function set scrollRect(value:Rectangle):void;
		/**
		 * The Stage of the display object. A Flash application has only one Stage object.
		 *  For example, you can create and load multiple display objects into the display list, and the
		 *  stage property of each display object refers to the same Stage object (even if the
		 *  display object belongs to a loaded SWF file).
		 */
		public function get stage():Stage;
		/**
		 * An object with properties pertaining to a display object's matrix, color transform, and pixel bounds.
		 *  The specific properties - matrix, colorTransform, and three read-only properties
		 *  (concatenatedMatrix, concatenatedColorTransform,
		 *  and pixelBounds) - are described in the entry for the Transform class.
		 */
		public function get transform():Transform;
		public function set transform(value:Transform):void;
		/**
		 * Whether or not the display object is visible. Display objects that are not visible
		 *  are disabled. For example, if visible=false for an InteractiveObject instance,
		 *  it cannot be clicked.
		 */
		public function get visible():Boolean;
		public function set visible(value:Boolean):void;
		/**
		 * Indicates the width of the display object, in pixels. The width is calculated based on the bounds of the content of the display object.
		 */
		public function get width():Number;
		public function set width(value:Number):void;
		/**
		 * Indicates the x coordinate of the DisplayObject instance relative to the local coordinates of
		 *  the parent DisplayObjectContainer. If the object is inside a DisplayObjectContainer that has
		 *  transformations, it is in the local coordinate system of the enclosing DisplayObjectContainer.
		 *  Thus, for a DisplayObjectContainer rotated 90° counterclockwise, the DisplayObjectContainer's
		 *  children inherit a coordinate system that is rotated 90° counterclockwise.
		 *  The object's coordinates refer to the registration point position.
		 */
		public function get x():Number;
		public function set x(value:Number):void;
		/**
		 * Indicates the y coordinate of the DisplayObject instance relative to the local coordinates of
		 *  the parent DisplayObjectContainer. If the object is inside a DisplayObjectContainer that has
		 *  transformations, it is in the local coordinate system of the enclosing DisplayObjectContainer.
		 *  Thus, for a DisplayObjectContainer rotated 90° counterclockwise, the DisplayObjectContainer's
		 *  children inherit a coordinate system that is rotated 90° counterclockwise.
		 *  The object's coordinates refer to the registration point position.
		 */
		public function get y():Number;
		public function set y(value:Number):void;
		/**
		 * Returns a rectangle that defines the area of the display object relative to the coordinate system
		 *  of the targetCoordinateSpace object.
		 *
		 * @param targetCoordinateSpace<DisplayObject> The display object that defines the coordinate system to use.
		 * @return                  <Rectangle> The rectangle that defines the area of the display object relative to
		 *                            the targetCoordinateSpace object's coordinate system.
		 */
		public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle;
		/**
		 * Returns a rectangle that defines the boundary of the display object,
		 *  based on the coordinate system defined by the targetCoordinateSpace
		 *  parameter, excluding any strokes on shapes. The values that the getRect() method
		 *  returns are the same or smaller than those returned by the getBounds() method.
		 *
		 * @param targetCoordinateSpace<DisplayObject> The display object that defines the coordinate system to use.
		 * @return                  <Rectangle> The rectangle that defines the area of the display object relative to
		 *                            the targetCoordinateSpace object's coordinate system.
		 */
		public function getRect(targetCoordinateSpace:DisplayObject):Rectangle;
		/**
		 * Converts the point object from the Stage (global) coordinates
		 *  to the display object's (local) coordinates.
		 *
		 * @param point             <Point> An object created with the Point class. The Point object
		 *                            specifies the x and y coordinates as properties.
		 * @return                  <Point> A Point object with coordinates relative to the display object.
		 */
		public function globalToLocal(point:Point):Point;
		/**
		 * Evaluates the display object to see if it overlaps or intersects with the
		 *  obj display object.
		 *
		 * @param obj               <DisplayObject> The display object to test against.
		 * @return                  <Boolean> true if the display objects intersect; false if not.
		 */
		public function hitTestObject(obj:DisplayObject):Boolean;
		/**
		 * Evaluates the display object to see if it overlaps or intersects with the
		 *  point specified by the x and y parameters.
		 *  The x and y parameters specify a point in the
		 *  coordinate space of the Stage, not the display object container that contains the
		 *  display object (unless that display object container is the Stage).
		 *
		 * @param x                 <Number> The x coordinate to test against this object.
		 * @param y                 <Number> The y coordinate to test against this object.
		 * @param shapeFlag         <Boolean (default = false)> Whether to check against the actual pixels of the object (true)
		 *                            or the bounding box (false).
		 * @return                  <Boolean> true if the display object overlaps or intersects with the specified point;
		 *                            false otherwise.
		 */
		public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean;
		/**
		 * Converts the point object from the display object's (local) coordinates to the
		 *  Stage (global) coordinates.
		 *
		 * @param point             <Point> The name or identifier of a point created with the Point class, specifying the
		 *                            x and y coordinates as properties.
		 * @return                  <Point> A Point object with coordinates relative to the Stage.
		 */
		public function localToGlobal(point:Point):Point;
		/**
		 * Returns the string representation of the specified object.
		 *
		 * @return                  <String> A string representation of the object.
		 */
		public function toString():String
	}
}
