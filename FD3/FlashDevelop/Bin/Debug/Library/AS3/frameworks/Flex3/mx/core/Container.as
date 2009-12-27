package mx.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	import mx.binding.BindingManager;
	import mx.controls.Button;
	import mx.controls.HScrollBar;
	import mx.controls.VScrollBar;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.graphics.RoundedRectangle;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerContainer;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.ISystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProtoChain;

	/**
	 *  Dispatched after a child has been added to a container.
 *
 *  <p>The childAdd event is dispatched when the <code>addChild()</code>
 *  or <code>addChildAt()</code> method is called.
 *  When a container is first created, the <code>addChild()</code>
 *  method is automatically called for each child component declared
 *  in the MXML file.
 *  The <code>addChildAt()</code> method is automatically called
 *  whenever a Repeater object adds or removes child objects.
 *  The application developer may also manually call these
 *  methods to add new children.</p>
 *
 *  <p>At the time when this event is sent, the child object has been
 *  initialized, but its width and height have not yet been calculated,
 *  and the child has not been drawn on the screen.
 *  If you want to be notified when the child has been fully initialized
 *  and rendered, then register as a listener for the child's
 *  <code>creationComplete</code> event.</p>
 *
 *  @eventType mx.events.ChildExistenceChangedEvent.CHILD_ADD
	 */
	[Event(name="childAdd", type="mx.events.ChildExistenceChangedEvent")] 

	/**
	 *  Dispatched after the index (among the container children) 
 *  of a container child changes.
 *  This event is only dispatched for the child specified as the argument to 
 *  the <code>setChildIndex()</code> method; it is not dispatched 
 *  for any other child whose index changes as a side effect of the call 
 *  to the <code>setChildIndex()</code> method.
 *
 *  <p>The child's index is changed when the
 *  <code>setChildIndex()</code> method is called.</p>
 *
 *  @eventType mx.events.IndexChangedEvent.CHILD_INDEX_CHANGE
	 */
	[Event(name="childIndexChange", type="mx.events.IndexChangedEvent")] 

	/**
	 *  Dispatched before a child of a container is removed.
 *
 *  <p>This event is delivered when any of the following methods is called:
 *  <code>removeChild()</code>, <code>removeChildAt()</code>,
 *  or <code>removeAllChildren()</code>.</p>
 *
 *  @eventType mx.events.ChildExistenceChangedEvent.CHILD_REMOVE
	 */
	[Event(name="childRemove", type="mx.events.ChildExistenceChangedEvent")] 

	/**
	 *  Dispatched when the <code>data</code> property changes.
 *
 *  <p>When a container is used as a renderer in a List or other components,
 *  the <code>data</code> property is used pass to the container 
 *  the data to display.</p>
 *
 *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 

	/**
	 *  Dispatched when the user manually scrolls the container.
 *
 *  <p>The event is dispatched when the scroll position is changed using
 *  either the mouse (e.g. clicking on the scrollbar's "down" button)
 *  or the keyboard (e.g., clicking on the down-arrow key).
 *  However, this event is not dispatched if the scroll position
 *  is changed programatically (e.g., setting the value of the
 *  <code>horizontalScrollPosition</code> property).
 *  The <code>viewChanged</code> event is delivered whenever the
 *  scroll position is changed, either manually or programatically.</p>
 *
 *  <p>At the time when this event is dispatched, the scrollbar has
 *  been updated to the new position, but the container's child objects
 *  have not been shifted to reflect the new scroll position.</p>
 *
 *  @eventType mx.events.ScrollEvent.SCROLL
	 */
	[Event(name="scroll", type="mx.events.ScrollEvent")] 

