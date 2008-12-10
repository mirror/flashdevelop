package mx.core
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 *  @private *  Helper class for the rawChildren property of the Container class. *  For descriptions of the properties and methods, *  see the IChildList interface. * *  @see mx.core.Container
	 */
	public class ContainerRawChildrenList implements IChildList
	{
		/**
		 *  @private
		 */
		private var owner : Container;

		/**
		 *  @private
		 */
		public function get numChildren () : int;

		/**
		 *  @private	 *  Constructor.
		 */
		public function ContainerRawChildrenList (owner:Container);
		/**
		 *  @private
		 */
		public function addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildByName (name:String) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildIndex (child:DisplayObject) : int;
		/**
		 *  @private
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		public function getObjectsUnderPoint (point:Point) : Array;
		/**
		 *  @private
		 */
		public function contains (child:DisplayObject) : Boolean;
	}
}
