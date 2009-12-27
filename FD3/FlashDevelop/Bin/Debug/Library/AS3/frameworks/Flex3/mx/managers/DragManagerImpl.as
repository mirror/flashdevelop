package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.EffectInstance;
	import mx.effects.Move;
	import mx.effects.Zoom;
	import mx.events.DragEvent;
	import mx.events.InterManagerRequest;
	import mx.events.InterDragManagerEvent;
	import mx.managers.ISystemManager;
	import mx.managers.dragClasses.DragProxy;
	import mx.managers.SystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class DragManagerImpl implements IDragManager
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
		 *  @private
	 *  The highest place we can listen for events in our DOM
		 */
		private var sandboxRoot : IEventDispatcher;
		/**
		 *  @private
	 *  Object that initiated the drag.
		 */
		private var dragInitiator : IUIComponent;
		/**
		 *  @private
	 *  Object being dragged around.
		 */
		public var dragProxy : DragProxy;
		/**
		 *  @private
		 */
		private var bDoingDrag : Boolean;
		/**
		 *  @private
		 */
		private var mouseIsDown : Boolean;

		/**
		 *  Read-only property that returns <code>true</code>
	 *  if a drag is in progress.
		 */
		public function get isDragging () : Boolean;

		/**
		 *  @private
		 */
		public static function getInstance () : IDragManager;

		/**
		 *  @private
		 */
		public function DragManagerImpl ();

		/**
		 *  Initiates a drag and drop operation.
	 *
	 *  @param dragInitiator IUIComponent that specifies the component initiating
	 *  the drag.
	 *
	 *  @param dragSource DragSource object that contains the data
	 *  being dragged.
	 *
	 *  @param mouseEvent The MouseEvent that contains the mouse information
	 *  for the start of the drag.
	 *
	 *  @param dragImage The image to drag. This argument is optional.
	 *  If omitted, a standard drag rectangle is used during the drag and
	 *  drop operation. If you specify an image, you must explicitly set a 
	 *  height and width of the image or else it will not appear.
	 *
	 *  @param xOffset Number that specifies the x offset, in pixels, for the
	 *  <code>dragImage</code>. This argument is optional. If omitted, the drag proxy
	 *  is shown at the upper-left corner of the drag initiator. The offset is expressed
	 *  in pixels from the left edge of the drag proxy to the left edge of the drag
	 *  initiator, and is usually a negative number.
	 *
	 *  @param yOffset Number that specifies the y offset, in pixels, for the
	 *  <code>dragImage</code>. This argument is optional. If omitted, the drag proxy
	 *  is shown at the upper-left corner of the drag initiator. The offset is expressed
	 *  in pixels from the top edge of the drag proxy to the top edge of the drag
	 *  initiator, and is usually a negative number.
	 *
	 *  @param imageAlpha Number that specifies the alpha value used for the
	 *  drag image. This argument is optional. If omitted, the default alpha
	 *  value is 0.5. A value of 0.0 indicates that the image is transparent;
	 *  a value of 1.0 indicates it is fully opaque.
		 */
		public function doDrag (dragInitiator:IUIComponent, dragSource:DragSource, mouseEvent:MouseEvent, dragImage:IFlexDisplayObject = null, xOffset:Number = 0, yOffset:Number = 0, imageAlpha:Number = 0.5, allowMove:Boolean = true) : void;

		/**
		 *  Call this method from your <code>dragEnter</code> event handler if you accept
	 *  the drag/drop data.
	 *  For example: 
	 *
	 *  <pre>DragManager.acceptDragDrop(event.target);</pre>
	 *
	 *	@param target The drop target accepting the drag.
		 */
		public function acceptDragDrop (target:IUIComponent) : void;

		/**
		 *  Sets the feedback indicator for the drag and drop operation.
	 *  Possible values are <code>DragManager.COPY</code>, <code>DragManager.MOVE</code>,
	 *  <code>DragManager.LINK</code>, or <code>DragManager.NONE</code>.
	 *
	 *  @param feedback The type of feedback indicator to display.
		 */
		public function showFeedback (feedback:String) : void;

		/**
		 *  Returns the current drag and drop feedback.
	 *
	 *  @return  Possible return values are <code>DragManager.COPY</code>, 
	 *  <code>DragManager.MOVE</code>,
	 *  <code>DragManager.LINK</code>, or <code>DragManager.NONE</code>.
		 */
		public function getFeedback () : String;

		/**
		 *  @private
		 */
		public function endDrag () : void;

		/**
		 *  @private
		 */
		private function sm_mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function sm_mouseUpHandler (event:MouseEvent) : void;

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
