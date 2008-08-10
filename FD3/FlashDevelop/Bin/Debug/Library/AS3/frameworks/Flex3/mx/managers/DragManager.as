/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import mx.core.IUIComponent;
	import mx.core.DragSource;
	import flash.events.MouseEvent;
	import mx.core.IFlexDisplayObject;
	public class DragManager {
		/**
		 * Read-only property that returns true
		 *  if a drag is in progress.
		 */
		public static function get isDragging():Boolean;
		/**
		 * Call this method from your dragEnter event handler if you accept
		 *  the drag/drop data.
		 *
		 * @param target            <IUIComponent> The drop target accepting the drag.
		 */
		public static function acceptDragDrop(target:IUIComponent):void;
		/**
		 * Initiates a drag and drop operation.
		 *
		 * @param dragInitiator     <IUIComponent> IUIComponent that specifies the component initiating
		 *                            the drag.
		 * @param dragSource        <DragSource> DragSource object that contains the data
		 *                            being dragged.
		 * @param mouseEvent        <MouseEvent> The MouseEvent that contains the mouse information
		 *                            for the start of the drag.
		 * @param dragImage         <IFlexDisplayObject (default = null)> The image to drag. This argument is optional.
		 *                            If omitted, a standard drag rectangle is used during the drag and
		 *                            drop operation. If you specify an image, you must explicitly set a
		 *                            height and width of the image or else it will not appear.
		 * @param xOffset           <Number (default = 0)> Number that specifies the x offset, in pixels, for the
		 *                            dragImage. This argument is optional. If omitted, the drag proxy
		 *                            is shown at the upper-left corner of the drag initiator. The offset is expressed
		 *                            in pixels from the left edge of the drag proxy to the left edge of the drag
		 *                            initiator, and is usually a negative number.
		 * @param yOffset           <Number (default = 0)> Number that specifies the y offset, in pixels, for the
		 *                            dragImage. This argument is optional. If omitted, the drag proxy
		 *                            is shown at the upper-left corner of the drag initiator. The offset is expressed
		 *                            in pixels from the top edge of the drag proxy to the top edge of the drag
		 *                            initiator, and is usually a negative number.
		 * @param imageAlpha        <Number (default = 0.5)> Number that specifies the alpha value used for the
		 *                            drag image. This argument is optional. If omitted, the default alpha
		 *                            value is 0.5. A value of 0.0 indicates that the image is transparent;
		 *                            a value of 1.0 indicates it is fully opaque.
		 * @param allowMove         <Boolean (default = true)> 
		 */
		public static function doDrag(dragInitiator:IUIComponent, dragSource:DragSource, mouseEvent:MouseEvent, dragImage:IFlexDisplayObject = null, xOffset:Number = 0, yOffset:Number = 0, imageAlpha:Number = 0.5, allowMove:Boolean = true):void;
		/**
		 * Returns the current drag and drop feedback.
		 *
		 * @return                  <String> Possible return values are DragManager.COPY,
		 *                            DragManager.MOVE,
		 *                            DragManager.LINK, or DragManager.NONE.
		 */
		public static function getFeedback():String;
		/**
		 * Sets the feedback indicator for the drag and drop operation.
		 *  Possible values are DragManager.COPY, DragManager.MOVE,
		 *  DragManager.LINK, or DragManager.NONE.
		 *
		 * @param feedback          <String> The type of feedback indicator to display.
		 */
		public static function showFeedback(feedback:String):void;
		/**
		 * Constant that specifies that the type of drag action is "copy".
		 */
		public static const COPY:String = "copy";
		/**
		 * Constant that specifies that the type of drag action is "link".
		 */
		public static const LINK:String = "link";
		/**
		 * Constant that specifies that the type of drag action is "move".
		 */
		public static const MOVE:String = "move";
		/**
		 * Constant that specifies that the type of drag action is "none".
		 */
		public static const NONE:String = "none";
	}
}
