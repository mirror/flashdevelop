package mx.managers
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import mx.core.IChildList;
	import mx.core.mx_internal;

	/**
	 *  @private *  A SystemManager has various types of children, *  such as the Application, popups, tooltips, and custom cursors. * *  You can access all the children via the <code>rawChildren</code> property. *  You can access just the popups via <code>popUpChildren</code>, *  the tooltips via <code>toolTipChildren</code>, *  and the custom cursors via <code>cursorChildren</code>. *  Each of these returns a SystemChildrenList which implements IChildList. * *  The SystemChildrenList is given two indices that map *  to a subset of the indices of children within the entire *  set of child indices in the SystemManager. *  It manages the children within those two indices.
	 */
	public class WindowedSystemChildrenList implements IChildList
	{
		/**
		 *  @private
		 */
		private var owner : WindowedSystemManager;
		/**
		 *  @private	 *  Either "noTopMostIndex", "topMostIndex", or "toolTipIndex".	 *  The popUpChildren extends from noTopMostIndex to topMostIndex.	 *  The toolTips extends from topMostIndex to toolTipIndex.	 *  The cursors extends from toolTipIndex to cursorIndex.
		 */
		private var lowerBoundReference : QName;
		/**
		 *  @private	 *  Either "topMostIndex", "toolTipIndex", or "cursorIndex".	 *  The popUpChildren extends from noTopMostIndex to topMostIndex.	 *  The toolTips extends from topMostIndex to toolTipIndex.	 *  The cursors extends from toolTipIndex to cursorIndex.
		 */
		private var upperBoundReference : QName;

		/**
		 *  @copy mx.core.IChildList#numChildren
		 */
		public function get numChildren () : int;

		/**
		 *  Constructor.
		 */
		public function WindowedSystemChildrenList (owner:WindowedSystemManager, lowerBoundReference:QName, upperBoundReference:QName);
		/**
		 *  @copy mx.core.IChildList#addChild
		 */
		public function addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#addChildAt
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#removeChild
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#removeChildAt
		 */
		public function removeChildAt (index:int) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#getChildAt
		 */
		public function getChildAt (index:int) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#getChildByName
		 */
		public function getChildByName (name:String) : DisplayObject;
		/**
		 *  @copy mx.core.IChildList#getChildIndex
		 */
		public function getChildIndex (child:DisplayObject) : int;
		/**
		 *  @copy mx.core.IChildList#setChildIndex
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @copy mx.core.IChildList#getObjectsUnderPoint
		 */
		public function getObjectsUnderPoint (point:Point) : Array;
		/**
		 *  @copy mx.core.IChildList#contains
		 */
		public function contains (child:DisplayObject) : Boolean;
	}
}
