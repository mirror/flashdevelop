package mx.flash
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import mx.automation.IAutomationObject;
	import mx.core.IConstraintClient;
	import mx.core.IDeferredInstantiationUIComponent;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.core.IStateClient;
	import mx.core.IUIComponent;
	import mx.core.UIComponentDescriptor;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	import mx.events.StateChangeEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.IToolTipManagerClient;
	import flash.events.FocusEvent;

	/**
	 *  Dispatched when the component is added to a container as a content child *  by using the <code>addChild()</code> or <code>addChildAt()</code> method.  *  If the component is added to the container as a noncontent child by  *  using the <code>rawChildren.addChild()</code> or  *  <code>rawChildren.addChildAt()</code> method, the event is not dispatched. *  *  @eventType mx.events.FlexEvent.ADD
	 */
	[Event(name="add", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component has finished its construction. *  For Flash-based components, this is the same time as the *  <code>initialize</code> event. * *  @eventType mx.events.FlexEvent.CREATION_COMPLETE
	 */
	[Event(name="creationComplete", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when an object's state changes from visible to invisible. * *  @eventType mx.events.FlexEvent.HIDE
	 */
	[Event(name="hide", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component has finished its construction *  and has all initialization properties set. * *  @eventType mx.events.FlexEvent.INITIALIZE
	 */
	[Event(name="initialize", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the object has moved. * *  <p>You can move the component by setting the <code>x</code> *  or <code>y</code> properties, by calling the <code>move()</code> *  method, by setting one  *  of the following properties either on the component or on other *  components such that the LayoutManager needs to change the *  <code>x</code> or <code>y</code> properties of the component:</p> * *  <ul> *    <li><code>minWidth</code></li> *    <li><code>minHeight</code></li> *    <li><code>maxWidth</code></li> *    <li><code>maxHeight</code></li> *    <li><code>explicitWidth</code></li> *    <li><code>explicitHeight</code></li> *  </ul> * *  <p>When you call the <code>move()</code> method, the <code>move</code> *  event is dispatched before the method returns. *  In all other situations, the <code>move</code> event is not dispatched *  until after the property changes.</p> * *  @eventType mx.events.MoveEvent.MOVE
	 */
	[Event(name="move", type="mx.events.MoveEvent")] 
	/**
	 *  Dispatched at the beginning of the component initialization sequence.  *  The component is in a very raw state when this event is dispatched.  *  Many components, such as the Button control, create internal child  *  components to implement functionality; for example, the Button control  *  creates an internal UITextField component to represent its label text.  *  When Flex dispatches the <code>preinitialize</code> event,  *  the children, including the internal children, of a component  *  have not yet been created. * *  @eventType mx.events.FlexEvent.PREINITIALIZE
	 */
	[Event(name="preinitialize", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component is removed from a container as a content child *  by using the <code>removeChild()</code> or <code>removeChildAt()</code> method.  *  If the component is removed from the container as a noncontent child by  *  using the <code>rawChildren.removeChild()</code> or  *  <code>rawChildren.removeChildAt()</code> method, the event is not dispatched. * *  @eventType mx.events.FlexEvent.REMOVE
	 */
	[Event(name="remove", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component is resized. * *  <p>You can resize the component by setting the <code>width</code> or *  <code>height</code> property, by calling the <code>setActualSize()</code> *  method, or by setting one of *  the following properties either on the component or on other components *  such that the LayoutManager needs to change the <code>width</code> or *  <code>height</code> properties of the component:</p> * *  <ul> *    <li><code>minWidth</code></li> *    <li><code>minHeight</code></li> *    <li><code>maxWidth</code></li> *    <li><code>maxHeight</code></li> *    <li><code>explicitWidth</code></li> *    <li><code>explicitHeight</code></li> *  </ul> * *  <p>The <code>resize</code> event is not  *  dispatched until after the property changes.</p> * *  @eventType mx.events.ResizeEvent.RESIZE
	 */
	[Event(name="resize", type="mx.events.ResizeEvent")] 
	/**
	 *  Dispatched when an object's state changes from invisible to visible. * *  @eventType mx.events.FlexEvent.SHOW
	 */
	[Event(name="show", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched from a component opened using the PopUpManager  *  when the user clicks outside it. * *  @eventType mx.events.FlexMouseEvent.MOUSE_DOWN_OUTSIDE
	 */
	[Event(name="mouseDownOutside", type="mx.events.FlexMouseEvent")] 
	/**
	 *  Dispatched from a component opened using the PopUpManager  *  when the user scrolls the mouse wheel outside it. * *  @eventType mx.events.FlexMouseEvent.MOUSE_WHEEL_OUTSIDE
	 */
	[Event(name="mouseWheelOutside", type="mx.events.FlexMouseEvent")] 
	/**
	 *  Dispatched by a component when the user moves the mouse over the component *  during a drag operation. * *  <p>In order to be a valid drop target, you must define a handler *  for this event. *  In the handler, you can change the appearance of the drop target *  to provide visual feedback to the user that the component can accept *  the drag. *  For example, you could draw a border around the drop target, *  or give focus to the drop target.</p> * *  <p>If you want to accept the drag, you must call the  *  <code>DragManager.acceptDragDrop()</code> method. If you don't *  call <code>acceptDragDrop()</code>, you will not get any of the *  other drag events.</p> * *  <p>The value of the <code>action</code> property is always *  <code>DragManager.MOVE</code>, even if you are doing a copy.  *  This is because the <code>dragEnter</code> event occurs before  *  the control recognizes that the Control key is pressed to signal a copy. *  The <code>action</code> property of the event object for the  *  <code>dragOver</code> event does contain a value that signifies the type of  *  drag operation.</p> *  *  <p>You may change the type of drag action by calling the *  <code>DragManager.showFeedback()</code> method.</p> * *  @see mx.managers.DragManager * *  @eventType mx.events.DragEvent.DRAG_ENTER
	 */
	[Event(name="dragEnter", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by a component when the user moves the mouse while over the component *  during a drag operation. * *  <p>In the handler, you can change the appearance of the drop target *  to provide visual feedback to the user that the component can accept *  the drag. *  For example, you could draw a border around the drop target, *  or give focus to the drop target.</p> * *  <p>You should handle this event to perform additional logic *  before allowing the drop, such as dropping data to various locations *  in the drop target, reading keyboard input to determine if the *  drag-and-drop action is a move or copy of the drag data, or providing *  different types of visual feedback based on the type of drag-and-drop *  action.</p> * *  <p>You may also change the type of drag action by changing the *  <code>DragManager.showFeedback()</code> method. *  The default value of the <code>action</code> property is *  <code>DragManager.MOVE</code>.</p> * *  @see mx.managers.DragManager * *  @eventType mx.events.DragEvent.DRAG_OVER
	 */
	[Event(name="dragOver", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by the component when the user drags outside the component, *  but does not drop the data onto the target. * *  <p>You use this event to restore the drop target to its normal appearance *  if you modified its appearance as part of handling the *  <code>dragEnter</code> or <code>dragOver</code> event.</p> * *  @eventType mx.events.DragEvent.DRAG_EXIT
	 */
	[Event(name="dragExit", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by the drop target when the user releases the mouse over it. * *  <p>You use this event handler to add the drag data to the drop target.</p> * *  <p>If you call <code>Event.preventDefault()</code> in the event handler  *  for the <code>dragDrop</code> event for  *  a Tree control when dragging data from one Tree control to another,  *  it prevents the drop.</p> * *  @eventType mx.events.DragEvent.DRAG_DROP
	 */
	[Event(name="dragDrop", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by the drag initiator (the component that is the source *  of the data being dragged) when the drag operation completes, *  either when you drop the dragged data onto a drop target or when you end *  the drag-and-drop operation without performing a drop. * *  <p>You can use this event to perform any final cleanup *  of the drag-and-drop operation. *  For example, if you drag a List control item from one list to another, *  you can delete the List control item from the source if you no longer *  need it.</p> * *  <p>If you call <code>Event.preventDefault()</code> in the event handler  *  for the <code>dragComplete</code> event for  *  a Tree control when dragging data from one Tree control to another,  *  it prevents the drop.</p> * *  @eventType mx.events.DragEvent.DRAG_COMPLETE
	 */
	[Event(name="dragComplete", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched after the <code>currentState</code> property changes, *  but before the view state changes. * *  @eventType mx.events.StateChangeEvent.CURRENT_STATE_CHANGING
	 */
	[Event(name="currentStateChanging", type="mx.events.StateChangeEvent")] 
	/**
	 *  Dispatched after the view state has changed. * *  @eventType mx.events.StateChangeEvent.CURRENT_STATE_CHANGE
	 */
	[Event(name="currentStateChange", type="mx.events.StateChangeEvent")] 
	/**
	 *  Dispatched by the component when it is time to create a ToolTip. * *  <p>If you create your own IToolTip object and place a reference *  to it in the <code>toolTip</code> property of the event object *  that is passed to your <code>toolTipCreate</code> handler, *  the ToolTipManager displays your custom ToolTip. *  Otherwise, the ToolTipManager creates an instance of *  <code>ToolTipManager.toolTipClass</code> to display.</p> * *  <p>The sequence of ToolTip events is <code>toolTipStart</code>, *  <code>toolTipCreate</code>, <code>toolTipShow</code>, *  <code>toolTipShown</code>, <code>toolTipHide</code>, *  and <code>toolTipEnd</code>.</p> * *  @eventType mx.events.ToolTipEvent.TOOL_TIP_CREATE
	 */
	[Event(name="toolTipCreate", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip has been hidden *  and will be discarded soon. * *  <p>If you specify an effect using the  *  <code>ToolTipManager.hideEffect</code> property,  *  this event is dispatched after the effect stops playing.</p> * *  <p>The sequence of ToolTip events is <code>toolTipStart</code>, *  <code>toolTipCreate</code>, <code>toolTipShow</code>, *  <code>toolTipShown</code>, <code>toolTipHide</code>, *  and <code>toolTipEnd</code>.</p> * *  @eventType mx.events.ToolTipEvent.TOOL_TIP_END
	 */
	[Event(name="toolTipEnd", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip is about to be hidden. * *  <p>If you specify an effect using the  *  <code>ToolTipManager.hideEffect</code> property,  *  this event is dispatched before the effect starts playing.</p> * *  <p>The sequence of ToolTip events is <code>toolTipStart</code>, *  <code>toolTipCreate</code>, <code>toolTipShow</code>, *  <code>toolTipShown</code>, <code>toolTipHide</code>, *  and <code>toolTipEnd</code>.</p> * *  @eventType mx.events.ToolTipEvent.TOOL_TIP_HIDE
	 */
	[Event(name="toolTipHide", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip is about to be shown. * *  <p>If you specify an effect using the  *  <code>ToolTipManager.showEffect</code> property,  *  this event is dispatched before the effect starts playing. *  You can use this event to modify the ToolTip before it appears.</p> * *  <p>The sequence of ToolTip events is <code>toolTipStart</code>, *  <code>toolTipCreate</code>, <code>toolTipShow</code>, *  <code>toolTipShown</code>, <code>toolTipHide</code>, *  and <code>toolTipEnd</code>.</p> * *  @eventType mx.events.ToolTipEvent.TOOL_TIP_SHOW
	 */
	[Event(name="toolTipShow", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip has been shown. * *  <p>If you specify an effect using the  *  <code>ToolTipManager.showEffect</code> property,  *  this event is dispatched after the effect stops playing.</p> * *  <p>The sequence of ToolTip events is <code>toolTipStart</code>, *  <code>toolTipCreate</code>, <code>toolTipShow</code>, *  <code>toolTipShown</code>, <code>toolTipHide</code>, *  and <code>toolTipEnd</code>.</p> * *  @eventType mx.events.ToolTipEvent.TOOL_TIP_SHOWN
	 */
	[Event(name="toolTipShown", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by a component whose <code>toolTip</code> property is set, *  as soon as the user moves the mouse over it. * *  <p>The sequence of ToolTip events is <code>toolTipStart</code>, *  <code>toolTipCreate</code>, <code>toolTipShow</code>, *  <code>toolTipShown</code>, <code>toolTipHide</code>, *  and <code>toolTipEnd</code>.</p> * *  @eventType mx.events.ToolTipEvent.TOOL_TIP_START
	 */
	[Event(name="toolTipStart", type="mx.events.ToolTipEvent")] 

	/**
	 *  Components created in Adobe Flash CS3 Professional for use in Flex  *  are subclasses of the mx.flash.UIMovieClip class.  *  The UIMovieClip class implements the interfaces necessary for a Flash component  *  to be used like a normal Flex component. Therefore, a subclass of UIMovieClip  *  can be used as a child of a Flex container or as a skin,  *  and it can respond to events, define view states and transitions,  *  and work with effects in the same way as can any Flex component. * *  <p>The following procedure describes the basic process for creating  *  a Flex component in Flash CS3:</p> * *  <ol> *    <li>Install the Adobe Flash Workflow Integration Kit.</li>  *    <li>Create symbols for your dynamic assets in the FLA file.</li> *    <li>Run Commands &gt; Make Flex Component to convert your symbol  *      to a subclass of the UIMovieClip class, and to configure  *      the Flash CS3 publishing settings for use with Flex.</li>  *    <li>Publish your FLA file as a SWC file.</li>  *    <li>Reference the class name of your symbols in your Flex application  *      as you would any class.</li>  *    <li>Include the SWC file in your <code>library-path</code> when you compile  *      your Flex application.</li> *  </ol> * *  <p>For more information, see the documentation that ships with the  *  Flex/Flash Integration Kit.</p>
	 */
	public dynamic class UIMovieClip extends MovieClip implements IDeferredInstantiationUIComponent
	{
		protected var initialized : Boolean;
		private var validateMeasuredSizeFlag : Boolean;
		private var _parent : DisplayObjectContainer;
		private var stateMap : Object;
		private var focusableObjects : Array;
		private var reverseDirectionFocus : Boolean;
		private var focusListenersAdded : Boolean;
		private var transitionStartFrame : Number;
		private var transitionEndFrame : Number;
		private var transitionDirection : Number;
		private var transitionEndState : String;
		private var oldX : Number;
		private var oldY : Number;
		protected var trackSizeChanges : Boolean;
		private var oldWidth : Number;
		private var oldHeight : Number;
		private var explicitSizeChanged : Boolean;
		private var explicitTabEnabledChanged : Boolean;
		/**
		 *  Name of the object to use as the bounding box.     *     *  <p>The bounding box is an object that is used by Flex to determine     *  the size of the component. The actual content can be larger or     *  smaller than the bounding box, but Flex uses the size of the     *  bounding box when laying out the component. This object is optional.     *  If omitted, the actual content size of the component is used instead.</p>     *     *  @default "boundingBox"
		 */
		public var boundingBoxName : String;
		private var _baseline : *;
		private var _bottom : *;
		private var _horizontalCenter : *;
		private var _left : *;
		private var _right : *;
		private var _top : *;
		private var _verticalCenter : *;
		private var _descriptor : UIComponentDescriptor;
		private var _id : String;
		private var _document : Object;
		private var _explicitHeight : Number;
		private var _explicitMaxHeight : Number;
		private var _explicitMaxWidth : Number;
		private var _explicitMinHeight : Number;
		private var _explicitMinWidth : Number;
		private var _explicitWidth : Number;
		private var _focusPane : Sprite;
		private var _includeInLayout : Boolean;
		private var _isPopUp : Boolean;
		private var _measuredMinHeight : Number;
		private var _measuredMinWidth : Number;
		private var _owner : DisplayObjectContainer;
		private var _percentHeight : Number;
		private var _percentWidth : Number;
		private var _systemManager : ISystemManager;
		private var _tweeningProperties : Array;
		/**
		 *  @private
		 */
		protected var _height : Number;
		private var _measuredHeight : Number;
		private var _measuredWidth : Number;
		/**
		 *  @private
		 */
		protected var _width : Number;
		private var _toolTip : String;
		private var _focusEnabled : Boolean;
		private var _currentState : String;
		private var _automationDelegate : IAutomationObject;
		/**
		 *  @private     *  Storage for the <code>automationName</code> property.
		 */
		private var _automationName : String;
		/**
		 *  @private     *  Storage for the <code>showInAutomationHierarchy</code> property.
		 */
		private var _showInAutomationHierarchy : Boolean;

		/**
		 *  Baseline constraint.
		 */
		public function get baseline () : *;
		public function set baseline (value:*) : void;
		/**
		 *  Bottom constraint.
		 */
		public function get bottom () : *;
		public function set bottom (value:*) : void;
		/**
		 *  Horizontal Center constraint.
		 */
		public function get horizontalCenter () : *;
		public function set horizontalCenter (value:*) : void;
		/**
		 *  Left constraint.
		 */
		public function get left () : *;
		public function set left (value:*) : void;
		/**
		 *  Right constraint.
		 */
		public function get right () : *;
		public function set right (value:*) : void;
		/**
		 *  Top constraint.
		 */
		public function get top () : *;
		public function set top (value:*) : void;
		/**
		 *  Vertical Center constraint.
		 */
		public function get verticalCenter () : *;
		public function set verticalCenter (value:*) : void;
		/**
		 *  Used by Flex to suggest bitmap caching for the object.     *  If <code>cachePolicy</code> is <code>UIComponentCachePolicy.AUTO</code>,      *  then <code>cacheHeuristic</code>     *  is used to control the object's <code>cacheAsBitmap</code> property.
		 */
		public function set cacheHeuristic (value:Boolean) : void;
		/**
		 *  Specifies the bitmap caching policy for this object.     *  Possible values in MXML are <code>"on"</code>,     *  <code>"off"</code> and     *  <code>"auto"</code> (default).     *      *  <p>Possible values in ActionScript are <code>UIComponentCachePolicy.ON</code>,     *  <code>UIComponentCachePolicy.OFF</code> and     *  <code>UIComponentCachePolicy.AUTO</code> (default).</p>     *     *  <p><ul>     *    <li>A value of <code>UIComponentCachePolicy.ON</code> means that      *      the object is always cached as a bitmap.</li>     *    <li>A value of <code>UIComponentCachePolicy.OFF</code> means that      *      the object is never cached as a bitmap.</li>     *    <li>A value of <code>UIComponentCachePolicy.AUTO</code> means that      *      the framework uses heuristics to decide whether the object should      *      be cached as a bitmap.</li>     *  </ul></p>     *     *  @default UIComponentCachePolicy.AUTO
		 */
		public function get cachePolicy () : String;
		/**
		 *  Reference to the UIComponentDescriptor, if any, that was used     *  by the <code>createComponentFromDescriptor()</code> method to create this     *  UIComponent instance. If this UIComponent instance      *  was not created from a descriptor, this property is null.     *     *  @see mx.core.UIComponentDescriptor
		 */
		public function get descriptor () : UIComponentDescriptor;
		/**
		 *  @private
		 */
		public function set descriptor (value:UIComponentDescriptor) : void;
		/**
		 *  ID of the component. This value becomes the instance name of the object     *  and should not contain any white space or special characters. Each component     *  throughout an application should have a unique id.     *     *  <p>If your application is going to be tested by third party tools, give each component     *  a meaningful id. Testing tools use ids to represent the control in their scripts and     *  having a meaningful name can make scripts more readable. For example, set the     *  value of a button to submit_button rather than b1 or button1.</p>
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  The y-coordinate of the baseline     *  of the first line of text of the component.
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @copy mx.core.IUIComponent#document
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;
		/**
		 *  The explicitly specified height for the component,      *  in pixels, as the component's coordinates.     *  If no height is explicitly specified, the value is <code>NaN</code>.     *     *  @see mx.core.UIComponent#explicitHeight
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;
		/**
		 *  Number that specifies the maximum height of the component,      *  in pixels, as the component's coordinates.      *     *  @see mx.core.UIComponent#explicitMaxHeight
		 */
		public function get explicitMaxHeight () : Number;
		public function set explicitMaxHeight (value:Number) : void;
		/**
		 *  Number that specifies the maximum width of the component,      *  in pixels, as the component's coordinates.      *     *  @see mx.core.UIComponent#explicitMaxWidth
		 */
		public function get explicitMaxWidth () : Number;
		public function set explicitMaxWidth (value:Number) : void;
		/**
		 *  Number that specifies the minimum height of the component,      *  in pixels, as the component's coordinates.      *     *  @see mx.core.UIComponent#explicitMinHeight
		 */
		public function get explicitMinHeight () : Number;
		public function set explicitMinHeight (value:Number) : void;
		/**
		 *  Number that specifies the minimum width of the component,      *  in pixels, as the component's coordinates.      *     *  @see mx.core.UIComponent#explicitMinWidth
		 */
		public function get explicitMinWidth () : Number;
		public function set explicitMinWidth (value:Number) : void;
		/**
		 *  The explicitly specified width for the component,      *  in pixels, as the component's coordinates.     *  If no width is explicitly specified, the value is <code>NaN</code>.     *     *  @see mx.core.UIComponent#explicitWidth
		 */
		public function get explicitWidth () : Number;
		public function set explicitWidth (value:Number) : void;
		/**
		 *  A single Sprite object that is shared among components     *  and used as an overlay for drawing focus.     *  Components share this object if their parent is a focused component,     *  not if the component implements the IFocusManagerComponent interface.     *     *  @see mx.core.UIComponent#focusPane
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  Specifies whether this component is included in the layout of the     *  parent container.     *  If <code>true</code>, the object is included in its parent container's     *  layout.  If <code>false</code>, the object is positioned by its parent     *  container as per its layout rules, but it is ignored for the purpose of     *  computing the position of the next child.     *     *  @default true
		 */
		public function get includeInLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set includeInLayout (value:Boolean) : void;
		/**
		 *  Set to <code>true</code> by the PopUpManager to indicate     *  that component has been popped up.
		 */
		public function get isPopUp () : Boolean;
		/**
		 *  @private
		 */
		public function set isPopUp (value:Boolean) : void;
		/**
		 *  Number that specifies the maximum height of the component,      *  in pixels, as the component's coordinates.     *     *  @see mx.core.UIComponent#maxHeight
		 */
		public function get maxHeight () : Number;
		public function set maxHeight (value:Number) : void;
		/**
		 *  Number that specifies the maximum width of the component,      *  in pixels, as the component's coordinates.     *     *  @see mx.core.UIComponent#maxWidth
		 */
		public function get maxWidth () : Number;
		public function set maxWidth (value:Number) : void;
		/**
		 *  The default minimum height of the component, in pixels.     *  This value is set by the <code>measure()</code> method.
		 */
		public function get measuredMinHeight () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinHeight (value:Number) : void;
		/**
		 *  The default minimum width of the component, in pixels.     *  This value is set by the <code>measure()</code> method.
		 */
		public function get measuredMinWidth () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinWidth (value:Number) : void;
		/**
		 *  Number that specifies the minimum height of the component,      *  in pixels, as the component's coordinates.      *     *  @see mx.core.UIComponent#minHeight
		 */
		public function get minHeight () : Number;
		public function set minHeight (value:Number) : void;
		/**
		 *  Number that specifies the minimum width of the component,      *  in pixels, as the component's coordinates.      *     *  @see mx.core.UIComponent#minWidth
		 */
		public function get minWidth () : Number;
		public function set minWidth (value:Number) : void;
		/**
		 *  Your owner is usually your parent, however     *  If you are a popup subcomponent, your owner will be     *  the component that popped you up.  For example,     *  a combobox dropdown's owner is the combobox.     *  This property is not managed by the framework, but      *  rather, by each component so if you popup sub-components     *  you should set this property on them
		 */
		public function get owner () : DisplayObjectContainer;
		/**
		 *  @private
		 */
		public function set owner (value:DisplayObjectContainer) : void;
		/**
		 *  Number that specifies the height of a component as a      *  percentage of its parent's size.     *  Allowed values are 0 to 100.
		 */
		public function get percentHeight () : Number;
		public function set percentHeight (value:Number) : void;
		/**
		 *  Number that specifies the width of a component as a      *  percentage of its parent's size.     *  Allowed values are 0 to 100.
		 */
		public function get percentWidth () : Number;
		public function set percentWidth (value:Number) : void;
		/**
		 *  A reference to the SystemManager object for this component.
		 */
		public function get systemManager () : ISystemManager;
		/**
		 *  @private
		 */
		public function set systemManager (value:ISystemManager) : void;
		/**
		 *  Used by EffectManager.     *  Returns non-null if a component     *  is not using the EffectManager to execute a Tween.
		 */
		public function get tweeningProperties () : Array;
		/**
		 *  @private
		 */
		public function set tweeningProperties (value:Array) : void;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;
		/**
		 *  The height of this object, in pixels.
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;
		/**
		 *  The measured height of this object.     *     *  <p>This is typically hard-coded for graphical skins     *  because this number is simply the number of pixels in the graphic.     *  For code skins, it can also be hard-coded     *  if you expect to be drawn at a certain size.     *  If your size can change based on properties, you may want     *  to also be an ILayoutManagerClient so a <code>measure()</code>     *  method will be called at an appropriate time,     *  giving you an opportunity to compute a <code>measuredHeight</code>.</p>
		 */
		public function get measuredHeight () : Number;
		/**
		 *  The measured width of this object.     *     *  <p>This is typically hard-coded for graphical skins     *  because this number is simply the number of pixels in the graphic.     *  For code skins, it can also be hard-coded     *  if you expect to be drawn at a certain size.     *  If your size can change based on properties, you may want     *  to also be an ILayoutManagerClient so a <code>measure()</code>     *  method will be called at an appropriate time,     *  giving you an opportunity to compute a <code>measuredHeight</code>.</p>
		 */
		public function get measuredWidth () : Number;
		/**
		 *  The width of this object, in pixels.
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;
		/**
		 *  Text to display in the ToolTip.     *     *  @default null
		 */
		public function get toolTip () : String;
		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;
		/**
		 *  A flag that indicates whether the component can receive focus when selected.	 * 	 *  <p>As an optimization, if a child component in your component 	 *  implements the IFocusManagerComponent interface, and you	 *  never want it to receive focus,	 *  you can set <code>focusEnabled</code>	 *  to <code>false</code> before calling <code>addChild()</code>	 *  on the child component.</p>	 * 	 *  <p>This will cause the FocusManager to ignore this component	 *  and not monitor it for changes to the <code>tabEnabled</code>,	 *  <code>tabChildren</code>, and <code>mouseFocusEnabled</code> properties.	 *  This also means you cannot change this value after	 *  <code>addChild()</code> and expect the FocusManager to notice.</p>	 *	 *  <p>Note: It does not mean that you cannot give this object focus	 *  programmatically in your <code>setFocus()</code> method;	 *  it just tells the FocusManager to ignore this IFocusManagerComponent	 *  component in the Tab and mouse searches.</p>
		 */
		public function get focusEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set focusEnabled (value:Boolean) : void;
		/**
		 *  A flag that indicates whether the component can receive focus 	 *  when selected with the mouse.	 *  If <code>false</code>, focus will be transferred to	 *  the first parent that is <code>mouseFocusEnabled</code>.
		 */
		public function get mouseFocusEnabled () : Boolean;
		/**
		 *  The unscaled bounds of the content.
		 */
		protected function get bounds () : Rectangle;
		/**
		 *  @private     *  Override the parent getter to skip non-UIComponent parents.
		 */
		public function get parent () : DisplayObjectContainer;
		/**
		 *  The document containing this component.
		 */
		public function get parentDocument () : Object;
		/**
		 *  The current state of this component. For UIMovieClip, the value of the      *  <code>currentState</code> property is the current frame label.
		 */
		public function get currentState () : String;
		public function set currentState (value:String) : void;
		/**
		 *  @private
		 */
		public function get tabEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set tabEnabled (value:Boolean) : void;
		/**
		 *  The delegate object that handles the automation-related functionality.
		 */
		public function get automationDelegate () : Object;
		/**
		 *  @private
		 */
		public function set automationDelegate (value:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function get automationName () : String;
		/**
		 *  @private
		 */
		public function set automationName (value:String) : void;
		/**
		 *  @copy mx.automation.IAutomationObject#automationValue
		 */
		public function get automationValue () : Array;
		/**
		 *  @inheritDoc
		 */
		public function get showInAutomationHierarchy () : Boolean;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function get numAutomationChildren () : int;
		/**
		 *  @inheritDoc
		 */
		public function get automationTabularData () : Object;

		/**
		 *  Constructor.
		 */
		public function UIMovieClip ();
		/**
		 *  Creates an <code>id</code> reference to this IUIComponent object     *  on its parent document object.     *  This function can create multidimensional references     *  such as b[2][4] for objects inside one or more repeaters.     *  If the indices are null, it creates a simple non-Array reference.     *     *  @param parentDocument The parent of this IUIComponent object.
		 */
		public function createReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  Deletes the <code>id</code> reference to this IUIComponent object     *  on its parent document object.     *  This function can delete from multidimensional references     *  such as b[2][4] for objects inside one or more Repeaters.     *  If the indices are null, it deletes the simple non-Array reference.     *     *  @param parentDocument The parent of this IUIComponent object.
		 */
		public function deleteReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  Executes the data bindings into this UIComponent object.     *     *  Workaround for MXML container/bindings problem (177074):     *  override Container.executeBindings() to prefer descriptor.document over parentDocument in the     *  call to BindingManager.executeBindings().     *     *  This should always provide the correct behavior for instances created by descriptor, and will     *  provide the original behavior for procedurally-created instances. (The bug may or may not appear     *  in the latter case.)     *     *  A more complete fix, guaranteeing correct behavior in both non-DI and reparented-component     *  scenarios, is anticipated for updater 1.     *     *  @param recurse Recursively execute bindings for children of this component.
		 */
		public function executeBindings (recurse:Boolean = false) : void;
		/**
		 *  For each effect event, register the EffectManager     *  as one of the event listeners.     *     *  @param effects An Array of strings of effect names.
		 */
		public function registerEffects (effects:Array) : void;
		public function getConstraintValue (constraintName:String) : *;
		public function setConstraintValue (constraintName:String, value:*) : void;
		/**
		 *  Initialize the object.     *     *  @see mx.core.UIComponent#initialize()
		 */
		public function initialize () : void;
		/**
		 *  Called by Flex when a UIComponent object is added to or removed from a parent.     *  Developers typically never need to call this method.     *     *  @param p The parent of this UIComponent object.
		 */
		public function parentChanged (p:DisplayObjectContainer) : void;
		/**
		 *  A convenience method for determining whether to use the     *  explicit or measured width     *     *  @return A Number which is explicitWidth if defined     *  or measuredWidth if not.
		 */
		public function getExplicitOrMeasuredWidth () : Number;
		/**
		 *  A convenience method for determining whether to use the     *  explicit or measured height     *     *  @return A Number which is explicitHeight if defined     *  or measuredHeight if not.
		 */
		public function getExplicitOrMeasuredHeight () : Number;
		/**
		 *  Called when the <code>visible</code> property changes.     *  You should set the <code>visible</code> property to show or hide     *  a component instead of calling this method directly.     *     *  @param value The new value of the <code>visible</code> property.      *  Specify <code>true</code> to show the component, and <code>false</code> to hide it.      *     *  @param noEvent If <code>true</code>, do not dispatch an event.      *  If <code>false</code>, dispatch a <code>show</code> event when      *  the component becomes visible, and a <code>hide</code> event when      *  the component becomes invisible.
		 */
		public function setVisible (value:Boolean, noEvent:Boolean = false) : void;
		/**
		 *  Returns <code>true</code> if the chain of <code>owner</code> properties      *  points from <code>child</code> to this UIComponent.     *     *  @param child A UIComponent.     *     *  @return <code>true</code> if the child is parented or owned by this UIComponent.
		 */
		public function owns (displayObject:DisplayObject) : Boolean;
		/**
		 *  Moves this object to the specified x and y coordinates.     *      *  @param x The new x-position for this object.     *      *  @param y The new y-position for this object.
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  Sets the actual size of this object.     *     *  <p>This method is mainly for use in implementing the     *  <code>updateDisplayList()</code> method, which is where     *  you compute this object's actual size based on     *  its explicit size, parent-relative (percent) size,     *  and measured size.     *  You then apply this actual size to the object     *  by calling <code>setActualSize()</code>.</p>     *     *  <p>In other situations, you should be setting properties     *  such as <code>width</code>, <code>height</code>,     *  <code>percentWidth</code>, or <code>percentHeight</code>     *  rather than calling this method.</p>     *      *  @param newWidth The new width for this object.     *      *  @param newHeight The new height for this object.
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
		/**
		 *  Called by the FocusManager when the component receives focus.	 *  The component may in turn set focus to an internal component.
		 */
		public function setFocus () : void;
		/**
		 *  Called by the FocusManager when the component receives focus.	 *  The component should draw or hide a graphic 	 *  that indicates that the component has focus.	 *	 *  @param isFocused If <code>true</code>, draw the focus indicator,	 *  otherwise hide it.
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  Validate the measuredWidth and measuredHeight properties to match the      *  current size of the content.
		 */
		private function validateMeasuredSize () : void;
		/**
		 *  Notify our parent that our size has changed.
		 */
		protected function notifySizeChanged () : void;
		/**
		 *  @private
		 */
		private function dispatchMoveEvent () : void;
		/**
		 *  @private
		 */
		protected function dispatchResizeEvent () : void;
		/**
		 *  @private
		 */
		protected function sizeChanged (oldValue:Number, newValue:Number) : Boolean;
		/**
		 *  Recursively finds all children that have tabEnabled=true and adds them	 *  to the focusableObjects array.
		 */
		protected function findFocusCandidates (obj:DisplayObjectContainer) : void;
		/**
		 *  Build a map of state name to labels.
		 */
		private function buildStateMap () : void;
		/**
		 *  The main function that watches our size and progesses through transitions.
		 */
		protected function enterFrameHandler (event:Event) : void;
		/**
		 *  Add the focus event listeners.
		 */
		private function addFocusEventListeners () : void;
		/**
		 *  Remove our focus event listeners.
		 */
		private function removeFocusEventListeners () : void;
		/**
		 *  Called when the focus is changed by keyboard navigation (TAB or Shift+TAB).     *  If we are currently managing the focus, stop the event propagation to     *  "steal" the event from the Flex focus manager.     *  If we are at the end of our focusable items (first item for Shift+TAB, or     *  last item for TAB), remove our event handlers to give control back     *  to the Flex focus manager.
		 */
		private function keyFocusChangeHandler (event:FocusEvent) : void;
		/**
		 *  Called when focus is entering any of our children. Make sure our     *  focus event handlers are called so we can take control from the     *  Flex focus manager.
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  Called when focus is leaving an object. We check to see if the new     *  focus item is in our focusableObjects list, and if not we remove     *  our event listeners to give control back to the Flex focus manager.
		 */
		private function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  Called during event capture phase when keyboard navigation is changing     *  focus. All we do here is set a flag so we know which direction the     *  focus is changing - TAB = forward; Shift+TAB = reverse.
		 */
		private function keyFocusChangeCaptureHandler (event:FocusEvent) : void;
		private function creationCompleteHandler (event:Event) : void;
		/**
		 *  @inheritDoc
		 */
		public function createAutomationIDPart (child:IAutomationObject) : Object;
		/**
		 *  @inheritDoc
		 */
		public function resolveAutomationIDPart (criteria:Object) : Array;
		/**
		 *  @inheritDoc
		 */
		public function getAutomationChildAt (index:int) : IAutomationObject;
		/**
		 *  @inheritDoc
		 */
		public function replayAutomatableEvent (event:Event) : Boolean;
	}
}
