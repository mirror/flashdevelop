package flash.desktop
{
	import flash.display.InteractiveObject;
	import flash.desktop.Clipboard;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.desktop.NativeDragOptions;

	/// The NativeDragManager class coordinates drag-and-drop operations.
	public class NativeDragManager extends Object
	{
		/// [AIR] The interactive object passed to the NativeDragManager.doDrag() call that initiated the drag operation.
		public static function get dragInitiator () : InteractiveObject;

		/// [AIR] The drag action specified by the drop target.
		public static function get dropAction () : String;
		public static function set dropAction (dropAction:String) : void;

		/// [AIR] Reports whether a drag operation is currently in progress.
		public static function get isDragging () : Boolean;

		/// [AIR] Informs the NativeDragManager object that the specified target interactive object can accept a drop corresponding to the current drag event.
		public static function acceptDragDrop (target:InteractiveObject) : void;

		/// [AIR] Starts a drag-and-drop operation.
		public static function doDrag (dragInitiator:InteractiveObject, clipboard:Clipboard, dragImage:BitmapData = null, offset:Point = null, allowedActions:NativeDragOptions = null) : void;

		public function NativeDragManager ();
	}
}
