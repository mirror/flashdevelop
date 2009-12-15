package mx.managers
{
	import mx.managers.IDragManager;
	import mx.managers.ISystemManager;
	import flash.events.Event;
	import mx.core.IFlexDisplayObject;
	import flash.events.IEventDispatcher;
	import flash.display.InteractiveObject;
	import flash.desktop.NativeDragOptions;
	import flash.desktop.Clipboard;
	import mx.managers.dragClasses.DragProxy;
	import mx.core.IUIComponent;
	import flash.events.MouseEvent;
	import mx.core.DragSource;
	import mx.events.FlexEvent;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import mx.events.DragEvent;
	import flash.events.NativeDragEvent;

	public class NativeDragManagerImpl extends Object implements IDragManager
	{
		public var dragProxy : DragProxy;

		public function get isDragging () : Boolean;

		public function acceptDragDrop (target:IUIComponent) : void;

		public function doDrag (dragInitiator:IUIComponent, dragSource:DragSource, mouseEvent:MouseEvent, dragImage:IFlexDisplayObject = null, xOffset:Number = 0, yOffset:Number = 0, imageAlpha:Number = 0,5, allowMove:Boolean = true) : void;

		public function endDrag () : void;

		public function getFeedback () : String;

		public static function getInstance () : IDragManager;

		public function NativeDragManagerImpl ();

		public function registerSystemManager (sm:ISystemManager) : void;

		public function showFeedback (feedback:String) : void;

		public function unregisterSystemManager (sm:ISystemManager) : void;
	}
}
