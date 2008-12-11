package flash.display
{
	/// The DisplayObjectContainer class is the base class for all objects that can serve as display object containers on the display list.
	public class DisplayObjectContainer extends flash.display.InteractiveObject
	{
		/// Returns the number of children of this object.
		public var numChildren:int;

		/// Returns a TextSnapshot object for this DisplayObjectContainer instance.
		public var textSnapshot:flash.text.TextSnapshot;

		/// Determines whether the children of the object are tab enabled.
		public var tabChildren:Boolean;

		/// Determines whether or not the children of the object are mouse enabled.
		public var mouseChildren:Boolean;

		/// Calling the new DisplayObjectContainer() constructor throws an ArgumentError exception.
		public function DisplayObjectContainer();

		/// Adds a child object to this DisplayObjectContainer instance.
		public function addChild(child:flash.display.DisplayObject):flash.display.DisplayObject;

		/// Adds a child object to this DisplayObjectContainer instance.
		public function addChildAt(child:flash.display.DisplayObject, index:int):flash.display.DisplayObject;

		/// Removes a child display object from the DisplayObjectContainer instance.
		public function removeChild(child:flash.display.DisplayObject):flash.display.DisplayObject;

		/// Removes a child display object, at the specified index position, from the DisplayObjectContainer instance.
		public function removeChildAt(index:int):flash.display.DisplayObject;

		/// Returns the index number of a child DisplayObject instance.
		public function getChildIndex(child:flash.display.DisplayObject):int;

		/// Changes the index number of an existing child.
		public function setChildIndex(child:flash.display.DisplayObject, index:int):void;

		/// Returns the child display object instance that exists at the specified index.
		public function getChildAt(index:int):flash.display.DisplayObject;

		/// Returns the child display object that exists with the specified name.
		public function getChildByName(name:String):flash.display.DisplayObject;

		/// Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance.
		public function getObjectsUnderPoint(point:flash.geom.Point):Array;

		/// Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point.
		public function areInaccessibleObjectsUnderPoint(point:flash.geom.Point):Boolean;

		/// Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.
		public function contains(child:flash.display.DisplayObject):Boolean;

		/// Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.
		public function swapChildrenAt(index1:int, index2:int):void;

		/// Swaps the z-order (front-to-back order) of the two specified child objects.
		public function swapChildren(child1:flash.display.DisplayObject, child2:flash.display.DisplayObject):void;

	}

}