include "../styles/metadata/BarColorStyle.as"
include "../styles/metadata/BorderStyles.as"
include "../styles/metadata/PaddingStyles.as"
include "../styles/metadata/TextStyles.as"
	/**
	 *  If a background image is specified, this style specifies
 *  whether it is fixed with regard to the viewport (<code>"fixed"</code>)
 *  or scrolls along with the content (<code>"scroll"</code>).
 *
 *  @default "scroll"
	 */
	[Style(name="backgroundAttachment", type="String", inherit="no")] 

	/**
	 *  The alpha value for the overlay that is placed on top of the
 *  container when it is disabled.
	 */
	[Style(name="disabledOverlayAlpha", type="Number", inherit="no")] 

	/**
	 *  The name of the horizontal scrollbar style.
 *
 *  @default undefined
	 */
	[Style(name="horizontalScrollBarStyleName", type="String", inherit="no")] 

	/**
	 *  The name of the vertical scrollbar style.
 *
 *  @default undefined
	 */
	[Style(name="verticalScrollBarStyleName", type="String", inherit="no")] 

	/**
	 *  Number of pixels between the container's bottom border
 *  and the bottom of its content area.
 *
 *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the container's top border
 *  and the top of its content area.
 *
 *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

include "../core/Version.as"
	/**
	 *  The Container class is an abstract base class for components that
 *  controls the layout characteristics of child components.
 *  You do not create an instance of Container in an application.
 *  Instead, you create an instance of one of Container's subclasses,
 *  such as Canvas or HBox.
 *
 *  <p>The Container class contains the logic for scrolling, clipping,
 *  and dynamic instantiation. 
 *  It contains methods for adding and removing children.
 *  It also contains the <code>getChildAt()</code> method, and the logic
 *  for drawing the background and borders of containers.</p>
 *
 *  @mxml
 *
 *  Flex Framework containers inherit the following attributes from the Container
 *  class:</p>
 *
 *  <pre>
 *  &lt;mx:<i>tagname</i>
 *    <strong>Properties</strong>
 *    autoLayout="true|false"
 *    clipContent="true|false"
 *    creationIndex="undefined"
 *    creationPolicy="auto|all|queued|none"
 *    defaultButton="<i>No default</i>"
 *    horizontalLineScrollSize="5"
 *    horizontalPageScrollSize="0"
 *    horizontalScrollBar="null"
 *    horizontalScrollPolicy="auto|on|off"
 *    horizontalScrollPosition="0"
 *    icon="undefined"
 *    label=""
 *    verticalLineScrollSize="5"
 *    verticalPageScrollSize="0"
 *    verticalScrollBar="null"
 *    verticalScrollPolicy="auto|on|off"
 *    verticalScrollPosition="0"
 * 
 *    <strong>Styles</strong>
 *    backgroundAlpha="1.0"
 *    backgroundAttachment="scroll"
 *    backgroundColor="undefined"
 *    backgroundDisabledColor="undefined"
 *    backgroundImage="undefined"
 *    backgroundSize="auto" 
 *    <i>    For the Application container only,</i> backgroundSize="100%"
 *    barColor="undefined"
 *    borderColor="0xAAB3B3"
 *    borderSides="left top right bottom"
 *    borderSkin="mx.skins.halo.HaloBorder"
 *    borderStyle="inset"
 *    borderThickness="1"
 *    color="0x0B333C"
 *    cornerRadius="0"
 *    disabledColor="0xAAB3B3"
 *    disbledOverlayAlpha="undefined"
 *    dropShadowColor="0x000000"
 *    dropShadowEnabled="false"
 *    fontAntiAliasType="advanced"
 *    fontfamily="Verdana"
 *    fontGridFitType="pixel"
 *    fontSharpness="0""
 *    fontSize="10"
 *    fontStyle="normal"
 *    fontThickness="0"
 *    fontWeight="normal"
 *    horizontalScrollBarStyleName="undefined"
 *    paddingBottom="0"
 *    paddingLeft="0"
 *    paddingRight="0"
 *    paddingTop="0"
 *    shadowDirection="center"
 *    shadowDistance="2"
 *    textAlign="left"
 *    textDecoration="none|underline"
 *    textIndent="0"
 *    verticalScrollBarStyleName="undefined"
 * 
 *    <strong>Events</strong>
 *    childAdd="<i>No default</i>"
 *    childIndexChange="<i>No default</i>"
 *    childRemove="<i>No default</i>"
 *    dataChange="<i>No default</i>"
 *    scroll="<i>No default</i>"
 *    &gt;
 *      ...
 *      <i>child tags</i>
 *      ...
 *  &lt;/mx:<i>tagname</i>&gt;
 *  </pre>
	 */
	public class Container extends UIComponent implements IContainer
	{
		/**
		 *  @private
     *  See changedStyles, below
		 */
		private static const MULTIPLE_PROPERTIES : String = "<MULTIPLE>";
		/**
		 *  The creation policy of this container. 
     *  This property is useful when the container inherits its creation policy 
     *  from its parent container.
		 */
		protected var actualCreationPolicy : String;
		/**
		 *  @private
		 */
		private var numChildrenBefore : int;
		/**
		 *  @private
		 */
		private var recursionFlag : Boolean;
		/**
		 *  @private
     *  Remember when a child has been added or removed.
     *  When that occurs, we want to run the LayoutManager
     *  (even if autoLayout is false).
		 */
		private var forceLayout : Boolean;
		/**
		 *  @private
		 */
		var doingLayout : Boolean;
		/**
		 *  @private
     *  If this value is non-null, then we need to recursively notify children
     *  that a style property has changed.  If one style property has changed,
     *  this field holds the name of the style that changed.  If multiple style
     *  properties have changed, then the value of this field is
     *  Container.MULTIPLE_PROPERTIES.
		 */
		private var changedStyles : String;
		/**
		 *  @private
		 */
		private var _creatingContentPane : Boolean;
		/**
		 *  @private
     *  A box that takes up space in the lower right corner,
     *  between the horizontal and vertical scrollbars.
		 */
		protected var whiteBox : Shape;
		/**
		 *  @private
		 */
		var contentPane : Sprite;
		/**
		 *  @private
     *  Flags that remember what work to do during the next updateDisplayList().
		 */
		private var scrollPropertiesChanged : Boolean;
		private var scrollPositionChanged : Boolean;
		private var horizontalScrollPositionPending : Number;
		private var verticalScrollPositionPending : Number;
		/**
		 *  @private
     *  Cached values describing the total size of the content being scrolled
     *  and the size of the area in which the scrolled content is displayed.
		 */
		private var scrollableWidth : Number;
		private var scrollableHeight : Number;
		private var viewableWidth : Number;
		private var viewableHeight : Number;
		/**
		 *  @private
     *  The border/background object.
		 */
		var border : IFlexDisplayObject;
		/**
		 *  @private
     *  Sprite used to block user input when the container is disabled.
		 */
		var blocker : Sprite;
		/**
		 *  @private
     *  Keeps track of the number of mouse events we are listening for
		 */
		private var mouseEventReferenceCount : int;
		/**
		 *  @private
     *  Storage for the focusPane property.
		 */
		private var _focusPane : Sprite;
		/**
		 *  @private
     *  Storage for the numChildren property.
		 */
		var _numChildren : int;
		/**
		 *  @private
     *  Storage for the autoLayout property.
		 */
		private var _autoLayout : Boolean;
		/**
		 *  @private
     *  Storage for the childDescriptors property.
     *  This variable is initialized in the construct() method
     *  using the childDescriptors in the initObj, which is autogenerated.
     *  If this Container was not created by createComponentFromDescriptor(),
     *  its childDescriptors property is null.
		 */
		private var _childDescriptors : Array;
		/**
		 *  @private
     *  Storage for the childRepeaters property.
		 */
		private var _childRepeaters : Array;
		/**
		 *  @private
     *  Storage for the clipContent property.
		 */
		private var _clipContent : Boolean;
		/**
		 *  @private
     *  Internal variable used to keep track of the components created
     *  by this Container.  This is different than the list maintained
     *  by DisplayObjectContainer, because it includes Repeaters.
		 */
		private var _createdComponents : Array;
		/**
		 *  @private
     *  Storage for the creationIndex property.
		 */
		private var _creationIndex : int;
		/**
		 *  @private
     *  Storage for the creationPolicy property.
     *  This variable is initialized in the construct() method
     *  using the childDescriptors in the initObj, which is autogenerated.
     *  If this Container was not created by createComponentFromDescriptor(),
     *  its childDescriptors property is null.
		 */
		private var _creationPolicy : String;
		/**
		 *  @private
     *  Storage for the defaultButton property.
		 */
		private var _defaultButton : IFlexDisplayObject;
		/**
		 *  @private
     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  @private
     *  Storage for the firstChildIndex property.
		 */
		private var _firstChildIndex : int;
		/**
		 *  @private
     *  Storage for the horizontalLineScrollSize property.
		 */
		private var _horizontalLineScrollSize : Number;
		/**
		 *  @private
     *  Storage for the horizontalPageScrollSize property.
		 */
		private var _horizontalPageScrollSize : Number;
		/**
		 *  @private
     *  The horizontal scrollbar (null if not present).
		 */
		private var _horizontalScrollBar : ScrollBar;
		/**
		 *  @private
     *  Storage for the horizontalScrollPosition property.
		 */
		private var _horizontalScrollPosition : Number;
		/**
		 *  @private
     *  Storage for the horizontalScrollPolicy property.
		 */
		var _horizontalScrollPolicy : String;
		/**
		 *  @private
     *  Storage for the icon property.
		 */
		private var _icon : Class;
		/**
		 *  @private
     *  Storage for the label property.
		 */
		private var _label : String;
		/**
		 *  @private
		 */
		private var _numChildrenCreated : int;
		/**
		 *  @private
     *  The single IChildList object that's always returned
     *  from the rawChildren property, below.
		 */
		private var _rawChildren : ContainerRawChildrenList;
		/**
		 *  @private
     *  Storage for the verticalLineScrollSize property.
		 */
		private var _verticalLineScrollSize : Number;
		/**
		 *  @private
     *  Storage for the verticalPageScrollSize property.
		 */
		private var _verticalPageScrollSize : Number;
		/**
		 *  @private
     *  The vertical scrollbar (null if not present).
		 */
		private var _verticalScrollBar : ScrollBar;
		/**
		 *  @private
     *  Storage for the verticalScrollPosition property.
		 */
		private var _verticalScrollPosition : Number;
		/**
		 *  @private
     *  Storage for the verticalScrollPolicy property.
		 */
		var _verticalScrollPolicy : String;
		/**
		 *  @private
     *  Offsets including borders and scrollbars
		 */
		private var _viewMetrics : EdgeMetrics;
		/**
		 *  @private
     *  Cached value containing the view metrics plus the object's margins.
		 */
		private var _viewMetricsAndPadding : EdgeMetrics;
		/**
		 *  @private
     *  Used by a child component to force clipping during a Move effect
		 */
		private var _forceClippingCount : int;

		/**
		 *  Containers use an internal content pane to control scrolling. 
     *  The <code>creatingContentPane</code> is <code>true</code> while the container is creating 
     *  the content pane so that some events can be ignored or blocked.
		 */
		public function get creatingContentPane () : Boolean;
		public function set creatingContentPane (value:Boolean) : void;

		/**
		 *  @private
     *  The baselinePosition of a Container is calculated
     *  as if there was a UITextField using the Container's styles
     *  whose top is at viewMetrics.top.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @copy mx.core.UIComponent#contentMouseX
		 */
		public function get contentMouseX () : Number;

		/**
		 *  @copy mx.core.UIComponent#contentMouseY
		 */
		public function get contentMouseY () : Number;

		/**
		 *  @private
     *  Propagate to children.
		 */
		public function set doubleClickEnabled (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  @private
     *  Focus pane associated with this object.
     *  An object has a focus pane when one of its children has got focus.
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (o:Sprite) : void;

		/**
		 *  @private
     *  This property allows access to the Player's native implementation
     *  of the numChildren property, which can be useful since components
     *  can override numChildren and thereby hide the native implementation.
     *  Note that this "base property" is final and cannot be overridden,
     *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $numChildren () : int;

		/**
		 *  Number of child components in this container.
     *
     *  <p>The number of children is initially equal
     *  to the number of children declared in MXML.
     *  At runtime, new children may be added by calling
     *  <code>addChild()</code> or <code>addChildAt()</code>,
     *  and existing children may be removed by calling
     *  <code>removeChild()</code>, <code>removeChildAt()</code>,
     *  or <code>removeAllChildren()</code>.</p>
		 */
		public function get numChildren () : int;

		/**
		 *  If <code>true</code>, measurement and layout are done
     *  when the position or size of a child is changed.
     *  If <code>false</code>, measurement and layout are done only once,
     *  when children are added to or removed from the container.
     *
     *  <p>When using the Move effect, the layout around the component that
     *  is moving does not readjust to fit that the Move effect animates.
     *  Setting a container's <code>autoLayout</code> property to
     *  <code>true</code> has no effect on this behavior.</p>
     *
     *  <p>The Zoom effect does not work when the <code>autoLayout</code> 
     *  property is <code>false</code>.</p>
     *
     *  <p>The <code>autoLayout</code> property does not apply to
     *  Accordion or ViewStack containers.</p>
     * 
     *  @default true
		 */
		public function get autoLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLayout (value:Boolean) : void;

		/**
		 *  Returns an EdgeMetrics object that has four properties:
     *  <code>left</code>, <code>top</code>, <code>right</code>,
     *  and <code>bottom</code>.
     *  The value of each property is equal to the thickness of one side
     *  of the border, expressed in pixels.
     *
     *  <p>Unlike <code>viewMetrics</code>, this property is not
     *  overriden by subclasses of Container.</p>
		 */
		public function get borderMetrics () : EdgeMetrics;

		/**
		 *  Array of UIComponentDescriptor objects produced by the MXML compiler.
     *
     *  <p>Each UIComponentDescriptor object contains the information 
     *  specified in one child MXML tag of the container's MXML tag.
     *  The order of the UIComponentDescriptor objects in the Array
     *  is the same as the order of the child tags.
     *  During initialization, the child descriptors are used to create
     *  the container's child UIComponent objects and its Repeater objects, 
     *  and to give them the initial property values, event handlers, effects, 
     *  and so on, that were specified in MXML.</p>
     *
     *  @see mx.core.UIComponentDescriptor
		 */
		public function get childDescriptors () : Array;

		/**
		 *  @private
     *  An array of the Repeater objects found within this container.
		 */
		function get childRepeaters () : Array;
		/**
		 *  @private
		 */
		function set childRepeaters (value:Array) : void;

		/**
		 *  Whether to apply a clip mask if the positions and/or sizes
     *  of this container's children extend outside the borders of
     *  this container.
     *  If <code>false</code>, the children of this container
     *  remain visible when they are moved or sized outside the
     *  borders of this container.
     *  If <code>true</code>, the children of this container are clipped.
     *
     *  <p>If <code>clipContent</code> is <code>false</code>, then scrolling
     *  is disabled for this container and scrollbars will not appear.
     *  If <code>clipContent</code> is true, then scrollbars will usually
     *  appear when the container's children extend outside the border of
     *  the container.
     *  For additional control over the appearance of scrollbars,
     *  see <code>horizontalScrollPolicy</code> and <code>verticalScrollPolicy</code>.</p>
     * 
     *  @default true
		 */
		public function get clipContent () : Boolean;
		/**
		 *  @private
		 */
		public function set clipContent (value:Boolean) : void;

		/**
		 *  @private
     *  An array of all components created by this container including
     *  Repeater components.
		 */
		function get createdComponents () : Array;
		/**
		 *  @private
		 */
		function set createdComponents (value:Array) : void;

		/**
		 *  Specifies the order to instantiate and draw the children
     *  of the container.
     *
     *  <p>This property can only be used when the <code>creationPolicy</code>
     *  property is set to <code>ContainerCreationPolicy.QUEUED</code>.
     *  Otherwise, it is ignored.</p>
     *
     *  @default -1
		 */
		public function get creationIndex () : int;
		/**
		 *  @private
		 */
		public function set creationIndex (value:int) : void;

		/**
		 *  The child creation policy for this Container.
     *  ActionScript values can be <code>ContainerCreationPolicy.AUTO</code>, 
     *  <code>ContainerCreationPolicy.ALL</code>,
     *  <code>ContainerCreationPolicy.NONE</code>, 
     *  or <code>ContainerCreationPolicy.QUEUED</code>.
     *  MXML values can be <code>"auto"</code>, <code>"all"</code>, 
     *  <code>"none"</code>, or <code>"queued"</code>.
     *
     *  <p>If no <code>creationPolicy</code> is specified for a container,
     *  that container inherits its parent's <code>creationPolicy</code>.
     *  If no <code>creationPolicy</code> is specified for the Application,
     *  it defaults to <code>ContainerCreationPolicy.AUTO</code>.</p>
     *
     *  <p>A <code>creationPolicy</code> of <code>ContainerCreationPolicy.AUTO</code> means
     *  that the container delays creating some or all descendants
     *  until they are needed, a process which is known as <i>deferred
     *  instantiation</i>.
     *  This policy produces the best startup time because fewer
     *  UIComponents are created initially.
     *  However, this introduces navigation delays when a user navigates
     *  to other parts of the application for the first time.
     *  Navigator containers such as Accordion, TabNavigator, and ViewStack
     *  implement the <code>ContainerCreationPolicy.AUTO</code> policy by creating all their
     *  children immediately, but wait to create the deeper descendants
     *  of a child until it becomes the selected child of the navigator
     *  container.</p>
     *
     *  <p>A <code>creationPolicy</code> of <code>ContainerCreationPolicy.ALL</code> means
     *  that the navigator containers immediately create deeper descendants
     *  for each child, rather than waiting until that child is
     *  selected. For single-view containers such as a VBox container,
     *  there is no difference  between the <code>ContainerCreationPolicy.AUTO</code> and
     *  <code>ContainerCreationPolicy.ALL</code> policies.</p>
     *
     *  <p>A <code>creationPolicy</code> of <code>ContainerCreationPolicy.QUEUED</code> means
     *  that the container is added to a creation queue rather than being
     *  immediately instantiated and drawn.
     *  When the application processes the queued container, it creates
     *  the children of the container and then waits until the children
     *  have been created before advancing to the next container in the
     *  creation queue.</p>
     *
     *  <p>A <code>creationPolicy</code> of <code>ContainerCreationPolicy.NONE</code> means
     *  that the container creates none of its children.
     *  In that case, it is the responsibility of the MXML author
     *  to create the children by calling the
     *  <code>createComponentsFromDescriptors()</code> method.</p>
		 */
		public function get creationPolicy () : String;
		/**
		 *  @private
		 */
		public function set creationPolicy (value:String) : void;

		/**
		 *  The Button control designated as the default button
     *  for the container.
     *  When controls in the container have focus, pressing the
     *  Enter key is the same as clicking this Button control.
     *
     *  @default null
		 */
		public function get defaultButton () : IFlexDisplayObject;
		/**
		 *  @private
		 */
		public function set defaultButton (value:IFlexDisplayObject) : void;

		/**
		 *  The <code>data</code> property lets you pass a value
     *  to the component when you use it in an item renderer or item editor.
     *  You typically use data binding to bind a field of the <code>data</code>
     *  property to a property of this component.
     *
     *  <p>You do not set this property in MXML.</p>
     *
     *  @default null
     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;

		/**
		 *  @private
     *  The index of the first content child,
     *  when dealing with both content and non-content children.
		 */
		function get firstChildIndex () : int;

		/**
		 *  Number of pixels to move when the left- or right-arrow
     *  button in the horizontal scroll bar is pressed.
     *  
     *  @default 5
		 */
		public function get horizontalLineScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set horizontalLineScrollSize (value:Number) : void;

		/**
		 *  Number of pixels to move when the track in the
     *  horizontal scroll bar is pressed.
     *  A value of 0 means that the page size
     *  will be calculated to be a full screen.
     * 
     *  @default 0
		 */
		public function get horizontalPageScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set horizontalPageScrollSize (value:Number) : void;

		/**
		 *  The horizontal scrollbar used in this container.
     *  This property is null if no horizontal scroll bar
     *  is currently displayed.
     *  In general you do not access this property directly.
     *  Manipulation of the <code>horizontalScrollPolicy</code> 
     *  and <code>horizontalScrollPosition</code>
     *  properties should provide sufficient control over the scroll bar.
		 */
		public function get horizontalScrollBar () : ScrollBar;
		/**
		 *  @private
		 */
		public function set horizontalScrollBar (value:ScrollBar) : void;

		/**
		 *  The current position of the horizontal scroll bar.
     *  This is equal to the distance in pixels between the left edge
     *  of the scrollable surface and the leftmost piece of the surface
     *  that is currently visible.
     *  
     *  @default 0
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set horizontalScrollPosition (value:Number) : void;

		/**
		 *  Specifies whether the horizontal scroll bar is always present,
     *  always absent, or automatically added when needed.
     *  ActionScript values can be <code>ScrollPolicy.ON</code>, <code>ScrollPolicy.OFF</code>,
     *  and <code>ScrollPolicy.AUTO</code>. 
     *  MXML values can be <code>"on"</code>, <code>"off"</code>,
     *  and <code>"auto"</code>.
     *
     *  <p>Setting this property to <code>ScrollPolicy.OFF</code> also prevents the
     *  <code>horizontalScrollPosition</code> property from having an effect.</p>
     *
     *  <p>Note: This property does not apply to the ControlBar container.</p>
     *
     *  <p>If the <code>horizontalScrollPolicy</code> is <code>ScrollPolicy.AUTO</code>,
     *  the horizontal scroll bar appears when all of the following
     *  are true:</p>
     *  <ul>
     *    <li>One of the container's children extends beyond the left
     *      edge or right edge of the container.</li>
     *    <li>The <code>clipContent</code> property is <code>true</code>.</li>
     *    <li>The width and height of the container are large enough to
     *      reasonably accommodate a scroll bar.</li>
     *  </ul>
     *
     *  @default ScrollPolicy.AUTO
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;

		/**
		 *  The Class of the icon displayed by some navigator
     *  containers to represent this Container.
     *
     *  <p>For example, if this Container is a child of a TabNavigator,
     *  this icon appears in the corresponding tab.
     *  If this Container is a child of an Accordion,
     *  this icon appears in the corresponding header.</p>
     *
     *  <p>To embed the icon in the SWF file, use the &#64;Embed()
     *  MXML compiler directive:</p>
     *
     *  <pre>
     *    icon="&#64;Embed('filepath')"
     *  </pre>
     *
     *  <p>The image can be a JPEG, GIF, PNG, SVG, or SWF file.</p>
     *
     *  @default null
		 */
		public function get icon () : Class;
		/**
		 *  @private
		 */
		public function set icon (value:Class) : void;

		/**
		 *  The text displayed by some navigator containers to represent
     *  this Container.
     *
     *  <p>For example, if this Container is a child of a TabNavigator,
     *  this string appears in the corresponding tab.
     *  If this Container is a child of an Accordion,
     *  this string appears in the corresponding header.</p>
     *
     *  @default ""
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;

		/**
		 *  The largest possible value for the
     *  <code>horizontalScrollPosition</code> property.
     *  Defaults to 0 if the horizontal scrollbar is not present.
		 */
		public function get maxHorizontalScrollPosition () : Number;

		/**
		 *  The largest possible value for the
     *  <code>verticalScrollPosition</code> property.
     *  Defaults to 0 if the vertical scrollbar is not present.
		 */
		public function get maxVerticalScrollPosition () : Number;

		/**
		 *  @private
     *  The number of children created inside this container.
     *  The default value is 0.
		 */
		function get numChildrenCreated () : int;
		/**
		 *  @private
		 */
		function set numChildrenCreated (value:int) : void;

		/**
		 *  @private 
     *  The number of Repeaters in this Container.
     *
     *  <p>This number includes Repeaters that are immediate children of this
     *  container and Repeaters that are nested inside other Repeaters.
     *  Consider the following example:</p>
     *
     *  <pre>
     *  &lt;mx:HBox&gt;
     *    &lt;mx:Repeater dataProvider="[1, 2]"&gt;
     *      &lt;mx:Repeater dataProvider="..."&gt;
     *        &lt;mx:Button/&gt;
     *      &lt;/mx:Repeater&gt;
     *    &lt;/mx:Repeater&gt;
     *  &lt;mx:HBox&gt;
     *  </pre>
     *
     *  <p>In this example, the <code>numRepeaters</code> property
     *  for the HBox would be set equal to 3 -- one outer Repeater
     *  and two inner repeaters.</p>
     *
     *  <p>The <code>numRepeaters</code> property does not include Repeaters
     *  that are nested inside other containers.
     *  Consider this example:</p>
     *
     *  <pre>
     *  &lt;mx:HBox&gt;
     *    &lt;mx:Repeater dataProvider="[1, 2]"&gt;
     *      &lt;mx:VBox&gt;
     *        &lt;mx:Repeater dataProvider="..."&gt;
     *          &lt;mx:Button/&gt;
     *        &lt;/mx:Repeater&gt;
     *      &lt;/mx:VBox&gt;
     *    &lt;/mx:Repeater&gt;
     *  &lt;mx:HBox&gt;
     *  </pre>
     *
     *  <p>In this example, the <code>numRepeaters</code> property
     *  for the outer HBox would be set equal to 1 -- just the outer repeater.
     *  The two inner VBox containers would also have a
     *  <code>numRepeaters</code> property equal to 1 -- one Repeater
     *  per VBox.</p>
		 */
		function get numRepeaters () : int;

		/**
		 *  A container typically contains child components, which can be enumerated
     *  using the <code>Container.getChildAt()</code> method and 
     *  <code>Container.numChildren</code> property.  In addition, the container
     *  may contain style elements and skins, such as the border and background.
     *  Flash Player and AIR do not draw any distinction between child components
     *  and skins.  They are all accessible using the player's 
     *  <code>getChildAt()</code> method  and
     *  <code>numChildren</code> property.  
     *  However, the Container class overrides the <code>getChildAt()</code> method 
     *  and <code>numChildren</code> property (and several other methods) 
     *  to create the illusion that
     *  the container's children are the only child components.
     *
     *  <p>If you need to access all of the children of the container (both the
     *  content children and the skins), then use the methods and properties
     *  on the <code>rawChildren</code> property instead of the regular Container methods. 
     *  For example, use the <code>Container.rawChildren.getChildAt())</code> method.
     *  However, if a container creates a ContentPane Sprite object for its children,
     *  the <code>rawChildren</code> property value only counts the ContentPane, not the
     *  container's children.
     *  It is not always possible to determine when a container will have a ContentPane.</p>
     * 
     *  <p><b>Note:</b>If you call the <code>addChild</code> or 
     *  <code>addChildAt</code>method of the <code>rawChildren</code> object,
     *  set <code>tabEnabled = false</code> on the component that you have added.
     *  Doing so prevents users from tabbing to the visual-only component
     *  that you have added.</p>
		 */
		public function get rawChildren () : IChildList;

		/**
		 *  @private
		 */
		function get usePadding () : Boolean;

		/**
		 *  Number of pixels to scroll when the up- or down-arrow
     *  button in the vertical scroll bar is pressed,
     *  or when you scroll by using the mouse wheel.
     *  
     *  @default 5
		 */
		public function get verticalLineScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set verticalLineScrollSize (value:Number) : void;

		/**
		 *  Number of pixels to scroll when the track
     *  in the vertical scroll bar is pressed.
     *  A value of 0 means that the page size
     *  will be calculated to be a full screen.
     * 
     *  @default 0
		 */
		public function get verticalPageScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set verticalPageScrollSize (value:Number) : void;

		/**
		 *  The vertical scrollbar used in this container.
     *  This property is null if no vertical scroll bar
     *  is currently displayed.
     *  In general you do not access this property directly.
     *  Manipulation of the <code>verticalScrollPolicy</code> 
     *  and <code>verticalScrollPosition</code>
     *  properties should provide sufficient control over the scroll bar.
		 */
		public function get verticalScrollBar () : ScrollBar;
		/**
		 *  @private
		 */
		public function set verticalScrollBar (value:ScrollBar) : void;

		/**
		 *  The current position of the vertical scroll bar.
     *  This is equal to the distance in pixels between the top edge
     *  of the scrollable surface and the topmost piece of the surface
     *  that is currently visible.
     *
     *  @default 0
		 */
		public function get verticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;

		/**
		 *  Specifies whether the vertical scroll bar is always present,
     *  always absent, or automatically added when needed.
     *  Possible values are <code>ScrollPolicy.ON</code>, <code>ScrollPolicy.OFF</code>,
     *  and <code>ScrollPolicy.AUTO</code>.
     *  MXML values can be <code>"on"</code>, <code>"off"</code>,
     *  and <code>"auto"</code>.
     *
     *  <p>Setting this property to <code>ScrollPolicy.OFF</code> also prevents the
     *  <code>verticalScrollPosition</code> property from having an effect.</p>
     *
     *  <p>Note: This property does not apply to the ControlBar container.</p>
     *
     *  <p>If the <code>verticalScrollPolicy</code> is <code>ScrollPolicy.AUTO</code>,
     *  the vertical scroll bar appears when all of the following
     *  are true:</p>
     *  <ul>
     *    <li>One of the container's children extends beyond the top
     *      edge or bottom edge of the container.</li>
     *    <li>The <code>clipContent</code> property is <code>true</code>.</li>
     *    <li>The width and height of the container are large enough to
     *      reasonably accommodate a scroll bar.</li>
     *  </ul>
     *
     *  @default ScrollPolicy.AUTO
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;

		/**
		 *  Returns an object that has four properties: <code>left</code>,
     *  <code>top</code>, <code>right</code>, and <code>bottom</code>.
     *  The value of each property equals the thickness of the chrome
     *  (visual elements) around the edge of the container. 
     *
     *  <p>The chrome includes the border thickness.
     *  If the <code>horizontalScrollPolicy</code> or <code>verticalScrollPolicy</code> 
     *  property value is <code>ScrollPolicy.ON</code>, the
     *  chrome also includes the thickness of the corresponding
     *  scroll bar. If a scroll policy is <code>ScrollPolicy.AUTO</code>,
     *  the chrome measurement does not include the scroll bar thickness, 
     *  even if a scroll bar is displayed.</p>
     *
     *  <p>Subclasses of Container should override this method, so that
     *  they include other chrome to be taken into account when positioning
     *  the Container's children.
     *  For example, the <code>viewMetrics</code> property for the
     *  Panel class should return an object whose <code>top</code> property
     *  includes the thickness of the Panel container's title bar.</p>
		 */
		public function get viewMetrics () : EdgeMetrics;

		/**
		 *  Returns an object that has four properties: <code>left</code>,
     *  <code>top</code>, <code>right</code>, and <code>bottom</code>.
     *  The value of each property is equal to the thickness of the chrome
     *  (visual elements)
     *  around the edge of the container plus the thickness of the object's margins.
     *
     *  <p>The chrome includes the border thickness.
     *  If the <code>horizontalScrollPolicy</code> or <code>verticalScrollPolicy</code> 
     *  property value is <code>ScrollPolicy.ON</code>, the
     *  chrome also includes the thickness of the corresponding
     *  scroll bar. If a scroll policy is <code>ScrollPolicy.AUTO</code>,
     *  the chrome measurement does not include the scroll bar thickness, 
     *  even if a scroll bar is displayed.</p>
		 */
		public function get viewMetricsAndPadding () : EdgeMetrics;

		function set forceClipping (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function Container ();

		/**
		 *  @private
     *  If we add a mouse event, then we need to add a mouse shield
     *  to us and to all our children
     *  The mouseShield style is a non-inheriting style
     *  that is used by the view.
     *  The mouseShieldChildren style is an inherting style
     *  that is used by the children views.
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

		/**
		 *  @private
     *  We're doing special behavior on addEventListener to make sure that 
     *  we successfully capture mouse events, even when there's no background.
     *  However, this means adding an event listener changes the behavior 
     *  a little, and this can be troublesome for overlapping components
     *  that now don't get any mouse events.  This is acceptable normally; 
     *  however, automation adds certain events to the Container, and 
     *  it'd be better if automation support didn't modify the behavior of 
     *  the component.  For this reason, especially, we have an mx_internal 
     *  $addEventListener to add event listeners without affecting the behavior 
     *  of the component.
		 */
		function $addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

		/**
		 *  @private
     *  Remove the mouse shield if we no longer listen to any mouse events
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;

		/**
		 *  @private
     *  We're doing special behavior on removeEventListener to make sure that 
     *  we successfully capture mouse events, even when there's no background.
     *  However, this means removing an event listener changes the behavior 
     *  a little, and this can be troublesome for overlapping components
     *  that now don't get any mouse events.  This is acceptable normally; 
     *  however, automation adds certain events to the Container, and 
     *  it'd be better if automation support didn't modify the behavior of 
     *  the component.  For this reason, especially, we have an mx_internal 
     *  $removeEventListener to remove event listeners without affecting the behavior 
     *  of the component.
		 */
		function $removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;

		/**
		 *  Adds a child DisplayObject to this Container.
     *  The child is added after other existing children,
     *  so that the first child added has index 0,
     *  the next has index 1, an so on.
     *
     *  <p><b>Note: </b>While the <code>child</code> argument to the method
     *  is specified as of type DisplayObject, the argument must implement
     *  the IUIComponent interface to be added as a child of a container.
     *  All Flex components implement this interface.</p>
     *
     *  <p>Children are layered from back to front.
     *  In other words, if children overlap, the one with index 0
     *  is farthest to the back, and the one with index
     *  <code>numChildren - 1</code> is frontmost.
     *  This means the newly added children are layered
     *  in front of existing children.</p>
     *
     *  @param child The DisplayObject to add as a child of this Container.
     *  It must implement the IUIComponent interface.
     *
     *  @return The added child as an object of type DisplayObject. 
     *  You typically cast the return value to UIComponent, 
     *  or to the type of the added component.
     *
     *  @see mx.core.IUIComponent
     *
     *  @tiptext Adds a child object to this container.
		 */
		public function addChild (child:DisplayObject) : DisplayObject;

		/**
		 *  Adds a child DisplayObject to this Container.
     *  The child is added at the index specified.
     *
     *  <p><b>Note: </b>While the <code>child</code> argument to the method
     *  is specified as of type DisplayObject, the argument must implement
     *  the IUIComponent interface to be added as a child of a container.
     *  All Flex components implement this interface.</p>
     *
     *  <p>Children are layered from back to front.
     *  In other words, if children overlap, the one with index 0
     *  is farthest to the back, and the one with index
     *  <code>numChildren - 1</code> is frontmost.
     *  This means the newly added children are layered
     *  in front of existing children.</p>
     *
     *  <p>When you add a new child at an index that is already occupied
     *  by an old child, it doesn't replace the old child; instead the
     *  old child and the ones after it "slide over" and have their index
     *  incremented by one.
     *  For example, suppose a Container contains the children
     *  (A, B, C) and you add D at index 1.
     *  Then the container will contain (A, D, B, C).
     *  If you want to replace an old child, you must first remove it
     *  before adding the new one.</p>
     *
     *  @param child The DisplayObject to add as a child of this Container.
     *  It must implement the IUIComponent interface.
     *
     *  @param index The index to add the child at.
     *
     *  @return The added child as an object of type DisplayObject. 
     *  You typically cast the return value to UIComponent, 
     *  or to the type of the added component.
     *
     *  @see mx.core.IUIComponent
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;

		/**
		 *  Removes a child DisplayObject from the child list of this Container.
     *  The removed child will have its <code>parent</code>
     *  property set to null. 
     *  The child will still exist unless explicitly destroyed.
     *  If you add it to another container,
     *  it will retain its last known state.
     *
     *  @param child The DisplayObject to remove.
     *
     *  @return The removed child as an object of type DisplayObject. 
     *  You typically cast the return value to UIComponent, 
     *  or to the type of the removed component.
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;

		/**
		 *  Removes a child DisplayObject from the child list of this Container
     *  at the specified index.
     *  The removed child will have its <code>parent</code>
     *  property set to null. 
     *  The child will still exist unless explicitly destroyed.
     *  If you add it to another container,
     *  it will retain its last known state.
     *
     *  @param index The child index of the DisplayObject to remove.
     *
     *  @return The removed child as an object of type DisplayObject. 
     *  You typically cast the return value to UIComponent, 
     *  or to the type of the removed component.
		 */
		public function removeChildAt (index:int) : DisplayObject;

		/**
		 *  Gets the <i>n</i>th child component object.
     *
     *  <p>The children returned from this method include children that are
     *  declared in MXML and children that are added using the
     *  <code>addChild()</code> or <code>addChildAt()</code> method.</p>
     *
     *  @param childIndex Number from 0 to (numChildren - 1).
     *
     *  @return Reference to the child as an object of type DisplayObject. 
     *  You typically cast the return value to UIComponent, 
     *  or to the type of a specific Flex control, such as ComboBox or TextArea.
		 */
		public function getChildAt (index:int) : DisplayObject;

		/**
		 *  Returns the child whose <code>name</code> property is the specified String.
     *
     *  @param name The identifier of the child.
     *
     *  @return The DisplayObject representing the child as an object of type DisplayObject.
     *  You typically cast the return value to UIComponent, 
     *  or to the type of a specific Flex control, such as ComboBox or TextArea.
		 */
		public function getChildByName (name:String) : DisplayObject;

		/**
		 *  Gets the zero-based index of a specific child.
     *
     *  <p>The first child of the container (i.e.: the first child tag
     *  that appears in the MXML declaration) has an index of 0,
     *  the second child has an index of 1, and so on.
     *  The indexes of a container's children determine
     *  the order in which they get laid out.
     *  For example, in a VBox the child with index 0 is at the top,
     *  the child with index 1 is below it, etc.</p>
     *
     *  <p>If you add a child by calling the <code>addChild()</code> method,
     *  the new child's index is equal to the largest index among existing
     *  children plus one.
     *  You can insert a child at a specified index by using the
     *  <code>addChildAt()</code> method; in that case the indices of the
     *  child previously at that index, and the children at higher indices,
     *  all have their index increased by 1 so that all indices fall in the
     *  range from 0 to <code>(numChildren - 1)</code>.</p>
     *
     *  <p>If you remove a child by calling <code>removeChild()</code>
     *  or <code>removeChildAt()</code> method, then the indices of the
     *  remaining children are adjusted so that all indices fall in the
     *  range from 0 to <code>(numChildren - 1)</code>.</p>
     *
     *  <p>If <code>myView.getChildIndex(myChild)</code> returns 5,
     *  then <code>myView.getChildAt(5)</code> returns myChild.</p>
     *
     *  <p>The index of a child may be changed by calling the
     *  <code>setChildIndex()</code> method.</p>
     *
     *  @param child Reference to child whose index to get.
     *
     *  @return Number between 0 and (numChildren - 1).
		 */
		public function getChildIndex (child:DisplayObject) : int;

		/**
		 *  Sets the index of a particular child.
     *  See the <code>getChildIndex()</code> method for a
     *  description of the child's index.
     *
     *  @param child Reference to child whose index to set.
     *
     *  @param newIndex Number that indicates the new index.
     *  Must be an integer between 0 and (numChildren - 1).
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;

		/**
		 *  @private
		 */
		public function contains (child:DisplayObject) : Boolean;

		/**
		 *  @private
		 */
		public function initialize () : void;

		/**
		 *  @private
     *  Create components that are children of this Container.
		 */
		protected function createChildren () : void;

		/**
		 *  @private
     *  Override to NOT set precessedDescriptors.
		 */
		protected function initializationComplete () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
		 */
		public function validateSize (recursive:Boolean = false) : void;

		/**
		 *  @private
		 */
		public function validateDisplayList () : void;

		/**
		 *  Respond to size changes by setting the positions and sizes
     *  of this container's children.
     *
     *  <p>See the <code>UIComponent.updateDisplayList()</code> method for more information
     *  about the <code>updateDisplayList()</code> method.</p>
     *
     *  <p>The <code>Container.updateDisplayList()</code> method sets the position
     *  and size of the Container container's border.
     *  In every subclass of Container, the subclass's <code>updateDisplayList()</code>
     *  method should call the <code>super.updateDisplayList()</code> method,
     *  so that the border is positioned properly.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
     *
     *  @see mx.core.UIComponent
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @copy mx.core.UIComponent#contentToGlobal()
		 */
		public function contentToGlobal (point:Point) : Point;

		/**
		 *  @copy mx.core.UIComponent#globalToContent()
		 */
		public function globalToContent (point:Point) : Point;

		/**
		 *  @copy mx.core.UIComponent#contentToLocal()
		 */
		public function contentToLocal (point:Point) : Point;

		/**
		 *  @copy mx.core.UIComponent#localToContent()
		 */
		public function localToContent (point:Point) : Point;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
     *  Call the styleChanged method on children of this container
     *
     *  Notify chrome children immediately, and recursively call this
     *  function for all descendants of the chrome children.  We recurse
     *  regardless of the recursive flag because one of the descendants
     *  might have a styleName property that points to this object.
     *
     *  If recursive is true, then also notify content children ... but
     *  do it later.  Notification is deferred so that multiple calls to
     *  setStyle can be batched up into one traversal.
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;

		/**
		 *  @private
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;

		/**
		 *  Used internally by the Dissolve Effect to add the overlay to the chrome of a container.
		 */
		protected function attachOverlay () : void;

		/**
		 *  Fill an overlay object which is always the topmost child in the container.
     *  This method is used
     *  by the Dissolve effect; never call it directly. It is called
     *  internally by the <code>addOverlay()</code> method.
     *
     *  The Container fills the overlay object so it covers the viewable area returned
     *  by the <code>viewMetrics</code> property and uses the <code>cornerRadius</code> style.
		 */
		function fillOverlay (overlay:UIComponent, color:uint, targetArea:RoundedRectangle = null) : void;

		/**
		 *  Executes all the data bindings on this Container. Flex calls this method
     *  automatically once a Container has been created to cause any data bindings that
     *  have destinations inside of it to execute.
     *
     *  Workaround for MXML container/bindings problem (177074):
     *  override Container.executeBindings() to prefer descriptor.document over parentDocument in the
     *  call to BindingManager.executeBindings().
     *
     *  This should always provide the correct behavior for instances created by descriptor, and will
     *  provide the original behavior for procedurally-created instances. (The bug may or may not appear
     *  in the latter case.)
     *
     *  A more complete fix, guaranteeing correct behavior in both non-DI and reparented-component
     *  scenarios, is anticipated for updater 1.
     *
     *  @param recurse If <code>false</code>, then only execute the bindings
     *  on this Container. 
     *  If <code>true</code>, then also execute the bindings on this
     *  container's children, grandchildren,
     *  great-grandchildren, and so on.
		 */
		public function executeBindings (recurse:Boolean = false) : void;

		/**
		 *  @private
     *  Prepare the Object for printing
     *
     *  @see mx.printing.FlexPrintJob
		 */
		public function prepareToPrint (target:IFlexDisplayObject) : Object;

		/**
		 *  @private
     *  After printing is done
     *
     *  @see mx.printing.FlexPrintJob
		 */
		public function finishPrint (obj:Object, target:IFlexDisplayObject) : void;

		/**
		 *  @private
		 */
		function addingChild (child:DisplayObject) : void;

		/**
		 *  @private
		 */
		function childAdded (child:DisplayObject) : void;

		/**
		 *  @private
		 */
		function removingChild (child:DisplayObject) : void;

		/**
		 *  @private
		 */
		function childRemoved (child:DisplayObject) : void;

		/**
		 *  Returns an Array of DisplayObject objects consisting of the content children 
     *  of the container.
     *  This array does <b>not</b> include the DisplayObjects that implement 
     *  the container's display elements, such as its border and 
     *  the background image.
     *
     *  @return Array of DisplayObject objects consisting of the content children 
     *  of the container.
     * 
     *  @see #rawChildren
		 */
		public function getChildren () : Array;

		/**
		 *  Removes all children from the child list of this container.
		 */
		public function removeAllChildren () : void;

		/**
		 *  @private
     *  For containers, we need to ensure that at most one set of children
     *  has been specified for the component.
     *  There are two ways to specify multiple sets of children:
     *  a) the component itself, as well as an instance of the component,
     *  might specify children;
     *  b) both a base and derived component might specify children.
     *  Case (a) is handled in initialize(), above.
     *  Case (b) is handled here.
     *  This method is called in overrides of initialize()
     *  that are generated for MXML components.
		 */
		function setDocumentDescriptor (desc:UIComponentDescriptor) : void;

		/**
		 *  @private
     *  Used by subclasses, so must be public.
		 */
		function setActualCreationPolicies (policy:String) : void;

		/**
		 *  Iterate through the Array of <code>childDescriptors</code>,
     *  and call the <code>createComponentFromDescriptor()</code> method for each one.
     *  
     *  <p>If the value of the container's <code>creationPolicy</code> property is
     *  <code>ContainerCreationPolicy.ALL</code>, then this method is called
     *  automatically during the initialization sequence.</p>
     *  
     *  <p>If the value of the container's <code>creationPolicy</code> is
     *  <code>ContainerCreationPolicy.AUTO</code>,
     *  then this method is called automatically when the
     *  container's children are about to become visible.</p>
     *  
     *  <p>If the value of the container's <code>creationPolicy</code> property is
     *  <code>ContainerCreationPolicy.NONE</code>,
     *  then you should call this function
     *  when you want to create this container's children.</p>
     *
     *  @param recurse If <code>true</code>, recursively
     *  create components.
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;

		/**
		 *  Given a single UIComponentDescriptor, create the corresponding
     *  component and add the component as a child of this Container.
     *  
     *  <p>This method instantiates the new object but does not add it to the display list, so the object does not 
     *  appear on the screen by default. To add the new object to the display list, call the <code>validateNow()</code>
     *  method on the container after calling the <code>createComponentFromDescriptor()</code> method,
     *  as the following example shows:
     *  <pre>
     *  myVBox.createComponentFromDescriptor(myVBox.childDescriptors[0],false);
     *  myVBox.validateNow();
     *  </pre>
     *  </p>
     *  
     *  <p>Alternatively, you can call the <code>createComponentsFromDescriptors()</code> method on the 
     *  container to create all components at one time. You are not required to call the <code>validateNow()</code>
     *  method after calling the <code>createComponentsFromDescriptors()</code> method.</p>
     *  
     *
     *  @param descriptorOrIndex The UIComponentDescriptor for the
     *  component to be created. This argument is either a
     *  UIComponentDescriptor object or the index of one of the container's
     *  children (an integer between 0 and n-1, where n is the total
     *  number of children of this container).
     *
     *  @param recurse If <code>false</code>, create this component
     *  but none of its children.
     *  If <code>true</code>, after creating the component, Flex calls
     *  the <code>createComponentsFromDescriptors()</code> method to create all or some
     *  of its children, based on the value of the component's <code>creationPolicy</code> property.
     *
     *  @see mx.core.UIComponentDescriptor
		 */
		public function createComponentFromDescriptor (descriptor:ComponentDescriptor, recurse:Boolean) : IFlexDisplayObject;

		/**
		 *  @private
		 */
		private function hasChildMatchingDescriptor (descriptor:UIComponentDescriptor) : Boolean;

		/**
		 *  @private
     *  This class overrides addChild() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_addChild (child:DisplayObject) : DisplayObject;

		/**
		 *  @private
     *  This class overrides addChildAt() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_addChildAt (child:DisplayObject, index:int) : DisplayObject;

		/**
		 *  @private
     *  This class overrides removeChild() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_removeChild (child:DisplayObject) : DisplayObject;

		/**
		 *  @private
     *  This class overrides removeChildAt() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_removeChildAt (index:int) : DisplayObject;

		/**
		 *  @private
     *  This class overrides getChildAt() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_getChildAt (index:int) : DisplayObject;

		/**
		 *  @private
     *  This class overrides getChildByName() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_getChildByName (name:String) : DisplayObject;

		/**
		 *  @private
     *  This class overrides getChildIndex() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_getChildIndex (child:DisplayObject) : int;

		/**
		 *  @private
     *  This class overrides setChildIndex() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_setChildIndex (child:DisplayObject, newIndex:int) : void;

		/**
		 *  @private
     *  This class overrides getObjectsUnderPoint() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_getObjectsUnderPoint (pt:Point) : Array;

		/**
		 *  @private
     *  This class overrides contains() to deal with only content children,
     *  so in order to implement the rawChildren property we need
     *  a parallel method that deals with all children.
		 */
		function rawChildren_contains (child:DisplayObject) : Boolean;

		/**
		 *  Respond to size changes by setting the positions and sizes
     *  of this container's borders.
     *  This is an advanced method that you might override
     *  when creating a subclass of Container.
     *
     *  <p>Flex calls the <code>layoutChrome()</code> method when the
     *  container is added to a parent container using the <code>addChild()</code> method,
     *  and when the container's <code>invalidateDisplayList()</code> method is called.</p>
     *
     *  <p>The <code>Container.layoutChrome()</code> method is called regardless of the
     *  value of the <code>autoLayout</code> property.</p>
     *
     *  <p>The <code>Container.layoutChrome()</code> method sets the
     *  position and size of the Container container's border.
     *  In every subclass of Container, the subclass's <code>layoutChrome()</code>
     *  method should call the <code>super.layoutChrome()</code> method,
     *  so that the border is positioned properly.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  Creates the container's border skin 
     *  if it is needed and does not already exist.
		 */
		protected function createBorder () : void;

		/**
		 *  @private
		 */
		private function isBorderNeeded () : Boolean;

		/**
		 *  @private
		 */
		function invalidateViewMetricsAndPadding () : void;

		/**
		 *  @private
		 */
		private function createOrDestroyBlocker () : void;

		/**
		 *  @private
		 */
		private function updateBackgroundImageRect () : void;

		/**
		 *  @private
		 */
		private function createContentPaneAndScrollbarsIfNeeded () : Boolean;

		/**
		 *  @private
		 */
		function getScrollableRect () : Rectangle;

		/**
		 *  @private
		 */
		private function createScrollbarsIfNeeded (bounds:Rectangle) : Boolean;

		/**
		 *  @private
		 */
		private function createOrDestroyScrollbars (needHorizontal:Boolean, needVertical:Boolean, needContentPane:Boolean) : Boolean;

		/**
		 *  @private
     *  Ensures that horizontalScrollPosition is in the range
     *  from 0 through maxHorizontalScrollPosition and that
     *  verticalScrollPosition is in the range from 0 through
     *  maxVerticalScrollPosition.
     *  Returns true if either horizontalScrollPosition or
     *  verticalScrollPosition was changed to ensure this.
		 */
		private function clampScrollPositions () : Boolean;

		/**
		 *  @private
		 */
		function createContentPane () : void;

		/**
		 *  Positions the container's content area relative to the viewable area 
     *  based on the horizontalScrollPosition and verticalScrollPosition properties. 
     *  Content that doesn't appear in the viewable area gets clipped. 
     *  This method should be overridden by subclasses that have scrollable 
     *  chrome in the content area.
		 */
		protected function scrollChildren () : void;

		/**
		 *  @private
		 */
		private function dispatchScrollEvent (direction:String, oldPosition:Number, newPosition:Number, detail:String) : void;

		/**
		 *  Executes the bindings into this Container's child UIComponent objects.
     *  Flex calls this method automatically once a Container has been created.
     *
     *  @param recurse If <code>false</code>, then only execute the bindings
     *  on the immediate children of this Container. 
     *  If <code>true</code>, then also execute the bindings on this
     *  container's grandchildren,
     *  great-grandchildren, and so on.
		 */
		public function executeChildBindings (recurse:Boolean) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
     *  This method copied verbatim from mx.core.ScrollControlBase.
		 */
		private function mouseWheelHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  This function is called when the LayoutManager finishes running.
     *  Clear the forceLayout flag that was set earlier.
		 */
		private function layoutCompleteHandler (event:FlexEvent) : void;

		/**
		 *  @private
		 */
		private function creationCompleteHandler (event:FlexEvent) : void;

		/**
		 *  @private
     *  This method is called if the user interactively moves
     *  the horizontal scrollbar thumb.
		 */
		private function horizontalScrollBar_scrollHandler (event:Event) : void;

		/**
		 *  @private
     *  This method is called if the user interactively moves
     *  the vertical scrollbar thumb.
		 */
		private function verticalScrollBar_scrollHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function blocker_clickHandler (event:Event) : void;
	}
}
