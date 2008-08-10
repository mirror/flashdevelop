/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	public class InteractiveObject extends DisplayObject {
		/**
		 * Specifies the context menu associated with this object.
		 */
		public function get contextMenu():NativeMenu;
		public function set contextMenu(value:NativeMenu):void;
		/**
		 * Specifies whether the object receives doubleClick events. The default value
		 *  is false, which means that by default an InteractiveObject instance does not receive
		 *  doubleClick events. If the doubleClickEnabled property is set to
		 *  true, the instance receives doubleClick events within its bounds.
		 *  The mouseEnabled property of the InteractiveObject instance must also be
		 *  set to true for the object to receive doubleClick events.
		 */
		public function get doubleClickEnabled():Boolean;
		public function set doubleClickEnabled(value:Boolean):void;
		/**
		 * Specifies whether this object displays a focus rectangle. A value of null
		 *  indicates that this object obeys the stageFocusRect property set on the Stage.
		 */
		public function get focusRect():Object;
		public function set focusRect(value:Object):void;
		/**
		 * Specifies whether this object receives mouse messages. The default value is true,
		 *  which means that by default any InteractiveObject instance that is on the display list
		 *  receives mouse events.
		 *  If mouseEnabled is set to false, the instance does not receive any
		 *  mouse events. Any children of this instance on the display list are not affected. To change
		 *  the mouseEnabled behavior for all children of an object on the display list, use
		 *  flash.display.DisplayObjectContainer.mouseChildren.
		 */
		public function get mouseEnabled():Boolean;
		public function set mouseEnabled(value:Boolean):void;
		/**
		 * Specifies whether this object is in the tab order. If this object is in the tab order,
		 *  the value is true; otherwise, the value is false. By default,
		 *  the value is false, except for the following:
		 *  For a SimpleButton object, the value is true.
		 *  For a TextField object with type = "input", the value is true.
		 *  For a Sprite object or MovieClip object with buttonMode = true, the value is true.
		 */
		public function get tabEnabled():Boolean;
		public function set tabEnabled(value:Boolean):void;
		/**
		 * Specifies the tab ordering of objects in a SWF file. The tabIndex
		 *  property is -1 by default, meaning no tab index is set for the object.
		 */
		public function get tabIndex():int;
		public function set tabIndex(value:int):void;
		/**
		 * Calling the new InteractiveObject() constructor
		 *  throws an ArgumentError exception.
		 *  You can, however, call constructors for the following subclasses of InteractiveObject:
		 *  new SimpleButton()
		 *  new TextField()
		 *  new Loader()
		 *  new Sprite()
		 *  new MovieClip()
		 */
		public function InteractiveObject();
	}
}
