/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.flash {
	import flash.display.MovieClip;
	import mx.core.IDeferredInstantiationUIComponent;
	import mx.managers.IToolTipManagerClient;
	import mx.core.IStateClient;
	import mx.managers.IFocusManagerComponent;
	import mx.core.IConstraintClient;
	import mx.automation.IAutomationObject;
	import flash.geom.Rectangle;
	import mx.core.UIComponentDescriptor;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import mx.managers.ISystemManager;
	import mx.core.IFlexDisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.display.DisplayObject;
	public dynamic  class UIMovieClip extends MovieClip implements IDeferredInstantiationUIComponent, IToolTipManagerClient, IStateClient, IFocusManagerComponent, IConstraintClient, IAutomationObject {
		/**
		 * The delegate object that handles the automation-related functionality.
		 */
		public function get automationDelegate():Object;
		public function set automationDelegate(value:Object):void;
		/**
		 * Name that can be used as an identifier for this object.
		 */
		public function get automationName():String;
		public function set automationName(value:String):void;
		/**
		 * An implementation of the IAutomationTabularData interface, which
		 *  can be used to retrieve the data.
		 */
		public function get automationTabularData():Object;
		/**
		 * This value generally corresponds to the rendered appearance of the
		 *  object and should be usable for correlating the identifier with
		 *  the object as it appears visually within the application.
		 */
		public function get automationValue():Array;
		/**
		 * The vertical distance in pixels from the top edge of the content area
		 *  to the component's baseline position.
		 *  If this property is set, the baseline of the component is anchored
		 *  to the top edge of its content area;
		 *  when its container is resized, the two edges maintain their separation.
		 */
		public function get baseline():*;
		public function set baseline(value:any):void;
		/**
		 * The y-coordinate of the baseline
		 *  of the first line of text of the component.
		 */
		public function get baselinePosition():Number;
		/**
		 * The vertical distance, in pixels, from the lower edge of the component
		 *  to the lower edge of its content area.
		 *  If this property is set, the lower edge of the component is anchored
		 *  to the bottom edge of its content area;
		 *  when its container is resized, the two edges maintain their separation.
		 */
		public function get bottom():*;
		public function set bottom(value:any):void;
		/**
		 * Name of the object to use as the bounding box.
		 */
		public var boundingBoxName:String = "boundingBox";
		/**
		 * The unscaled bounds of the content.
		 */
		protected function get bounds():Rectangle;
		/**
		 * Used by Flex to suggest bitmap caching for the object.
		 *  If cachePolicy is UIComponentCachePolicy.AUTO,
		 *  then cacheHeuristic
		 *  is used to control the object's cacheAsBitmap property.
		 */
		public function set cacheHeuristic(value:Boolean):void;
		/**
		 * Specifies the bitmap caching policy for this object.
		 *  Possible values in MXML are "on",
		 *  "off" and
		 *  "auto" (default).
		 */
		public function get cachePolicy():String;
		/**
		 * The current state of this component. For UIMovieClip, the value of the
		 *  currentState property is the current frame label.
		 */
		public function get currentState():String;
		public function set currentState(value:String):void;
		/**
		 * Reference to the UIComponentDescriptor, if any, that was used
		 *  by the createComponentFromDescriptor() method to create this
		 *  UIComponent instance. If this UIComponent instance
		 *  was not created from a descriptor, this property is null.
		 */
		public function get descriptor():UIComponentDescriptor;
		public function set descriptor(value:UIComponentDescriptor):void;
		/**
		 * A reference to the document object associated with this component.
		 *  A document object is an Object at the top of the hierarchy
		 *  of a Flex application, MXML component, or ActionScript component.
		 */
		public function get document():Object;
		public function set document(value:Object):void;
		/**
		 * The explicitly specified height for the component,
		 *  in pixels, as the component's coordinates.
		 *  If no height is explicitly specified, the value is NaN.
		 */
		public function get explicitHeight():Number;
		public function set explicitHeight(value:Number):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMaxHeight():Number;
		public function set explicitMaxHeight(value:Number):void;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMaxWidth():Number;
		public function set explicitMaxWidth(value:Number):void;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMinHeight():Number;
		public function set explicitMinHeight(value:Number):void;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get explicitMinWidth():Number;
		public function set explicitMinWidth(value:Number):void;
		/**
		 * The explicitly specified width for the component,
		 *  in pixels, as the component's coordinates.
		 *  If no width is explicitly specified, the value is NaN.
		 */
		public function get explicitWidth():Number;
		public function set explicitWidth(value:Number):void;
		/**
		 * A flag that indicates whether the component can receive focus when selected.
		 */
		public function get focusEnabled():Boolean;
		public function set focusEnabled(value:Boolean):void;
		/**
		 * A single Sprite object that is shared among components
		 *  and used as an overlay for drawing focus.
		 *  Components share this object if their parent is a focused component,
		 *  not if the component implements the IFocusManagerComponent interface.
		 */
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		/**
		 * The height of this object, in pixels.
		 */
		public var height:Number;
		/**
		 * The horizontal distance in pixels from the center of the
		 *  component's content area to the center of the component.
		 *  If this property is set, the center of the component
		 *  will be anchored to the center of its content area;
		 *  when its container is resized, the two centers maintain their horizontal separation.
		 */
		public function get horizontalCenter():*;
		public function set horizontalCenter(value:any):void;
		/**
		 * ID of the component. This value becomes the instance name of the object
		 *  and should not contain any white space or special characters. Each component
		 *  throughout an application should have a unique id.
		 */
		public function get id():String;
		public function set id(value:String):void;
		/**
		 * Specifies whether this component is included in the layout of the
		 *  parent container.
		 *  If true, the object is included in its parent container's
		 *  layout.  If false, the object is positioned by its parent
		 *  container as per its layout rules, but it is ignored for the purpose of
		 *  computing the position of the next child.
		 */
		public function get includeInLayout():Boolean;
		public function set includeInLayout(value:Boolean):void;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout: commitment, measurement, and layout (provided that any were required).
		 */
		protected var initialized:Boolean = false;
		/**
		 * Set to true by the PopUpManager to indicate
		 *  that component has been popped up.
		 */
		public function get isPopUp():Boolean;
		public function set isPopUp(value:Boolean):void;
		/**
		 * The horizontal distance, in pixels, from the left edge of the component's
		 *  content area to the left edge of the component.
		 *  If this property is set, the left edge of the component is anchored
		 *  to the left edge of its content area;
		 *  when its container is resized, the two edges maintain their separation.
		 */
		public function get left():*;
		public function set left(value:any):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get maxHeight():Number;
		public function set maxHeight(value:Number):void;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get maxWidth():Number;
		public function set maxWidth(value:Number):void;
		/**
		 * The measured height of this object.
		 */
		public function get measuredHeight():Number;
		/**
		 * The default minimum height of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredMinHeight():Number;
		public function set measuredMinHeight(value:Number):void;
		/**
		 * The default minimum width of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredMinWidth():Number;
		public function set measuredMinWidth(value:Number):void;
		/**
		 * The measured width of this object.
		 */
		public function get measuredWidth():Number;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get minHeight():Number;
		public function set minHeight(value:Number):void;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, as the component's coordinates.
		 */
		public function get minWidth():Number;
		public function set minWidth(value:Number):void;
		/**
		 * A flag that indicates whether the component can receive focus
		 *  when selected with the mouse.
		 *  If false, focus will be transferred to
		 *  the first parent that is mouseFocusEnabled.
		 */
		public function get mouseFocusEnabled():Boolean;
		/**
		 * The number of automation children this container has.
		 *  This sum should not include any composite children, though
		 *  it does include those children not significant within the
		 *  automation hierarchy.
		 */
		public function get numAutomationChildren():int;
		/**
		 * Typically the parent container of this component.
		 *  However, if this is a popup component, the owner is
		 *  the component that popped it up.
		 *  For example, the owner of a dropdown list of a ComboBox control
		 *  is the ComboBox control itself.
		 *  This property is not managed by Flex, but
		 *  by each component.
		 *  Therefore, if you popup a component,
		 *  you should set this property accordingly.
		 */
		public function get owner():DisplayObjectContainer;
		public function set owner(value:DisplayObjectContainer):void;
		/**
		 * The document containing this component.
		 */
		public function get parentDocument():Object;
		/**
		 * Number that specifies the height of a component as a
		 *  percentage of its parent's size.
		 *  Allowed values are 0 to 100.
		 */
		public function get percentHeight():Number;
		public function set percentHeight(value:Number):void;
		/**
		 * Number that specifies the width of a component as a
		 *  percentage of its parent's size.
		 *  Allowed values are 0 to 100.
		 */
		public function get percentWidth():Number;
		public function set percentWidth(value:Number):void;
		/**
		 * The horizontal distance, in pixels, from the right edge of the component
		 *  to the right edge of its content area.
		 *  If this property is set, the right edge of the component is anchored
		 *  to the right edge of its content area;
		 *  when its container is resized, the two edges maintain their separation.
		 */
		public function get right():*;
		public function set right(value:any):void;
		/**
		 * A flag that determines if an automation object
		 *  shows in the automation hierarchy.
		 *  Children of containers that are not visible in the hierarchy
		 *  appear as children of the next highest visible parent.
		 *  Typically containers used for layout, such as boxes and Canvas,
		 *  do not appear in the hierarchy.
		 */
		public function get showInAutomationHierarchy():Boolean;
		public function set showInAutomationHierarchy(value:Boolean):void;
		/**
		 * A reference to the SystemManager object for this component.
		 */
		public function get systemManager():ISystemManager;
		public function set systemManager(value:ISystemManager):void;
		/**
		 * Text to display in the ToolTip.
		 */
		public function get toolTip():String;
		public function set toolTip(value:String):void;
		/**
		 * The vertical distance, in pixels, from the top edge of the control's content area
		 *  to the top edge of the component.
		 *  If this property is set, the top edge of the component is anchored
		 *  to the top edge of its content area;
		 *  when its container is resized, the two edges maintain their separation.
		 */
		public function get top():*;
		public function set top(value:any):void;
		/**
		 * Used by EffectManager.
		 *  Returns non-null if a component
		 *  is not using the EffectManager to execute a Tween.
		 */
		public function get tweeningProperties():Array;
		public function set tweeningProperties(value:Array):void;
		/**
		 * The vertical distance in pixels from the center of the component's content area
		 *  to the center of the component.
		 *  If this property is set, the center of the component is anchored
		 *  to the center of its content area;
		 *  when its container is resized, the two centers maintain their vertical separation.
		 */
		public function get verticalCenter():*;
		public function set verticalCenter(value:any):void;
		/**
		 * The width of this object, in pixels.
		 */
		public var width:Number;
		/**
		 * Constructor.
		 */
		public function UIMovieClip();
		/**
		 * Returns a set of properties that identify the child within
		 *  this container.  These values should not change during the
		 *  lifespan of the application.
		 *
		 * @param child             <IAutomationObject> Child for which to provide the id.
		 * @return                  <Object> Sets of properties describing the child which can
		 *                            later be used to resolve the component.
		 */
		public function createAutomationIDPart(child:IAutomationObject):Object;
		/**
		 * Creates an id reference to this IUIComponent object
		 *  on its parent document object.
		 *  This function can create multidimensional references
		 *  such as b[2][4] for objects inside one or more repeaters.
		 *  If the indices are null, it creates a simple non-Array reference.
		 *
		 * @param parentDocument    <IFlexDisplayObject> The parent of this IUIComponent object.
		 */
		public function createReferenceOnParentDocument(parentDocument:IFlexDisplayObject):void;
		/**
		 * Deletes the id reference to this IUIComponent object
		 *  on its parent document object.
		 *  This function can delete from multidimensional references
		 *  such as b[2][4] for objects inside one or more Repeaters.
		 *  If the indices are null, it deletes the simple non-Array reference.
		 *
		 * @param parentDocument    <IFlexDisplayObject> The parent of this IUIComponent object.
		 */
		public function deleteReferenceOnParentDocument(parentDocument:IFlexDisplayObject):void;
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component should draw or hide a graphic
		 *  that indicates that the component has focus.
		 *
		 * @param isFocused         <Boolean> If true, draw the focus indicator,
		 *                            otherwise hide it.
		 */
		public function drawFocus(isFocused:Boolean):void;
		/**
		 * The main function that watches our size and progesses through transitions.
		 *
		 * @param event             <Event> 
		 */
		protected function enterFrameHandler(event:Event):void;
		/**
		 * Executes the data bindings into this UIComponent object.
		 *  Workaround for MXML container/bindings problem (177074):
		 *  override Container.executeBindings() to prefer descriptor.document over parentDocument in the
		 *  call to BindingManager.executeBindings().
		 *  This should always provide the correct behavior for instances created by descriptor, and will
		 *  provide the original behavior for procedurally-created instances. (The bug may or may not appear
		 *  in the latter case.)
		 *  A more complete fix, guaranteeing correct behavior in both non-DI and reparented-component
		 *  scenarios, is anticipated for updater 1.
		 *
		 * @param recurse           <Boolean (default = false)> Recursively execute bindings for children of this component.
		 */
		public function executeBindings(recurse:Boolean = false):void;
		/**
		 * Recursively finds all children that have tabEnabled=true and adds them
		 *  to the focusableObjects array.
		 *
		 * @param obj               <DisplayObjectContainer> 
		 */
		protected function findFocusCandidates(obj:DisplayObjectContainer):void;
		/**
		 * Called when focus is entering any of our children. Make sure our
		 *  focus event handlers are called so we can take control from the
		 *  Flex focus manager.
		 *
		 * @param event             <FocusEvent> 
		 */
		protected function focusInHandler(event:FocusEvent):void;
		/**
		 * Provides the automation object at the specified index.  This list
		 *  should not include any children that are composites.
		 *
		 * @param index             <int> The index of the child to return
		 * @return                  <IAutomationObject> The child at the specified index.
		 */
		public function getAutomationChildAt(index:int):IAutomationObject;
		/**
		 * Returns the specified constraint value.
		 *
		 * @param constraintName    <String> name of the constraint value. Constraint parameters are
		 *                            "baseline", "bottom", "horizontalCenter",
		 *                            "left", "right", "top", and
		 *                            "verticalCenter".
		 *                            For more information about these parameters, see the Canvas and Panel containers and
		 *                            Styles Metadata AnchorStyles.
		 * @return                  <*> The constraint value, or null if it is not defined.
		 */
		public function getConstraintValue(constraintName:String):*;
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured height
		 *
		 * @return                  <Number> A Number which is explicitHeight if defined
		 *                            or measuredHeight if not.
		 */
		public function getExplicitOrMeasuredHeight():Number;
		/**
		 * A convenience method for determining whether to use the
		 *  explicit or measured width
		 *
		 * @return                  <Number> A Number which is explicitWidth if defined
		 *                            or measuredWidth if not.
		 */
		public function getExplicitOrMeasuredWidth():Number;
		/**
		 * Initialize the object.
		 */
		public function initialize():void;
		/**
		 * Moves this object to the specified x and y coordinates.
		 *
		 * @param x                 <Number> The new x-position for this object.
		 * @param y                 <Number> The new y-position for this object.
		 */
		public function move(x:Number, y:Number):void;
		/**
		 * Notify our parent that our size has changed.
		 */
		protected function notifySizeChanged():void;
		/**
		 * Returns true if the chain of owner properties
		 *  points from child to this UIComponent.
		 *
		 * @param displayObject     <DisplayObject> A UIComponent.
		 * @return                  <Boolean> true if the child is parented or owned by this UIComponent.
		 */
		public function owns(displayObject:DisplayObject):Boolean;
		/**
		 * Called by Flex when a UIComponent object is added to or removed from a parent.
		 *  Developers typically never need to call this method.
		 *
		 * @param p                 <DisplayObjectContainer> The parent of this UIComponent object.
		 */
		public function parentChanged(p:DisplayObjectContainer):void;
		/**
		 * For each effect event, register the EffectManager
		 *  as one of the event listeners.
		 *
		 * @param effects           <Array> An Array of strings of effect names.
		 */
		public function registerEffects(effects:Array):void;
		/**
		 * Replays the specified event.  A component author should probably call
		 *  super.replayAutomatableEvent in case default replay behavior has been defined
		 *  in a superclass.
		 *
		 * @param event             <Event> The event to replay.
		 * @return                  <Boolean> true if a replay was successful.
		 */
		public function replayAutomatableEvent(event:Event):Boolean;
		/**
		 * Resolves a child by using the id provided. The id is a set
		 *  of properties as provided by the createAutomationIDPart() method.
		 *
		 * @param criteria          <Object> Set of properties describing the child.
		 *                            The criteria can contain regular expression values
		 *                            resulting in multiple children being matched.
		 * @return                  <Array> Array of children that matched the criteria
		 *                            or null if no children could not be resolved.
		 */
		public function resolveAutomationIDPart(criteria:Object):Array;
		/**
		 * Sets the actual size of this object.
		 *
		 * @param newWidth          <Number> The new width for this object.
		 * @param newHeight         <Number> The new height for this object.
		 */
		public function setActualSize(newWidth:Number, newHeight:Number):void;
		/**
		 * Sets the specified constraint value.
		 *
		 * @param constraintName    <String> name of the constraint value. Constraint parameters are
		 *                            "baseline", "bottom", "horizontalCenter",
		 *                            "left", "right", "top", and
		 *                            "verticalCenter".
		 *                            For more information about these parameters, see the Canvas and Panel containers and
		 *                            Styles Metadata AnchorStyles.
		 * @param value             <*> The new value for the constraint.
		 */
		public function setConstraintValue(constraintName:String, value:*):void;
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component may in turn set focus to an internal component.
		 */
		public function setFocus():void;
		/**
		 * Called when the visible property changes.
		 *  You should set the visible property to show or hide
		 *  a component instead of calling this method directly.
		 *
		 * @param value             <Boolean> The new value of the visible property.
		 *                            Specify true to show the component, and false to hide it.
		 * @param noEvent           <Boolean (default = false)> If true, do not dispatch an event.
		 *                            If false, dispatch a show event when
		 *                            the component becomes visible, and a hide event when
		 *                            the component becomes invisible.
		 */
		public function setVisible(value:Boolean, noEvent:Boolean = false):void;
	}
}
