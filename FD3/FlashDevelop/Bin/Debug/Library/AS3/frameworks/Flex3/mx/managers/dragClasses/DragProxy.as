package mx.managers.dragClasses
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	import flash.utils.getQualifiedClassName;
	import mx.core.DragSource;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.effects.EffectInstance;
	import mx.effects.Move;
	import mx.effects.Zoom;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.events.InterDragManagerEvent;
	import mx.events.SandboxMouseEvent;
	import mx.events.InterManagerRequest;
	import mx.managers.CursorManager;
	import mx.managers.DragManager;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

include "../../core/Version.as"
	/**
	 *  @private
 *  A helper class for DragManager that displays the drag image
	 */
	public class DragProxy extends UIComponent
	{
		/**
		 *  @private
     *  Class of current cursor being displayed.
		 */
		private var cursorClass : Class;
		/**
		 *  @private
     *  ID of current cursor.
		 */
		private var cursorID : int;
		/**
		 *  @private
     *  Last keyboard event received
		 */
		private var lastKeyEvent : KeyboardEvent;
		/**
		 *  @private
     *  Last Mouse event received
		 */
		private var lastMouseEvent : MouseEvent;
		/**
		 *  @private
     *  Root of sandbox
		 */
		private var sandboxRoot : IEventDispatcher;
		/**
		 *  @private
		 */
		public var dragInitiator : IUIComponent;
		/**
		 *  @private
		 */
		public var dragSource : DragSource;
		/**
		 *  @private
		 */
		public var xOffset : Number;
		/**
		 *  @private
		 */
		public var yOffset : Number;
		/**
		 *  @private
		 */
		public var startX : Number;
		/**
		 *  @private
		 */
		public var startY : Number;
		/**
		 *  @private
		 */
		public var target : DisplayObject;
		/**
		 *  @private
     *  Current drag action - NONE, COPY, MOVE or LINK
		 */
		public var action : String;
		/**
		 *  @private
     *  whether move is allowed or not
		 */
		public var allowMove : Boolean;

		/**
		 *  Constructor.
		 */
		public function DragProxy (dragInitiator:IUIComponent, dragSource:DragSource);

		/**
		 *  @private
		 */
		public function initialize () : void;

		/**
		 *  @private
		 */
		public function showFeedback () : void;

		/**
		 *  @private
		 */
		public function checkKeyEvent (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		public function stage_mouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function dispatchDragEvent (type:String, mouseEvent:MouseEvent, eventTarget:Object) : void;

		/**
		 *  @private
		 */
		private function _dispatchDragEvent (target:DisplayObject, event:DragEvent) : void;

		private function isSameOrChildApplicationDomain (target:Object) : Boolean;

		/**
		 *  @private
		 */
		public function mouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		public function mouseLeaveHandler (event:Event) : void;

		/**
		 *  @private
		 */
		public function mouseUpHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function effectEndHandler (event:EffectEvent) : void;

		/**
		 *  Player doesn't handle this correctly so we have to do it ourselves
		 */
		private static function getObjectsUnderPoint (obj:DisplayObject, pt:Point, arr:Array) : void;
	}
}
