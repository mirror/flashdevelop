package mx.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.FocusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.text.TextLineMetrics;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import mx.automation.IAutomationObject;
	import mx.binding.BindingManager;
	import mx.controls.IFlexContextMenu;
	import mx.effects.EffectManager;
	import mx.effects.IEffect;
	import mx.effects.IEffectInstance;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.DragEvent;
	import mx.events.DynamicEvent;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.MoveEvent;
	import mx.events.PropertyChangeEvent;
	import mx.events.ResizeEvent;
	import mx.events.StateChangeEvent;
	import mx.events.ToolTipEvent;
	import mx.events.ValidationResultEvent;
	import mx.graphics.RoundedRectangle;
	import mx.managers.CursorManager;
	import mx.managers.ICursorManager;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.IFocusManagerContainer;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.ISystemManager;
	import mx.managers.IToolTipManagerClient;
	import mx.managers.SystemManager;
	import mx.managers.SystemManagerGlobals;
	import mx.managers.SystemManagerProxy;
	import mx.managers.ToolTipManager;
	import mx.modules.ModuleManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.states.State;
	import mx.states.Transition;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProtoChain;
	import mx.utils.ColorUtil;
	import mx.utils.GraphicsUtil;
	import mx.utils.StringUtil;
	import mx.validators.IValidatorListener;
	import mx.validators.ValidationResult;
	import flash.system.Security;

	/**
	 *  Dispatched when the component is added to a container as a content child *  by using the <code>addChild()</code> or <code>addChildAt()</code> method.  *  If the component is added to the container as a noncontent child by  *  using the <code>rawChildren.addChild()</code> or  *  <code>rawChildren.addChildAt()</code> method, the event is not dispatched. *  *  @eventType mx.events.FlexEvent.ADD
	 */
	[Event(name="add", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component has finished its construction, *  property processing, measuring, layout, and drawing. * *  <p>At this point, depending on its <code>visible</code> property, *  the component may not be visible even though it has been drawn.</p> * *  @eventType mx.events.FlexEvent.CREATION_COMPLETE
	 */
	[Event(name="creationComplete", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when an object has had its <code>commitProperties()</code>,  *  <code>measure()</code>, and *  <code>updateDisplayList()</code> methods called (if needed). * *  <p>This is the last opportunity to alter the component before it is *  displayed. All properties have been committed and the component has *  been measured and layed out.</p> * *  @eventType mx.events.FlexEvent.UPDATE_COMPLETE
	 */
	[Event(name="updateComplete", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when an object's state changes from visible to invisible. * *  @eventType mx.events.FlexEvent.HIDE
	 */
	[Event(name="hide", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component has finished its construction *  and has all initialization properties set. * *  <p>After the initialization phase, properties are processed, the component *  is measured, laid out, and drawn, after which the *  <code>creationComplete</code> event is dispatched.</p> * *  @eventType mx.events.FlexEvent.INITIALIZE
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
	 *  Dispatched when values are changed programmatically *  or by user interaction. * *  <p>Because a programmatic change triggers this event, make sure *  that any <code>valueCommit</code> event handler does not change *  a value that causes another <code>valueCommit</code> event. *  For example, do not change a control's <code>dataProvider</code> *  property in a <code>valueCommit</code> event handler. </p> * *  @eventType mx.events.FlexEvent.VALUE_COMMIT
	 */
	[Event(name="valueCommit", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when a component is monitored by a Validator *  and the validation failed. * *  @eventType mx.events.FlexEvent.INVALID
	 */
	[Event(name="invalid", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when a component is monitored by a Validator *  and the validation succeeded. * *  @eventType mx.events.FlexEvent.VALID
	 */
	[Event(name="valid", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched by a component when the user moves the mouse over the component *  during a drag operation.  *  In an application running in Flash Player,  *  the event is dispatched many times when you move the mouse over any component. *  In an application running in AIR, the event is dispatched only once. * *  <p>In order to be a valid drop target, you must define a handler *  for this event. *  In the handler, you can change the appearance of the drop target *  to provide visual feedback to the user that the component can accept *  the drag. *  For example, you could draw a border around the drop target, *  or give focus to the drop target.</p> * *  <p>If you want to accept the drag, you must call the  *  <code>DragManager.acceptDragDrop()</code> method. If you don't *  call <code>acceptDragDrop()</code>, you will not get any of the *  other drag events.</p> * *  <p>In Flash Player, the value of the <code>action</code> property is always *  <code>DragManager.MOVE</code>, even if you are doing a copy.  *  This is because the <code>dragEnter</code> event occurs before  *  the control recognizes that the Control key is pressed to signal a copy. *  The <code>action</code> property of the event object for the  *  <code>dragOver</code> event does contain a value that signifies the type of  *  drag operation. You may change the type of drag action by calling the *  <code>DragManager.showFeedback()</code> method.</p> * *  <p>In AIR, the default value of the <code>action</code> property is  *  <code>DragManager.COPY</code>.</p>  * *  <p>Because of the way data to a Tree control is structured,  *  the Tree control handles drag and drop differently from the other list-based controls.  *  For the Tree control, the event handler for the <code>dragDrop</code> event  *  only performs an action when you move or copy data in the same Tree control,  *  or copy data to another Tree control.  *  If you drag data from one Tree control and drop it onto another Tree control  *  to move the data, the event handler for the <code>dragComplete</code> event  *  actually performs the work to add the data to the destination Tree control,  *  rather than the event handler for the dragDrop event,  *  and also removes the data from the source Tree control.  *  This is necessary because to reparent the data being moved,  *  Flex must remove it first from the source Tree control.</p> * *  @see mx.managers.DragManager * *  @eventType mx.events.DragEvent.DRAG_ENTER
	 */
	[Event(name="dragEnter", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by a component when the user moves the mouse while over the component *  during a drag operation.  *  In Flash Player, the event is dispatched  *  when you drag an item over a valid drop target. *  In AIR, the event is dispatched when you drag an item over  *  any component, even if the component is not a valid drop target. * *  <p>In the handler, you can change the appearance of the drop target *  to provide visual feedback to the user that the component can accept *  the drag. *  For example, you could draw a border around the drop target, *  or give focus to the drop target.</p> * *  <p>You should handle this event to perform additional logic *  before allowing the drop, such as dropping data to various locations *  in the drop target, reading keyboard input to determine if the *  drag-and-drop action is a move or copy of the drag data, or providing *  different types of visual feedback based on the type of drag-and-drop *  action.</p> * *  <p>You may also change the type of drag action by changing the *  <code>DragManager.showFeedback()</code> method. *  The default value of the <code>action</code> property is *  <code>DragManager.MOVE</code>.</p> * *  @see mx.managers.DragManager * *  @eventType mx.events.DragEvent.DRAG_OVER
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
	 *  Dispatched by the drag initiator when starting a drag operation. *  This event is used internally by the list-based controls;  *  you do not handle it when implementing drag and drop.  *  If you want to control the start of a drag-and-drop operation,  *  use the <code>mouseDown</code> or <code>mouseMove</code> event. *  *  @eventType mx.events.DragEvent.DRAG_START
	 */
	[Event(name="dragStart", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched just before an effect starts. * *  <p>The effect does not start changing any visuals *  until after this event is fired.</p> * *  @eventType mx.events.EffectEvent.EFFECT_START
	 */
	[Event(name="effectStart", type="mx.events.EffectEvent")] 
	/**
	 *  Dispatched after an effect ends. * *  <p>The effect will have made the last set of visual changes *  before this event is fired, but those changes will not have *  been rendered on the screen. *  Thus, you might have to use the <code>callLater()</code> method *  to delay any other changes that you want to make until after the  *  changes have been rendered onscreen.</p> * *  @eventType mx.events.EffectEvent.EFFECT_END
	 */
	[Event(name="effectEnd", type="mx.events.EffectEvent")] 
	/**
	 *  Dispatched after the <code>currentState</code> property changes, *  but before the view state changes. * *  @eventType mx.events.StateChangeEvent.CURRENT_STATE_CHANGING
	 */
	[Event(name="currentStateChanging", type="mx.events.StateChangeEvent")] 
	/**
	 *  Dispatched after the view state has changed. * *  @eventType mx.events.StateChangeEvent.CURRENT_STATE_CHANGE
	 */
	[Event(name="currentStateChange", type="mx.events.StateChangeEvent")] 
	/**
	 *  Dispatched after the component has returned to the root view state. * *  @eventType mx.events.FlexEvent.ENTER_STATE
	 */
	[Event(name="enterState", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched before the component exits from the root view state. * *  @eventType mx.events.FlexEvent.EXIT_STATE
	 */
	[Event(name="exitState", type="mx.events.FlexEvent")] 
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
	 *  Color of the component highlight when validation fails.  *  Flex also sets the <code>borderColor</code> style of the component to this  *  <code>errorColor</code> on a validation failure. * *  @default 0xFF0000
	 */
	[Style(name="errorColor", type="uint", format="Color", inherit="yes")] 
	/**
	 *  Blend mode used by the focus rectangle. *  For more information, see the <code>blendMode</code> property  *  of the flash.display.DisplayObject class. * *  @default "normal"
	 */
	[Style(name="focusBlendMode", type="String", inherit="no")] 
	/**
	 *  Skin used to draw the focus rectangle. * *  @default mx.skins.halo.HaloFocusRect
	 */
	[Style(name="focusSkin", type="Class", inherit="no")] 
	/**
	 *  Thickness, in pixels, of the focus rectangle outline. * *  @default 2
	 */
	[Style(name="focusThickness", type="Number", format="Length", inherit="no")] 
	/**
	 *  Theme color of a component. This property controls the appearance of highlights, *  appearance when a component is selected, and other similar visual cues, but it *  does not have any effect on the regular borders or background colors of the component. *  The preferred values are <code>haloGreen</code>, <code>haloBlue</code>, *  <code>haloOrange</code>, and <code>haloSilver</code>, although any valid color *  value can be used. * *  <p>The default values of the <code>rollOverColor</code> and *  <code>selectionColor</code> styles are based on the *  <code>themeColor</code> value.</p> * *  @default "haloBlue"
	 */
	[Style(name="themeColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The UIComponent class is the base class for all visual components, *  both interactive and noninteractive. * *  <p>An interactive component can participate in tabbing and other kinds of *  keyboard focus manipulation, accept low-level events like keyboard and *  mouse input, and be disabled so that it does not receive keyboard and *  mouse input. *  This is in contrast to noninteractive components, like Label and *  ProgressBar, which simply display contents and are not manipulated by *  the user.</p> *  <p>The UIComponent class is not used as an MXML tag, but is used as a base *  class for other classes.</p> * *  @mxml * *  <p>All user interface components in Flex extend the UIComponent class. *  Flex components inherit the following properties from the UIComponent *  class:</p> * *  <pre> *  &lt;mx:<i>tagname</i> *   <b>Properties </b> *    automationName="null" *    cachePolicy="auto|on|off" *    currentState="null" *    doubleClickEnabled="false|true" *    enabled="true|false" *    explicitHeight="NaN" *    explicitMaxHeight="NaN" *    explicitMaxWidth="NaN" *    explicitMinHeight="NaN" *    explicitMinWidth="NaN" *    explicitWidth="NaN" *    focusEnabled="true|false" *    height="0" *    id="" *    includeInLayout="true|false" *    maxHeight="10000" *    maxWidth="10000" *    measuredHeight= *    measuredMinHeight= *    measuredMinWidth= *    measuredWidth= *    minHeight="0" *    minWidth="0" *    mouseFocusEnabled="true|false" *    percentHeight="NaN" *    percentWidth="NaN" *    scaleX="1.0" *    scaleY="1.0" *    states="null" *    styleName="undefined" *    toolTip="null" *    transitions="" *    validationSubField *    width="0" *    x="0" *    y="0" *   *  <b>Styles</b> *    bottom="undefined" *    errorColor="0xFF0000" *    focusBlendMode="normal" *    focusSkin="HaloFocusRect"" *    focusThickness="2" *    horizontalCenter="undefined" *    left="undefined" *    right="undefined" *    themeColor="haloGreen" *    top="undefined" *    verticalCenter="undefined" *   *  <b>Effects</b> *    addedEffect="<i>No default</i>" *    creationCompleteEffect="<i>No default</i>"  *   focusInEffect="<i>No default</i>" *    focusOutEffect="<i>No default</i>" *    hideEffect="<i>No default</i>" *    mouseDownEffect="<i>No default</i>" *    mouseUpEffect="<i>No default</i>" *    moveEffect="<i>No default</i>" *    removedEffect="<i>No default</i>" *    resizeEffect="<i>No default</i>" *    rollOutEffect="<i>No default</i>" *    rollOverEffect="<i>No default</i>"     *    showEffect="<i>No default</i>" *   *  <b>Events</b> *    add="<i>No default</i>" *    creationComplete="<i>No default</i>" *    currentStateChange="<i>No default</i>" *    currentStateChanging="<i>No default</i>" *    dragComplete="<i>No default</i>" *    dragDrop="<i>No default</i>" *    dragEnter="<i>No default</i>" *    dragExit="<i>No default</i>" *    dragOver="<i>No default</i>" *    effectEnd="<i>No default</i>" *    effectStart="<i>No default</i>" *    enterState="<i>No default</i>" *    exitState="<i>No default</i>" *    hide="<i>No default</i>" *    initialize="<i>No default</i>" *    invalid="<i>No default</i>" *    mouseDownOutside="<i>No default</i>" *    mouseWheelOutside="<i>No default</i>" *    move="<i>No default</i>" *    preinitialize="<i>No default</i>" *    record="<i>No default</i>" *    remove="<i>No default</i>" *    resize="<i>No default</i>" *    show="<i>No default</i>" *    toolTipCreate="<i>No default</i>" *    toolTipEnd="<i>No default</i>" *    toolTipHide="<i>No default</i>" *    toolTipShow="<i>No default</i>" *    toolTipShown="<i>No default</i>" *    toolTipStart="<i>No default</i>" *    updateComplete="<i>No default</i>" *    valid="<i>No default</i>" *    valueCommit="<i>No default</i>" *  &gt; *  </pre> * *  @see mx.core.UIComponent
	 */
	public class UIComponent extends FlexSprite implements IAutomationObject
	{
		/**
		 *  The default value for the <code>measuredWidth</code> property.     *  Most components calculate a measuredWidth but some are flow-based and     *  have to pick a number that looks reasonable.     *     *  @default 160
		 */
		public static const DEFAULT_MEASURED_WIDTH : Number = 160;
		/**
		 *  The default value for the <code>measuredMinWidth</code> property.     *  Most components calculate a measuredMinWidth but some are flow-based and     *  have to pick a number that looks reasonable.     *     *  @default 40
		 */
		public static const DEFAULT_MEASURED_MIN_WIDTH : Number = 40;
		/**
		 *  The default value for the <code>measuredHeight</code> property.     *  Most components calculate a measuredHeight but some are flow-based and     *  have to pick a number that looks reasonable.     *     *  @default 22
		 */
		public static const DEFAULT_MEASURED_HEIGHT : Number = 22;
		/**
		 *  The default value for the <code>measuredMinHeight</code> property.     *  Most components calculate a measuredMinHeight but some are flow-based and     *  have to pick a number that looks reasonable.     *     *  @default 22
		 */
		public static const DEFAULT_MEASURED_MIN_HEIGHT : Number = 22;
		/**
		 *  The default value for the <code>maxWidth</code> property.     *     *  @default 10000
		 */
		public static const DEFAULT_MAX_WIDTH : Number = 10000;
		/**
		 *  The default value for the <code>maxHeight</code> property.     *     *  @default 10000
		 */
		public static const DEFAULT_MAX_HEIGHT : Number = 10000;
		/**
		 *  @private     *  The inheritingStyles and nonInheritingStyles properties     *  are initialized to this empty Object.     *  This allows the getStyle() and getStyle()     *  methods to simply access inheritingStyles[] and nonInheritingStyles[]     *  without needing to first check whether those objects exist.     *  If they were simply initialized to {}, we couldn't determine     *  whether the style chain has already been built or not.
		 */
		static var STYLE_UNINITIALIZED : Object;
		/**
		 *  @private     *  Placeholder for mixin by UIComponentAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private     *  Storage for the _embeddedFontRegistry property.     *  Note: This gets initialized on first access,     *  not when this class is initialized, in order to ensure     *  that the Singleton registry has already been initialized.
		 */
		private static var _embeddedFontRegistry : IEmbeddedFontRegistry;
		/**
		 *  @private     *  There is a bug (139381) where we occasionally get callLaterDispatcher()     *  even though we didn't expect it.     *  That causes us to do a removeEventListener() twice,     *  which messes up some internal thing in the player so that     *  the next addEventListener() doesn't actually get us the render event.
		 */
		private var listeningForRender : Boolean;
		/**
		 *  @private     *  List of methods used by callLater().
		 */
		private var methodQueue : Array;
		/**
		 *  @private     *  Whether or not we "own" the focus graphic
		 */
		private var hasFocusRect : Boolean;
		/**
		 *  @private     *  Storage for the initialized property.
		 */
		private var _initialized : Boolean;
		/**
		 *  @private     *  Storage for the processedDescriptors property.
		 */
		private var _processedDescriptors : Boolean;
		/**
		 *  @private     *  Storage for the updateCompletePendingFlag property.
		 */
		private var _updateCompletePendingFlag : Boolean;
		/**
		 *  @private     *  Whether this component needs to have its     *  commitProperties() method called.
		 */
		local var invalidatePropertiesFlag : Boolean;
		/**
		 *  @private     *  Whether this component needs to have its     *  measure() method called.
		 */
		local var invalidateSizeFlag : Boolean;
		/**
		 *  @private     *  Whether this component needs to be have its     *  updateDisplayList() method called.
		 */
		local var invalidateDisplayListFlag : Boolean;
		/**
		 *  @private     *  Holds the last recorded value of the x property.     *  Used in dispatching a MoveEvent.
		 */
		private var oldX : Number;
		/**
		 *  @private     *  Holds the last recorded value of the y property.     *  Used in dispatching a MoveEvent.
		 */
		private var oldY : Number;
		/**
		 *  @private     *  Holds the last recorded value of the width property.     *  Used in dispatching a ResizeEvent.
		 */
		private var oldWidth : Number;
		/**
		 *  @private     *  Holds the last recorded value of the height property.     *  Used in dispatching a ResizeEvent.
		 */
		private var oldHeight : Number;
		/**
		 *  @private     *  Holds the last recorded value of the minWidth property.
		 */
		private var oldMinWidth : Number;
		/**
		 *  @private     *  Holds the last recorded value of the minHeight property.
		 */
		private var oldMinHeight : Number;
		/**
		 *  @private     *  Holds the last recorded value of the explicitWidth property.
		 */
		private var oldExplicitWidth : Number;
		/**
		 *  @private     *  Holds the last recorded value of the explicitHeight property.
		 */
		private var oldExplicitHeight : Number;
		/**
		 *  @private     *  Holds the last recorded value of the scaleX property.
		 */
		private var oldScaleX : Number;
		/**
		 *  @private     *  Holds the last recorded value of the scaleY property.
		 */
		private var oldScaleY : Number;
		/**
		 *  @private     * True if createInFontContext has been called.
		 */
		private var hasFontContextBeenSaved : Boolean;
		/**
		 *  @private     * Holds the last recorded value of the module factory used to create the font.
		 */
		private var oldEmbeddedFontContext : IFlexModuleFactory;
		/**
		 * @private     *      * Cache last value of embedded font.
		 */
		private var cachedEmbeddedFont : EmbeddedFont;
		/**
		 *  @private
		 */
		private var cachedTextFormat : UITextFormat;
		/**
		 *  @private     *  Sprite used to display an overlay.
		 */
		local var overlay : UIComponent;
		/**
		 *  @private     *  Color used for overlay.
		 */
		local var overlayColor : uint;
		/**
		 *  @private     *  Counter to keep track of the number of current users     *  of the overlay.
		 */
		local var overlayReferenceCount : int;
		/**
		 *  @private
		 */
		local var saveBorderColor : Boolean;
		/**
		 *  @private
		 */
		local var origBorderColor : Number;
		/**
		 *  @private     *  Storage for automatically-created RadioButtonGroups.     *  If a RadioButton's groupName isn't the id of a RadioButtonGroup tag,     *  we automatically create a RadioButtonGroup and store it here as     *  document.automaticRadioButtonGroups[groupName] = theRadioButtonGroup;
		 */
		local var automaticRadioButtonGroups : Object;
		/**
		 *  @private
		 */
		private var _owner : DisplayObjectContainer;
		/**
		 *  @private     *  Reference to this component's virtual parent container.     *  "Virtual" means that this parent may not be the same     *  as the one that the Player returns as the 'parent'     *  property of a DisplayObject.     *  For example, if a Container has created a contentPane     *  to improve scrolling performance,     *  then its "children" are really its grandchildren     *  and their "parent" is actually their grandparent,     *  because we don't want developers to be concerned with     *  whether a contentPane exists or not.
		 */
		local var _parent : DisplayObjectContainer;
		/**
		 *  @private     *  Storage for the width property.
		 */
		local var _width : Number;
		/**
		 *  @private     *  Storage for the height property.
		 */
		local var _height : Number;
		/**
		 *  @private     *  Storage for the scaleX property.
		 */
		private var _scaleX : Number;
		/**
		 *  @private     *  Storage for the scaleY property.
		 */
		private var _scaleY : Number;
		/**
		 *  @private     *  Storage for the visible property.
		 */
		private var _visible : Boolean;
		/**
		 *  @private
		 */
		private var _enabled : Boolean;
		/**
		 *  @private     *  Storage for the filters property.
		 */
		private var _filters : Array;
		/**
		 *  @private
		 */
		private var _tweeningProperties : Array;
		/**
		 *  @private     *  Storage for the focusManager property.
		 */
		private var _focusManager : IFocusManager;
		/**
		 *  @private     *  Storage for the resourceManager property.
		 */
		private var _resourceManager : IResourceManager;
		/**
		 *  @private     *  Storage for the systemManager property.     *  Set by the SystemManager so that each UIComponent     *  has a references to its SystemManager
		 */
		private var _systemManager : ISystemManager;
		/**
		 *  @private     *  if component has been reparented, we need to potentially      *  reassign systemManager, cause we could be in a new Window.
		 */
		private var _systemManagerDirty : Boolean;
		/**
		 *  @private     *  Storage for the nestLevel property.
		 */
		private var _nestLevel : int;
		/**
		 *  @private     *  Storage for the descriptor property.     *  This variable is initialized in the construct() method     *  using the _descriptor in the initObj, which is set in     *  createComponentFromDescriptor().     *  If this UIComponent was not created by createComponentFromDescriptor(),     *  its 'descriptor' property is null.
		 */
		local var _descriptor : UIComponentDescriptor;
		/**
		 *  @private     *  Storage for the document property.     *  This variable is initialized in the init() method.     *  A document object (i.e., an Object at the top of the hierarchy     *  of a Flex application, MXML component, or AS component) has an     *  autogenerated override of initalize() which sets its _document to     *  'this', so that its 'document' property is a reference to itself.     *  Other UIComponents set their _document to their parent's _document,     *  so that their 'document' property refers to the document object     *  that they are inside.
		 */
		local var _document : Object;
		/**
		 *  @private     *  Storage for the documentDescriptor property.     *  A document object (i.e., a UIComponent at the top of the     *  hierarchy of a Flex application, MXML component,     *  or AS component) has an autogenerated override of init()     *  which sets its _documentDescriptor to the descriptor     *  at the top of the autogenerated descriptor tree for that     *  document. For other UIComponents, _documentDescriptor is     *  never defined.
		 */
		local var _documentDescriptor : UIComponentDescriptor;
		/**
		 *  @private
		 */
		private var _id : String;
		/**
		 *  @private     *  Storage for the moduleFactory property.
		 */
		private var _moduleFactory : IFlexModuleFactory;
		/**
		 *  @private     *  Storage for the inheritingStyles property.
		 */
		private var _inheritingStyles : Object;
		/**
		 *  @private     *  Storage for the nonInheritingStyles property.
		 */
		private var _nonInheritingStyles : Object;
		/**
		 *  @private     *  Storage for the styleDeclaration property.
		 */
		private var _styleDeclaration : CSSStyleDeclaration;
		/**
		 *  @private     *  Storage for cachePolicy property.
		 */
		private var _cachePolicy : String;
		/**
		 *  @private     *  Counter used by the cacheHeuristic property.
		 */
		private var cacheAsBitmapCount : int;
		/**
		 *  @private     *  Storage for the focusPane property.
		 */
		private var _focusPane : Sprite;
		/**
		 *  @private     *  Storage for the focusEnabled property.
		 */
		private var _focusEnabled : Boolean;
		/**
		 *  @private     *  Storage for the mouseFocusEnabled property.
		 */
		private var _mouseFocusEnabled : Boolean;
		/**
		 *  @private     *  Storage for the measuredMinWidth property.
		 */
		private var _measuredMinWidth : Number;
		/**
		 *  @private     *  Storage for the measuredMinHeight property.
		 */
		private var _measuredMinHeight : Number;
		/**
		 *  @private     *  Storage for the measuredWidth property.
		 */
		private var _measuredWidth : Number;
		/**
		 *  @private     *  Storage for the measuredHeight property.
		 */
		private var _measuredHeight : Number;
		/**
		 *  @private     *  Storage for the percentWidth property.
		 */
		private var _percentWidth : Number;
		/**
		 *  @private     *  Storage for the percentHeight property.
		 */
		private var _percentHeight : Number;
		/**
		 *  @private     *  Storage for the minWidth property.
		 */
		local var _explicitMinWidth : Number;
		/**
		 *  @private     *  Storage for the minHeight property.
		 */
		local var _explicitMinHeight : Number;
		/**
		 *  @private     *  Storage for the maxWidth property.
		 */
		local var _explicitMaxWidth : Number;
		/**
		 *  @private     *  Storage for the maxHeight property.
		 */
		local var _explicitMaxHeight : Number;
		/**
		 *  @private     *  Storage for the explicitWidth property.
		 */
		private var _explicitWidth : Number;
		/**
		 *  @private     *  Storage for the explicitHeight property.
		 */
		private var _explicitHeight : Number;
		/**
		 *  @private     *  Storage for the includeInLayout property.
		 */
		private var _includeInLayout : Boolean;
		/**
		 *  @private     *  Storage for the instanceIndices and index properties.
		 */
		private var _instanceIndices : Array;
		/**
		 *  @private     *  Storage for the repeaters and repeater properties.
		 */
		private var _repeaters : Array;
		/**
		 *  @private     *  Storage for the repeaterIndices and repeaterIndex properties.
		 */
		private var _repeaterIndices : Array;
		/**
		 *  @private     *  Storage for the currentState property.
		 */
		private var _currentState : String;
		/**
		 *  @private     *  Pending current state name.
		 */
		private var requestedCurrentState : String;
		/**
		 *  @private     *  Flag to play state transition
		 */
		private var playStateTransition : Boolean;
		/**
		 *  @private     *  Flag that is set when the currentState has changed and needs to be     *  committed.     *  This property name needs the initial underscore to avoid collisions     *  with the "currentStateChange" event attribute.
		 */
		private var _currentStateChanged : Boolean;
		/**
		 *  The view states that are defined for this component.     *  You can specify the <code>states</code> property only on the root     *  of the application or on the root tag of an MXML component.     *  The compiler generates an error if you specify it on any other control.
		 */
		public var states : Array;
		/**
		 *  @private     *  Transition effect currently playing.
		 */
		private var _currentTransitionEffect : IEffect;
		/**
		 *  An Array of Transition objects, where each Transition object defines a     *  set of effects to play when a view state change occurs.     *     *  @see mx.states.Transition
		 */
		public var transitions : Array;
		/**
		 *  @private     *  Storage for the flexContextMenu property.
		 */
		private var _flexContextMenu : IFlexContextMenu;
		/**
		 *  @private     *  Storage for the styleName property.
		 */
		private var _styleName : Object;
		/**
		 *  @private     *  Storage for the toolTip property.
		 */
		local var _toolTip : String;
		/**
		 *  @private
		 */
		private var _uid : String;
		/**
		 *  @private
		 */
		private var _isPopUp : Boolean;
		/**
		 *  @private
		 */
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
		 *  @private     *  Storage for errorString property.
		 */
		local var _errorString : String;
		/**
		 *  @private     *  Flag set when error string changes.
		 */
		private var errorStringChanged : Boolean;
		/**
		 *  @private     *  Storage for the validationSubField property.
		 */
		private var _validationSubField : String;
		/**
		 *  @private
		 */
		private var lastUnscaledWidth : Number;
		/**
		 *  @private
		 */
		private var lastUnscaledHeight : Number;
		/**
		 *  @private
		 */
		local var _effectsStarted : Array;
		/**
		 *  @private
		 */
		local var _affectedProperties : Object;
		/**
		 *  Contains <code>true</code> if an effect is currently playing on the component.
		 */
		private var _isEffectStarted : Boolean;
		private var preventDrawFocus : Boolean;
		private var _endingEffectInstances : Array;
		static var dispatchEventHook : Function;
		private static var fakeMouseX : QName;
		private static var fakeMouseY : QName;

		/**
		 *  @private     *  A reference to the embedded font registry.     *  Single registry in the system.     *  Used to look up the moduleFactory of a font.
		 */
		private static function get embeddedFontRegistry () : IEmbeddedFontRegistry;
		/**
		 *  A flag that determines if an object has been through all three phases     *  of layout: commitment, measurement, and layout (provided that any were required).
		 */
		public function get initialized () : Boolean;
		/**
		 *  @private
		 */
		public function set initialized (value:Boolean) : void;
		/**
		 *  Set to <code>true</code> after immediate or deferred child creation,      *  depending on which one happens. For a Container object, it is set      *  to <code>true</code> at the end of      *  the <code>createComponentsFromDescriptors()</code> method,      *  meaning after the Container object creates its children from its child descriptors.      *       *  <p>For example, if an Accordion container uses deferred instantiation,      *  the <code>processedDescriptors</code> property for the second pane of      *  the Accordion container does not become <code>true</code> until after      *  the user navigates to that pane and the pane creates its children.      *  But, if the Accordion had set the <code>creationPolicy</code> property      *  to <code>"all"</code>, the <code>processedDescriptors</code> property      *  for its second pane is set to <code>true</code> during application startup.</p>     *       *  <p>For classes that are not containers, which do not have descriptors,      *  it is set to <code>true</code> after the <code>createChildren()</code>      *  method creates any internal component children.</p>
		 */
		public function get processedDescriptors () : Boolean;
		/**
		 *  @private
		 */
		public function set processedDescriptors (value:Boolean) : void;
		/**
		 *  A flag that determines if an object has been through all three phases     *  of layout validation (provided that any were required).
		 */
		public function get updateCompletePendingFlag () : Boolean;
		/**
		 *  @private
		 */
		public function set updateCompletePendingFlag (value:Boolean) : void;
		/**
		 *  The owner of this UIComponent. By default, it is the parent of this UIComponent.     *  However, if this UIComponent object is a child component that is      *  popped up by its parent, such as the dropdown list of a ComboBox control,      *  the owner is the component that popped up this UIComponent object.      *     *  <p>This property is not managed by Flex, but by each component.      *  Therefore, if you use the <code>PopUpManger.createPopUp()</code> or      *  <code>PopUpManger.addPopUp()</code> method to pop up a child component,      *  you should set the <code>owner</code> property of the child component      *  to the component that popped it up.</p>     *      *  <p>The default value is the value of the <code>parent</code> property.</p>
		 */
		public function get owner () : DisplayObjectContainer;
		public function set owner (value:DisplayObjectContainer) : void;
		/**
		 *  The parent container or component for this component.     *  Only UIComponent objects should have a parent property.     *  Non-UIComponent objects should use another property to reference     *  the object to which they belong.     *  By convention, non-UIComponent objects use an <code>owner</code>     *  property to reference the object to which they belong.
		 */
		public function get parent () : DisplayObjectContainer;
		/**
		 *  Number that specifies the component's horizontal position,     *  in pixels, within its parent container.     *     *  <p>Setting this property directly or calling <code>move()</code>     *  will have no effect -- or only a temporary effect -- if the     *  component is parented by a layout container such as HBox, Grid,     *  or Form, because the layout calculations of those containers     *  set the <code>x</code> position to the results of the calculation.     *  However, the <code>x</code> property must almost always be set     *  when the parent is a Canvas or other absolute-positioning     *  container because the default value is 0.</p>     *     *  @default 0
		 */
		public function get x () : Number;
		/**
		 *  @private
		 */
		public function set x (value:Number) : void;
		/**
		 *  Number that specifies the component's vertical position,     *  in pixels, within its parent container.     *     *  <p>Setting this property directly or calling <code>move()</code>     *  will have no effect -- or only a temporary effect -- if the     *  component is parented by a layout container such as HBox, Grid,     *  or Form, because the layout calculations of those containers     *  set the <code>x</code> position to the results of the calculation.     *  However, the <code>x</code> property must almost always be set     *  when the parent is a Canvas or other absolute-positioning     *  container because the default value is 0.</p>     *     *  @default 0
		 */
		public function get y () : Number;
		/**
		 *  @private
		 */
		public function set y (value:Number) : void;
		/**
		 *  Number that specifies the width of the component, in pixels,     *  in the parent's coordinates.     *  The default value is 0, but this property will contain the actual component      *  width after Flex completes sizing the components in your application.     *     *  <p>Note: You can specify a percentage value in the MXML     *  <code>width</code> attribute, such as <code>width="100%"</code>,     *  but you cannot use a percentage value in the <code>width</code>     *  property in ActionScript.     *  Use the <code>percentWidth</code> property instead.</p>     *     *  <p>Setting this property causes a <code>resize</code> event to     *  be dispatched.     *  See the <code>resize</code> event for details on when     *  this event is dispatched.     *  If the component's <code>scaleX</code> property is not 1.0,     *  the width of the component from its internal coordinates     *  will not match.     *  Thus a 100 pixel wide component with a <code>scaleX</code>     *  of 2 will take 100 pixels in the parent, but will     *  internally think it is 50 pixels wide.</p>
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;
		/**
		 *  Number that specifies the height of the component, in pixels,     *  in the parent's coordinates.     *  The default value is 0, but this property will contain the actual component      *  height after Flex completes sizing the components in your application.     *     *  <p>Note: You can specify a percentage value in the MXML     *  <code>height</code> attribute, such as <code>height="100%"</code>,     *  but you cannot use a percentage value for the <code>height</code>     *  property in ActionScript;     *  use the <code>percentHeight</code> property instead.</p>     *     *  <p>Setting this property causes a <code>resize</code> event to be dispatched.     *  See the <code>resize</code> event for details on when     *  this event is dispatched.     *  If the component's <code>scaleY</code> property is not 100,     *  the height of the component from its internal coordinates     *  will not match.     *  Thus a 100 pixel high component with a <code>scaleY</code>     *  of 200 will take 100 pixels in the parent, but will     *  internally think it is 50 pixels high.</p>
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;
		/**
		 *  Number that specifies the horizontal scaling factor.     *     *  <p>The default value is 1.0, which means that the object     *  is not scaled.     *  A <code>scaleX</code> of 2.0 means the object has been     *  magnified by a factor of 2, and a <code>scaleX</code> of 0.5     *  means the object has been reduced by a factor of 2.</p>     *     *  <p>A value of 0.0 is an invalid value.      *  Rather than setting it to 0.0, set it to a small value, or set      *  the <code>visible</code> property to <code>false</code> to hide the component.</p>     *     *  @default 1.0
		 */
		public function get scaleX () : Number;
		/**
		 *  @private
		 */
		public function set scaleX (value:Number) : void;
		/**
		 *  Number that specifies the vertical scaling factor.     *     *  <p>The default value is 1.0, which means that the object     *  is not scaled.     *  A <code>scaleY</code> of 2.0 means the object has been     *  magnified by a factor of 2, and a <code>scaleY</code> of 0.5     *  means the object has been reduced by a factor of 2.</p>     *     *  <p>A value of 0.0 is an invalid value.      *  Rather than setting it to 0.0, set it to a small value, or set      *  the <code>visible</code> property to <code>false</code> to hide the component.</p>     *     *  @default 1.0
		 */
		public function get scaleY () : Number;
		/**
		 *  @private
		 */
		public function set scaleY (value:Number) : void;
		/**
		 *  Controls the visibility of this UIComponent. If <code>true</code>,      *  the object is visible.     *     *  <p>When setting to <code>true</code>, the object will dispatch     *  a <code>show</code> event.     *  When setting to <code>false</code>, the object will dispatch     *  a <code>hide</code> event.     *  In either case the children of the object will not emit a     *  <code>show</code> or <code>hide</code> event unless the object     *  has specifically written an implementation to do so.</p>     *     *  @default true
		 */
		public function get visible () : Boolean;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set alpha (value:Number) : void;
		/**
		 *  Specifies whether the UIComponent object receives <code>doubleClick</code> events.      *  The default value is <code>false</code>, which means that the UIComponent object      *  does not receive <code>doubleClick</code> events.      *     *  <p>The <code>mouseEnabled</code> property must also be set to <code>true</code>,      *  its default value, for the object to receive <code>doubleClick</code> events.</p>     *     *  @default false
		 */
		public function get doubleClickEnabled () : Boolean;
		/**
		 *  @private     *  Propagate to children.
		 */
		public function set doubleClickEnabled (value:Boolean) : void;
		/**
		 *  @copy mx.core.IUIComponent#enabled
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set cacheAsBitmap (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get filters () : Array;
		/**
		 *  @private
		 */
		public function set filters (value:Array) : void;
		/**
		 *  @private     *  This property allows access to the Player's native implementation     *  of the 'parent' property, which can be useful since components     *  can override 'parent' and thereby hide the native implementation.     *  Note that this "base property" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $parent () : DisplayObjectContainer;
		/**
		 *  @private     *  This property allows access to the Player's native implementation     *  of the 'x' property, which can be useful since components     *  can override 'x' and thereby hide the native implementation.     *  Note that this "base property" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $x () : Number;
		/**
		 *  @private
		 */
		function set $x (value:Number) : void;
		/**
		 *  @private     *  This property allows access to the Player's native implementation     *  of the 'y' property, which can be useful since components     *  can override 'y' and thereby hide the native implementation.     *  Note that this "base property" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $y () : Number;
		/**
		 *  @private
		 */
		function set $y (value:Number) : void;
		/**
		 *  @private     *  This property allows access to the Player's native implementation     *  of the 'width' property, which can be useful since components     *  can override 'width' and thereby hide the native implementation.     *  Note that this "base property" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $width () : Number;
		/**
		 *  @private
		 */
		function set $width (value:Number) : void;
		/**
		 *  @private     *  This property allows access to the Player's native implementation     *  of the 'height' property, which can be useful since components     *  can override 'height' and thereby hide the native implementation.     *  Note that this "base property" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $height () : Number;
		/**
		 *  @private
		 */
		function set $height (value:Number) : void;
		/**
		 *  @private     *  This property allows access to the Player's native implementation     *  of the 'visible' property, which can be useful since components     *  can override 'visible' and thereby hide the native implementation.     *  Note that this "base property" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $visible () : Boolean;
		/**
		 *  @private
		 */
		function set $visible (value:Boolean) : void;
		/**
		 *  Returns the <i>x</i> position of the mouse, in the content coordinate system.     *  Content coordinates specify a pixel position relative to the upper left      *  corner of the component's content, and include all of the component's      *  content area, including any regions that are currently clipped and must      *  be accessed by scrolling the component.
		 */
		public function get contentMouseX () : Number;
		/**
		 *  Returns the <i>y</i> position of the mouse, in the content coordinate system.     *  Content coordinates specify a pixel position relative to the upper left      *  corner of the component's content, and include all of the component's      *  content area, including any regions that are currently clipped and must      *  be accessed by scrolling the component.
		 */
		public function get contentMouseY () : Number;
		/**
		 *  Array of properties that are currently being tweened on this object.     *     *  <p>Used to alert the EffectManager that certain properties of this object     *  are being tweened, so that the EffectManger doesn't attempt to animate     *  the same properties.</p>
		 */
		public function get tweeningProperties () : Array;
		/**
		 *  @private
		 */
		public function set tweeningProperties (value:Array) : void;
		/**
		 *  Gets the CursorManager that controls the cursor for this component     *  and its peers.     *  Each top-level window has its own instance of a CursorManager;     *  To make sure you're talking to the right one, use this method.
		 */
		public function get cursorManager () : ICursorManager;
		/**
		 *  Gets the FocusManager that controls focus for this component     *  and its peers.     *  Each popup has its own focus loop and therefore its own instance     *  of a FocusManager.     *  To make sure you're talking to the right one, use this method.
		 */
		public function get focusManager () : IFocusManager;
		/**
		 *  @private     *  IFocusManagerContainers have this property assigned by the framework
		 */
		public function set focusManager (value:IFocusManager) : void;
		/**
		 *  A reference to the object which manages     *  all of the application's localized resources.     *  This is a singleton instance which implements     *  the IResourceManager interface.
		 */
		protected function get resourceManager () : IResourceManager;
		/**
		 *  Returns the SystemManager object used by this component.
		 */
		public function get systemManager () : ISystemManager;
		/**
		 *  @private
		 */
		public function set systemManager (value:ISystemManager) : void;
		/**
		 *  Depth of this object in the containment hierarchy.     *  This number is used by the measurement and layout code.     *  The value is 0 if this component is not on the DisplayList.
		 */
		public function get nestLevel () : int;
		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;
		/**
		 *  Reference to the UIComponentDescriptor, if any, that was used     *  by the <code>createComponentFromDescriptor()</code> method to create this     *  UIComponent instance. If this UIComponent instance      *  was not created from a descriptor, this property is null.     *     *  @see mx.core.UIComponentDescriptor
		 */
		public function get descriptor () : UIComponentDescriptor;
		/**
		 *  @private
		 */
		public function set descriptor (value:UIComponentDescriptor) : void;
		/**
		 *  A reference to the document object associated with this UIComponent.     *  A document object is an Object at the top of the hierarchy of a     *  Flex application, MXML component, or AS component.
		 */
		public function get document () : Object;
		/**
		 *  A reference to the document object associated with this UIComponent.     *  A document object is an Object at the top of the hierarchy of a     *  Flex application, MXML component, or AS component.
		 */
		public function set document (value:Object) : void;
		/**
		 *  @private     *  For a document object, which is an instance of a UIComponent     *  at the top of the hierarchy of a Flex application, MXML     *  component, or ActionScript component, the     *  <code>documentDescriptor</code> property is a reference     *  to the UIComponentDescriptor at the top of the autogenerated     *  descriptor tree for that document, which describes the     *  set of children and their attributes for that document.     *  For other UIComponents, it is <code>null</code>.
		 */
		function get documentDescriptor () : UIComponentDescriptor;
		/**
		 *  ID of the component. This value becomes the instance name of the object     *  and should not contain any white space or special characters. Each component     *  throughout an application should have a unique id.     *     *  <p>If your application is going to be tested by third party tools, give each component     *  a meaningful id. Testing tools use ids to represent the control in their scripts and     *  having a meaningful name can make scripts more readable. For example, set the     *  value of a button to submit_button rather than b1 or button1.</p>
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  Determines whether this UIComponent instance is a document object,     *  that is, whether it is at the top of the hierarchy of a Flex     *  application, MXML component, or ActionScript component.
		 */
		public function get isDocument () : Boolean;
		/**
		 *  Note:     *  There are two reasons that 'parentApplication' is typed as Object     *  rather than as Application. The first is that typing it as Application     *  would make UIComponent dependent on Application, slowing down compile     *  times not only for SWCs for also for MXML and AS components. The     *  second is that authors would not be able to access properties and     *  methods in the <Script> of their <Application> without casting it     *  to their application's subclass, as in     *     MyApplication(paentApplication).myAppMethod().     *  Therefore we decided to dispense with strict typing for     *  'parentApplication'.
		 */
		public function get parentApplication () : Object;
		/**
		 *  A reference to the parent document object for this UIComponent.     *  A document object is a UIComponent at the top of the hierarchy     *  of a Flex application, MXML component, or AS component.     *  For the Application object, the <code>parentDocument</code>      *  property is null.     *  This property  is useful in MXML scripts to go up a level     *  in the chain of document objects.     *  It can be used to walk this chain using     *  <code>parentDocument.parentDocument</code>, and so on.     *  It is typed as Object so that authors can access properties     *  and methods on ancestor document objects without casting.
		 */
		public function get parentDocument () : Object;
		/**
		 *  Returns an object that contains the size and position of the base     *  drawing surface for this object.
		 */
		public function get screen () : Rectangle;
		/**
		 *  The moduleFactory that is used to create TextFields in the correct SWF context. This is necessary so that     *  embedded fonts will work.
		 */
		public function get moduleFactory () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set moduleFactory (factory:IFlexModuleFactory) : void;
		/**
		 *  The beginning of this component's chain of inheriting styles.     *  The <code>getStyle()</code> method simply accesses     *  <code>inheritingStyles[styleName]</code> to search the entire     *  prototype-linked chain.     *  This object is set up by <code>initProtoChain()</code>.     *  Developers typically never need to access this property directly.
		 */
		public function get inheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set inheritingStyles (value:Object) : void;
		/**
		 *  The beginning of this component's chain of non-inheriting styles.     *  The <code>getStyle()</code> method simply accesses     *  <code>nonInheritingStyles[styleName]</code> to search the entire     *  prototype-linked chain.     *  This object is set up by <code>initProtoChain()</code>.     *  Developers typically never need to access this property directly.
		 */
		public function get nonInheritingStyles () : Object;
		/**
		 *  @private
		 */
		public function set nonInheritingStyles (value:Object) : void;
		/**
		 *  Storage for the inline inheriting styles on this object.     *  This CSSStyleDeclaration is created the first time that      *  the <code>setStyle()</code> method     *  is called on this component to set an inheriting style.     *  Developers typically never need to access this property directly.
		 */
		public function get styleDeclaration () : CSSStyleDeclaration;
		/**
		 *  @private
		 */
		public function set styleDeclaration (value:CSSStyleDeclaration) : void;
		/**
		 *  Specifies the bitmap caching policy for this object.     *  Possible values in MXML are <code>"on"</code>,     *  <code>"off"</code> and     *  <code>"auto"</code> (default).     *      *  <p>Possible values in ActionScript are <code>UIComponentCachePolicy.ON</code>,     *  <code>UIComponentCachePolicy.OFF</code> and     *  <code>UIComponentCachePolicy.AUTO</code> (default).</p>     *     *  <p><ul>     *    <li>A value of <code>UIComponentCachePolicy.ON</code> means that      *      the object is always cached as a bitmap.</li>     *    <li>A value of <code>UIComponentCachePolicy.OFF</code> means that      *      the object is never cached as a bitmap.</li>     *    <li>A value of <code>UIComponentCachePolicy.AUTO</code> means that      *      the framework uses heuristics to decide whether the object should      *      be cached as a bitmap.</li>     *  </ul></p>     *     *  @default UIComponentCachePolicy.AUTO
		 */
		public function get cachePolicy () : String;
		/**
		 *  @private
		 */
		public function set cachePolicy (value:String) : void;
		/**
		 *  Used by Flex to suggest bitmap caching for the object.     *  If <code>cachePolicy</code> is <code>UIComponentCachePolicy.AUTO</code>,      *  then <code>cacheHeuristic</code>     *  is used to control the object's <code>cacheAsBitmap</code> property.
		 */
		public function set cacheHeuristic (value:Boolean) : void;
		/**
		 *  The focus pane associated with this object.     *  An object has a focus pane when one of its children has focus.
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  Indicates whether the component can receive focus when tabbed to.     *  You can set <code>focusEnabled</code> to <code>false</code>      *  when a UIComponent is used as a subcomponent of another component      *  so that the outer component becomes the focusable entity.     *  If this property is <code>false</code>, focus will be transferred to     *  the first parent that has <code>focusEnable</code>      *  set to <code>true</code>.     *       *  @default true
		 */
		public function get focusEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set focusEnabled (value:Boolean) : void;
		/**
		 *  Whether you can receive focus when clicked on.     *  If <code>false</code>, focus will be transferred to     *  the first parent that is <code>mouseFocusEnable</code>      *  set to <code>true</code>.     *  For example, you can set this property to <code>false</code>      *  on a Button control so that you can use the Tab key to move focus      *  to the control, but not have the control get focus when you click on it.     *     *  @default true
		 */
		public function get mouseFocusEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set mouseFocusEnabled (value:Boolean) : void;
		/**
		 *  The default minimum width of the component, in pixels.     *  This value is set by the <code>measure()</code> method.
		 */
		public function get measuredMinWidth () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinWidth (value:Number) : void;
		/**
		 *  The default minimum height of the component, in pixels.     *  This value is set by the <code>measure()</code> method.
		 */
		public function get measuredMinHeight () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinHeight (value:Number) : void;
		/**
		 *  The default width of the component, in pixels.     *  This value is set by the <code>measure()</code> method.
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private
		 */
		public function set measuredWidth (value:Number) : void;
		/**
		 *  The default height of the component, in pixels.     *  This value is set by the <code>measure()</code> method.
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @private
		 */
		public function set measuredHeight (value:Number) : void;
		/**
		 *  Number that specifies the width of a component as a percentage     *  of its parent's size. Allowed values are 0-100. The default value is NaN.     *  Setting the <code>width</code> or <code>explicitWidth</code> properties      *  resets this property to NaN.     *     *  <p>This property returns a numeric value only if the property was     *  previously set; it does not reflect the exact size of the component     *  in percent.</p>     *     *  <p>This property is always set to NaN for the UITextField control.</p>
		 */
		public function get percentWidth () : Number;
		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;
		/**
		 *  Number that specifies the height of a component as a percentage     *  of its parent's size. Allowed values are 0-100. The default value is NaN.     *  Setting the <code>height</code> or <code>explicitHeight</code> properties      *  resets this property to NaN.     *     *  <p>This property returns a numeric value only if the property was     *  previously set; it does not reflect the exact size of the component     *  in percent.</p>     *     *  <p>This property is always set to NaN for the UITextField control.</p>
		 */
		public function get percentHeight () : Number;
		/**
		 *  @private
		 */
		public function set percentHeight (value:Number) : void;
		/**
		 *  The minimum recommended width of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels. The default value depends on     *  the component's implementation.     *     *  <p>If the application developer sets the value of minWidth,     *  the new value is stored in explicitMinWidth. The default value of minWidth     *  does not change. As a result, at layout time, if     *  minWidth was explicitly set by the application developer, then the value of     *  explicitMinWidth is used for the component's minimum recommended width.     *  If minWidth is not set explicitly by the application developer, then the value of     *  measuredMinWidth is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>minWidth</code> with respect to its parent     *  is affected by the <code>scaleX</code> property.</p>
		 */
		public function get minWidth () : Number;
		/**
		 *  @private
		 */
		public function set minWidth (value:Number) : void;
		/**
		 *  The minimum recommended height of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels. The default value depends on     *  the component's implementation.     *     *  <p>If the application developer sets the value of minHeight,     *  the new value is stored in explicitMinHeight. The default value of minHeight     *  does not change. As a result, at layout time, if     *  minHeight was explicitly set by the application developer, then the value of     *  explicitMinHeight is used for the component's minimum recommended height.     *  If minHeight is not set explicitly by the application developer, then the value of     *  measuredMinHeight is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>minHeight</code> with respect to its parent     *  is affected by the <code>scaleY</code> property.</p>
		 */
		public function get minHeight () : Number;
		/**
		 *  @private
		 */
		public function set minHeight (value:Number) : void;
		/**
		 *  The maximum recommended width of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels. The default value of this property is     *  set by the component developer.     *     *  <p>The component developer uses this property to set an upper limit on the     *  width of the component.</p>     *     *  <p>If the application developer overrides the default value of maxWidth,     *  the new value is stored in explicitMaxWidth. The default value of maxWidth     *  does not change. As a result, at layout time, if     *  maxWidth was explicitly set by the application developer, then the value of     *  explicitMaxWidth is used for the component's maximum recommended width.     *  If maxWidth is not set explicitly by the user, then the default value is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>maxWidth</code> with respect to its parent     *  is affected by the <code>scaleX</code> property.     *  Some components have no theoretical limit to their width.     *  In those cases their <code>maxWidth</code> will be set to     *  <code>UIComponent.DEFAULT_MAX_WIDTH</code>.</p>     *     *  @default 10000
		 */
		public function get maxWidth () : Number;
		/**
		 *  @private
		 */
		public function set maxWidth (value:Number) : void;
		/**
		 *  The maximum recommended height of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels. The default value of this property is     *  set by the component developer.     *     *  <p>The component developer uses this property to set an upper limit on the     *  height of the component.</p>     *     *  <p>If the application developer overrides the default value of maxHeight,     *  the new value is stored in explicitMaxHeight. The default value of maxHeight     *  does not change. As a result, at layout time, if     *  maxHeight was explicitly set by the application developer, then the value of     *  explicitMaxHeight is used for the component's maximum recommended height.     *  If maxHeight is not set explicitly by the user, then the default value is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>maxHeight</code> with respect to its parent     *  is affected by the <code>scaleY</code> property.     *  Some components have no theoretical limit to their height.     *  In those cases their <code>maxHeight</code> will be set to     *  <code>UIComponent.DEFAULT_MAX_HEIGHT</code>.</p>     *     *  @default 10000
		 */
		public function get maxHeight () : Number;
		/**
		 *  @private
		 */
		public function set maxHeight (value:Number) : void;
		/**
		 *  The minimum recommended width of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels.     *     *  <p>Application developers typically do not set the explicitMinWidth property. Instead, they     *  set the value of the minWidth property, which sets the explicitMinWidth property. The     *  value of minWidth does not change.</p>     *     *  <p>At layout time, if minWidth was explicitly set by the application developer, then     *  the value of explicitMinWidth is used. Otherwise, the value of measuredMinWidth     *  is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>minWidth</code> with respect to its parent     *  is affected by the <code>scaleX</code> property.</p>     *     *  @default NaN
		 */
		public function get explicitMinWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitMinWidth (value:Number) : void;
		/**
		 *  The minimum recommended height of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels.     *     *  <p>Application developers typically do not set the explicitMinHeight property. Instead, they     *  set the value of the minHeight property, which sets the explicitMinHeight property. The     *  value of minHeight does not change.</p>     *     *  <p>At layout time, if minHeight was explicitly set by the application developer, then     *  the value of explicitMinHeight is used. Otherwise, the value of measuredMinHeight     *  is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>minHeight</code> with respect to its parent     *  is affected by the <code>scaleY</code> property.</p>     *     *  @default NaN
		 */
		public function get explicitMinHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitMinHeight (value:Number) : void;
		/**
		 *  The maximum recommended width of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels.     *     *  <p>Application developers typically do not set the explicitMaxWidth property. Instead, they     *  set the value of the maxWidth property, which sets the explicitMaxWidth property. The     *  value of maxWidth does not change.</p>     *     *  <p>At layout time, if maxWidth was explicitly set by the application developer, then     *  the value of explicitMaxWidth is used. Otherwise, the default value for maxWidth     *  is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>maxWidth</code> with respect to its parent     *  is affected by the <code>scaleX</code> property.     *  Some components have no theoretical limit to their width.     *  In those cases their <code>maxWidth</code> will be set to     *  <code>UIComponent.DEFAULT_MAX_WIDTH</code>.</p>     *     *  @default NaN
		 */
		public function get explicitMaxWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitMaxWidth (value:Number) : void;
		/**
		 *  The maximum recommended height of the component to be considered     *  by the parent during layout. This value is in the     *  component's coordinates, in pixels.     *     *  <p>Application developers typically do not set the explicitMaxHeight property. Instead, they     *  set the value of the maxHeight property, which sets the explicitMaxHeight property. The     *  value of maxHeight does not change.</p>     *     *  <p>At layout time, if maxHeight was explicitly set by the application developer, then     *  the value of explicitMaxHeight is used. Otherwise, the default value for maxHeight     *  is used.</p>     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>maxHeight</code> with respect to its parent     *  is affected by the <code>scaleY</code> property.     *  Some components have no theoretical limit to their height.     *  In those cases their <code>maxHeight</code> will be set to     *  <code>UIComponent.DEFAULT_MAX_HEIGHT</code>.</p>     *     *  @default NaN
		 */
		public function get explicitMaxHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitMaxHeight (value:Number) : void;
		/**
		 *  Number that specifies the explicit width of the component,     *  in pixels, in the component's coordinates.     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>explicitWidth</code> with respect to its parent     *  is affected by the <code>scaleX</code> property.</p>     *  <p>Setting the <code>width</code> property also sets this property to     *  the specified width value.</p>
		 */
		public function get explicitWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;
		/**
		 *  Number that specifies the explicit height of the component,     *  in pixels, in the component's coordinates.     *     *  <p>This value is used by the container in calculating     *  the size and position of the component.     *  It is not used by the component itself in determining     *  its default size.     *  Thus this property may not have any effect if parented by     *  Container, or containers that don't factor in     *  this property.     *  Because the value is in component coordinates,     *  the true <code>explicitHeight</code> with respect to its parent     *  is affected by the <code>scaleY</code> property.</p>     *  <p>Setting the <code>height</code> property also sets this property to     *  the specified height value.</p>
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;
		/**
		 *  Specifies whether this component is included in the layout of the     *  parent container.     *  If <code>true</code>, the object is included in its parent container's     *  layout.  If <code>false</code>, the object is positioned by its parent     *  container as per its layout rules, but it is ignored for the purpose of     *  computing the position of the next child.     *     *  @default true
		 */
		public function get includeInLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set includeInLayout (value:Boolean) : void;
		/**
		 *  The index of a repeated component.      *  If the component is not within a Repeater, the value is -1.
		 */
		public function get instanceIndex () : int;
		/**
		 *  An Array containing the indices required to reference     *  this UIComponent object from its parent document.     *  The Array is empty unless this UIComponent object is within one or more Repeaters.     *  The first element corresponds to the outermost Repeater.     *  For example, if the id is "b" and instanceIndices is [2,4],     *  you would reference it on the parent document as b[2][4].
		 */
		public function get instanceIndices () : Array;
		/**
		 *  @private
		 */
		public function set instanceIndices (value:Array) : void;
		/**
		 *  A reference to the Repeater object     *  in the parent document that produced this UIComponent.     *  Use this property, rather than the <code>repeaters</code> property,      *  when the UIComponent is created by a single Repeater object.      *  Use the <code>repeaters</code> property when this UIComponent is created      *  by nested Repeater objects.      *     *  <p>The property is set to <code>null</code> when this UIComponent      *  is not created by a Repeater.</p>
		 */
		public function get repeater () : IRepeater;
		/**
		 *  An Array containing references to the Repeater objects     *  in the parent document that produced this UIComponent.     *  The Array is empty unless this UIComponent is within     *  one or more Repeaters.     *  The first element corresponds to the outermost Repeater object.
		 */
		public function get repeaters () : Array;
		/**
		 *  @private
		 */
		public function set repeaters (value:Array) : void;
		/**
		 *  The index of the item in the data provider     *  of the Repeater that produced this UIComponent.     *  Use this property, rather than the <code>repeaterIndices</code> property,      *  when the UIComponent is created by a single Repeater object.      *  Use the <code>repeaterIndices</code> property when this UIComponent is created      *  by nested Repeater objects.      *     *  <p>This property is set to -1 when this UIComponent is      *  not created by a Repeater.</p>
		 */
		public function get repeaterIndex () : int;
		/**
		 *  An Array containing the indices of the items in the data provider     *  of the Repeaters in the parent document that produced this UIComponent.     *  The Array is empty unless this UIComponent is within one or more Repeaters.     *      *  <p>The first element in the Array corresponds to the outermost Repeater.     *  For example, if <code>repeaterIndices</code> is [2,4] it means that the     *  outer repeater used item <code>dataProvider[2]</code> and the inner repeater     *  used item <code>dataProvider[4]</code>.</p>     *      *  <p>Note that this property differs from the <code>instanceIndices</code> property     *  if the <code>startingIndex</code> property of any of the Repeaters is not 0.     *  For example, even if a Repeater starts at <code>dataProvider[4]</code>,     *  the document reference of the first repeated object is b[0], not b[4].</p>
		 */
		public function get repeaterIndices () : Array;
		/**
		 *  @private
		 */
		public function set repeaterIndices (value:Array) : void;
		/**
		 *  The current view state of the component.     *  Set to <code>""</code> or <code>null</code> to reset     *  the component back to its base state.     *     *  <p>When you use this property to set a component's state,     *  Flex applies any transition you have defined.     *  You can also use the <code>setCurrentState()</code> method to set the     *  current state; this method can optionally change states without     *  applying a transition.</p>     *     *  @see #setCurrentState()
		 */
		public function get currentState () : String;
		/**
		 *  @private
		 */
		public function set currentState (value:String) : void;
		/**
		 *  The y-coordinate of the baseline     *  of the first line of text of the component.     *      *  <p>This property is used to implement     *  the <code>baseline</code> constraint style.     *  It is also used to align the label of a FormItem     *  with the controls in the FormItem.</p>     *      *  <p>Each component should override this property.</p>
		 */
		public function get baselinePosition () : Number;
		/**
		 *  The name of this instance's class, such as <code>"Button"</code>.     *     *  <p>This string does not include the package name.     *  If you need the package name as well, call the     *  <code>getQualifiedClassName()</code> method in the flash.utils package.     *  It will return a string such as <code>"mx.controls::Button"</code>.</p>
		 */
		public function get className () : String;
		/**
		 *  The list of effects that are currently playing on the component,     *  as an Array of EffectInstance instances.
		 */
		public function get activeEffects () : Array;
		/**
		 *  The context menu for this UIComponent.      *     *  @default null
		 */
		public function get flexContextMenu () : IFlexContextMenu;
		/**
		 *  @private
		 */
		public function set flexContextMenu (value:IFlexContextMenu) : void;
		/**
		 *  The class style used by this component. This can be a String, CSSStyleDeclaration     *  or an IStyleClient.      *     *  <p>If this is a String, it is the name of a class declaration     *  in an <code>mx:Style</code> tag or CSS file. You do not include the period in      *  the <code>styleName</code>. For example, if you have a class style named <code>".bigText"</code>,     *  set the <code>styleName</code> property to <code>"bigText"</code> (no period).</p>     *     *  <p>If this is an IStyleClient (typically a UIComponent), all styles in the     *  <code>styleName</code> object are used by this component.</p>     *     *  @default null
		 */
		public function get styleName () : Object;
		/**
		 *  @private
		 */
		public function set styleName (value:Object) : void;
		/**
		 *  Text to display in the ToolTip.     *     *  @default null
		 */
		public function get toolTip () : String;
		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;
		/**
		 *  A unique identifier for the object.      *  Flex data-driven controls, including all controls that are      *  subclasses of List class, use a UID to track data provider items.      *     *  <p>Flex can automatically create and manage UIDs.      *  However, there are circumstances when you must supply your own      *  <code>uid</code> property by implementing the IUID interface,      *  or when supplying your own <code>uid</code> property improves processing efficiency.      *  UIDs do not need to be universally unique for most uses in Flex.      *  One exception is for messages sent by data services.</p>     *     *  @see IUID     *  @see mx.utils.UIDUtil
		 */
		public function get uid () : String;
		/**
		 *  @private
		 */
		public function set uid (uid:String) : void;
		/**
		 *  @private     *  Utility getter used by uid. It returns an indexed id string     *  such as "foo[1][2]" if this object is a repeated object,     *  or a nonindexed id string like "bar" if it isn't.
		 */
		private function get indexedID () : String;
		/**
		 *  Set to <code>true</code> by the PopUpManager to indicate     *  that component has been popped up.
		 */
		public function get isPopUp () : Boolean;
		public function set isPopUp (value:Boolean) : void;
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
		 *  The text that will be displayed by a component's error tip when a     *  component is monitored by a Validator and validation fails.     *     *  <p>You can use the <code>errorString</code> property to show a     *  validation error for a component, without actually using a validator class.     *  When you write a String value to the <code>errorString</code> property,     *  Flex draws a red border around the component to indicate the validation error,     *  and the String appears in a tooltip as the validation error message when you move     *  the mouse over the component, just as if a validator detected a validation error.</p>     *     *  <p>To clear the validation error, write an empty String, "",     *  to the <code>errorString</code> property.</p>     *     *  <p>Note that writing a value to the <code>errorString</code> property     *  does not trigger the valid or invalid events; it only changes the border     *  color and displays the validation error message.</p>
		 */
		public function get errorString () : String;
		/**
		 *  @private
		 */
		public function set errorString (value:String) : void;
		/**
		 *  Used by a validator to associate a subfield with this component.
		 */
		public function get validationSubField () : String;
		/**
		 *  @private
		 */
		public function set validationSubField (value:String) : void;
		/**
		 *  A convenience method for determining the unscaled width     *  of the component     *  All of a component's drawing and child layout should be done     *  within a bounding rectangle of this width, which is also passed     *  as an argument to <code>updateDisplayList()</code>.     *     *  @return A Number which is unscaled width of the component.
		 */
		protected function get unscaledWidth () : Number;
		/**
		 *  A convenience method for determining the unscaled height     *  of the component.     *  All of a component's drawing and child layout should be done     *  within a bounding rectangle of this height, which is also passed     *  as an argument to <code>updateDisplayList()</code>.     *     *  @return A Number which is unscaled height of the component.
		 */
		protected function get unscaledHeight () : Number;
		function get isEffectStarted () : Boolean;
		function set isEffectStarted (value:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function get numAutomationChildren () : int;
		/**
		 *  @inheritDoc
		 */
		public function get automationTabularData () : Object;
		/**
		 *  @private
		 */
		public function get mouseX () : Number;
		/**
		 *  @private
		 */
		public function get mouseY () : Number;

		/**
		 *  Blocks the background processing of methods     *  queued by <code>callLater()</code>,     *  until <code>resumeBackgroundProcessing()</code> is called.     *     *  <p>These methods can be useful when you have time-critical code     *  which needs to execute without interruption.     *  For example, when you set the <code>suspendBackgroundProcessing</code>     *  property of an Effect to <code>true</code>,     *  <code>suspendBackgroundProcessing()</code> is automatically called     *  when it starts playing, and <code>resumeBackgroundProcessing</code>     *  is called when it stops, in order to ensure that the animation     *  is smooth.</p>     *     *  <p>Since the LayoutManager uses <code>callLater()</code>,     *  this means that <code>commitProperties()</code>,     *  <code>measure()</code>, and <code>updateDisplayList()</code>     *  will not get called in between calls to     *  <code>suspendBackgroundProcessing()</code> and     *  <code>resumeBackgroundProcessing()</code>.</p>     *     *  <p>It is safe for both an outer method and an inner method     *  (i.e., one that the outer methods calls) to call     *  <code>suspendBackgroundProcessing()</code>     *  and <code>resumeBackgroundProcessing()</code>, because these     *  methods actually increment and decrement a counter     *  which determines whether background processing occurs.</p>
		 */
		public static function suspendBackgroundProcessing () : void;
		/**
		 *  Resumes the background processing of methods     *  queued by <code>callLater()</code>, after a call to     *  <code>suspendBackgroundProcessing()</code>.     *     *  <p>Refer to the description of     *  <code>suspendBackgroundProcessing()</code> for more information.</p>
		 */
		public static function resumeBackgroundProcessing () : void;
		/**
		 *  Constructor.
		 */
		public function UIComponent ();
		/**
		 *  Called when the <code>visible</code> property changes.     *  You should set the <code>visible</code> property to show or hide     *  a component instead of calling this method directly.     *     *  @param value The new value of the <code>visible</code> property.      *  Specify <code>true</code> to show the component, and <code>false</code> to hide it.      *     *  @param noEvent If <code>true</code>, do not dispatch an event.      *  If <code>false</code>, dispatch a <code>show</code> event when      *  the component becomes visible, and a <code>hide</code> event when      *  the component becomes invisible.
		 */
		public function setVisible (value:Boolean, noEvent:Boolean = false) : void;
		/**
		 *  @private     *  Returns the current system manager, <code>systemManager</code>,     *  unless it is null.      *  If the current system manager is null,     *  then search to find the correct system manager.     *      *  @return A system manager, will not be null.
		 */
		function getNonNullSystemManager () : ISystemManager;
		/**
		 *  @private     *  Set the appropriate borderColor based on errorString.     *  If we have an errorString, use errorColor. If we don't     *  have an errorString, restore the original borderColor.
		 */
		private function setBorderColorForErrorString () : void;
		/**
		 *  @private
		 */
		public function addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		public function removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		public function stopDrag () : void;
		/**
		 *  @private     *  This method allows access to the Player's native implementation     *  of addChild(), which can be useful since components     *  can override addChild() and thereby hide the native implementation.     *  Note that this "base method" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function $addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private     *  This method allows access to the Player's native implementation     *  of addChildAt(), which can be useful since components     *  can override addChildAt() and thereby hide the native implementation.     *  Note that this "base method" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function $addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private     *  This method allows access to the Player's native implementation     *  of removeChild(), which can be useful since components     *  can override removeChild() and thereby hide the native implementation.     *  Note that this "base method" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function $removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private     *  This method allows access to the Player's native implementation     *  of removeChildAt(), which can be useful since components     *  can override removeChildAt() and thereby hide the native implementation.     *  Note that this "base method" is final and cannot be overridden,     *  so you can count on it to reflect what is happening at the player level.
		 */
		function $removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function updateCallbacks () : void;
		/**
		 *  Called by Flex when a UIComponent object is added to or removed from a parent.     *  Developers typically never need to call this method.     *     *  @param p The parent of this UIComponent object.
		 */
		public function parentChanged (p:DisplayObjectContainer) : void;
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
		 *  Initializes the internal structure of this component.     *     *  <p>Initializing a UIComponent is the fourth step in the creation     *  of a visual component instance, and happens automatically     *  the first time that the instance is added to a parent.     *  Therefore, you do not generally need to call     *  <code>initialize()</code>; the Flex framework calls it for you     *  from UIComponent's override of the <code>addChild()</code>     *  and <code>addChildAt()</code> methods.</p>     *     *  <p>The first step in the creation of a visual component instance     *  is construction, with the <code>new</code> operator:</p>     *     *  <pre>     *  var okButton:Button = new Button();</pre>     *     *  <p>After construction, the new Button instance is a solitary     *  DisplayObject; it does not yet have a UITextField as a child     *  to display its label, and it doesn't have a parent.</p>     *     *  <p>The second step is configuring the newly-constructed instance     *  with the appropriate properties, styles, and event handlers:</p>     *     *  <pre>     *  okButton.label = "OK";     *  okButton.setStyle("cornerRadius", 0);     *  okButton.addEventListener(MouseEvent.CLICK, clickHandler);</pre>     *     *  <p>The third step is adding the instance to a parent:</p>     *     *  <pre>     *  someContainer.addChild(okButton);</pre>     *     *  <p>A side effect of calling <code>addChild()</code>     *  or <code>addChildAt()</code>, when adding a component to a parent     *  for the first time, is that <code>initialize</code> gets     *  automatically called.</p>     *     *  <p>This method first dispatches a <code>preinitialize</code> event,     *  giving developers using this component a chance to affect it     *  before its internal structure has been created.     *  Next it calls the <code>createChildren()</code> method     *  to create the component's internal structure; for a Button,     *  this method creates and adds the UITextField for the label.     *  Then it dispatches an <code>initialize</code> event,     *  giving developers a chance to affect the component     *  after its internal structure has been created.</p>     *     *  <p>Note that it is the act of attaching a component to a parent     *  for the first time that triggers the creation of its internal structure.     *  If its internal structure includes other UIComponents, then this is a     *  recursive process in which the tree of DisplayObjects grows by one leaf     *  node at a time.</p>      *     *  <p>If you are writing a component, you should not need     *  to override this method.</p>
		 */
		public function initialize () : void;
		/**
		 *  Finalizes the initialization of this component.     *     *  <p>This method is the last code that executes when you add a component     *  to a parent for the first time using <code>addChild()</code>     *  or <code>addChildAt()</code>.     *  It handles some housekeeping related to dispatching     *  the <code>initialize</code> event.     *  If you are writing a component, you should not need     *  to override this method.</p>
		 */
		protected function initializationComplete () : void;
		/**
		 *  Initializes this component's accessibility code.     *     *  <p>This method is called by the <code>initialize()</code> method to hook in the     *  component's accessibility code, which resides in a separate class     *  in the mx.accessibility package.     *  Each subclass that supports accessibility must override this method     *  because the hook-in process uses a different static variable     *  in each subclass.</p>
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  Initializes various properties which keep track of repeated instances     *  of this component.     *     *  <p>An MXML <code>&lt;mx:Repeater/&gt;</code> tag can cause repeated instances     *  of a component to be created, one instance for each item in the     *  Repeater's data provider.     *  The <code>instanceIndices</code>, <code>repeaters</code>,     *  and <code>repeaterIndices</code> properties of UIComponent     *  keep track of which instance came from which data item     *  and which Repeater.</p>     *     *  <p>This method is an internal method which is automatically called     *  by the Flex framework.     *  You should not have to call it or override it.</p>     *     *  @param parent The parent object containing the Repeater that created     *  this component.
		 */
		public function initializeRepeaterArrays (parent:IRepeaterClient) : void;
		/**
		 *  Create child objects of the component.     *  This is an advanced method that you might override     *  when creating a subclass of UIComponent.     *     *  <p>A component that creates other components or objects within it is called a composite component.     *  For example, the Flex ComboBox control is actually made up of a TextInput control     *  to define the text area of the ComboBox, and a Button control to define the ComboBox arrow.     *  Components implement the <code>createChildren()</code> method to create child     *  objects (such as other components) within the component.</p>     *     *  <p>From within an override of the <code>createChildren()</code> method,     *  you call the <code>addChild()</code> method to add each child object. </p>     *     *  <p>You do not call this method directly. Flex calls the     *  <code>createChildren()</code> method in response to the call to     *  the <code>addChild()</code> method to add the component to its parent. </p>
		 */
		protected function createChildren () : void;
		/**
		 *  Performs any final processing after child objects are created.     *  This is an advanced method that you might override     *  when creating a subclass of UIComponent.
		 */
		protected function childrenCreated () : void;
		/**
		 *  Marks a component so that its <code>commitProperties()</code>     *  method gets called during a later screen update.     *     *  <p>Invalidation is a useful mechanism for eliminating duplicate     *  work by delaying processing of changes to a component until a     *  later screen update.     *  For example, if you want to change the text color and size,     *  it would be wasteful to update the color immediately after you     *  change it and then update the size when it gets set.     *  It is more efficient to change both properties and then render     *  the text with its new size and color once.</p>     *     *  <p>Invalidation methods rarely get called.     *  In general, setting a property on a component automatically     *  calls the appropriate invalidation method.</p>
		 */
		public function invalidateProperties () : void;
		/**
		 *  Marks a component so that its <code>measure()</code>     *  method gets called during a later screen update.     *     *  <p>Invalidation is a useful mechanism for eliminating duplicate     *  work by delaying processing of changes to a component until a     *  later screen update.     *  For example, if you want to change the text and font size,     *  it would be wasteful to update the text immediately after you     *  change it and then update the size when it gets set.     *  It is more efficient to change both properties and then render     *  the text with its new size once.</p>     *     *  <p>Invalidation methods rarely get called.     *  In general, setting a property on a component automatically     *  calls the appropriate invalidation method.</p>
		 */
		public function invalidateSize () : void;
		/**
		 *  Marks a component so that its <code>updateDisplayList()</code>     *  method gets called during a later screen update.     *     *  <p>Invalidation is a useful mechanism for eliminating duplicate     *  work by delaying processing of changes to a component until a     *  later screen update.     *  For example, if you want to change the width and height,     *  it would be wasteful to update the component immediately after you     *  change the width and then update again with the new height.     *  It is more efficient to change both properties and then render     *  the component with its new size once.</p>     *     *  <p>Invalidation methods rarely get called.     *  In general, setting a property on a component automatically     *  calls the appropriate invalidation method.</p>
		 */
		public function invalidateDisplayList () : void;
		private function isOnDisplayList () : Boolean;
		/**
		 *  Flex calls the <code>stylesInitialized()</code> method when     *  the styles for a component are first initialized.     *     *  <p>This is an advanced method that you might override     *  when creating a subclass of UIComponent. Flex guarantees that     *  your component's styles will be fully initialized before     *  the first time your component's <code>measure</code> and     *  <code>updateDisplayList</code> methods are called.  For most     *  components, that is sufficient. But if you need early access to     *  your style values, you can override the stylesInitialized() function     *  to access style properties as soon as they are initialized the first time.</p>
		 */
		public function stylesInitialized () : void;
		/**
		 *  Detects changes to style properties. When any style property is set,     *  Flex calls the <code>styleChanged()</code> method,     *  passing to it the name of the style being set.     *     *  <p>This is an advanced method that you might override     *  when creating a subclass of UIComponent. When you create a custom component,     *  you can override the <code>styleChanged()</code> method     *  to check the style name passed to it, and handle the change accordingly.     *  This lets you override the default behavior of an existing style,     *  or add your own custom style properties.</p>     *     *  <p>If you handle the style property, your override of     *  the <code>styleChanged()</code> method should call the     *  <code>invalidateDisplayList()</code> method to cause Flex to execute     *  the component's <code>updateDisplayList()</code> method at the next screen update.</p>     *     *  @param styleProp The name of the style property, or null if all styles for this     *  component have changed.
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  Validate and update the properties and layout of this object     *  and redraw it, if necessary.     *     *  Processing properties that require substantial computation are normally     *  not processed until the script finishes executing.     *  For example setting the <code>width</code> property is delayed, because it may     *  require recalculating the widths of the objects children or its parent.     *  Delaying the processing prevents it from being repeated     *  multiple times if the script sets the <code>width</code> property more than once.     *  This method lets you manually override this behavior.
		 */
		public function validateNow () : void;
		/**
		 *  @private     *  This method is called at the beginning of each getter     *  for the baselinePosition property.     *  If it returns false, the getter should return NaN     *  because the baselinePosition can't be computed.     *  If it returns true, the getter can do computations     *  like textField.y + textField.baselinePosition     *  because these properties will be valid.
		 */
		function validateBaselinePosition () : Boolean;
		/**
		 *  Queues a function to be called later.     *     *  <p>Before each update of the screen, Flash Player or AIR calls     *  the set of functions that are scheduled for the update.     *  Sometimes, a function should be called in the next update     *  to allow the rest of the code scheduled for the current     *  update to be executed.     *  Some features, like effects, can cause queued functions to be     *  delayed until the feature completes.</p>     *     *  @param method Reference to a method to be executed later.     *     *  @param args Array of Objects that represent the arguments to pass to the method.     *
		 */
		public function callLater (method:Function, args:Array = null) : void;
		/**
		 *  @private     *  Cancels all queued functions.
		 */
		function cancelAllCallLaters () : void;
		/**
		 *  Used by layout logic to validate the properties of a component     *  by calling the <code>commitProperties()</code> method.       *  In general, subclassers should     *  override the <code>commitProperties()</code> method and not this method.
		 */
		public function validateProperties () : void;
		/**
		 *  Processes the properties set on the component.     *  This is an advanced method that you might override     *  when creating a subclass of UIComponent.     *     *  <p>You do not call this method directly.     *  Flex calls the <code>commitProperties()</code> method when you     *  use the <code>addChild()</code> method to add a component to a container,     *  or when you call the <code>invalidateProperties()</code> method of the component.     *  Calls to the <code>commitProperties()</code> method occur before calls to the     *  <code>measure()</code> method. This lets you set property values that might     *  be used by the <code>measure()</code> method.</p>     *     *  <p>Some components have properties that affect the number or kinds     *  of child objects that they need to create, or have properties that     *  interact with each other, such as the <code>horizontalScrollPolicy</code>     *  and <code>horizontalScrollPosition</code> properties.     *  It is often best at startup time to process all of these     *  properties at one time to avoid duplicating work.</p>
		 */
		protected function commitProperties () : void;
		/**
		 *  @inheritDoc
		 */
		public function validateSize (recursive:Boolean = false) : void;
		/**
		 *  @private
		 */
		private function measureSizes () : Boolean;
		/**
		 *  Calculates the default size, and optionally the default minimum size,     *  of the component. This is an advanced method that you might override when     *  creating a subclass of UIComponent.     *     *  <p>You do not call this method directly. Flex calls the     *  <code>measure()</code> method when the component is added to a container     *  using the <code>addChild()</code> method, and when the component's     *  <code>invalidateSize()</code> method is called. </p>     *     *  <p>When you set a specific height and width of a component,      *  Flex does not call the <code>measure()</code> method,      *  even if you explicitly call the <code>invalidateSize()</code> method.      *  That is, Flex only calls the <code>measure()</code> method if      *  the <code>explicitWidth</code> property or the <code>explicitHeight</code>      *  property of the component is NaN. </p>     *      *  <p>In your override of this method, you must set the     *  <code>measuredWidth</code> and <code>measuredHeight</code> properties     *  to define the default size.     *  You may optionally set the <code>measuredMinWidth</code> and     *  <code>measuredMinHeight</code> properties to define the default     *  minimum size.</p>     *     *  <p>Most components calculate these values based on the content they are     *  displaying, and from the properties that affect content display.     *  A few components simply have hard-coded default values. </p>     *     *  <p>The conceptual point of <code>measure()</code> is for the component to provide     *  its own natural or intrinsic size as a default. Therefore, the     *  <code>measuredWidth</code> and <code>measuredHeight</code> properties     *  should be determined by factors such as:</p>     *  <ul>     *     <li>The amount of text the component needs to display.</li>     *     <li>The styles, such as <code>fontSize</code>, for that text.</li>     *     <li>The size of a JPEG image that the component displays.</li>     *     <li>The measured or explicit sizes of the component's children.</li>     *     <li>Any borders, margins, and gaps.</li>     *  </ul>     *     *  <p>In some cases, there is no intrinsic way to determine default values.     *  For example, a simple GreenCircle component might simply set     *  measuredWidth = 100 and measuredHeight = 100 in its <code>measure()</code> method to     *  provide a reasonable default size. In other cases, such as a TextArea,     *  an appropriate computation (such as finding the right width and height     *  that would just display all the text and have the aspect ratio of a Golden Rectangle)     *  might be too time-consuming to be worthwhile.</p>     *     *  <p>The default implementation of <code>measure()</code>     *  sets <code>measuredWidth</code>, <code>measuredHeight</code>,     *  <code>measuredMinWidth</code>, and <code>measuredMinHeight</code>     *  to <code>0</code>.</p>
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		function adjustSizesForScaleChanges () : void;
		/**
		 *  A convenience method for determining whether to use the     *  explicit or measured width     *     *  @return A Number which is explicitWidth if defined     *  or measuredWidth if not.
		 */
		public function getExplicitOrMeasuredWidth () : Number;
		/**
		 *  A convenience method for determining whether to use the     *  explicit or measured height     *     *  @return A Number which is explicitHeight if defined     *  or measuredHeight if not.
		 */
		public function getExplicitOrMeasuredHeight () : Number;
		/**
		 *  A convenience method for setting the unscaledWidth of a      *  component.      *      *  Setting this sets the width of the component as desired     *  before any transformation is applied.
		 */
		function setUnscaledWidth (value:Number) : void;
		/**
		 *  A convenience method for setting the unscaledHeight of a      *  component.      *      *  Setting this sets the height of the component as desired     *  before any transformation is applied.
		 */
		function setUnscaledHeight (value:Number) : void;
		/**
		 *  Measures the specified text, assuming that it is displayed     *  in a single-line UITextField using a UITextFormat     *  determined by the styles of this UIComponent.     *     *  @param text A String specifying the text to measure.     *     *  @return A TextLineMetrics object containing the text measurements.
		 */
		public function measureText (text:String) : TextLineMetrics;
		/**
		 *  Measures the specified HTML text, which may contain HTML tags such     *  as <code>&lt;font&gt;</code> and <code>&lt;b&gt;</code>,      *  assuming that it is displayed     *  in a single-line UITextField using a UITextFormat     *  determined by the styles of this UIComponent.     *     *  @param text A String specifying the HTML text to measure.     *     *  @return A TextLineMetrics object containing the text measurements.
		 */
		public function measureHTMLText (htmlText:String) : TextLineMetrics;
		/**
		 *  @inheritDoc
		 */
		public function validateDisplayList () : void;
		/**
		 *  Draws the object and/or sizes and positions its children.     *  This is an advanced method that you might override     *  when creating a subclass of UIComponent.     *     *  <p>You do not call this method directly. Flex calls the     *  <code>updateDisplayList()</code> method when the component is added to a container     *  using the <code>addChild()</code> method, and when the component's     *  <code>invalidateDisplayList()</code> method is called. </p>     *     *  <p>If the component has no children, this method     *  is where you would do programmatic drawing     *  using methods on the component's Graphics object     *  such as <code>graphics.drawRect()</code>.</p>     *     *  <p>If the component has children, this method is where     *  you would call the <code>move()</code> and <code>setActualSize()</code>     *  methods on its children.</p>     *     *  <p>Components may do programmatic drawing even if     *  they have children. In doing either, you should use the     *  component's <code>unscaledWidth</code> and <code>unscaledHeight</code>     *  as its bounds.</p>     *     *  <p>It is important to use <code>unscaledWidth</code> and     *  <code>unscaledHeight</code> instead of the <code>width</code>     *  and <code>height</code> properties.</p>     *     *  @param unscaledWidth Specifies the width of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleX</code> property of the component.     *     *  @param unscaledHeight Specifies the height of the component, in pixels,     *  in the component's coordinates, regardless of the value of the     *  <code>scaleY</code> property of the component.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Returns a layout constraint value, which is the same as      *  getting the constraint style for this component.     *     *  @param constraintName The name of the constraint style, which     *  can be any of the following: left, right, top, bottom,     *  verticalCenter, horizontalCenter, baseline     *     *  @return Returns the layout constraint value, which can be     *  specified in either of two forms. It can be specified as a     *  numeric string, for example, "10" or it can be specified as     *  identifier:numeric string. For identifier:numeric string,     *  identifier is the <code>id</code> of a ConstraintRow or     *  ConstraintColumn. For example, a value of "cc1:10" specifies a     *  value of 10 for the ConstraintColumn that has the     *  <code>id</code> "cc1."
		 */
		public function getConstraintValue (constraintName:String) : *;
		/**
		 *  Sets a layout constraint value, which is the same as      *  setting the constraint style for this component.     *     *  @param constraintName The name of the constraint style, which     *  can be any of the following: left, right, top, bottom,     *  verticalCenter, horizontalCenter, baseline     *       *  @value The value of the constraint can be specified in either     *  of two forms. It can be specified as a numeric string, for     *  example, "10" or it can be specified as identifier:numeric     *  string. For identifier:numeric string, identifier is the     *  <code>id</code> of a ConstraintRow or ConstraintColumn. For     *  example, a value of "cc1:10" specifies a value of 10 for the     *  ConstraintColumn that has the <code>id</code> "cc1."     *
		 */
		public function setConstraintValue (constraintName:String, value:*) : void;
		/**
		 *  Returns a box Matrix which can be passed to the      *  <code>drawRoundRect()</code> method     *  as the <code>rot</code> parameter when drawing a horizontal gradient.     *     *  <p>For performance reasons, the Matrix is stored in a static variable     *  which is reused by all calls to <code>horizontalGradientMatrix()</code>     *  and <code>verticalGradientMatrix()</code>.     *  Therefore, you should pass the resulting Matrix     *  to <code>drawRoundRect()</code> before calling     *  <code>horizontalGradientMatrix()</code>     *  or <code>verticalGradientMatrix()</code> again.</p>     *     *  @param x The left coordinate of the gradient, in pixels.     *     *  @param y The top coordinate of the gradient, in pixels.     *     *  @param width The width of the gradient, in pixels.     *     *  @param height The height of the gradient, in pixels.     *     *  @return The Matrix for the horizontal gradient.
		 */
		public function horizontalGradientMatrix (x:Number, y:Number, width:Number, height:Number) : Matrix;
		/**
		 *  Returns a box Matrix which can be passed to <code>drawRoundRect()</code>     *  as the <code>rot</code> parameter when drawing a vertical gradient.     *     *  <p>For performance reasons, the Matrix is stored in a static variable     *  which is reused by all calls to <code>horizontalGradientMatrix()</code>     *  and <code>verticalGradientMatrix()</code>.     *  Therefore, you should pass the resulting Matrix     *  to <code>drawRoundRect()</code> before calling     *  <code>horizontalGradientMatrix()</code>     *  or <code>verticalGradientMatrix()</code> again.</p>     *     *  @param x The left coordinate of the gradient, in pixels.     *     *  @param y The top coordinate of the gradient, in pixels.     *     *  @param width The width of the gradient, in pixels.     *     *  @param height The height of the gradient, in pixels.     *     *  @return The Matrix for the vertical gradient.
		 */
		public function verticalGradientMatrix (x:Number, y:Number, width:Number, height:Number) : Matrix;
		/**
		 *  @copy mx.skins.ProgrammaticSkin#drawRoundRect()
		 */
		public function drawRoundRect (x:Number, y:Number, w:Number, h:Number, r:Object = null, c:Object = null, alpha:Object = null, rot:Object = null, gradient:String = null, ratios:Array = null, hole:Object = null) : void;
		/**
		 *  Moves the component to a specified position within its parent.      *  Calling this method is exactly the same as      *  setting the component's <code>x</code> and <code>y</code> properties.      *      *  <p>If you are overriding the <code>updateDisplayList()</code> method       *  in a custom component, you should call the <code>move()</code> method       *  rather than setting the <code>x</code> and <code>y</code> properties.       *  The difference is that the <code>move()</code> method changes the location       *  of the component and then dispatches a <code>move</code> event when you       *  call the method, while setting the <code>x</code> and <code>y</code>       *  properties changes the location of the component and dispatches       *  the event on the next screen refresh.</p>      *      *  @param x Left position of the component within its parent.      *      *  @param y Top position of the component within its parent.
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  Sizes the object.     *  Unlike directly setting the <code>width</code> and <code>height</code>     *  properties, calling the <code>setActualSize()</code> method     *  does not set the <code>explictWidth</code> and     *  <code>explicitHeight</code> properties, so a future layout     *  calculation may result in the object returning to its previous size.     *  This method is used primarily by component developers implementing     *  the <code>updateDisplayList()</code> method, by Effects,     *  and by the LayoutManager.     *     *  @param w Width of the object.     *     *  @param h Height of the object.
		 */
		public function setActualSize (w:Number, h:Number) : void;
		/**
		 *  Converts a <code>Point</code> object from content coordinates to global coordinates.     *  Content coordinates specify a pixel position relative to the upper left corner     *  of the component's content, and include all of the component's content area,      *  including any regions that are currently clipped and must be      *  accessed by scrolling the component.     *  You use the content coordinate system to set and get the positions of children      *  of a container that uses absolute positioning.      *  Global coordinates specify a pixel position relative to the upper-left corner      *  of the stage, that is, the outermost edge of the application.     *       *  @param point A Point object that      *  specifies the <i>x</i> and <i>y</i> coordinates in the content coordinate system      *  as properties.     *       *  @return A Point object with coordinates relative to the Stage.      *      *  @see #globalToContent()
		 */
		public function contentToGlobal (point:Point) : Point;
		/**
		 *  Converts a <code>Point</code> object from global to content coordinates.     *  Global coordinates specify a pixel position relative to the upper-left corner      *  of the stage, that is, the outermost edge of the application.     *  Content coordinates specify a pixel position relative to the upper left corner     *  of the component's content, and include all of the component's content area,      *  including any regions that are currently clipped and must be      *  accessed by scrolling the component.     *  You use the content coordinate system to set and get the positions of children      *  of a container that uses absolute positioning.      *       *  @param point A Point object that      *  specifies the <i>x</i> and <i>y</i> coordinates in the global (Stage)      *  coordinate system as properties.     *       *  @return Point A Point object with coordinates relative to the component.     *      *  @see #contentToGlobal()
		 */
		public function globalToContent (point:Point) : Point;
		/**
		 *  Converts a <code>Point</code> object from content to local coordinates.     *  Content coordinates specify a pixel position relative to the upper left corner     *  of the component's content, and include all of the component's content area,      *  including any regions that are currently clipped and must be      *  accessed by scrolling the component.     *  You use the content coordinate system to set and get the positions of children      *  of a container that uses absolute positioning.      *  Local coordinates specify a pixel position relative to the      *  upper left corner of the component.     *       *  @param point A Point object that specifies the <i>x</i> and <i>y</i>      *  coordinates in the content coordinate system as properties.     *       *  @return Point A Point object with coordinates relative to the      *  local coordinate system.      *      *  @see #contentToGlobal()
		 */
		public function contentToLocal (point:Point) : Point;
		/**
		 *  Converts a <code>Point</code> object from local to content coordinates.     *  Local coordinates specify a pixel position relative to the      *  upper left corner of the component.     *  Content coordinates specify a pixel position relative to the upper left corner     *  of the component's content, and include all of the component's content area,      *  including any regions that are currently clipped and must be      *  accessed by scrolling the component.     *  You use the content coordinate system to set and get the positions of children      *  of a container that uses absolute positioning.      *       *  @param point A Point object that specifies the <i>x</i> and <i>y</i>      *  coordinates in the local coordinate system as properties.     *       *  @return Point A Point object with coordinates relative to the      *  content coordinate system.      *      *  @see #contentToLocal()
		 */
		public function localToContent (point:Point) : Point;
		/**
		 *  Gets the object that currently has focus.     *  It might not be this object.     *  Note that this method does not necessarily return the component     *  that has focus.     *  It may return the internal subcomponent of the component     *  that has focus.     *  To get the component that has focus, use the     *  <code>focusManager.focus</code> property.     *     *  @return Object that has focus.
		 */
		public function getFocus () : InteractiveObject;
		/**
		 *  Sets the focus to this component.     *  The component may in turn pass focus to a subcomponent.     *     *  <p><b>Note:</b> Only the TextInput and TextArea controls show a highlight     *  when this method sets the focus.     *  All controls show a highlight when the user tabs to the control.</p>
		 */
		public function setFocus () : void;
		/**
		 *  @private     *  Returns the focus object
		 */
		function getFocusObject () : DisplayObject;
		/**
		 *  Shows or hides the focus indicator around this component.     *     *  <p>UIComponent implements this by creating an instance of the class     *  specified by the <code>focusSkin</code> style and positioning it     *  appropriately.</p>     *       *  @param isFocused Determines if the focus indicator should be displayed. Set to     *  <code>true</code> to display the focus indicator. Set to <code>false</code> to hide it.
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  Adjust the focus rectangle.     *     *  @param The component whose focus rectangle to modify.      *  If omitted, the default value is this UIComponent object.
		 */
		protected function adjustFocusRect (obj:DisplayObject = null) : void;
		/**
		 *  @private
		 */
		private function dispatchMoveEvent () : void;
		/**
		 *  @private
		 */
		private function dispatchResizeEvent () : void;
		/**
		 *  Set the current state.      *       *  @param stateName The name of the new view state.     *       *  @param playTransition If <code>true</code>, play      *  the appropriate transition when the view state changes.     *     *  @see #currentState
		 */
		public function setCurrentState (stateName:String, playTransition:Boolean = true) : void;
		/**
		 *  @private     *  Returns true if the passed in state name is the 'base' state, which     *  is currently defined as null or ""
		 */
		private function isBaseState (stateName:String) : Boolean;
		/**
		 *  @private     *  Commit a pending current state change.
		 */
		private function commitCurrentState () : void;
		/**
		 *  @private
		 */
		private function transition_effectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private     *  Returns the state with the specified name, or null if it doesn't exist.     *  If multiple states have the same name the first one will be returned.
		 */
		private function getState (stateName:String) : State;
		/**
		 *  @private     *  Find the deepest common state between two states. For example:     *     *  State A     *  State B basedOn A     *  State C basedOn A     *     *  findCommonBaseState(B, C) returns A     *     *  If there are no common base states, the root state ("") is returned.
		 */
		private function findCommonBaseState (state1:String, state2:String) : String;
		/**
		 *  @private     *  Returns the base states for a given state.     *  This Array is in high-to-low order - the first entry     *  is the immediate basedOn state, the last entry is the topmost     *  basedOn state.
		 */
		private function getBaseStates (state:State) : Array;
		/**
		 *  @private     *  Remove the overrides applied by a state, and any     *  states it is based on.
		 */
		private function removeState (stateName:String, lastState:String) : void;
		/**
		 *  @private     *  Apply the overrides from a state, and any states it     *  is based on.
		 */
		private function applyState (stateName:String, lastState:String) : void;
		/**
		 *  @private     *  Initialize the state, and any states it is based on
		 */
		private function initializeState (stateName:String) : void;
		/**
		 *  @private     *  Find the appropriate transition to play between two states.
		 */
		private function getTransition (oldState:String, newState:String) : IEffect;
		/**
		 *  @private     *  Sets up the inheritingStyles and nonInheritingStyles objects     *  and their proto chains so that getStyle() can work.
		 */
		function initProtoChain () : void;
		/**
		 *  Finds the type selectors for this UIComponent instance.     *  The algorithm walks up the superclass chain.     *  For example, suppose that class MyButton extends Button.     *  A MyButton instance will first look for a MyButton type selector     *  then, it will look for a Button type selector.     *  then, it will look for a UIComponent type selector.     *  (The superclass chain is considered to stop at UIComponent, not Object.)     *     *  @return An Array of type selectors for this UIComponent instance.
		 */
		public function getClassStyleDeclarations () : Array;
		/**
		 *  Builds or rebuilds the CSS style cache for this component     *  and, if the <code>recursive</code> parameter is <code>true</code>,     *  for all descendants of this component as well.     *     *  <p>The Flex framework calls this method in the following     *  situations:</p>     *     *  <ul>     *    <li>When you add a UIComponent to a parent using the     *    <code>addChild()</code> or <code>addChildAt()</code> methods.</li>     *    <li>When you change the <code>styleName</code> property     *    of a UIComponent.</li>     *    <li>When you set a style in a CSS selector using the     *    <code>setStyle()</code> method of CSSStyleDeclaration.</li>     *  </ul>     *     *  <p>Building the style cache is a computation-intensive operation,     *  so you should avoid changing <code>styleName</code> or     *  setting selector styles unnecessarily.</p>     *     *  <p>This method is not called when you set an instance style     *  by calling the <code>setStyle()</code> method of UIComponent.     *  Setting an instance style is a relatively fast operation     *  compared with setting a selector style.</p>     *     *  <p>You should not need to call or override this method.</p>     *     *  @param recursive Recursivly regenerates the style cache for      *  all children of this component.
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  Gets a style property that has been set anywhere in this     *  component's style lookup chain.     *     *  <p>This same method is used to get any kind of style property,     *  so the value returned may be a Boolean, String, Number, int,     *  uint (for an RGB color), Class (for a skin), or any kind of object.     *  Therefore the return type is simply specified as ~~.</p>     *     *  <p>If you are getting a particular style property, you will     *  know its type and will often want to store the result in a     *  variable of that type.     *  No casting from ~~ to that type is necessary.</p>     *     *  <p>     *  <code>     *  var backgroundColor:uint = getStyle("backgroundColor");     *  </code>     *  </p>     *     *  <p>If the style property has not been set anywhere in the     *  style lookup chain, the value returned by <code>getStyle()</code>     *  will be <code>undefined</code>.     *  Note that <code>undefined</code> is a special value that is     *  not the same as <code>false</code>, <code>""</code>,     *  <code>NaN</code>, <code>0</code>, or <code>null</code>.     *  No valid style value is ever <code>undefined</code>.     *  You can use the static method     *  <code>StyleManager.isValidStyleValue()</code>     *  to test whether the value was set.</p>     *     *  @param styleProp Name of the style property.     *     *  @return Style value.
		 */
		public function getStyle (styleProp:String) : *;
		/**
		 *  Sets a style property on this component instance.     *     *  <p>This may override a style that was set globally.</p>     *     *  <p>Calling the <code>setStyle()</code> method can result in decreased performance.     *  Use it only when necessary.</p>     *     *  @param styleProp Name of the style property.     *     *  @param newValue New value for the style.
		 */
		public function setStyle (styleProp:String, newValue:*) : void;
		/**
		 *  Deletes a style property from this component instance.     *     *  <p>This does not necessarily cause the <code>getStyle()</code> method      *  to return <code>undefined</code>.</p>     *     *  @param styleProp The name of the style property.
		 */
		public function clearStyle (styleProp:String) : void;
		/**
		 *  Propagates style changes to the children.     *  You typically never need to call this method.     *     *  @param styleProp String specifying the name of the style property.     *     *  @param recursive Recursivly notify all children of this component.
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @private     *  If this object has a themeColor style, which is not inherited,     *  then set it inline.
		 */
		function initThemeColor () : Boolean;
		/**
		 *  @private     *  Calculate and set new roll over and selection colors based on theme color.
		 */
		function setThemeColor (value:Object) : void;
		/**
		 *  Returns a UITextFormat object corresponding to the text styles     *  for this UIComponent.     *     *  @return UITextFormat object corresponding to the text styles     *  for this UIComponent.
		 */
		public function determineTextFormatFromStyles () : UITextFormat;
		/**
		 *  Executes the data bindings into this UIComponent object.     *     *  Workaround for MXML container/bindings problem (177074):     *  override Container.executeBindings() to prefer descriptor.document over parentDocument in the     *  call to BindingManager.executeBindings().     *     *  This should always provide the correct behavior for instances created by descriptor, and will     *  provide the original behavior for procedurally-created instances. (The bug may or may not appear     *  in the latter case.)     *     *  A more complete fix, guaranteeing correct behavior in both non-DI and reparented-component     *  scenarios, is anticipated for updater 1.     *     *  @param recurse Recursively execute bindings for children of this component.
		 */
		public function executeBindings (recurse:Boolean = false) : void;
		/**
		 *  For each effect event, registers the EffectManager     *  as one of the event listeners.     *  You typically never need to call this method.     *     *  @param effects The names of the effect events.
		 */
		public function registerEffects (effects:Array) : void;
		/**
		 *  @private     *      *  Adds an overlay object that's always on top of our children.     *  Calls createOverlay(), which returns the overlay object.     *  Currently used by the Dissolve and Resize effects.     *     *  Returns the overlay object.
		 */
		function addOverlay (color:uint, targetArea:RoundedRectangle = null) : void;
		/**
		 *  This is an internal method used by the Flex framework     *  to support the Dissolve effect.     *  You should not need to call it or override it.
		 */
		protected function attachOverlay () : void;
		/**
		 *  @private     *  Fill an overlay object which is always the topmost child.     *  Used by the Dissolve effect.     *  Never call this function directly.     *  It is called internally by addOverlay().     *     *  The overlay object is filled with a solid rectangle that has the     *  same width and height as the component.
		 */
		function fillOverlay (overlay:UIComponent, color:uint, targetArea:RoundedRectangle = null) : void;
		/**
		 *  @private       *  Removes the overlay object added by addOverlay().
		 */
		function removeOverlay () : void;
		/**
		 *  @private     *  Resize the overlay when the components size changes     *
		 */
		private function overlay_resizeHandler (event:Event) : void;
		/**
		 *  Called by the effect instance when it starts playing on the component.     *  You can use this method to perform a modification to the component as part     *  of an effect. You can use the <code>effectFinished()</code> method     *  to restore the modification when the effect ends.     *     *  @param effectInst The effect instance object playing on the component.
		 */
		public function effectStarted (effectInst:IEffectInstance) : void;
		/**
		 *  Called by the effect instance when it stops playing on the component.     *  You can use this method to restore a modification to the component made     *  by the <code>effectStarted()</code> method when the effect started,     *  or perform some other action when the effect ends.     *     *  @param effectInst The effect instance object playing on the component.
		 */
		public function effectFinished (effectInst:IEffectInstance) : void;
		/**
		 *  Ends all currently playing effects on the component.
		 */
		public function endEffectsStarted () : void;
		/**
		 *  @private
		 */
		private function updateCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function processEffectFinished (effectInsts:Array) : void;
		/**
		 *  @private
		 */
		function getEffectsForProperty (propertyName:String) : Array;
		/**
		 *  @inheritDoc
		 */
		public function createReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  @inheritDoc
		 */
		public function deleteReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  Returns the item in the <code>dataProvider</code> that was used     *  by the specified Repeater to produce this Repeater, or     *  <code>null</code> if this Repeater isn't repeated.     *  The argument <code>whichRepeater</code> is 0 for the outermost     *  Repeater, 1 for the next inner Repeater, and so on.     *  If <code>whichRepeater</code> is not specified,     *  the innermost Repeater is used.     *     *  @param whichRepeater Number of the Repeater,     *  counting from the outermost one, starting at 0.     *     *  @return The requested repeater item.
		 */
		public function getRepeaterItem (whichRepeater:int = -1) : Object;
		/**
		 *  This method is called when a UIComponent is constructed,     *  and again whenever the ResourceManager dispatches     *  a <code>"change"</code> Event to indicate     *  that the localized resources have changed in some way.     *      *  <p>This event will be dispatched when you set the ResourceManager's     *  <code>localeChain</code> property, when a resource module     *  has finished loading, and when you call the ResourceManager's     *  <code>update()</code> method.</p>     *     *  <p>Subclasses should override this method and, after calling     *  <code>super.resourcesChanged()</code>, do whatever is appropriate     *  in response to having new resource values.</p>
		 */
		protected function resourcesChanged () : void;
		/**
		 *  Prepares an IFlexDisplayObject for printing.      *  For the UIComponent class, the method performs no action.      *  Flex containers override the method to prepare for printing;      *  for example, by removing scroll bars from the printed output.     *     *  <p>This method is normally not used by application developers. </p>     *     *  @param target The component to be printed.     *  It may be the current component or one of its children.     *     *  @return Object containing the properties of the current component      *  required by the <code>finishPrint()</code> method      *  to restore it to its previous state.     *     *  @see mx.printing.FlexPrintJob
		 */
		public function prepareToPrint (target:IFlexDisplayObject) : Object;
		/**
		 *  Called after printing is complete.      *  For the UIComponent class, the method performs no action.      *  Flex containers override the method to restore the container after printing.     *     *  <p>This method is normally not used by application developers. </p>     *     *  @param obj Contains the properties of the component that      *  restore it to its state before printing.     *     *  @param target The component that just finished printing.     *  It may be the current component or one of its children.     *     *  @see mx.printing.FlexPrintJob
		 */
		public function finishPrint (obj:Object, target:IFlexDisplayObject) : void;
		/**
		 *  @private     *  Callback that then calls queued functions.
		 */
		private function callLaterDispatcher (event:Event) : void;
		/**
		 *  @private     *  Callback that then calls queued functions.
		 */
		private function callLaterDispatcher2 (event:Event) : void;
		/**
		 *  @private     *  Event handler called when creation is complete and we have a pending     *  current state change. We commit the current state change here instead     *  of inside commitProperties since the state may have bindings to children     *  that have not been created yet if we are inside a deferred instantiation     *  container.
		 */
		private function creationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  The event handler called for a <code>keyDown</code> event.     *  If you override this method, make sure to call the base class version.     *     *  @param event The event object.
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  The event handler called for a <code>keyUp</code> event.     *  If you override this method, make sure to call the base class version.     *     *  @param event The event object.
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 *  Typically overridden by components containing UITextField objects,     *  where the UITextField object gets focus.     *     *  @param target A UIComponent object containing a UITextField object      *  that can receive focus.     *     *  @return Returns <code>true</code> if the UITextField object has focus.
		 */
		protected function isOurFocus (target:DisplayObject) : Boolean;
		/**
		 *  The event handler called when a UIComponent object gets focus.     *  If you override this method, make sure to call the base class version.     *     *  @param event The event object.
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  The event handler called when a UIComponent object loses focus.     *  If you override this method, make sure to call the base class version.     *     *  @param event The event object.
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private     *  The player dispatches an "added" event when the addChild()     *  or addChildAt() method of DisplayObjectContainer is called,     *  but handling this event at that time can be dangerous     *  so we prevent the event dispatched then from propagating;     *  we'll dispatch another "added" event later when it is safe.     *  The reason the timing of this player event is dangerous     *  is that the Flex framework overrides addChild() and addChildAt(),     *  to perform important additional work after calling the super     *  method, such as setting _parent to skip over the contentPane     *  of a Container. So if an "added" handler executes too early,     *  the child is in an inconsistent state. (For example, its     *  toString() can be wrong because the contentPane is wrongly     *  included when traversing the parent chain.) Our overrides     *  delay dispatching the "added" event until the end of the     *  override, as opposed to in the middle when super.addChild()     *  is called.     *  Note: This event handler is registered by the UIComponent     *  constructor, which means it is registered before any     *  other handlers for an "added" event.     *  Therefore it can prevent all others from being called.
		 */
		private function addedHandler (event:Event) : void;
		/**
		 *  @private     *  See the comments for addedHandler() above.
		 */
		private function removedHandler (event:Event) : void;
		/**
		 *  @private     *  There is a bug (139390) where setting focus from within callLaterDispatcher     *  screws up the ActiveX player.  We defer focus until enterframe.
		 */
		private function setFocusLater (event:Event = null) : void;
		/**
		 *  @private     *  Called when this component moves. Adjust the focus rect.
		 */
		private function focusObj_scrollHandler (event:Event) : void;
		/**
		 *  @private     *  Called when this component moves. Adjust the focus rect.
		 */
		private function focusObj_moveHandler (event:MoveEvent) : void;
		/**
		 *  @private     *  Called when this component resizes. Adjust the focus rect.
		 */
		private function focusObj_resizeHandler (event:ResizeEvent) : void;
		/**
		 *  @private     *  Called when this component is unloaded. Hide the focus rect.
		 */
		private function focusObj_removedHandler (event:Event) : void;
		/**
		 *  Handles both the <code>valid</code> and <code>invalid</code> events from a     *  validator assigned to this component.     *     *  <p>You typically handle the <code>valid</code> and <code>invalid</code> events     *  dispatched by a validator by assigning event listeners to the validators.     *  If you want to handle validation events directly in the component that is being validated,     *  you can override this method to handle the <code>valid</code>     *  and <code>invalid</code> events. You typically call     *  <code>super.validationResultHandler(event)</code> in your override.</p>     *     *  @param event The event object for the validation.     *     *  @see mx.events.ValidationResultEvent
		 */
		public function validationResultHandler (event:ValidationResultEvent) : void;
		/**
		 *  @private
		 */
		private function resourceManager_changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function filterChangeHandler (event:Event) : void;
		/**
		 *  Returns <code>true</code> if the chain of <code>owner</code> properties      *  points from <code>child</code> to this UIComponent.     *     *  @param child A UIComponent.     *     *  @return <code>true</code> if the child is parented or owned by this UIComponent.
		 */
		public function owns (child:DisplayObject) : Boolean;
		/**
		 * @private     *      * Get the embedded font for a set of font attributes.
		 */
		function getEmbeddedFont (fontName:String, bold:Boolean, italic:Boolean) : EmbeddedFont;
		/**
		 *  @private     *  Finds a module factory that can create a TextField     *  that can display the given font.     *  This is important for embedded fonts, not for system fonts.     *      *  @param fontName The name of the fontFamily.     *     *  @param bold A flag which true if the font weight is bold,     *  and false otherwise.     *     *  @param italic A flag which is true if the font style is italic,     *  and false otherwise.     *      *  @return The IFlexModuleFactory that represents the context     *  where an object wanting to  use the font should be created.
		 */
		function getFontContext (fontName:String, bold:Boolean, italic:Boolean) : IFlexModuleFactory;
		/**
		 *  Creates a new object using a context     *  based on the embedded font being used.     *     *  <p>This method is used to solve a problem     *  with access to fonts embedded  in an application SWF     *  when the framework is loaded as an RSL     *  (the RSL has its own SWF context).     *  Embedded fonts may only be accessed from the SWF file context     *  in which they were created.     *  By using the context of the application SWF,     *  the RSL can create objects in the application SWF context     *  that will have access to the application's  embedded fonts.</p>     *      *  <p>Call this method only after the font styles     *  for this object are set.</p>     *      *  @param class The class to create.     *     *  @return The instance of the class created in the context     *  of the SWF owning the embedded font.     *  If this object is not using an embedded font,     *  the class is created in the context of this object.
		 */
		protected function createInFontContext (classObj:Class) : Object;
		/**
		 *  Creates the object using a given moduleFactory.     *  If the moduleFactory is null or the object     *  cannot be created using the module factory,     *  then fall back to creating the object using a systemManager.     *      *  @param moduleFactory The moduleFactory to create the class in;     *  may be null.     *     *  @param className The name of the class to create.     *     *  @return The object created in the context of the moduleFactory.
		 */
		protected function createInModuleContext (moduleFactory:IFlexModuleFactory, className:String) : Object;
		/**
		 *  @private     *      *  Tests if the current font context has changed      *  since that last time createInFontContext() was called.
		 */
		public function hasFontContextChanged () : Boolean;
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
		/**
		 *  @private     *      *  Get the bounds of this object that are visible to the user     *  on the screen.     *      *  @param targetParent The parent to stop at when calculating the visible     *  bounds. If null, this object's system manager will be used as     *  the parent.     *      *  @return a <code>Rectangle</code> including the visible portion of the this      *  object. The rectangle is in global coordinates.
		 */
		public function getVisibleRect (targetParent:DisplayObject = null) : Rectangle;
		/**
		 *  Dispatches an event into the event flow.      *  The event target is the EventDispatcher object upon which      *  the <code>dispatchEvent()</code> method is called.     *     *  @param event The Event object that is dispatched into the event flow.      *  If the event is being redispatched, a clone of the event is created automatically.      *  After an event is dispatched, its <code>target</code> property cannot be changed,      *  so you must create a new copy of the event for redispatching to work.     *     *  @return A value of <code>true</code> if the event was successfully dispatched.      *  A value of <code>false</code> indicates failure or that      *  the <code>preventDefault()</code> method was called on the event.
		 */
		public function dispatchEvent (event:Event) : Boolean;
	}
	/**
	 *  @private *  An element of the methodQueue array.
	 */
	internal class MethodQueueElement
	{
		/**
		 *  A reference to the method to be called.
		 */
		public var method : Function;
		/**
		 *  The arguments to be passed to the method.
		 */
		public var args : Array;

		/**
		 *  Constructor.
		 */
		public function MethodQueueElement (method:Function, args:Array = null);
	}
}
