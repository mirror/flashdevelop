package mx.managers
{
	import flash.desktop.Clipboard;
	import flash.desktop.NativeDragManager;
	import flash.desktop.NativeDragOptions;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.events.InterManagerRequest;
	import mx.events.InterDragManagerEvent;
	import mx.managers.dragClasses.DragProxy;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

	/**
	 *  @private *  *  @playerversion AIR 1.1
	 */
	public class NativeDragManagerImpl implements IDragManager
	{
		/**
		 *  @private
		 */
		private static var sm : ISystemManager;
		/**
		 *  @private
		 */
		private static var instance : IDragManager;
		/**
		 *  @private	 *  Object being dragged around.
		 */
		public var dragProxy : DragProxy;
		/**
		 *  @private
		 */
		private var mouseIsDown : Boolean;
		private var _action : String;
		/**
		 *  @private
		 */
		private var _dragInitiator : IUIComponent;
		/**
		 *  @private
		 */
		private var _clipboard : Clipboard;
		/**
		 *  @private
		 */
		private var _dragImage : IFlexDisplayObject;
		private var _offset : Point;
		private var _allowedActions : NativeDragOptions;
		private var _allowMove : Boolean;
		private var _relatedObject : InteractiveObject;
		/**
		 *  @private	 *  The highest place we can listen for events in our DOM
		 */
		private var sandboxRoot : IEventDispatcher;

		/**
		 *  Read-only property that returns <code>true</code>	 *  if a drag is in progress.
		 */
		public function get isDragging () : Boolean;

		/**
		 *  @private
		 */
		public static function getInstance () : IDragManager;
		/**
		 *  @private
		 */
		public function NativeDragManagerImpl ();
		/**
		 *  Initiates a drag and drop operation.	 *	 *  @param dragInitiator IUIComponent that specifies the component initiating	 *  the drag.	 *	 *  @param dragSource DragSource object that contains the data	 *  being dragged.	 *	 *  @param mouseEvent The MouseEvent that contains the mouse information	 *  for the start of the drag.	 *	 *  @param dragImage The image to drag. This argument is optional.	 *  If omitted, a standard drag rectangle is used during the drag and	 *  drop operation. If you specify an image, you must explicitly set a 	 *  height and width of the image or else it will not appear.	 *	 *  @param xOffset Number that specifies the x offset, in pixels, for the	 *  <code>dragImage</code>. This argument is optional. If omitted, the drag proxy	 *  is shown at the upper-left corner of the drag initiator. The offset is expressed	 *  in pixels from the left edge of the drag proxy to the left edge of the drag	 *  initiator, and is usually a negative number.	 *	 *  @param yOffset Number that specifies the y offset, in pixels, for the	 *  <code>dragImage</code>. This argument is optional. If omitted, the drag proxy	 *  is shown at the upper-left corner of the drag initiator. The offset is expressed	 *  in pixels from the top edge of the drag proxy to the top edge of the drag	 *  initiator, and is usually a negative number.	 *	 *  @param imageAlpha Number that specifies the alpha value used for the	 *  drag image. This argument is optional. If omitted, the default alpha	 *  value is 0.5. A value of 0.0 indicates that the image is transparent;	 *  a value of 1.0 indicates it is fully opaque.
		 */
		public function doDrag (dragInitiator:IUIComponent, dragSource:DragSource, mouseEvent:MouseEvent, dragImage:IFlexDisplayObject = null, xOffset:Number = 0, yOffset:Number = 0, imageAlpha:Number = 0.5, allowMove:Boolean = true) : void;
		/**
		 *  Finish up the doDrag once the dragImage has been drawn
		 */
		private function initiateDrag (event:FlexEvent, removeImage:Boolean = true) : void;
		/**
		 *  Call this method from your <code>dragEnter</code> event handler if you accept	 *  the drag/drop data.	 *  For example: 	 *	 *  <pre>DragManager.acceptDragDrop(event.target);</pre>	 *	 *	@param target The drop target accepting the drag.
		 */
		public function acceptDragDrop (target:IUIComponent) : void;
		/**
		 *  Sets the feedback indicator for the drag and drop operation.	 *  Possible values are <code>DragManager.COPY</code>, <code>DragManager.MOVE</code>,	 *  <code>DragManager.LINK</code>, or <code>DragManager.NONE</code>.	 *	 *  @param feedback The type of feedback indicator to display.
		 */
		public function showFeedback (feedback:String) : void;
		/**
		 *  Returns the current drag and drop feedback.	 *	 *  @return  Possible return values are <code>DragManager.COPY</code>, 	 *  <code>DragManager.MOVE</code>,	 *  <code>DragManager.LINK</code>, or <code>DragManager.NONE</code>.
		 */
		public function getFeedback () : String;
		/**
		 *  @Review	 *  Not Supported by NativeDragManagerImpl
		 */
		public function endDrag () : void;
		/**
		 *  @private	 *  register ISystemManagers that will listen for events 	 *  (such as those for additional windows)
		 */
		function registerSystemManager (sm:ISystemManager) : void;
		/**
		 *  @private	 *  unregister ISystemManagers that will listen for events 	 *  (such as those for additional windows)
		 */
		function unregisterSystemManager (sm:ISystemManager) : void;
		private function sm_mouseDownHandler (event:MouseEvent) : void;
		private function sm_mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  Listens for all NativeDragEvents and then redispatches them as DragEvents
		 */
		private function nativeDragEventHandler (event:NativeDragEvent) : void;
		/**
		 *  @private
		 */
		private function _dispatchDragEvent (target:DisplayObject, event:DragEvent) : void;
		private function isSameOrChildApplicationDomain (target:Object) : Boolean;
		/**
		 *  Marshal dispatchEvents
		 */
		private function marshalDispatchEventHandler (event:Event) : void;
		/**
		 *  Marshal dragManager
		 */
		private function marshalDragManagerHandler (event:Event) : void;
	}
}
