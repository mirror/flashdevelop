package mx.managers
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import mx.core.IChildList;
	import mx.core.mx_internal;

	/**
	 *  @private *  A SystemManager has various types of children, *  such as the Application, popups,  *  tooltips, and custom cursors. *  You can access the just the custom cursors through *  the <code>cursors</code> property, *  the tooltips via <code>toolTips</code>, and *  the popups via <code>popUpChildren</code>.  Each one returns *  a SystemChildrenList which implements IChildList.  The SystemManager's *  IChildList methods return the set of children that aren't popups, tooltips *  or cursors.  To get the list of all children regardless of type, you *  use the rawChildrenList property which returns this SystemRawChildrenList.
	 */
	public class SystemRawChildrenList implements IChildList
	{
		/**
		 *  @private
		 */
		private var owner : SystemManager;

		/**
		 *  @copy mx.core.IChildList#numChildren
		 */
		public function get numChildren () : int;

		/**
		 *  Constructor.
		 */
		public function SystemRawChildrenList (owner:SystemManager);
		/**
		 *  @copy mx.core.IChildList#getChildAt
		 */
		public function getChildAt (index:int) : DisplayObject;
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
