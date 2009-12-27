package mx.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import mx.core.IRawChildrenContainer;

include "../core/Version.as"
	/**
	 *  The DisplayUtil utility class is an all-static class with utility methods
 *  related to DisplayObjects.
 *  You do not create instances of the DisplayUtil class;
 *  instead you call static methods such as the 
 *  <code>DisplayUtil.walkDisplayObjects()</code>.
	 */
	public class DisplayUtil
	{
		/**
		 *  Recursively calls the specified function on each node in the specified DisplayObject's tree,
	 *  passing it a reference to that DisplayObject.
	 *  
	 *  @param displayObject The target DisplayObject.
	 *  @param callbackFunction The method to call on each node in the specified DisplayObject's tree.
		 */
		public static function walkDisplayObjects (displayObject:DisplayObject, callbackFunction:Function) : void;
	}
}
