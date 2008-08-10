/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.desktop {
	import flash.display.InteractiveObject;
	import flash.display.BitmapData;
	import flash.geom.Point;
	public class NativeDragManager {
		/**
		 * The interactive object passed to the NativeDragManager.doDrag() call that initiated the drag operation.
		 */
		public static function get dragInitiator():InteractiveObject;
		/**
		 * The drag action specified by the drop target.
		 */
		public static function get dropAction():String;
		public function set dropAction(value:String):void;
		/**
		 * Reports whether a drag operation is currently in progress.
		 */
		public static function get isDragging():Boolean;
		/**
		 * Informs the NativeDragManager object that the specified target interactive object can accept a drop
		 *  corresponding to the current drag event.
		 *
		 * @param target            <InteractiveObject> 
		 */
		public static function acceptDragDrop(target:InteractiveObject):void;
		/**
		 * Starts a drag-and-drop operation.
		 *
		 * @param dragInitiator     <InteractiveObject> Typically the object from which the drag gesture began. Receives the nativeDragStart
		 *                            and nativeDragComplete events.
		 * @param clipboard         <Clipboard> The container object for data being dragged.
		 * @param dragImage         <BitmapData (default = null)> An optional proxy image displayed under the mouse pointer
		 *                            during the drag gesture. If null, no image is displayed.
		 * @param offset            <Point (default = null)> The offset between the mouse hotspot and the top left
		 *                            corner of the drag image. Negative coordinates move the image up and
		 *                            to the left in relation to the hotspot. If null, the top
		 *                            left corner of the drag image is positioned at the mouse hotspot.
		 * @param allowedActions    <NativeDragOptions (default = null)> Restricts the drag-and-drop actions allowed for
		 *                            this operation. If null, all actions are allowed.
		 */
		public static function doDrag(dragInitiator:InteractiveObject, clipboard:Clipboard, dragImage:BitmapData = null, offset:Point = null, allowedActions:NativeDragOptions = null):void;
	}
}
