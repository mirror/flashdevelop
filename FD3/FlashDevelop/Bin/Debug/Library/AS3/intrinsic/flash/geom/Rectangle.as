/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.geom {
	public class Rectangle {
		/**
		 * The sum of the y and
		 *  height properties.
		 */
		public function get bottom():Number;
		public function set bottom(value:Number):void;
		/**
		 * The location of the Rectangle object's bottom-right corner, determined by the values of the right and
		 *  bottom properties.
		 */
		public function get bottomRight():Point;
		public function set bottomRight(value:Point):void;
		/**
		 * The height of the rectangle, in pixels. Changing the height value of a Rectangle
		 *  object has no effect on the x, y, and
		 *  width properties.
		 */
		public var height:Number;
		/**
		 * The x coordinate of the top-left corner of the rectangle. Changing
		 *  the left property of a Rectangle object has no effect on the y
		 *  and height properties. However it does affect the width
		 *  property, whereas changing the x value does not affect the
		 *  width property.
		 */
		public function get left():Number;
		public function set left(value:Number):void;
		/**
		 * The sum of the x and
		 *  width properties.
		 */
		public function get right():Number;
		public function set right(value:Number):void;
		/**
		 * The size of the Rectangle object, expressed as a Point object with the values
		 *  of the width and height properties.
		 */
		public function get size():Point;
		public function set size(value:Point):void;
		/**
		 * The y coordinate of the top-left corner of the rectangle. Changing
		 *  the top property of a Rectangle object has no effect on the x
		 *  and width properties. However it does affect the height
		 *  property, whereas changing the y value does not affect the
		 *  height property.
		 */
		public function get top():Number;
		public function set top(value:Number):void;
		/**
		 * The location of the Rectangle object's top-left corner, determined by the x and
		 *  y coordinates of the point.
		 */
		public function get topLeft():Point;
		public function set topLeft(value:Point):void;
		/**
		 * The width of the rectangle, in pixels. Changing the width value of a Rectangle object
		 *  has no effect on the x, y, and height
		 *  properties.
		 */
		public var width:Number;
		/**
		 * The x coordinate of the top-left corner of the rectangle. Changing
		 *  the value of the x property of a Rectangle object has no effect on the
		 *  y,
		 *  width, and height properties.
		 */
		public var x:Number;
		/**
		 * The y coordinate of the top-left corner of the rectangle. Changing
		 *  the value of the y property of a Rectangle object has no effect on the
		 *  x, width, and height properties.
		 */
		public var y:Number;
		/**
		 * Creates a new Rectangle object with the top-left corner specified by the x
		 *  and y parameters and with the specified width and height
		 *  parameters. If you call this function without parameters,
		 *  a rectangle with x, y, width, and height
		 *  properties set to 0 is created.
		 *
		 * @param x                 <Number (default = 0)> The x coordinate of the top-left corner of the rectangle.
		 * @param y                 <Number (default = 0)> The y coordinate of the top-left corner of the rectangle.
		 * @param width             <Number (default = 0)> The width of the rectangle, in pixels.
		 * @param height            <Number (default = 0)> The height of the rectangle, in pixels.
		 */
		public function Rectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0);
		/**
		 * Returns a new Rectangle object with the same values for the x, y,
		 *  width, and height properties as the original Rectangle object.
		 *
		 * @return                  <Rectangle> A new Rectangle object with the same values for the x, y,
		 *                            width, and height properties as the original Rectangle object.
		 */
		public function clone():Rectangle;
		/**
		 * Determines whether the specified point is contained within the rectangular region defined
		 *  by this Rectangle object.
		 *
		 * @param x                 <Number> The x coordinate (horizontal position) of the point.
		 * @param y                 <Number> The y coordinate (vertical position) of the point.
		 * @return                  <Boolean> A value of true if the Rectangle object contains the specified point;
		 *                            otherwise false.
		 */
		public function contains(x:Number, y:Number):Boolean;
		/**
		 * Determines whether the specified point is contained within the rectangular region defined
		 *  by this Rectangle object. This method is similar to the Rectangle.contains() method,
		 *  except that it takes a Point object as a parameter.
		 *
		 * @param point             <Point> The point, as represented by its x and y coordinates.
		 * @return                  <Boolean> A value of true if the Rectangle object contains the specified point;
		 *                            otherwise false.
		 */
		public function containsPoint(point:Point):Boolean;
		/**
		 * Determines whether the Rectangle object specified by the rect parameter is contained
		 *  within this Rectangle object. A Rectangle object is said to contain another if the second
		 *  Rectangle object falls entirely within the boundaries of the first.
		 *
		 * @param rect              <Rectangle> The Rectangle object being checked.
		 * @return                  <Boolean> A value of true if the Rectangle object that you specify is
		 *                            contained by this Rectangle object; otherwise false.
		 */
		public function containsRect(rect:Rectangle):Boolean;
		/**
		 * Determines whether the object specified in the toCompare parameter is
		 *  equal to this Rectangle object. This method compares the x, y,
		 *  width, and height properties of an object against the same properties
		 *  of this Rectangle object.
		 *
		 * @param toCompare         <Rectangle> The rectangle to compare to this Rectangle object.
		 * @return                  <Boolean> A value of true if the object has exactly the same values for the
		 *                            x, y, width, and height properties
		 *                            as this Rectangle object; otherwise false.
		 */
		public function equals(toCompare:Rectangle):Boolean;
		/**
		 * Increases the size of the Rectangle object by the specified amounts, in pixels. The center point of the
		 *  Rectangle object stays the same, and its size increases to the left and right by the
		 *  dx value, and to the top and the bottom by the dy value.
		 *
		 * @param dx                <Number> The value to be added to the left and the right of the Rectangle object. The following
		 *                            equation is used to calculate the new width and position of the rectangle:
		 *                            x -= dx;
		 *                            width += 2 * dx;
		 * @param dy                <Number> The value to be added to the top and the bottom of the Rectangle. The
		 *                            following equation is used to calculate the new height and position of the rectangle:
		 *                            y -= dy;
		 *                            height += 2 * dy;
		 */
		public function inflate(dx:Number, dy:Number):void;
		/**
		 * Increases the size of the Rectangle object.
		 *  This method is similar to the Rectangle.inflate() method
		 *  except it takes a Point object as a parameter.
		 *
		 * @param point             <Point> The x property of this Point object is used to increase the
		 *                            horizontal dimension of the Rectangle object. The y property
		 *                            is used to increase the vertical dimension of the Rectangle object.
		 */
		public function inflatePoint(point:Point):void;
		/**
		 * If the Rectangle object specified in the toIntersect parameter intersects with this Rectangle
		 *  object, returns the area of intersection as a Rectangle object.
		 *  If the rectangles do not intersect, this method returns an empty Rectangle object with its properties
		 *  set to 0.
		 *
		 * @param toIntersect       <Rectangle> The Rectangle object to compare against to see if it intersects with
		 *                            this Rectangle object.
		 * @return                  <Rectangle> A Rectangle object that equals the area of intersection. If the rectangles do not
		 *                            intersect, this method returns an empty Rectangle object; that is, a rectangle with its x,
		 *                            y, width, and height properties set to 0.
		 */
		public function intersection(toIntersect:Rectangle):Rectangle;
		/**
		 * Determines whether the object specified in the toIntersect parameter intersects
		 *  with this Rectangle object. This method checks the x, y,
		 *  width, and height properties of the specified Rectangle object to see
		 *  if it intersects with this Rectangle object.
		 *
		 * @param toIntersect       <Rectangle> The Rectangle object to compare against this Rectangle object.
		 * @return                  <Boolean> A value of true if the specified object intersects with this Rectangle object;
		 *                            otherwise false.
		 */
		public function intersects(toIntersect:Rectangle):Boolean;
		/**
		 * Determines whether or not this Rectangle object is empty.
		 *
		 * @return                  <Boolean> A value of true if the Rectangle object's width or height is less than
		 *                            or equal to 0; otherwise false.
		 */
		public function isEmpty():Boolean;
		/**
		 * Adjusts the location of the Rectangle object, as determined by its top-left corner,
		 *  by the specified amounts.
		 *
		 * @param dx                <Number> Moves the x value of the Rectangle object by this amount.
		 * @param dy                <Number> Moves the y value of the Rectangle object by this amount.
		 */
		public function offset(dx:Number, dy:Number):void;
		/**
		 * Adjusts the location of the Rectangle object using a Point object as a parameter.
		 *  This method is similar to the Rectangle.offset() method, except that it takes a Point
		 *  object as a parameter.
		 *
		 * @param point             <Point> A Point object to use to offset this Rectangle object.
		 */
		public function offsetPoint(point:Point):void;
		/**
		 * Sets all of the Rectangle object's properties to 0. A Rectangle object is empty if its width or
		 *  height is less than or equal to 0.
		 */
		public function setEmpty():void;
		/**
		 * Builds and returns a string that lists the horizontal and vertical positions
		 *  and the width and height of the Rectangle object.
		 *
		 * @return                  <String> A string listing the value of each of the following properties of the Rectangle object:
		 *                            x, y, width, and height.
		 */
		public function toString():String;
		/**
		 * Adds two rectangles together to create a new Rectangle object, by
		 *  filling in the horizontal and vertical space between the two rectangles.
		 *
		 * @param toUnion           <Rectangle> A Rectangle object to add to this Rectangle object.
		 * @return                  <Rectangle> A new Rectangle object that is the union of the two rectangles.
		 */
		public function union(toUnion:Rectangle):Rectangle;
	}
}
