/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.display.DisplayObject;
	import mx.managers.IFocusManager;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.media.SoundTransform;
	import flash.text.TextSnapshot;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public interface IContainer extends <a href="../../mx/core/IUIComponent.html">IUIComponent</a> , <a href="../../mx/core/IFlexDisplayObject.html">IFlexDisplayObject</a> , <a href="../../flash/display/IBitmapDrawable.html">IBitmapDrawable</a> , <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * Specifies the button mode of this sprite. If true, this
		 *  sprite behaves as a button, which means that it triggers the display
		 *  of the hand cursor when the mouse passes over the sprite and can
		 *  receive a click event if the enter or space keys are pressed
		 *  when the sprite has focus. You can suppress the display of the hand cursor
		 *  by setting the useHandCursor property to false,
		 *  in which case the pointer is displayed.
		 */
		public function get buttonMode():Boolean;
		public function set buttonMode(value:Boolean):void;
		/**
		 * Containers use an internal content pane to control scrolling.
		 *  The creatingContentPane is true while the container is creating
		 *  the content pane so that some events can be ignored or blocked.
		 */
		public function get creatingContentPane():Boolean;
		public function set creatingContentPane(value:Boolean):void;
		/**
		 * The Button control designated as the default button
		 *  for the container.
		 *  When controls in the container have focus, pressing the
		 *  Enter key is the same as clicking this Button control.
		 */
		public var defaultButton:IFlexDisplayObject;
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
		 * Specifies the display object over which the sprite is being dragged, or on
		 *  which the sprite was dropped.
		 */
		public function get dropTarget():DisplayObject;
		/**
		 * Gets the FocusManager that controls focus for this component
		 *  and its peers.
		 *  Each popup has its own focus loop and therefore its own instance
		 *  of a FocusManager.
		 *  To make sure you're talking to the right one, use this method.
		 */
		public function get focusManager():IFocusManager;
		/**
		 * Specifies whether this object displays a focus rectangle. A value of null
		 *  indicates that this object obeys the stageFocusRect property set on the Stage.
		 */
		public function get focusRect():Object;
		public function set focusRect(value:Object):void;
		/**
		 * Specifies the Graphics object that belongs to this sprite where vector
		 *  drawing commands can occur.
		 */
		public function get graphics():Graphics;
		/**
		 * Designates another sprite to serve as the hit area for a sprite. If the hitArea
		 *  property does not exist or the value is null or undefined, the
		 *  sprite itself is used as the hit area. The value of the hitArea property can
		 *  be a reference to a Sprite object.
		 */
		public function get hitArea():Sprite;
		public function set hitArea(value:Sprite):void;
		/**
		 * The current position of the horizontal scroll bar.
		 *  This is equal to the distance in pixels between the left edge
		 *  of the scrollable surface and the leftmost piece of the surface
		 *  that is currently visible.
		 */
		public function get horizontalScrollPosition():Number;
		public function set horizontalScrollPosition(value:Number):void;
		/**
		 * Determines whether or not the children of the object are mouse enabled.
		 *  If an object is mouse enabled, a user can interact with it by using a mouse. The default is true.
		 */
		public function get mouseChildren():Boolean;
		public function set mouseChildren(value:Boolean):void;
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
		 * Returns the number of children of this object.
		 */
		public function get numChildren():int;
		/**
		 * Controls sound within this sprite.
		 */
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		/**
		 * Determines whether the children of the object are tab enabled. Enables or disables tabbing for the
		 *  children of the object. The default is true.
		 */
		public function get tabChildren():Boolean;
		public function set tabChildren(value:Boolean):void;
		/**
		 * The methods here would normally just be in IInteractiveObject,
		 *  but for backward compatibility, their ancestor methods have to be included
		 *  directly into IFlexDisplayObject, so these also have to be kept in
		 *  this separate include file so it can be used in ITextField
		 */
		public var tabEnabled:Boolean;
		/**
		 * Specifies the tab ordering of objects in a SWF file. The tabIndex
		 *  property is -1 by default, meaning no tab index is set for the object.
		 */
		public function get tabIndex():int;
		public function set tabIndex(value:int):void;
		/**
		 * Returns a TextSnapshot object for this DisplayObjectContainer instance.
		 */
		public function get textSnapshot():TextSnapshot;
		/**
		 * A Boolean value that indicates whether the pointing hand (hand cursor) appears when the mouse rolls
		 *  over a sprite in which the buttonMode property is set to true.
		 *  The default value of the useHandCursor property is true.
		 *  If useHandCursor is set to true, the pointing hand used for buttons
		 *  appears when the mouse rolls over a button sprite. If useHandCursor is
		 *  false, the arrow pointer is used instead.
		 */
		public function get useHandCursor():Boolean;
		public function set useHandCursor(value:Boolean):void;
		/**
		 * The current position of the vertical scroll bar.
		 *  This is equal to the distance in pixels between the top edge
		 *  of the scrollable surface and the topmost piece of the surface
		 *  that is currently visible.
		 */
		public function get verticalScrollPosition():Number;
		public function set verticalScrollPosition(value:Number):void;
		/**
		 * Returns an object that has four properties: left,
		 *  top, right, and bottom.
		 *  The value of each property equals the thickness of the chrome
		 *  (visual elements) around the edge of the container.
		 */
		public function get viewMetrics():EdgeMetrics;
		/**
		 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added
		 *  to the front (top) of all other children in this DisplayObjectContainer instance. (To add a child to a
		 *  specific index position, use the addChildAt() method.)
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public function addChild(child:DisplayObject):DisplayObject;
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
		public function addChildAt(child:DisplayObject, index:int):DisplayObject;
		/**
		 * Indicates whether the security restrictions
		 *  would cause any display objects to be omitted from the list returned by calling
		 *  the DisplayObjectContainer.getObjectsUnderPoint() method
		 *  with the specified point point. By default, content from one domain cannot
		 *  access objects from another domain unless they are permitted to do so with a call to the
		 *  Security.allowDomain() method.
		 *
		 * @param point             <Point> The point under which to look.
		 * @return                  <Boolean> true if the point contains child display objects with security restrictions.
		 */
		public function areInaccessibleObjectsUnderPoint(point:Point):Boolean;
		/**
		 * Determines whether the specified display object is a child of the DisplayObjectContainer instance or
		 *  the instance itself.
		 *  The search includes the entire display list including this DisplayObjectContainer instance. Grandchildren,
		 *  great-grandchildren, and so on each return true.
		 *
		 * @param child             <DisplayObject> The child object to test.
		 * @return                  <Boolean> true if the child object is a child of the DisplayObjectContainer
		 *                            or the container itself; otherwise false.
		 */
		public function contains(child:DisplayObject):Boolean;
		/**
		 * Returns the child display object instance that exists at the specified index.
		 *
		 * @param index             <int> The index position of the child object.
		 * @return                  <DisplayObject> The child display object at the specified index position.
		 */
		public function getChildAt(index:int):DisplayObject;
		/**
		 * Returns the child display object that exists with the specified name.
		 *  If more that one child display object has the specified name,
		 *  the method returns the first object in the child list.
		 *
		 * @param name              <String> The name of the child to return.
		 * @return                  <DisplayObject> The child display object with the specified name.
		 */
		public function getChildByName(name:String):DisplayObject;
		/**
		 * Returns the index position of a child DisplayObject instance.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to identify.
		 * @return                  <int> The index position of the child display object to identify.
		 */
		public function getChildIndex(child:DisplayObject):int;
		/**
		 * Returns an array of objects that lie under the specified point and are children
		 *  (or grandchildren, and so on) of this DisplayObjectContainer instance. Any child objects that
		 *  are inaccessible for security reasons are omitted from the returned array. To determine whether
		 *  this security restriction affects the returned array, call the
		 *  areInaccessibleObjectsUnderPoint() method.
		 *
		 * @param point             <Point> The point under which to look.
		 * @return                  <Array> An array of objects that lie under the specified point and are children
		 *                            (or grandchildren, and so on) of this DisplayObjectContainer instance.
		 */
		public function getObjectsUnderPoint(point:Point):Array;
		/**
		 * Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance.
		 *  The parent property of the removed child is set to null
		 *  , and the object is garbage collected if no other
		 *  references to the child exist. The index positions of any display objects above the child in the
		 *  DisplayObjectContainer are decreased by 1.
		 *
		 * @param child             <DisplayObject> The DisplayObject instance to remove.
		 * @return                  <DisplayObject> The DisplayObject instance that you pass in the
		 *                            child parameter.
		 */
		public function removeChild(child:DisplayObject):DisplayObject;
		/**
		 * Removes a child DisplayObject from the specified index position in the child list of
		 *  the DisplayObjectContainer. The parent property of the removed child is set to
		 *  null, and the object is garbage collected if no other references to the child exist. The index
		 *  positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
		 *
		 * @param index             <int> The child index of the DisplayObject to remove.
		 * @return                  <DisplayObject> The DisplayObject instance that was removed.
		 */
		public function removeChildAt(index:int):DisplayObject;
		/**
		 * Changes the  position of an existing child in the display object container.
		 *  This affects the layering of child objects.
		 *
		 * @param child             <DisplayObject> The child DisplayObject instance for which you want to change
		 *                            the index number.
		 * @param index             <int> The resulting index number for the child display object.
		 */
		public function setChildIndex(child:DisplayObject, index:int):void;
		/**
		 * Lets the user drag the specified sprite. The sprite remains draggable until explicitly
		 *  stopped through a call to the Sprite.stopDrag() method, or until
		 *  another sprite is made draggable. Only one sprite is draggable at a time.
		 *
		 * @param lockCenter        <Boolean (default = false)> Specifies whether the draggable sprite is locked to the center of
		 *                            the mouse position (true), or locked to the point where the user first clicked the
		 *                            sprite (false).
		 * @param bounds            <Rectangle (default = null)> Value relative to the coordinates of the Sprite's parent that specify a constraint
		 *                            rectangle for the Sprite.
		 */
		public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		/**
		 * Ends the startDrag() method. A sprite that was made draggable with the
		 *  startDrag() method remains draggable until a
		 *  stopDrag() method is added, or until another
		 *  sprite becomes draggable. Only one sprite is draggable at a time.
		 */
		public function stopDrag():void;
		/**
		 * Swaps the z-order (front-to-back order) of the two specified child objects.  All other child
		 *  objects in the display object container remain in the same index positions.
		 *
		 * @param child1            <DisplayObject> The first child object.
		 * @param child2            <DisplayObject> The second child object.
		 */
		public function swapChildren(child1:DisplayObject, child2:DisplayObject):void;
		/**
		 * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the
		 *  child list. All other child objects in the display object container remain in the same index positions.
		 *
		 * @param index1            <int> The index position of the first child object.
		 * @param index2            <int> The index position of the second child object.
		 */
		public function swapChildrenAt(index1:int, index2:int):void;
	}
}
