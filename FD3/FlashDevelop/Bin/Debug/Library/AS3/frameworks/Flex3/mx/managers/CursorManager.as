/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	public class CursorManager {
		/**
		 * ID of the current custom cursor,
		 *  or NO_CURSOR if the system cursor is showing.
		 */
		public static function get currentCursorID():int;
		public function set currentCursorID(value:int):void;
		/**
		 * The x offset of the custom cursor, in pixels,
		 *  relative to the mouse pointer.
		 */
		public static function get currentCursorXOffset():Number;
		public function set currentCursorXOffset(value:Number):void;
		/**
		 * The y offset of the custom cursor, in pixels,
		 *  relative to the mouse pointer.
		 */
		public static function get currentCursorYOffset():Number;
		public function set currentCursorYOffset(value:Number):void;
		/**
		 * Each mx.core.Window instance in an AIR application has its own CursorManager instance.
		 *  This method returns the CursorManager instance for the main Window instance.
		 */
		public static function getInstance():ICursorManager;
		/**
		 * Makes the cursor invisible.
		 *  Cursor visibility is not reference-counted.
		 *  A single call to the hideCursor() method
		 *  always hides the cursor regardless of how many calls
		 *  to the showCursor() method were made.
		 */
		public static function hideCursor():void;
		/**
		 * Removes all of the cursors from the cursor list
		 *  and restores the system cursor.
		 */
		public static function removeAllCursors():void;
		/**
		 * Removes the busy cursor from the cursor list.
		 *  If other busy cursor requests are still active in the cursor list,
		 *  which means you called the setBusyCursor() method more than once,
		 *  a busy cursor does not disappear until you remove
		 *  all busy cursors from the list.
		 */
		public static function removeBusyCursor():void;
		/**
		 * Removes a cursor from the cursor list.
		 *  If the cursor being removed is the currently displayed cursor,
		 *  the CursorManager displays the next cursor in the list, if one exists.
		 *  If the list becomes empty, the CursorManager displays
		 *  the default system cursor.
		 *
		 * @param cursorID          <int> ID of cursor to remove.
		 */
		public static function removeCursor(cursorID:int):void;
		/**
		 * Displays the busy cursor.
		 *  The busy cursor has a priority of CursorManagerPriority.LOW.
		 *  Therefore, if the cursor list contains a cursor
		 *  with a higher priority, the busy cursor is not displayed
		 *  until you remove the higher priority cursor.
		 *  To create a busy cursor at a higher priority level,
		 *  use the setCursor() method.
		 */
		public static function setBusyCursor():void;
		/**
		 * Creates a new cursor and sets an optional priority for the cursor.
		 *  Adds the new cursor to the cursor list.
		 *
		 * @param cursorClass       <Class> Class of the cursor to display.
		 * @param priority          <int (default = 2)> Integer that specifies
		 *                            the priority level of the cursor.
		 *                            Possible values are CursorManagerPriority.HIGH,
		 *                            CursorManagerPriority.MEDIUM, and CursorManagerPriority.LOW.
		 * @param xOffset           <Number (default = 0)> Number that specifies the x offset
		 *                            of the cursor, in pixels, relative to the mouse pointer.
		 * @param yOffset           <Number (default = 0)> Number that specifies the y offset
		 *                            of the cursor, in pixels, relative to the mouse pointer.
		 * @return                  <int> The ID of the cursor.
		 */
		public static function setCursor(cursorClass:Class, priority:int = 2, xOffset:Number = 0, yOffset:Number = 0):int;
		/**
		 * Makes the cursor visible.
		 *  Cursor visibility is not reference-counted.
		 *  A single call to the showCursor() method
		 *  always shows the cursor regardless of how many calls
		 *  to the hideCursor() method were made.
		 */
		public static function showCursor():void;
		/**
		 * Constant that is the value of currentCursorID property
		 *  when there is no cursor managed by the CursorManager and therefore
		 *  the system cursor is being displayed.
		 */
		public static const NO_CURSOR:int = 0;
	}
}
