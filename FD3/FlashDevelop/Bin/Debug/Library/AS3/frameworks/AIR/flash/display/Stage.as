/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.display {
	import flash.geom.Rectangle;
	import flash.text.TextSnapshot;
	import flash.events.Event;
	public class Stage extends DisplayObjectContainer {
		/**
		 * A value from the StageAlign class that specifies the alignment of the stage in
		 *  Flash Player or the browser.
		 */
		public function get align():String;
		public function set align(value:String):void;
		/**
		 */
		public function set cacheAsBitmap(value:Boolean):void;
		/**
		 * A value from the StageDisplayState class that specifies which display state to use. The following
		 *  are valid values:
		 *  StageDisplayState.FULL_SCREEN Sets AIR application or Flash Player to expand the
		 *  stage over the user's entire screen, with keyboard input disabled.
		 *  StageDisplayState.FULL_SCREEN_INTERACTIVE Sets the AIR application to expand the
		 *  stage over the user's entire screen, with keyboard input allowed.
		 *  (Not available for content running in Flash Player.)
		 *  StageDisplayState.NORMAL Sets the player back to the standard stage display mode.
		 */
		public function get displayState():String;
		public function set displayState(value:String):void;
		/**
		 * The interactive object with keyboard focus; or null if focus is not set
		 *  or if the focused object belongs to a security sandbox to which the calling object does not
		 *  have access.
		 */
		public function get focus():InteractiveObject;
		public function set focus(value:InteractiveObject):void;
		/**
		 * Gets and sets the frame rate of the stage. The frame rate is defined as frames per second.
		 *  By default the rate is set to the frame rate of the first SWF file loaded. Valid range for the frame rate
		 *  is from 0.01 to 1000 frames per second.
		 */
		public function get frameRate():Number;
		public function set frameRate(value:Number):void;
		/**
		 * Returns the height of the monitor that will be used when going to full screen size, if that state
		 *  is entered immediately. If the user has multiple monitors, the monitor that's used is the
		 *  monitor that most of the stage is on at the time.
		 */
		public function get fullScreenHeight():uint;
		/**
		 * Sets Flash Player to scale a specific region of the stage to full-screen mode.
		 *  If available, Flash Player scales in hardware, which uses the graphics and video card on a user's computer,
		 *  and generally displays content more quickly than software scaling.
		 */
		public function get fullScreenSourceRect():Rectangle;
		public function set fullScreenSourceRect(value:Rectangle):void;
		/**
		 * Returns the width of the monitor that will be used when going to full screen size, if that state
		 *  is entered immediately. If the user has multiple monitors, the monitor that's used is the
		 *  monitor that most of the stage is on at the time.
		 */
		public function get fullScreenWidth():uint;
		/**
		 * Indicates the height of the display object, in pixels. The height is calculated based on the bounds of the content of the display object.
		 */
		public function get height():Number;
		public function set height(value:Number):void;
		/**
		 * Determines whether or not the children of the object are mouse enabled.
		 *  If an object is mouse enabled, a user can interact with it by using a mouse. The default is true.
		 */
		public function get mouseChildren():Boolean;
		public function set mouseChildren(value:Boolean):void;
		/**
		 * A reference to the NativeWindow object containing this Stage.
		 */
		public function get nativeWindow():NativeWindow;
		/**
		 * Returns the number of children of this object.
		 */
		public function get numChildren():int;
		/**
		 * A value from the StageQuality class that specifies which rendering quality is used.
		 *  The following are valid values:
		 *  StageQuality.LOW-Low rendering quality. Graphics are not
		 *  anti-aliased, and bitmaps are not smoothed. This setting is not supported in Adobe AIR.
		 *  StageQuality.MEDIUM-Medium rendering quality. Graphics are
		 *  anti-aliased using a 2 x 2 pixel grid, but bitmaps are not
		 *  smoothed. This setting is suitable for movies that do not contain text.
		 *  This setting is not supported in Adobe AIR.
		 *  StageQuality.HIGH-High rendering quality. Graphics are anti-aliased
		 *  using a 4 x 4 pixel grid, and bitmaps are smoothed if the movie
		 *  is static. This is the default rendering quality setting that Flash Player uses.
		 *  StageQuality.BEST-Very high rendering quality. Graphics are
		 *  anti-aliased using a 4 x 4 pixel grid and bitmaps are always
		 *  smoothed.
		 */
		public function get quality():String;
		public function set quality(value:String):void;
		/**
		 * A value from the StageScaleMode class that specifies which scale mode to use.
		 *  The following are valid values:
		 *  StageScaleMode.EXACT_FIT-The entire Flash application is
		 *  visible in the specified area without distortion while maintaining the original aspect ratio
		 *  of the application. Borders can appear on two sides of the application.
		 *  StageScaleMode.SHOW_ALL-The entire Flash application is visible in
		 *  the specified area without trying to preserve the original aspect ratio. Distortion can occur.
		 *  StageScaleMode.NO_BORDER-The entire Flash application fills the specified area,
		 *  without distortion but possibly with some cropping, while maintaining the original aspect ratio
		 *  of the application.
		 *  StageScaleMode.NO_SCALE-The entire Flash application is fixed, so that
		 *  it remains unchanged even as the size of the player window changes. Cropping might
		 *  occur if the player window is smaller than the content.
		 */
		public function get scaleMode():String;
		public function set scaleMode(value:String):void;
		/**
		 * Specifies whether to show or hide the default items in the Flash Player
		 *  context menu.
		 */
		public function get showDefaultContextMenu():Boolean;
		public function set showDefaultContextMenu(value:Boolean):void;
		/**
		 * Specifies whether or not objects display a glowing border when they have focus.
		 */
		public function get stageFocusRect():Boolean;
		public function set stageFocusRect(value:Boolean):void;
		/**
		 * The current height, in pixels, of the Stage.
		 */
		public function get stageHeight():int;
		public function set stageHeight(value:int):void;
		/**
		 * Specifies the current width, in pixels, of the Stage.
		 */
		public function get stageWidth():int;
		public function set stageWidth(value:int):void;
		/**
		 * Determines whether the children of the object are tab enabled. Enables or disables tabbing for the
		 *  children of the object. The default is true.
		 */
		public function get tabChildren():Boolean;
		public function set tabChildren(value:Boolean):void;
		/**
		 */
		public function set tabEnabled(value:Boolean):void;
		/**
		 * Returns a TextSnapshot object for this DisplayObjectContainer instance.
		 */
		public function get textSnapshot():TextSnapshot;
		/**
		 * Indicates the width of the display object, in pixels. The width is calculated based on the bounds of the content of the display object.
		 */
		public function get width():Number;
		public function set width(value:Number):void;
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added
		 *  to the front (top) of all other children in this DisplayObjectContainer instance. (To add a child to a
		 *  specific index position, use the addChildAt() method.)
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public override function addChild(child:DisplayObject):DisplayObject;
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer
		 *  instance.  The child is added
		 *  at the index position specified. An index of 0 represents the back (bottom)
		 *  of the display list for this DisplayObjectContainer object.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to add as a child of this
		 *                            DisplayObjectContainer instance.
		 * @param index             <int> The index position to which the child is added. If you specify a
		 *                            currently occupied index position, the child object that exists at that position and all
		 *                            higher positions are moved up one position in the child list.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener
		 *  receives notification of an event. You can register event listeners on all nodes in the
		 *  display list for a specific type of event, phase, and priority.
		 *
		 * @param type              <String> The type of event.
		 * @param listener          <Function> The listener function that processes the event. This function must accept
		 *                            an Event object as its only parameter and must return nothing, as this example shows:
		 *                            function(evt:Event):void
		 *                            The function can have any name.
		 * @param useCapture        <Boolean (default = false)> Determines whether the listener works in the capture phase or the
		 *                            target and bubbling phases. If useCapture is set to true,
		 *                            the listener processes the event only during the capture phase and not in the
		 *                            target or bubbling phase. If useCapture is false, the
		 *                            listener processes the event only during the target or bubbling phase. To listen for
		 *                            the event in all three phases, call addEventListener twice, once with
		 *                            useCapture set to true, then again with
		 *                            useCapture set to false.
		 * @param priority          <int (default = 0)> The priority level of the event listener. The priority is designated by
		 *                            a signed 32-bit integer. The higher the number, the higher the priority. All listeners
		 *                            with priority n are processed before listeners of priority n-1. If two
		 *                            or more listeners share the same priority, they are processed in the order in which they
		 *                            were added. The default priority is 0.
		 * @param useWeakReference  <Boolean (default = false)> Determines whether the reference to the listener is strong or
		 *                            weak. A strong reference (the default) prevents your listener from being garbage-collected.
		 *                            A weak reference does not. Class-level member functions are not subject to garbage
		 *                            collection, so you can set useWeakReference to true for
		 *                            class-level member functions without subjecting them to garbage collection. If you set
		 *                            useWeakReference to true for a listener that is a nested inner
		 *                            function, the function will be garbage-collected and no longer persistent. If you create
		 *                            references to the inner function (save it in another variable) then it is not
		 *                            garbage-collected and stays persistent.
		 */
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		/**
		 * Sets keyboard focus to the interactive object specified by objectToFocus, with
		 *  the focus direction specified by the direction parameter.
		 *
		 * @param objectToFocus     <InteractiveObject> The object to focus, or null to clear the focus from
		 *                            any element on the Stage.
		 * @param direction         <String> The direction from which objectToFocus is being focused.
		 *                            Valid values are enumerated as constants in the FocusDirection class.
		 */
		public function assignFocus(objectToFocus:InteractiveObject, direction:String):void;
		/**
		 * Dispatches an event into the event flow. The event target is the EventDispatcher
		 *  object upon which the dispatchEvent() method is called.
		 *
		 * @param event             <Event> The Event object that is dispatched into the event flow.
		 *                            If the event is being redispatched, a clone of the event is created automatically.
		 *                            After an event is dispatched, its target property cannot be changed, so you
		 *                            must create a new copy of the event for redispatching to work.
		 * @return                  <Boolean> A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called
		 *                            on the event.
		 */
		public override function dispatchEvent(event:Event):Boolean;
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type
		 *  of event. This allows you to determine where an EventDispatcher object has altered
		 *  handling of an event type in the event flow hierarchy. To determine whether a specific
		 *  event type actually triggers an event listener, use willTrigger().
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the specified type is registered;
		 *                            false otherwise.
		 */
		public override function hasEventListener(type:String):Boolean;
		/**
		 * Calling the invalidate() method signals Flash Player to alert display objects
		 *  on the next opportunity it has to render the display list (for example, when the playhead
		 *  advances to a new frame). After you call the invalidate() method, when the display
		 *  list is next rendered, Flash Player sends a render event to each display object that has
		 *  registered to listen for the render event. You must call the invalidate()
		 *  method each time you want Flash Player to send render events.
		 */
		public function invalidate():void;
		/**
		 * Determines whether the Stage.focus property returns null for
		 *  security reasons.
		 *  In other words, isFocusInaccessible returns true if the
		 *  object that has focus belongs to a security sandbox to which the SWF file does not have access.
		 *
		 * @return                  <Boolean> true if the object that has focus belongs to a security sandbox to which
		 *                            the SWF file does not have access.
		 */
		public function isFocusInaccessible():Boolean;
		/**
		 * Removes a child DisplayObject from the specified index position in the child list of
		 *  the DisplayObjectContainer. The parent property of the removed child is set to
		 *  null, and the object is garbage collected if no other references to the child exist. The index
		 *  positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
		 *
		 * @param index             <int> The child index of the DisplayObject to remove.
		 * @return                  <DisplayObject> The DisplayObject instance that was removed.
		 */
		public override function removeChildAt(index:int):DisplayObject;
		/**
		 * Changes the  position of an existing child in the display object container.
		 *  This affects the layering of child objects.
		 *
		 * @param child             <DisplayObject> The child DisplayObject instance for which you want to change
		 *                            the index number.
		 * @param index             <int> The resulting index number for the child display object.
		 */
		public override function setChildIndex(child:DisplayObject, index:int):void;
		/**
		 * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the
		 *  child list. All other child objects in the display object container remain in the same index positions.
		 *
		 * @param index1            <int> The index position of the first child object.
		 * @param index2            <int> The index position of the second child object.
		 */
		public override function swapChildrenAt(index1:int, index2:int):void;
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of
		 *  its ancestors for the specified event type. This method returns true if an
		 *  event listener is triggered during any phase of the event flow when an event of the
		 *  specified type is dispatched to this EventDispatcher object or any of its descendants.
		 *
		 * @param type              <String> The type of event.
		 * @return                  <Boolean> A value of true if a listener of the specified type will be triggered; false otherwise.
		 */
		public override function willTrigger(type:String):Boolean;
	}
}
