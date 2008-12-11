package flash.geom
{
	/// A Rectangle object is an area defined by its position, as indicated by its top-left corner point (x, y) and by its width and its height.
	public class Rectangle
	{
		/// The x coordinate of the top-left corner of the rectangle.
		public var x:Number;

		/// The y coordinate of the top-left corner of the rectangle.
		public var y:Number;

		/// The width of the rectangle, in pixels.
		public var width:Number;

		/// The height of the rectangle, in pixels.
		public var height:Number;

		/// The x coordinate of the top-left corner of the rectangle.
		public var left:Number;

		/// The sum of the x and width properties.
		public var right:Number;

		/// The y coordinate of the top-left corner of the rectangle.
		public var top:Number;

		/// The sum of the y and height properties.
		public var bottom:Number;

		/// The location of the Rectangle object's top-left corner, determined by the x and y coordinates of the point.
		public var topLeft:flash.geom.Point;

		/// The location of the Rectangle object's bottom-right corner, determined by the values of the right and bottom properties.
		public var bottomRight:flash.geom.Point;

		/// The size of the Rectangle object, expressed as a Point object with the values of the width and height properties.
		public var size:flash.geom.Point;

		/// Creates a new Rectangle object with the top-left corner specified by the x and y parameters and with the specified width and height.
		public function Rectangle(x:Number=0, y:Number=0, width:Number=0, height:Number=0);

		/// Returns a copy of this Rectangle object.
		public function clone():flash.geom.Rectangle;

		/// Determines whether or not this Rectangle object is empty.
		public function isEmpty():Boolean;

		/// Sets all properties to 0.
		public function setEmpty():void;

		/// Increases the size of the Rectangle object by the specified amounts, in pixels.
		public function inflate(dx:Number, dy:Number):void;

		/// Increases the size of the Rectangle object using a Point object as a parameter.
		public function inflatePoint(point:flash.geom.Point):void;

		/// Adjusts the location of the Rectangle object.
		public function offset(dx:Number, dy:Number):void;

		/// Adjusts the location of the Rectangle object using a Point object as a parameter.
		public function offsetPoint(point:flash.geom.Point):void;

		/// Determines if the specified point is contained within the rectangular region.
		public function contains(x:Number, y:Number):Boolean;

		/// Determines if the specified point is contained within the rectangular region defined by this Rectangle object using a Point object as a parameter.
		public function containsPoint(point:flash.geom.Point):Boolean;

		/// Determines if the Rectangle object specified by the rect parameter is contained within this Rectangle object.
		public function containsRect(rect:flash.geom.Rectangle):Boolean;

		/// Returns the area of intersection.
		public function intersection(toIntersect:flash.geom.Rectangle):flash.geom.Rectangle;

		/// Determines if the object specified in the toIntersect parameter intersects with this Rectangle object.
		public function intersects(toIntersect:flash.geom.Rectangle):Boolean;

		/// Adds two rectangles together to create a new Rectangle object.
		public function union(toUnion:flash.geom.Rectangle):flash.geom.Rectangle;

		/// Determines if the object specified in the toCompare parameter is equal to this Rectangle object.
		public function equals(toCompare:flash.geom.Rectangle):Boolean;

		/// Builds and returns a string that lists the horizontal and vertical positions and the width and height of the Rectangle object.
		public function toString():String;

	}

}

