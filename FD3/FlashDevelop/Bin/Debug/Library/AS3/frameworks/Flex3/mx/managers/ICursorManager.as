package mx.managers
{
	import mx.core.IUIComponent;

	/**
	 *  @private
	 */
	public interface ICursorManager
	{
		public function get currentCursorID () : int;
		public function set currentCursorID (value:int) : void;

		public function get currentCursorXOffset () : Number;
		public function set currentCursorXOffset (value:Number) : void;

		public function get currentCursorYOffset () : Number;
		public function set currentCursorYOffset (value:Number) : void;

		public function showCursor () : void;

		public function hideCursor () : void;

		public function setCursor (cursorClass:Class, priority:int = 2, xOffset:Number = 0, yOffset:Number = 0) : int;

		public function removeCursor (cursorID:int) : void;

		public function removeAllCursors () : void;

		public function setBusyCursor () : void;

		public function removeBusyCursor () : void;

		public function registerToUseBusyCursor (source:Object) : void;

		public function unRegisterToUseBusyCursor (source:Object) : void;
	}
}
