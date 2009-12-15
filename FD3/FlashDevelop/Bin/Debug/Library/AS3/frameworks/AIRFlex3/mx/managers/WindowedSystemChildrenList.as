package mx.managers
{
	import mx.core.IChildList;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import mx.managers.WindowedSystemManager;

	public class WindowedSystemChildrenList extends Object implements IChildList
	{
		public static const VERSION : String;

		public function get numChildren () : int;

		public function addChild (child:DisplayObject) : DisplayObject;

		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;

		public function contains (child:DisplayObject) : Boolean;

		public function getChildAt (index:int) : DisplayObject;

		public function getChildByName (name:String) : DisplayObject;

		public function getChildIndex (child:DisplayObject) : int;

		public function getObjectsUnderPoint (point:Point) : Array;

		public function removeChild (child:DisplayObject) : DisplayObject;

		public function removeChildAt (index:int) : DisplayObject;

		public function setChildIndex (child:DisplayObject, newIndex:int) : void;

		public function WindowedSystemChildrenList (owner:WindowedSystemManager, lowerBoundReference:QName, upperBoundReference:QName);
	}
}
