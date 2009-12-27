package mx.managers.layoutClasses
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import mx.core.IChildList;
	import mx.core.IRawChildrenContainer;
	import mx.managers.ILayoutManagerClient;

include "../../core/Version.as"
	/**
	 *  @private
 *  The PriorityQueue class provides a general purpose priority queue.
 *  It is used internally by the LayoutManager.
	 */
	public class PriorityQueue
	{
		/**
		 *  @private
		 */
		private var arrayOfArrays : Array;
		/**
		 *  @private
	 *  The smallest occupied index in arrayOfArrays.
		 */
		private var minPriority : int;
		/**
		 *  @private
	 *  The largest occupied index in arrayOfArrays.
		 */
		private var maxPriority : int;

		/**
		 *  Constructor.
		 */
		public function PriorityQueue ();

		/**
		 *  @private
		 */
		public function addObject (obj:Object, priority:int) : void;

		/**
		 *  @private
		 */
		public function removeLargest () : Object;

		/**
		 *  @private
		 */
		public function removeLargestChild (client:ILayoutManagerClient) : Object;

		/**
		 *  @private
		 */
		public function removeSmallest () : Object;

		/**
		 *  @private
		 */
		public function removeSmallestChild (client:ILayoutManagerClient) : Object;

		/**
		 *  @private
		 */
		public function removeAll () : void;

		/**
		 *  @private
		 */
		public function isEmpty () : Boolean;

		/**
		 *  @private
		 */
		private function contains (parent:DisplayObject, child:DisplayObject) : Boolean;
	}
}
