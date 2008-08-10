/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	public interface IChildList {
		/**
		 * The number of children in this child list.
		 */
		public function get numChildren():int;
		/**
		 * Adds a child DisplayObject after the end of this child list.
		 *
		 * @param child             <DisplayObject> The DisplayObject to add as a child.
		 * @return                  <DisplayObject> The child that was added; this is the same
		 *                            as the argument passed in.
		 */
		public function addChild(child:DisplayObject):DisplayObject;
		/**
		 * Adds a child DisplayObject to this child list at the index specified.
		 *  An index of 0 represents the beginning of the DisplayList,
		 *  and an index of numChildren represents the end.
		 *
		 * @param child             <DisplayObject> The DisplayObject to add as a child.
		 * @param index             <int> The index to add the child at.
		 * @return                  <DisplayObject> The child that was added; this is the same
		 *                            as the child argument passed in.
		 */
		public function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * Determines if a DisplayObject is in this child list,
		 *  or is a descendant of an child in this child list.
		 *
		 * @param child             <DisplayObject> The DisplayObject to test.
		 * @return                  <Boolean> true if the DisplayObject is in this child list
		 *                            or is a descendant of an child in this child list;
		 *                            false otherwise.
		 */
		public function contains(child:DisplayObject):Boolean;
		/**
		 * Gets the child DisplayObject at the specified index in this child list.
		 *
		 * @param index             <int> An integer from 0 to (numChildren - 1)
		 *                            that specifies the index of a child in this child list.
		 * @return                  <DisplayObject> The child at the specified index.
		 */
		public function getChildAt(index:int):DisplayObject;
		/**
		 * Gets the child DisplayObject with the specified name
		 *  in this child list.
		 *
		 * @param name              <String> The name of the child to return.
		 * @return                  <DisplayObject> The child with the specified name.
		 */
		public function getChildByName(name:String):DisplayObject;
		/**
		 * Gets the index of a specific child in this child list.
		 *
		 * @param child             <DisplayObject> The child whose index to get.
		 * @return                  <int> The index of the child, which is an integer
		 *                            between 0 and (numChildren - 1).
		 */
		public function getChildIndex(child:DisplayObject):int;
		/**
		 * Returns an array of DisplayObjects that lie under the specified point
		 *  and are in this child list.
		 *
		 * @param point             <Point> The point under which to look.
		 * @return                  <Array> An array of object that lie under the specified point
		 *                            that are children of this Container.
		 */
		public function getObjectsUnderPoint(point:Point):Array;
		/**
		 * Removes the specified child DisplayObject from this child list.
		 *
		 * @param child             <DisplayObject> The DisplayObject to remove.
		 * @return                  <DisplayObject> The child that was removed; this is the same
		 *                            as the argument passed in.
		 */
		public function removeChild(child:DisplayObject):DisplayObject;
		/**
		 * Removes the child DisplayObject at the specified index
		 *  from this child list.
		 *
		 * @param index             <int> The child index of the DisplayObject to remove.
		 * @return                  <DisplayObject> The child that was removed.
		 */
		public function removeChildAt(index:int):DisplayObject;
		/**
		 * Changes the index of a particular child in this child list.
		 *  See the getChildIndex() method for a
		 *  description of the child's index.
		 *
		 * @param child             <DisplayObject> The child whose index to set.
		 * @param newIndex          <int> The new index for the specified child.
		 *                            This must be an integer between zero and (numChildren - 1).
		 */
		public function setChildIndex(child:DisplayObject, newIndex:int):void;
	}
}
