/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import mx.automation.IAutomationObject;
	import mx.managers.ILayoutManagerClient;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.managers.IToolTipManagerClient;
	import mx.validators.IValidatorListener;
	import mx.controls.IFlexContextMenu;
	import mx.managers.IFocusManager;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import mx.resources.IResourceManager;
	import flash.geom.Rectangle;
	import mx.styles.CSSStyleDeclaration;
	import mx.managers.ISystemManager;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.geom.Matrix;
	import mx.effects.IEffectInstance;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import mx.events.ValidationResultEvent;
	public class UIComponent extends FlexSprite implements IAutomationObject, IChildList, IDeferredInstantiationUIComponent, IFlexDisplayObject, IFlexModule, IInvalidating, ILayoutManagerClient, IPropertyChangeNotifier, IRepeaterClient, ISimpleStyleClient, IStyleClient, IToolTipManagerClient, IUIComponent, IValidatorListener, IStateClient, IConstraintClient {
		/**
		 * The list of effects that are currently playing on the component,
		 *  as an Array of EffectInstance instances.
		 */
		public function get activeEffects():Array;
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
		 * The y-coordinate of the baseline
		 *  of the first line of text of the component.
		 */
		public function get baselinePosition():Number;
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
		public function set cachePolicy(value:String):void;
		/**
		 * The name of this instance's class, such as "Button".
		 */
		public function get className():String;
		/**
		 * Returns the x position of the mouse, in the content coordinate system.
		 *  Content coordinates specify a pixel position relative to the upper left
		 *  corner of the component's content, and include all of the component's
		 *  content area, including any regions that are currently clipped and must
		 *  be accessed by scrolling the component.
		 */
		public function get contentMouseX():Number;
		/**
		 * Returns the y position of the mouse, in the content coordinate system.
		 *  Content coordinates specify a pixel position relative to the upper left
		 *  corner of the component's content, and include all of the component's
		 *  content area, including any regions that are currently clipped and must
		 *  be accessed by scrolling the component.
		 */
		public function get contentMouseY():Number;
		/**
		 * The current view state of the component.
		 *  Set to "" or null to reset
		 *  the component back to its base state.
		 */
		public function get currentState():String;
		public function set currentState(value:String):void;
		/**
		 * Gets the CursorManager that controls the cursor for this component
		 *  and its peers.
		 *  Each top-level window has its own instance of a CursorManager;
		 *  To make sure you're talking to the right one, use this method.
		 */
		public function get cursorManager():ICursorManager;
		/**
		 * Reference to the UIComponentDescriptor, if any, that was used
		 *  by the createComponentFromDescriptor() method to create this
		 *  UIComponent instance. If this UIComponent instance
		 *  was not created from a descriptor, this property is null.
		 */
		public function get descriptor():UIComponentDescriptor;
		public function set descriptor(value:UIComponentDescriptor):void;
		/**
		 * A reference to the document object associated with this UIComponent.
		 *  A document object is an Object at the top of the hierarchy of a
		 *  Flex application, MXML component, or AS component.
		 */
		public function get document():Object;
		public function set document(value:Object):void;
		/**
		 * Specifies whether the UIComponent object receives doubleClick events.
		 *  The default value is false, which means that the UIComponent object
		 *  does not receive doubleClick events.
		 */
		public function get doubleClickEnabled():Boolean;
		public function set doubleClickEnabled(value:Boolean):void;
		/**
		 * Whether the component can accept user interaction. After setting the enabled
		 *  property to false, some components still respond to mouse interactions such
		 *  as mouseOver. As a result, to fully disable UIComponents,
		 *  you should also set the value of the mouseEnabled property to false.
		 *  If you set the enabled property to false
		 *  for a container, Flex dims the color of the container and of all
		 *  of its children, and blocks user input to the container
		 *  and to all of its children.
		 */
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		/**
		 * The text that will be displayed by a component's error tip when a
		 *  component is monitored by a Validator and validation fails.
		 */
		public function get errorString():String;
		public function set errorString(value:String):void;
		/**
		 * Number that specifies the explicit height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitHeight():Number;
		public function set explicitHeight(value:Number):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMaxHeight():Number;
		public function set explicitMaxHeight(value:Number):void;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMaxWidth():Number;
		public function set explicitMaxWidth(value:Number):void;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMinHeight():Number;
		public function set explicitMinHeight(value:Number):void;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitMinWidth():Number;
		public function set explicitMinWidth(value:Number):void;
		/**
		 * Number that specifies the explicit width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get explicitWidth():Number;
		public function set explicitWidth(value:Number):void;
		/**
		 * The context menu for this UIComponent.
		 */
		public function get flexContextMenu():IFlexContextMenu;
		public function set flexContextMenu(value:IFlexContextMenu):void;
		/**
		 * Indicates whether the component can receive focus when tabbed to.
		 *  You can set focusEnabled to false
		 *  when a UIComponent is used as a subcomponent of another component
		 *  so that the outer component becomes the focusable entity.
		 *  If this property is false, focus will be transferred to
		 *  the first parent that has focusEnable
		 *  set to true.
		 */
		public function get focusEnabled():Boolean;
		public function set focusEnabled(value:Boolean):void;
		/**
		 * Gets the FocusManager that controls focus for this component
		 *  and its peers.
		 *  Each popup has its own focus loop and therefore its own instance
		 *  of a FocusManager.
		 *  To make sure you're talking to the right one, use this method.
		 */
		public function get focusManager():IFocusManager;
		public function set focusManager(value:IFocusManager):void;
		/**
		 * The focus pane associated with this object.
		 *  An object has a focus pane when one of its children has focus.
		 */
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		/**
		 * Number that specifies the height of the component, in pixels,
		 *  in the parent's coordinates.
		 *  The default value is 0, but this property will contain the actual component
		 *  height after Flex completes sizing the components in your application.
		 */
		public function get height():Number;
		public function set height(value:Number):void;
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
		 * The beginning of this component's chain of inheriting styles.
		 *  The getStyle() method simply accesses
		 *  inheritingStyles[styleName] to search the entire
		 *  prototype-linked chain.
		 *  This object is set up by initProtoChain().
		 *  Developers typically never need to access this property directly.
		 */
		public function get inheritingStyles():Object;
		public function set inheritingStyles(value:Object):void;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout: commitment, measurement, and layout (provided that any were required).
		 */
		public function get initialized():Boolean;
		public function set initialized(value:Boolean):void;
		/**
		 * The index of a repeated component.
		 *  If the component is not within a Repeater, the value is -1.
		 */
		public function get instanceIndex():int;
		/**
		 * An Array containing the indices required to reference
		 *  this UIComponent object from its parent document.
		 *  The Array is empty unless this UIComponent object is within one or more Repeaters.
		 *  The first element corresponds to the outermost Repeater.
		 *  For example, if the id is "b" and instanceIndices is [2,4],
		 *  you would reference it on the parent document as b[2][4].
		 */
		public function get instanceIndices():Array;
		public function set instanceIndices(value:Array):void;
		/**
		 * Determines whether this UIComponent instance is a document object,
		 *  that is, whether it is at the top of the hierarchy of a Flex
		 *  application, MXML component, or ActionScript component.
		 */
		public function get isDocument():Boolean;
		/**
		 * Set to true by the PopUpManager to indicate
		 *  that component has been popped up.
		 */
		public function get isPopUp():Boolean;
		public function set isPopUp(value:Boolean):void;
		/**
		 * Number that specifies the maximum height of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get maxHeight():Number;
		public function set maxHeight(value:Number):void;
		/**
		 * Number that specifies the maximum width of the component,
		 *  in pixels, in the component's coordinates.
		 */
		public function get maxWidth():Number;
		public function set maxWidth(value:Number):void;
		/**
		 * The default height of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredHeight():Number;
		public function set measuredHeight(value:Number):void;
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
		 * The default width of the component, in pixels.
		 *  This value is set by the measure() method.
		 */
		public function get measuredWidth():Number;
		public function set measuredWidth(value:Number):void;
		/**
		 * Number that specifies the minimum height of the component,
		 *  in pixels, in the component's coordinates.
		 *  The default value depends on the component implementation.
		 */
		public function get minHeight():Number;
		public function set minHeight(value:Number):void;
		/**
		 * Number that specifies the minimum width of the component,
		 *  in pixels, in the component's coordinates.
		 *  The default value depends on the component implementation.
		 */
		public function get minWidth():Number;
		public function set minWidth(value:Number):void;
		/**
		 * The moduleFactory that is used to create TextFields in the correct SWF context. This is necessary so that
		 *  embedded fonts will work.
		 */
		public function get moduleFactory():IFlexModuleFactory;
		public function set moduleFactory(value:IFlexModuleFactory):void;
		/**
		 * Whether you can receive focus when clicked on.
		 *  If false, focus will be transferred to
		 *  the first parent that is mouseFocusEnable
		 *  set to true.
		 *  For example, you can set this property to false
		 *  on a Button control so that you can use the Tab key to move focus
		 *  to the control, but not have the control get focus when you click on it.
		 */
		public function get mouseFocusEnabled():Boolean;
		public function set mouseFocusEnabled(value:Boolean):void;
		/**
		 * Depth of this object in the containment hierarchy.
		 *  This number is used by the measurement and layout code.
		 *  The value is 0 if this component is not on the DisplayList.
		 */
		public function get nestLevel():int;
		public function set nestLevel(value:int):void;
		/**
		 * The beginning of this component's chain of non-inheriting styles.
		 *  The getStyle() method simply accesses
		 *  nonInheritingStyles[styleName] to search the entire
		 *  prototype-linked chain.
		 *  This object is set up by initProtoChain().
		 *  Developers typically never need to access this property directly.
		 */
		public function get nonInheritingStyles():Object;
		public function set nonInheritingStyles(value:Object):void;
		/**
		 * The number of automation children this container has.
		 *  This sum should not include any composite children, though
		 *  it does include those children not significant within the
		 *  automation hierarchy.
		 */
		public function get numAutomationChildren():int;
		/**
		 * The owner of this UIComponent. By default, it is the parent of this UIComponent.
		 *  However, if this UIComponent object is a child component that is
		 *  popped up by its parent, such as the dropdown list of a ComboBox control,
		 *  the owner is the component that popped up this UIComponent object.
		 */
		public function get owner():DisplayObjectContainer;
		public function set owner(value:DisplayObjectContainer):void;
		/**
		 * The parent container or component for this component.
		 *  Only UIComponent objects should have a parent property.
		 *  Non-UIComponent objects should use another property to reference
		 *  the object to which they belong.
		 *  By convention, non-UIComponent objects use an owner
		 *  property to reference the object to which they belong.
		 */
		public function get parent():DisplayObjectContainer;
		/**
		 * A reference to the Application object that contains this UIComponent
		 *  instance.
		 *  This Application object might exist in a SWFLoader control in another
		 *  Application, and so on, creating a chain of Application objects that
		 *  can be walked using parentApplication.
		 *  The parentApplication property of an Application is never itself;
		 *  it is either the Application into which it was loaded or null
		 *  (for the top-level Application).
		 *  Walking the application chain using the parentApplication
		 *  property is similar to walking the document chain using the
		 *  parentDocument property.
		 *  You can access the top-level application using the
		 *  application property of the Application class.
		 */
		public function get parentApplication():Object;
		/**
		 * A reference to the parent document object for this UIComponent.
		 *  A document object is a UIComponent at the top of the hierarchy
		 *  of a Flex application, MXML component, or AS component.
		 *  For the Application object, the parentDocument
		 *  property is null.
		 *  This property  is useful in MXML scripts to go up a level
		 *  in the chain of document objects.
		 *  It can be used to walk this chain using
		 *  parentDocument.parentDocument, and so on.
		 *  It is typed as Object so that authors can access properties
		 *  and methods on ancestor document objects without casting.
		 */
		public function get parentDocument():Object;
		/**
		 * Number that specifies the height of a component as a percentage
		 *  of its parent's size. Allowed values are 0-100. The default value is NaN.
		 *  Setting the height or explicitHeight properties
		 *  resets this property to NaN.
		 */
		public function get percentHeight():Number;
		public function set percentHeight(value:Number):void;
		/**
		 * Number that specifies the width of a component as a percentage
		 *  of its parent's size. Allowed values are 0-100. The default value is NaN.
		 *  Setting the width or explicitWidth properties
		 *  resets this property to NaN.
		 */
		public function get percentWidth():Number;
		public function set percentWidth(value:Number):void;
		/**
		 * Set to true after immediate or deferred child creation,
		 *  depending on which one happens. For a Container object, it is set
		 *  to true at the end of
		 *  the createComponentsFromDescriptors() method,
		 *  meaning after the Container object creates its children from its child descriptors.
		 */
		public function get processedDescriptors():Boolean;
		public function set processedDescriptors(value:Boolean):void;
		/**
		 * A reference to the Repeater object
		 *  in the parent document that produced this UIComponent.
		 *  Use this property, rather than the repeaters property,
		 *  when the UIComponent is created by a single Repeater object.
		 *  Use the repeaters property when this UIComponent is created
		 *  by nested Repeater objects.
		 */
		public function get repeater():IRepeater;
		/**
		 * The index of the item in the data provider
		 *  of the Repeater that produced this UIComponent.
		 *  Use this property, rather than the repeaterIndices property,
		 *  when the UIComponent is created by a single Repeater object.
		 *  Use the repeaterIndices property when this UIComponent is created
		 *  by nested Repeater objects.
		 */
		public function get repeaterIndex():int;
		/**
		 * An Array containing the indices of the items in the data provider
		 *  of the Repeaters in the parent document that produced this UIComponent.
		 *  The Array is empty unless this UIComponent is within one or more Repeaters.
		 */
		public function get repeaterIndices():Array;
		public function set repeaterIndices(value:Array):void;
		/**
		 * An Array containing references to the Repeater objects
		 *  in the parent document that produced this UIComponent.
		 *  The Array is empty unless this UIComponent is within
		 *  one or more Repeaters.
		 *  The first element corresponds to the outermost Repeater object.
		 */
		public function get repeaters():Array;
		public function set repeaters(value:Array):void;
		/**
		 * A reference to the object which manages
		 *  all of the application's localized resources.
		 *  This is a singleton instance which implements
		 *  the IResourceManager interface.
		 */
		protected function set resourceManager(value:IResourceManager):void;
		/**
		 * Number that specifies the horizontal scaling factor.
		 */
		public function get scaleX():Number;
		public function set scaleX(value:Number):void;
		/**
		 * Number that specifies the vertical scaling factor.
		 */
		public function get scaleY():Number;
		public function set scaleY(value:Number):void;
		/**
		 * Returns an object that contains the size and position of the base
		 *  drawing surface for this object.
		 */
		public function get screen():Rectangle;
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
		 * The view states that are defined for this component.
		 *  You can specify the states property only on the root
		 *  of the application or on the root tag of an MXML component.
		 *  The compiler generates an error if you specify it on any other control.
		 */
		public var states:Array;
		/**
		 * Storage for the inline inheriting styles on this object.
		 *  This CSSStyleDeclaration is created the first time that
		 *  the setStyle() method
		 *  is called on this component to set an inheriting style.
		 *  Developers typically never need to access this property directly.
		 */
		public function get styleDeclaration():CSSStyleDeclaration;
		public function set styleDeclaration(value:CSSStyleDeclaration):void;
		/**
		 * The class style used by this component. This can be a String, CSSStyleDeclaration
		 *  or an IStyleClient.
		 */
		public function get styleName():Object;
		public function set styleName(value:Object):void;
		/**
		 * Returns the SystemManager object used by this component.
		 */
		public function get systemManager():ISystemManager;
		public function set systemManager(value:ISystemManager):void;
		/**
		 * Text to display in the ToolTip.
		 */
		public function get toolTip():String;
		public function set toolTip(value:String):void;
		/**
		 * An Array of Transition objects, where each Transition object defines a
		 *  set of effects to play when a view state change occurs.
		 */
		public var transitions:Array;
		/**
		 * Array of properties that are currently being tweened on this object.
		 */
		public function get tweeningProperties():Array;
		public function set tweeningProperties(value:Array):void;
		/**
		 * A unique identifier for the object.
		 *  Flex data-driven controls, including all controls that are
		 *  subclasses of List class, use a UID to track data provider items.
		 */
		public function get uid():String;
		public function set uid(value:String):void;
		/**
		 * A convenience method for determining the unscaled height
		 *  of the component.
		 *  All of a component's drawing and child layout should be done
		 *  within a bounding rectangle of this height, which is also passed
		 *  as an argument to updateDisplayList().
		 */
		protected function get unscaledHeight():Number;
		/**
		 * A convenience method for determining the unscaled width
		 *  of the component
		 *  All of a component's drawing and child layout should be done
		 *  within a bounding rectangle of this width, which is also passed
		 *  as an argument to updateDisplayList().
		 */
		protected function get unscaledWidth():Number;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout validation (provided that any were required).
		 */
		public function get updateCompletePendingFlag():Boolean;
		public function set updateCompletePendingFlag(value:Boolean):void;
		/**
		 * Used by a validator to associate a subfield with this component.
		 */
		public function get validationSubField():String;
		public function set validationSubField(value:String):void;
		/**
		 * Controls the visibility of this UIComponent. If true,
		 *  the object is visible.
		 */
		public function get visible():Boolean;
		public function set visible(value:Boolean):void;
		/**
		 * Number that specifies the width of the component, in pixels,
		 *  in the parent's coordinates.
		 *  The default value is 0, but this property will contain the actual component
		 *  width after Flex completes sizing the components in your application.
		 */
		public function get width():Number;
		public function set width(value:Number):void;
		/**
		 * Number that specifies the component's horizontal position,
		 *  in pixels, within its parent container.
		 */
		public function get x():Number;
		public function set x(value:Number):void;
		/**
		 * Number that specifies the component's vertical position,
		 *  in pixels, within its parent container.
		 */
		public function get y():Number;
		public function set y(value:Number):void;
		/**
		 * Constructor.
		 */
		public function UIComponent();
		/**
		 * Adjust the focus rectangle.
		 *
		 * @param obj               <DisplayObject (default = null)> component whose focus rectangle to modify.
		 *                            If omitted, the default value is this UIComponent object.
		 */
		protected function adjustFocusRect(obj:DisplayObject = null):void;
		/**
		 * This is an internal method used by the Flex framework
		 *  to support the Dissolve effect.
		 *  You should not need to call it or override it.
		 */
		protected function attachOverlay():void;
		/**
		 * Queues a function to be called later.
		 *
		 * @param method            <Function> Reference to a method to be executed later.
		 * @param args              <Array (default = null)> Array of Objects that represent the arguments to pass to the method.
		 */
		public function callLater(method:Function, args:Array = null):void;
		/**
		 * Performs any final processing after child objects are created.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected function childrenCreated():void;
		/**
		 * Deletes a style property from this component instance.
		 *
		 * @param styleProp         <String> The name of the style property.
		 */
		public function clearStyle(styleProp:String):void;
		/**
		 * Processes the properties set on the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected function commitProperties():void;
		/**
		 * Converts a Point object from content coordinates to global coordinates.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *  Global coordinates specify a pixel position relative to the upper-left corner
		 *  of the stage, that is, the outermost edge of the application.
		 *
		 * @param point             <Point> A Point object that
		 *                            specifies the x and y coordinates in the content coordinate system
		 *                            as properties.
		 * @return                  <Point> A Point object with coordinates relative to the Stage.
		 */
		public function contentToGlobal(point:Point):Point;
		/**
		 * Converts a Point object from content to local coordinates.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *  Local coordinates specify a pixel position relative to the
		 *  upper left corner of the component.
		 *
		 * @param point             <Point> A Point object that specifies the x and y
		 *                            coordinates in the content coordinate system as properties.
		 * @return                  <Point> Point A Point object with coordinates relative to the
		 *                            local coordinate system.
		 */
		public function contentToLocal(point:Point):Point;
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
		 * Create child objects of the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected function createChildren():void;
		/**
		 * Creates a new object using a context
		 *  based on the embedded font being used.
		 *
		 * @param classObj          <Class> The class to create.
		 * @return                  <Object> The instance of the class created in the context
		 *                            of the SWF owning the embedded font.
		 *                            If this object is not using an embedded font,
		 *                            the class is created in the context of this object.
		 */
		protected function createInFontContext(classObj:Class):Object;
		/**
		 * Creates the object using a given moduleFactory.
		 *  If the moduleFactory is null or the object
		 *  cannot be created using the module factory,
		 *  then fall back to creating the object using a systemManager.
		 *
		 * @param moduleFactory     <IFlexModuleFactory> The moduleFactory to create the class in;
		 *                            may be null.
		 * @param className         <String> The name of the class to create.
		 * @return                  <Object> The object created in the context of the moduleFactory.
		 */
		protected function createInModuleContext(moduleFactory:IFlexModuleFactory, className:String):Object;
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
		 * Returns a UITextFormat object corresponding to the text styles
		 *  for this UIComponent.
		 *
		 * @return                  <UITextFormat> UITextFormat object corresponding to the text styles
		 *                            for this UIComponent.
		 */
		public function determineTextFormatFromStyles():UITextFormat;
		/**
		 * Dispatches an event into the event flow.
		 *  The event target is the EventDispatcher object upon which
		 *  the dispatchEvent() method is called.
		 *
		 * @param event             <Event> The Event object that is dispatched into the event flow.
		 *                            If the event is being redispatched, a clone of the event is created automatically.
		 *                            After an event is dispatched, its target property cannot be changed,
		 *                            so you must create a new copy of the event for redispatching to work.
		 * @return                  <Boolean> A value of true if the event was successfully dispatched.
		 *                            A value of false indicates failure or that
		 *                            the preventDefault() method was called on the event.
		 */
		public override function dispatchEvent(event:Event):Boolean;
		/**
		 * Shows or hides the focus indicator around this component.
		 *
		 * @param isFocused         <Boolean> Determines if the focus indicator should be displayed. Set to
		 *                            true to display the focus indicator. Set to false to hide it.
		 */
		public function drawFocus(isFocused:Boolean):void;
		/**
		 * Programatically draws a rectangle into this skin's Graphics object.
		 *
		 * @param x                 <Number> Horizontal position of upper-left corner
		 *                            of rectangle within this skin.
		 * @param y                 <Number> Vertical position of upper-left corner
		 *                            of rectangle within this skin.
		 * @param width             <Number> Width of rectangle, in pixels.
		 * @param height            <Number> Height of rectangle, in pixels.
		 * @param cornerRadius      <Object (default = null)> Corner radius/radii of rectangle.
		 *                            Can be null, a Number, or an Object.
		 *                            If it is null, it specifies that the corners should be square
		 *                            rather than rounded.
		 *                            If it is a Number, it specifies the same radius, in pixels,
		 *                            for all four corners.
		 *                            If it is an Object, it should have properties named
		 *                            tl, tr, bl, and
		 *                            br, whose values are Numbers specifying
		 *                            the radius, in pixels, for the top left, top right,
		 *                            bottom left, and bottom right corners.
		 *                            For example, you can pass a plain Object such as
		 *                            { tl: 5, tr: 5, bl: 0, br: 0 }.
		 *                            The default value is null (square corners).
		 * @param color             <Object (default = null)> The RGB color(s) for the fill.
		 *                            Can be null, a uint, or an Array.
		 *                            If it is null, the rectangle not filled.
		 *                            If it is a uint, it specifies an RGB fill color.
		 *                            For example, pass 0xFF0000 to fill with red.
		 *                            If it is an Array, it should contain uints
		 *                            specifying the gradient colors.
		 *                            For example, pass [ 0xFF0000, 0xFFFF00, 0x0000FF ]
		 *                            to fill with a red-to-yellow-to-blue gradient.
		 *                            You can specify up to 15 colors in the gradient.
		 *                            The default value is null (no fill).
		 * @param alpha             <Object (default = null)> Alpha value(s) for the fill.
		 *                            Can be null, a Number, or an Array.
		 *                            This argument is ignored if color is null.
		 *                            If color is a uint specifying an RGB fill color,
		 *                            then alpha should be a Number specifying
		 *                            the transparency of the fill, where 0.0 is completely transparent
		 *                            and 1.0 is completely opaque.
		 *                            You can also pass null instead of 1.0 in this case
		 *                            to specify complete opaqueness.
		 *                            If color is an Array specifying gradient colors,
		 *                            then alpha should be an Array of Numbers, of the
		 *                            same length, that specifies the corresponding alpha values
		 *                            for the gradient.
		 *                            In this case, the default value is null (completely opaque).
		 * @param gradientMatrix    <Matrix (default = null)> Matrix object used for the gradient fill.
		 *                            The utility methods horizontalGradientMatrix(),
		 *                            verticalGradientMatrix(), and
		 *                            rotatedGradientMatrix() can be used to create the value for
		 *                            this parameter.
		 * @param gradientType      <String (default = "linear")> Type of gradient fill. The possible values are
		 *                            GradientType.LINEAR or GradientType.RADIAL.
		 *                            (The GradientType class is in the package flash.display.)
		 * @param gradientRatios    <Array (default = null)> (optional default [0,255])
		 *                            Specifies the distribution of colors. The number of entries must match
		 *                            the number of colors defined in the color parameter.
		 *                            Each value defines the percentage of the width where the color is
		 *                            sampled at 100%. The value 0 represents the left-hand position in
		 *                            the gradient box, and 255 represents the right-hand position in the
		 *                            gradient box.
		 * @param hole              <Object (default = null)> (optional) A rounded rectangular hole
		 *                            that should be carved out of the middle
		 *                            of the otherwise solid rounded rectangle
		 *                            { x: #, y: #, w: #, h: #, r: # or { br: #, bl: #, tl: #, tr: # } }
		 */
		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, cornerRadius:Object = null, color:Object = null, alpha:Object = null, gradientMatrix:Matrix = null, gradientType:String = "linear", gradientRatios:Array = null, hole:Object = null):void;
		/**
		 * Called by the effect instance when it stops playing on the component.
		 *  You can use this method to restore a modification to the component made
		 *  by the effectStarted() method when the effect started,
		 *  or perform some other action when the effect ends.
		 *
		 * @param effectInst        <IEffectInstance> The effect instance object playing on the component.
		 */
		public function effectFinished(effectInst:IEffectInstance):void;
		/**
		 * Called by the effect instance when it starts playing on the component.
		 *  You can use this method to perform a modification to the component as part
		 *  of an effect. You can use the effectFinished() method
		 *  to restore the modification when the effect ends.
		 *
		 * @param effectInst        <IEffectInstance> The effect instance object playing on the component.
		 */
		public function effectStarted(effectInst:IEffectInstance):void;
		/**
		 * Ends all currently playing effects on the component.
		 */
		public function endEffectsStarted():void;
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
		 * Called after printing is complete.
		 *  For the UIComponent class, the method performs no action.
		 *  Flex containers override the method to restore the container after printing.
		 *
		 * @param obj               <Object> Contains the properties of the component that
		 *                            restore it to its state before printing.
		 * @param target            <IFlexDisplayObject> The component that just finished printing.
		 *                            It may be the current component or one of its children.
		 */
		public function finishPrint(obj:Object, target:IFlexDisplayObject):void;
		/**
		 * The event handler called when a UIComponent object gets focus.
		 *  If you override this method, make sure to call the base class version.
		 *
		 * @param event             <FocusEvent> The event object.
		 */
		protected function focusInHandler(event:FocusEvent):void;
		/**
		 * The event handler called when a UIComponent object loses focus.
		 *  If you override this method, make sure to call the base class version.
		 *
		 * @param event             <FocusEvent> The event object.
		 */
		protected function focusOutHandler(event:FocusEvent):void;
		/**
		 * Provides the automation object at the specified index.  This list
		 *  should not include any children that are composites.
		 *
		 * @param index             <int> The index of the child to return
		 * @return                  <IAutomationObject> The child at the specified index.
		 */
		public function getAutomationChildAt(index:int):IAutomationObject;
		/**
		 * Finds the type selectors for this UIComponent instance.
		 *  The algorithm walks up the superclass chain.
		 *  For example, suppose that class MyButton extends Button.
		 *  A MyButton instance will first look for a MyButton type selector
		 *  then, it will look for a Button type selector.
		 *  then, it will look for a UIComponent type selector.
		 *  (The superclass chain is considered to stop at UIComponent, not Object.)
		 *
		 * @return                  <Array> An Array of type selectors for this UIComponent instance.
		 */
		public function getClassStyleDeclarations():Array;
		/**
		 * Returns a layout constraint value, which is the same as
		 *  getting the constraint style for this component.
		 *
		 * @param constraintName    <String> 
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
		 * Gets the object that currently has focus.
		 *  It might not be this object.
		 *  Note that this method does not necessarily return the component
		 *  that has focus.
		 *  It may return the internal subcomponent of the component
		 *  that has focus.
		 *  To get the component that has focus, use the
		 *  focusManager.focus property.
		 *
		 * @return                  <InteractiveObject> Object that has focus.
		 */
		public function getFocus():InteractiveObject;
		/**
		 * Returns the item in the dataProvider that was used
		 *  by the specified Repeater to produce this Repeater, or
		 *  null if this Repeater isn't repeated.
		 *  The argument whichRepeater is 0 for the outermost
		 *  Repeater, 1 for the next inner Repeater, and so on.
		 *  If whichRepeater is not specified,
		 *  the innermost Repeater is used.
		 *
		 * @param whichRepeater     <int (default = -1)> Number of the Repeater,
		 *                            counting from the outermost one, starting at 0.
		 * @return                  <Object> The requested repeater item.
		 */
		public function getRepeaterItem(whichRepeater:int = -1):Object;
		/**
		 * Gets a style property that has been set anywhere in this
		 *  component's style lookup chain.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @return                  <*> Style value.
		 */
		public function getStyle(styleProp:String):*;
		/**
		 * Converts a Point object from global to content coordinates.
		 *  Global coordinates specify a pixel position relative to the upper-left corner
		 *  of the stage, that is, the outermost edge of the application.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *
		 * @param point             <Point> A Point object that
		 *                            specifies the x and y coordinates in the global (Stage)
		 *                            coordinate system as properties.
		 * @return                  <Point> Point A Point object with coordinates relative to the component.
		 */
		public function globalToContent(point:Point):Point;
		/**
		 * Returns a box Matrix which can be passed to the
		 *  drawRoundRect() method
		 *  as the rot parameter when drawing a horizontal gradient.
		 *
		 * @param x                 <Number> The left coordinate of the gradient, in pixels.
		 * @param y                 <Number> The top coordinate of the gradient, in pixels.
		 * @param width             <Number> The width of the gradient, in pixels.
		 * @param height            <Number> The height of the gradient, in pixels.
		 * @return                  <Matrix> The Matrix for the horizontal gradient.
		 */
		public function horizontalGradientMatrix(x:Number, y:Number, width:Number, height:Number):Matrix;
		/**
		 * Finalizes the initialization of this component.
		 */
		protected function initializationComplete():void;
		/**
		 * Initializes the internal structure of this component.
		 */
		public function initialize():void;
		/**
		 * Initializes this component's accessibility code.
		 */
		protected function initializeAccessibility():void;
		/**
		 * Initializes various properties which keep track of repeated instances
		 *  of this component.
		 *
		 * @param parent            <IRepeaterClient> The parent object containing the Repeater that created
		 *                            this component.
		 */
		public function initializeRepeaterArrays(parent:IRepeaterClient):void;
		/**
		 * Marks a component so that its updateDisplayList()
		 *  method gets called during a later screen update.
		 */
		public function invalidateDisplayList():void;
		/**
		 * Marks a component so that its commitProperties()
		 *  method gets called during a later screen update.
		 */
		public function invalidateProperties():void;
		/**
		 * Marks a component so that its measure()
		 *  method gets called during a later screen update.
		 */
		public function invalidateSize():void;
		/**
		 * Typically overridden by components containing UITextField objects,
		 *  where the UITextField object gets focus.
		 *
		 * @param target            <DisplayObject> A UIComponent object containing a UITextField object
		 *                            that can receive focus.
		 * @return                  <Boolean> Returns true if the UITextField object has focus.
		 */
		protected function isOurFocus(target:DisplayObject):Boolean;
		/**
		 * The event handler called for a keyDown event.
		 *  If you override this method, make sure to call the base class version.
		 *
		 * @param event             <KeyboardEvent> The event object.
		 */
		protected function keyDownHandler(event:KeyboardEvent):void;
		/**
		 * The event handler called for a keyUp event.
		 *  If you override this method, make sure to call the base class version.
		 *
		 * @param event             <KeyboardEvent> The event object.
		 */
		protected function keyUpHandler(event:KeyboardEvent):void;
		/**
		 * Converts a Point object from local to content coordinates.
		 *  Local coordinates specify a pixel position relative to the
		 *  upper left corner of the component.
		 *  Content coordinates specify a pixel position relative to the upper left corner
		 *  of the component's content, and include all of the component's content area,
		 *  including any regions that are currently clipped and must be
		 *  accessed by scrolling the component.
		 *  You use the content coordinate system to set and get the positions of children
		 *  of a container that uses absolute positioning.
		 *
		 * @param point             <Point> A Point object that specifies the x and y
		 *                            coordinates in the local coordinate system as properties.
		 * @return                  <Point> Point A Point object with coordinates relative to the
		 *                            content coordinate system.
		 */
		public function localToContent(point:Point):Point;
		/**
		 * Calculates the default size, and optionally the default minimum size,
		 *  of the component. This is an advanced method that you might override when
		 *  creating a subclass of UIComponent.
		 */
		protected function measure():void;
		/**
		 * Measures the specified HTML text, which may contain HTML tags such
		 *  as <font> and <b>,
		 *  assuming that it is displayed
		 *  in a single-line UITextField using a UITextFormat
		 *  determined by the styles of this UIComponent.
		 *
		 * @param htmlText          <String> A String specifying the HTML text to measure.
		 * @return                  <TextLineMetrics> A TextLineMetrics object containing the text measurements.
		 */
		public function measureHTMLText(htmlText:String):TextLineMetrics;
		/**
		 * Measures the specified text, assuming that it is displayed
		 *  in a single-line UITextField using a UITextFormat
		 *  determined by the styles of this UIComponent.
		 *
		 * @param text              <String> A String specifying the text to measure.
		 * @return                  <TextLineMetrics> A TextLineMetrics object containing the text measurements.
		 */
		public function measureText(text:String):TextLineMetrics;
		/**
		 * Moves the component to a specified position within its parent.
		 *  Calling this method is exactly the same as
		 *  setting the component's x and y properties.
		 *
		 * @param x                 <Number> Left position of the component within its parent.
		 * @param y                 <Number> Top position of the component within its parent.
		 */
		public function move(x:Number, y:Number):void;
		/**
		 * Propagates style changes to the children.
		 *  You typically never need to call this method.
		 *
		 * @param styleProp         <String> String specifying the name of the style property.
		 * @param recursive         <Boolean> Recursivly notify all children of this component.
		 */
		public function notifyStyleChangeInChildren(styleProp:String, recursive:Boolean):void;
		/**
		 * Returns true if the chain of owner properties
		 *  points from child to this UIComponent.
		 *
		 * @param child             <DisplayObject> A UIComponent.
		 * @return                  <Boolean> true if the child is parented or owned by this UIComponent.
		 */
		public function owns(child:DisplayObject):Boolean;
		/**
		 * Called by Flex when a UIComponent object is added to or removed from a parent.
		 *  Developers typically never need to call this method.
		 *
		 * @param p                 <DisplayObjectContainer> The parent of this UIComponent object.
		 */
		public function parentChanged(p:DisplayObjectContainer):void;
		/**
		 * Prepares an IFlexDisplayObject for printing.
		 *  For the UIComponent class, the method performs no action.
		 *  Flex containers override the method to prepare for printing;
		 *  for example, by removing scroll bars from the printed output.
		 *
		 * @param target            <IFlexDisplayObject> The component to be printed.
		 *                            It may be the current component or one of its children.
		 * @return                  <Object> Object containing the properties of the current component
		 *                            required by the finishPrint() method
		 *                            to restore it to its previous state.
		 */
		public function prepareToPrint(target:IFlexDisplayObject):Object;
		/**
		 * Builds or rebuilds the CSS style cache for this component
		 *  and, if the recursive parameter is true,
		 *  for all descendants of this component as well.
		 *
		 * @param recursive         <Boolean> Recursivly regenerates the style cache for
		 *                            all children of this component.
		 */
		public function regenerateStyleCache(recursive:Boolean):void;
		/**
		 * For each effect event, registers the EffectManager
		 *  as one of the event listeners.
		 *  You typically never need to call this method.
		 *
		 * @param effects           <Array> The names of the effect events.
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
		 * This method is called when a UIComponent is constructed,
		 *  and again whenever the ResourceManager dispatches
		 *  a "change" Event to indicate
		 *  that the localized resources have changed in some way.
		 */
		protected function resourcesChanged():void;
		/**
		 * Resumes the background processing of methods
		 *  queued by callLater(), after a call to
		 *  suspendBackgroundProcessing().
		 */
		public static function resumeBackgroundProcessing():void;
		/**
		 * Sizes the object.
		 *  Unlike directly setting the width and height
		 *  properties, calling the setActualSize() method
		 *  does not set the explictWidth and
		 *  explicitHeight properties, so a future layout
		 *  calculation may result in the object returning to its previous size.
		 *  This method is used primarily by component developers implementing
		 *  the updateDisplayList() method, by Effects,
		 *  and by the LayoutManager.
		 *
		 * @param w                 <Number> Width of the object.
		 * @param h                 <Number> Height of the object.
		 */
		public function setActualSize(w:Number, h:Number):void;
		/**
		 * Sets a layout constraint value, which is the same as
		 *  setting the constraint style for this component.
		 *
		 * @param constraintName    <String> 
		 * @param value             <*> 
		 */
		public function setConstraintValue(constraintName:String, value:*):void;
		/**
		 * Set the current state.
		 *
		 * @param stateName         <String> The name of the new view state.
		 * @param playTransition    <Boolean (default = true)> If true, play
		 *                            the appropriate transition when the view state changes.
		 */
		public function setCurrentState(stateName:String, playTransition:Boolean = true):void;
		/**
		 * Sets the focus to this component.
		 *  The component may in turn pass focus to a subcomponent.
		 */
		public function setFocus():void;
		/**
		 * Sets a style property on this component instance.
		 *
		 * @param styleProp         <String> Name of the style property.
		 * @param newValue          <*> New value for the style.
		 */
		public function setStyle(styleProp:String, newValue:*):void;
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
		/**
		 * Detects changes to style properties. When any style property is set,
		 *  Flex calls the styleChanged() method,
		 *  passing to it the name of the style being set.
		 *
		 * @param styleProp         <String> The name of the style property, or null if all styles for this
		 *                            component have changed.
		 */
		public function styleChanged(styleProp:String):void;
		/**
		 * Flex calls the stylesInitialized() method when
		 *  the styles for a component are first initialized.
		 */
		public function stylesInitialized():void;
		/**
		 * Blocks the background processing of methods
		 *  queued by callLater(),
		 *  until resumeBackgroundProcessing() is called.
		 */
		public static function suspendBackgroundProcessing():void;
		/**
		 * Draws the object and/or sizes and positions its children.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
		/**
		 * Validates the position and size of children and draws other
		 *  visuals.
		 *  If the LayoutManager.invalidateDisplayList() method is called with
		 *  this ILayoutManagerClient, then the validateDisplayList() method
		 *  is called when it's time to update the display list.
		 */
		public function validateDisplayList():void;
		/**
		 * Validate and update the properties and layout of this object
		 *  and redraw it, if necessary.
		 *  Processing properties that require substantial computation are normally
		 *  not processed until the script finishes executing.
		 *  For example setting the width property is delayed, because it may
		 *  require recalculating the widths of the objects children or its parent.
		 *  Delaying the processing prevents it from being repeated
		 *  multiple times if the script sets the width property more than once.
		 *  This method lets you manually override this behavior.
		 */
		public function validateNow():void;
		/**
		 * Used by layout logic to validate the properties of a component
		 *  by calling the commitProperties() method.
		 *  In general, subclassers should
		 *  override the commitProperties() method and not this method.
		 */
		public function validateProperties():void;
		/**
		 * Validates the measured size of the component
		 *  If the LayoutManager.invalidateSize() method is called with
		 *  this ILayoutManagerClient, then the validateSize() method
		 *  is called when it's time to do measurements.
		 *
		 * @param recursive         <Boolean (default = false)> If true, call this method
		 *                            on the objects children.
		 */
		public function validateSize(recursive:Boolean = false):void;
		/**
		 * Handles both the valid and invalid events from a
		 *  validator assigned to this component.
		 *
		 * @param event             <ValidationResultEvent> The event object for the validation.
		 */
		public function validationResultHandler(event:ValidationResultEvent):void;
		/**
		 * Returns a box Matrix which can be passed to drawRoundRect()
		 *  as the rot parameter when drawing a vertical gradient.
		 *
		 * @param x                 <Number> The left coordinate of the gradient, in pixels.
		 * @param y                 <Number> The top coordinate of the gradient, in pixels.
		 * @param width             <Number> The width of the gradient, in pixels.
		 * @param height            <Number> The height of the gradient, in pixels.
		 * @return                  <Matrix> The Matrix for the vertical gradient.
		 */
		public function verticalGradientMatrix(x:Number, y:Number, width:Number, height:Number):Matrix;
		/**
		 * The default value for the maxHeight property.
		 */
		public static const DEFAULT_MAX_HEIGHT:Number = 10000;
		/**
		 * The default value for the maxWidth property.
		 */
		public static const DEFAULT_MAX_WIDTH:Number = 10000;
		/**
		 * The default value for the measuredHeight property.
		 *  Most components calculate a measuredHeight but some are flow-based and
		 *  have to pick a number that looks reasonable.
		 */
		public static const DEFAULT_MEASURED_HEIGHT:Number = 22;
		/**
		 * The default value for the measuredMinHeight property.
		 *  Most components calculate a measuredMinHeight but some are flow-based and
		 *  have to pick a number that looks reasonable.
		 */
		public static const DEFAULT_MEASURED_MIN_HEIGHT:Number = 22;
		/**
		 * The default value for the measuredMinWidth property.
		 *  Most components calculate a measuredMinWidth but some are flow-based and
		 *  have to pick a number that looks reasonable.
		 */
		public static const DEFAULT_MEASURED_MIN_WIDTH:Number = 40;
		/**
		 * The default value for the measuredWidth property.
		 *  Most components calculate a measuredWidth but some are flow-based and
		 *  have to pick a number that looks reasonable.
		 */
		public static const DEFAULT_MEASURED_WIDTH:Number = 160;
	}
}
