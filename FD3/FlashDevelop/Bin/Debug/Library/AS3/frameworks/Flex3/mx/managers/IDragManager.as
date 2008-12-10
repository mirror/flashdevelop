package mx.managers
{
	import flash.events.MouseEvent;
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;

	/**
	 *  @private
	 */
	public interface IDragManager
	{
		public function get isDragging () : Boolean;

		public function doDrag (dragInitiator:IUIComponent, dragSource:DragSource, mouseEvent:MouseEvent, dragImage:IFlexDisplayObject = null, xOffset:Number = 0, yOffset:Number = 0, imageAlpha:Number = 0.5, allowMove:Boolean = true) : void;
		public function acceptDragDrop (target:IUIComponent) : void;
		public function showFeedback (feedback:String) : void;
		public function getFeedback () : String;
		public function endDrag () : void;
	}
}
