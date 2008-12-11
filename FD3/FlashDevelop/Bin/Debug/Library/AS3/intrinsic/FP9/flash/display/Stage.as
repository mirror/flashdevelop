package flash.display
{
	/// The Stage class represents the main drawing area.
	public class Stage extends flash.display.DisplayObjectContainer
	{
		/** 
		 * Dispatched when the Stage object enters, or leaves, full-screen mode.
		 * @eventType flash.events.FullScreenEvent.FULL_SCREEN
		 * @eventType flash.events.FullScreenEvent.FULL_SCREEN
		 */
		[Event(name="fullScreen", type="flash.events.FullScreenEvent")]

		/** 
		 * Dispatched when the scaleMode property of the Stage object is set to StageScaleMode.NO_SCALE and the SWF file is resized.
		 * @eventType flash.events.Event.RESIZE
		 * @eventType flash.events.Event.RESIZE
		 */
		[Event(name="resize", type="flash.events.Event")]

		/** 
		 * Dispatched by the Stage object when the mouse pointer moves out of the stage area.
		 * @eventType flash.events.Event.MOUSE_LEAVE
		 * @eventType flash.events.Event.MOUSE_LEAVE
		 */
		[Event(name="mouseLeave", type="flash.events.Event")]

		/// Gets and sets the frame rate of the stage.
		public var frameRate:Number;

		/// A value from the StageScaleMode class that specifies which scale mode to use.
		public var scaleMode:String;

		/// A value from the StageAlign class that specifies the alignment of the stage in Flash Player or the browser.
		public var align:String;

		/// Specifies the current width, in pixels, of the Stage.
		public var stageWidth:int;

		/// The current height, in pixels, of the Stage.
		public var stageHeight:int;

		/// Specifies whether to show or hide the default items in the Flash Player context menu.
		public var showDefaultContextMenu:Boolean;

		/// The interactive object with keyboard focus; or null if focus is not set or if the focused object belongs to a security sandbox to which the calling object does not have access.
		public var focus:flash.display.InteractiveObject;

		/// Controls Flash Player color correction for displays.
		public var colorCorrection:String;

		/// Specifies whether Flash Player is running on an operating system that supports color correction and whether the color profile of the main (primary) monitor can be read and understood by Flash Player.
		public var colorCorrectionSupport:String;

		/// Specifies whether or not objects display a glowing border when they have focus.
		public var stageFocusRect:Boolean;

		/// A value from the StageQuality class that specifies which rendering quality is used.
		public var quality:String;

		/// A value from the StageDisplayState class that specifies which display state to use.
		public var displayState:String;

		/// Sets Flash Player to scale a specific region of the stage to full-screen mode.
		public var fullScreenSourceRect:flash.geom.Rectangle;

		/// Returns the width of the monitor that will be used when going to full screen size, if that state is entered immediately.
		public var fullScreenWidth:uint;

		/// Returns the height of the monitor that will be used when going to full screen size, if that state is entered immediately.
		public var fullScreenHeight:uint;

		/// Indicates the width of the display object, in pixels.
		public var width:Number;

		/// Indicates the height of the display object, in pixels.
		public var height:Number;

		/// Returns a TextSnapshot object for this DisplayObjectContainer instance.
		public var textSnapshot:flash.text.TextSnapshot;

		/// Determines whether or not the children of the object are mouse enabled.
		public var mouseChildren:Boolean;

		/// Returns the number of children of this object.
		public var numChildren:int;

		/// Determines whether the children of the object are tab enabled.
		public var tabChildren:Boolean;

		/// Signals Flash Player to update properties of display objects on the next opportunity it has to refresh the Stage.
		public function invalidate():void;

		/// Determines whether the Stage.focus property would return null for security reasons.
		public function isFocusInaccessible():Boolean;

		/// Adds a child DisplayObject instance to this DisplayObjectContainer instance.
		public function addChild(child:flash.display.DisplayObject):flash.display.DisplayObject;

		/// Adds a child DisplayObject instance to this DisplayObjectContainer instance.
		public function addChildAt(child:flash.display.DisplayObject, index:int):flash.display.DisplayObject;

		/// Changes the position of an existing child in the display object container.
		public function setChildIndex(child:flash.display.DisplayObject, index:int):void;

		/// Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void;

		/// Dispatches an event into the event flow.
		public function dispatchEvent(event:flash.events.Event):Boolean;

		/// Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		public function hasEventListener(type:String):Boolean;

		/// Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		public function willTrigger(type:String):Boolean;

		/// Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer.
		public function removeChildAt(index:int):flash.display.DisplayObject;

		/// Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.
		public function swapChildrenAt(index1:int, index2:int):void;

	}

}

