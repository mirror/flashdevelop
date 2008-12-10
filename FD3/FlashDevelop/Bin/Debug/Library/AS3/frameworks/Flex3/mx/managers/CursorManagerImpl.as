package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Mouse;
	import mx.core.ApplicationGlobals;
	import mx.core.EventPriority;
	import mx.core.FlexSprite;
	import mx.core.mx_internal;
	import mx.core.IUIComponent;
	import mx.events.InterManagerRequest;
	import mx.events.SandboxMouseEvent;
	import mx.events.SWFBridgeRequest;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	import mx.managers.ISystemManager;

	/**
	 *  @private
	 */
	public class CursorManagerImpl implements ICursorManager
	{
		/**
		 *  @private
		 */
		private static var instance : ICursorManager;
		/**
		 *  @private
		 */
		private var nextCursorID : int;
		/**
		 *  @private
		 */
		private var cursorList : Array;
		/**
		 *  @private
		 */
		private var busyCursorList : Array;
		/**
		 *  @private
		 */
		private var initialized : Boolean;
		/**
		 *  @private
		 */
		private var cursorHolder : Sprite;
		/**
		 *  @private
		 */
		private var currentCursor : DisplayObject;
		/**
		 *  @private
		 */
		private var listenForContextMenu : Boolean;
		/**
		 *  @private
		 */
		private var overTextField : Boolean;
		/**
		 *  @private
		 */
		private var overLink : Boolean;
		/**
		 *  @private
		 */
		private var showSystemCursor : Boolean;
		/**
		 *  @private
		 */
		private var showCustomCursor : Boolean;
		/**
		 *  @private
		 */
		private var systemManager : ISystemManager;
		/**
		 *  @private
		 */
		private var sandboxRoot : IEventDispatcher;
		/**
		 *  @private
		 */
		private var sourceArray : Array;
		/**
		 *  @private
		 */
		private var _currentCursorID : int;
		/**
		 *  @private
		 */
		private var _currentCursorXOffset : Number;
		/**
		 *  @private
		 */
		private var _currentCursorYOffset : Number;

		/**
		 *  ID of the current custom cursor,     *  or CursorManager.NO_CURSOR if the system cursor is showing.
		 */
		public function get currentCursorID () : int;
		/**
		 *  @private
		 */
		public function set currentCursorID (value:int) : void;
		/**
		 *  The x offset of the custom cursor, in pixels,     *  relative to the mouse pointer.     *            *  @default 0
		 */
		public function get currentCursorXOffset () : Number;
		/**
		 *  @private
		 */
		public function set currentCursorXOffset (value:Number) : void;
		/**
		 *  The y offset of the custom cursor, in pixels,     *  relative to the mouse pointer.     *     *  @default 0
		 */
		public function get currentCursorYOffset () : Number;
		/**
		 *  @private
		 */
		public function set currentCursorYOffset (value:Number) : void;

		/**
		 *  @private
		 */
		public static function getInstance () : ICursorManager;
		/**
		 *  @private
		 */
		public function CursorManagerImpl (systemManager:ISystemManager = null);
		/**
		 *  Makes the cursor visible.     *  Cursor visibility is not reference-counted.     *  A single call to the <code>showCursor()</code> method     *  always shows the cursor regardless of how many calls     *  to the <code>hideCursor()</code> method were made.
		 */
		public function showCursor () : void;
		/**
		 *  Makes the cursor invisible.     *  Cursor visibility is not reference-counted.     *  A single call to the <code>hideCursor()</code> method     *  always hides the cursor regardless of how many calls     *  to the <code>showCursor()</code> method were made.
		 */
		public function hideCursor () : void;
		/**
		 *  Creates a new cursor and sets an optional priority for the cursor.     *  Adds the new cursor to the cursor list.     *     *  @param cursorClass Class of the cursor to display.     *     *  @param priority Integer that specifies     *  the priority level of the cursor.     *  Possible values are <code>CursorManagerPriority.HIGH</code>,     *  <code>CursorManagerPriority.MEDIUM</code>, and <code>CursorManagerPriority.LOW</code>.     *     *  @param xOffset Number that specifies the x offset     *  of the cursor, in pixels, relative to the mouse pointer.     *     *  @param yOffset Number that specifies the y offset     *  of the cursor, in pixels, relative to the mouse pointer.     *     *  @param setter The IUIComponent that set the cursor. Necessary (in multi-window environments)      *  to know which window needs to display the cursor.      *      *  @return The ID of the cursor.     *     *  @see mx.managers.CursorManagerPriority
		 */
		public function setCursor (cursorClass:Class, priority:int = 2, xOffset:Number = 0, yOffset:Number = 0) : int;
		/**
		 *  @private
		 */
		private function priorityCompare (a:CursorQueueItem, b:CursorQueueItem) : int;
		/**
		 *  Removes a cursor from the cursor list.     *  If the cursor being removed is the currently displayed cursor,     *  the CursorManager displays the next cursor in the list, if one exists.     *  If the list becomes empty, the CursorManager displays     *  the default system cursor.     *     *  @param cursorID ID of cursor to remove.
		 */
		public function removeCursor (cursorID:int) : void;
		/**
		 *  Removes all of the cursors from the cursor list     *  and restores the system cursor.
		 */
		public function removeAllCursors () : void;
		/**
		 *  Displays the busy cursor.     *  The busy cursor has a priority of CursorManagerPriority.LOW.     *  Therefore, if the cursor list contains a cursor     *  with a higher priority, the busy cursor is not displayed      *  until you remove the higher priority cursor.     *  To create a busy cursor at a higher priority level,     *  use the <code>setCursor()</code> method.
		 */
		public function setBusyCursor () : void;
		/**
		 *  Removes the busy cursor from the cursor list.     *  If other busy cursor requests are still active in the cursor list,     *  which means you called the <code>setBusyCursor()</code> method more than once,     *  a busy cursor does not disappear until you remove     *  all busy cursors from the list.
		 */
		public function removeBusyCursor () : void;
		/**
		 *  @private     *  Decides what cursor to display.
		 */
		private function showCurrentCursor () : void;
		/**
		 *  @private     *  Called by other components if they want to display     *  the busy cursor during progress events.
		 */
		public function registerToUseBusyCursor (source:Object) : void;
		/**
		 *  @private     *  Called by other components to unregister     *  a busy cursor from the progress events.
		 */
		public function unRegisterToUseBusyCursor (source:Object) : void;
		/**
		 *  @private     *  Called when contextMenu is opened
		 */
		private function contextMenu_menuSelectHandler (event:ContextMenuEvent) : void;
		/**
		 *  @private
		 */
		private function mouseOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function findSource (target:Object) : int;
		/**
		 *  @private
		 */
		private function marshalMouseMoveHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  Displays the busy cursor if a component is in a busy state.
		 */
		private function progressHandler (event:ProgressEvent) : void;
		/**
		 *  @private
		 */
		private function completeHandler (event:Event) : void;
		/**
		 *  Marshal cursorManager
		 */
		private function marshalCursorManagerHandler (event:Event) : void;
	}
	/**
	 *  @private
	 */
	internal class CursorQueueItem
	{
		/**
		 *  @private
		 */
		public var cursorID : int;
		/**
		 *  @private
		 */
		public var cursorClass : Class;
		/**
		 *  @private
		 */
		public var priority : int;
		/**
		 *  @private
		 */
		public var systemManager : ISystemManager;
		/**
		 *  @private
		 */
		public var x : Number;
		/**
		 *  @private
		 */
		public var y : Number;

		/**
		 *  Constructor.
		 */
		public function CursorQueueItem ();
	}
}
