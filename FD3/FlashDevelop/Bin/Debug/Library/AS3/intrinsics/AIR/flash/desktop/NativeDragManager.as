package flash.desktop
{
	/// The NativeDragManager class coordinates drag-and-drop operations.
	public class NativeDragManager
	{
		/// [AIR] The drag action specified by the drop target.
		public var dropAction:String;

		/// [AIR] Reports whether a drag operation is currently in progress.
		public var isDragging:Boolean;

		/// [AIR] The interactive object passed to the NativeDragManager.doDrag() call that initiated the drag operation.
		public var dragInitiator:flash.display.InteractiveObject;

		/// [AIR] Informs the NativeDragManager object that the specified target interactive object can accept a drop corresponding to the current drag event.
		public static function acceptDragDrop(target:flash.display.InteractiveObject):void;

		/// [AIR] Starts a drag-and-drop operation.
		public static function doDrag(dragInitiator:flash.display.InteractiveObject, clipboard:flash.desktop.Clipboard, dragImage:flash.display.BitmapData=null, offset:flash.geom.Point=null, allowedActions:flash.desktop.NativeDragOptions=null):void;

	}

}

