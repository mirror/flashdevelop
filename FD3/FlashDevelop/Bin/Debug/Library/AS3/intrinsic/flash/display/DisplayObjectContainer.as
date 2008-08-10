/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	import flash.text.TextSnapshot;
	import flash.geom.Point;
	public class DisplayObjectContainer extends InteractiveObject {
		/**
		 * Determines whether or not the children of the object are mouse enabled.
		 *  If an object is mouse enabled, a user can interact with it by using a mouse. The default is true.
		 */
		public function get mouseChildren():Boolean;
		public function set mouseChildren(value:Boolean):void;
		/**
		 * Returns the number of children of this object.
		 */
		public function get numChildren():int;
		/**
		 * Determines whether the children of the object are tab enabled. Enables or disables tabbing for the
		 *  children of the object. The default is true.
		 */
		public function get tabChildren():Boolean;
		public function set tabChildren(value:Boolean):void;
		/**
		 * Returns a TextSnapshot object for this DisplayObjectContainer instance.
		 */
		public function get textSnapshot():TextSnapshot;
		/**
		 * Calling the new DisplayObjectContainer() constructor throws an
		 *  ArgumentError exception. You can, however, call constructors for
		 *  the following subclasses of DisplayObjectContainer:
		 *  new Loader()
		 *  new Sprite()
		 *  new MovieClip()
		 */
		public function DisplayObjectContainer();
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added
		 *  to the front (top) of all other children in this DisplayObjectContainer instance. (To add a child to a
		 *  specific index position, use the addChildAt() method.)
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public function addChild(child:DisplayObject):DisplayObject;
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer
		 *  instance.  The child is added
		 *  at the index position specified. An index of 0 represents the back (bottom)
		 *  of the display list for this DisplayObjectContainer object.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to add as a child of this
		 *                            DisplayObjectContainer instance.
		 * @param index             <int> The index position to which the child is added. If you specify a
		 *                            currently occupied index position, the child object that exists at that position and all
		 *                            higher positions are moved up one position in the child list.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * Indicates whether the security restrictions
		 *  would cause any display objects to be omitted from the list returned by calling
		 *  the DisplayObjectContainer.getObjectsUnderPoint() method
		 *  with the specified point point. By default, content from one domain cannot
		 *  access objects from another domain unless they are permitted to do so with a call to the
		 *  Security.allowDomain() method.
		 *
		 * @param point             <Point> The point under which to look.
		 * @return                  <Boolean> true if the point contains child display objects with security restrictions.
		 */
		public function areInaccessibleObjectsUnderPoint(point:Point):Boolean;
		/**
		 * Determines whether the specified display object is a child of the DisplayObjectContainer instance or
		 *  the instance itself.
		 *  The search includes the entire display list including this DisplayObjectContainer instance. Grandchildren,
		 *  great-grandchildren, and so on each return true.
		 *
		 * @param child             <DisplayObject> The child object to test.
		 * @return                  <Boolean> true if the child object is a child of the DisplayObjectContainer
		 *                            or the container itself; otherwise false.
		 */
		public function contains(child:DisplayObject):Boolean;
		/**
		 * Returns the child display object instance that exists at the specified index.
		 *
		 * @param index             <int> The index position of the child object.
		 * @return                  <DisplayObject> The child display object at the specified index position.
		 */
		public function getChildAt(index:int):DisplayObject;
		/**
		 * Returns the child display object that exists with the specified name.
		 *  If more that one child display object has the specified name,
		 *  the method returns the first object in the child list.
		 *
		 * @param name              <String> The name of the child to return.
		 * @return                  <DisplayObject> The child display object with the specified name.
		 */
		public function getChildByName(name:String):DisplayObject;
		/**
		 * Returns the index position of a child DisplayObject instance.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to identify.
		 * @return                  <int> The index position of the child display object to identify.
		 */
		public function getChildIndex(child:DisplayObject):int;
		/**
		 * Returns an array of objects that lie under the specified point and are children
		 *  (or grandchildren, and so on) of this DisplayObjectContainer instance. Any child objects that
		 *  are inaccessible for security reasons are omitted from the returned array. To determine whether
		 *  this security restriction affects the returned array, call the
		 *  areInaccessibleObjectsUnderPoint() method.
		 *
		 * @param point             <Point> The point under which to look.
		 * @return                  <Array> An array of objects that lie under the specified point and are children
		 *                            (or grandchildren, and so on) of this DisplayObjectContainer instance.
		 */
		public function getObjectsUnderPoint(point:Point):Array;
		/**
		 * Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.
		 *  The parent property of the removed child is set to null
		 *  , and the object is garbage collected if no other
		 *  references to the child exist. The index positions of any display objects above the child in the
		 *  DisplayObjectContainer are decreased by 1.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to remove.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public function removeChild(child:DisplayObject):DisplayObject;
		/**
		 * Removes a child DisplayObject from the specified index position in the child list of
		 *  the DisplayObjectContainer. The parent property of the removed child is set to
		 *  null, and the object is garbage collected if no other references to the child exist. The index
		 *  positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
		 *
		 * @param index             <int> The child index of the DisplayObject to remove.
		 * @return                  <DisplayObject> The DisplayObject instance that was removed.
		 */
		public function removeChildAt(index:int):DisplayObject;
		/**
		 * Changes the  position of an existing child in the display object container.
		 *  This affects the layering of child objects.
		 *
		 * @param child             <DisplayObject> The child DisplayObject instance for which you want to change
		 *                            the index number.
		 * @param index             <int> The resulting index number for the child display object.
		 */
		public function setChildIndex(child:DisplayObject, index:int):void;
		/**
		 * Swaps the z-order (front-to-back order) of the two specified child objects.  All other child
		 *  objects in the display object container remain in the same index positions.
		 *
		 * @param child1            <DisplayObject> The first child object.
		 * @param child2            <DisplayObject> The second child object.
		 */
		public function swapChildren(child1:DisplayObject, child2:DisplayObject):void;
		/**
		 * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the
		 *  child list. All other child objects in the display object container remain in the same index positions.
		 *
		 * @param index1            <int> The index position of the first child object.
		 * @param index2            <int> The index position of the second child object.
		 */
		public function swapChildrenAt(index1:int, index2:int):void;
	}
}
