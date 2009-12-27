package mx.managers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import mx.controls.ToolTip;
	import mx.core.ApplicationGlobals;
	import mx.core.IInvalidating;
	import mx.core.IToolTip;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.effects.IAbstractEffect;
	import mx.effects.EffectManager;
	import mx.events.EffectEvent;
	import mx.events.ToolTipEvent;
	import mx.events.InterManagerRequest;
	import mx.managers.IToolTipManagerClient;
	import mx.styles.IStyleClient;
	import mx.validators.IValidatorListener;

include "../core/Version.as"
	/**
	 *  @private
 *  The ToolTipManager lets you set basic ToolTip and error tip functionality,
 *  such as display delay and the disabling of ToolTips.
 *
 *  @see mx.controls.ToolTip
 *  @see mx.validators.Validator
	 */
	public class ToolTipManagerImpl extends EventDispatcher implements IToolTipManager2
	{
		/**
		 *  @private
		 */
		private static var instance : IToolTipManager2;
		/**
		 *  @private
		 */
		private var systemManager : ISystemManager;
		/**
		 *  @private
		 */
		private var sandboxRoot : IEventDispatcher;
		/**
		 *  @private
     *  A flag that keeps track of whether this class's initialize()
     *  method has been executed.
		 */
		var initialized : Boolean;
		/**
		 *  @private
     *  This timer is used to delay the appearance of a normal ToolTip
     *  after the mouse moves over a target; an error tip has no such delay.
     *
     *  <p>This timer, which is lazily created, is started when the mouse
     *  moves over an object with a ToolTip, with a duration specified
     *  by showDelay.
     *  If the mouse moves out of this object before the timer fires,
     *  the ToolTip is never created.
     *  If the mouse stays over the object until the timer fires,
     *  the ToolTip is created and its showEffect is started.
		 */
		var showTimer : Timer;
		/**
		 *  @private
     *  This timer is used to make the tooltip "time out" and hide itself
     *  if the mouse stays over a target.
     *
     *  <p>This timer, which is lazily created, is started
     *  when the showEffect ends.
     *  When it fires, the hideEffect is started.</p>
		 */
		var hideTimer : Timer;
		/**
		 *  @private
     *  This timer is used to implement mousing quickly over multiple targets
     *  with ToolTip...
     *
     *  <p>This timer, which is lazily created, is started
     *  when ...</p>
		 */
		var scrubTimer : Timer;
		/**
		 *  @private
		 */
		var currentText : String;
		/**
		 *  @private
		 */
		var isError : Boolean;
		/**
		 *  The UIComponent with the ToolTip assigned to it
     *  that was most recently under the mouse.
     *  During much of the tool tip life cycle this property
     *  has the same value as the <code>currentTarget</code> property.
		 */
		var previousTarget : DisplayObject;
		/**
		 *  @private
		 */
		private var _currentTarget : DisplayObject;
		/**
		 *  @private
		 */
		private var _currentToolTip : DisplayObject;
		/**
		 *  @private
		 */
		private var _enabled : Boolean;
		/**
		 *  @private
		 */
		private var _hideDelay : Number;
		/**
		 *  @private
		 */
		private var _hideEffect : IAbstractEffect;
		/**
		 *  @private
		 */
		private var _scrubDelay : Number;
		/**
		 *  @private
		 */
		private var _showDelay : Number;
		/**
		 *  @private
		 */
		private var _showEffect : IAbstractEffect;
		/**
		 *  @private
		 */
		private var _toolTipClass : Class;

		/**
		 *  The UIComponent that is currently displaying a ToolTip,
     *  or <code>null</code> if none is.
		 */
		public function get currentTarget () : DisplayObject;
		/**
		 *  @private
		 */
		public function set currentTarget (value:DisplayObject) : void;

		/**
		 *  The ToolTip object that is currently visible,
     *  or <code>null</code> if none is shown.
		 */
		public function get currentToolTip () : IToolTip;
		/**
		 *  @private
		 */
		public function set currentToolTip (value:IToolTip) : void;

		/**
		 *  If <code>true</code>, the ToolTipManager will automatically show
     *  ToolTips when the user moves the mouse pointer over components.
     *  If <code>false</code>, no ToolTips will be shown.
     *
     *  @default true
		 */
		public function get enabled () : Boolean;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  The amount of time, in milliseconds, that Flex waits
     *  to hide the ToolTip after it appears.
     *  Once Flex hides a ToolTip, the user must move the mouse
     *  off the component and then back onto it to see the ToolTip again.
     *  If you set <code>hideDelay</code> to <code>Infinity</code>,
     *  Flex does not hide the ToolTip until the user triggers an event,
     *  such as moving the mouse off of the component.
     *
     *  @default 10000
		 */
		public function get hideDelay () : Number;
		/**
		 *  @private
		 */
		public function set hideDelay (value:Number) : void;

		/**
		 *  The effect that plays when a ToolTip is hidden,
     *  or <code>null</code> if the ToolTip should disappear with no effect.
	 *
	 *  <p>Effects are not marshaled across applicationDomains in a sandbox
	 *  as they may not be supportable in different versions</p>
     *
     *  @default null
		 */
		public function get hideEffect () : IAbstractEffect;
		/**
		 *  @private
		 */
		public function set hideEffect (value:IAbstractEffect) : void;

		/**
		 *  The amount of time, in milliseconds, that a user can take
     *  when moving the mouse between controls before Flex again waits
     *  for the duration of <code>showDelay</code> to display a ToolTip.
     *
     *  <p>This setting is useful if the user moves quickly from one control
     *  to another; after displaying the first ToolTip, Flex will display
     *  the others immediately rather than waiting.
     *  The shorter the setting for <code>scrubDelay</code>, the more
     *  likely that the user must wait for an amount of time specified
     *  by <code>showDelay</code> in order to see the next ToolTip.
     *  A good use of this property is if you have several buttons on a
     *  toolbar, and the user will quickly scan across them to see brief
     *  descriptions of their functionality.</p>
     *
     *  @default 100
		 */
		public function get scrubDelay () : Number;
		/**
		 *  @private
		 */
		public function set scrubDelay (value:Number) : void;

		/**
		 *  The amount of time, in milliseconds, that Flex waits
     *  before displaying the ToolTip box once a user
     *  moves the mouse over a component that has a ToolTip.
     *  To make the ToolTip appear instantly, set <code>showDelay</code> to 0.
     *
     *  @default 500
		 */
		public function get showDelay () : Number;
		/**
		 *  @private
		 */
		public function set showDelay (value:Number) : void;

		/**
		 *  The effect that plays when a ToolTip is shown,
     *  or <code>null</code> if the ToolTip should appear with no effect.
	 *
	 *  <p>Effects are not marshaled across applicationDomains in a sandbox
	 *  as they may not be supportable in different versions</p>
     *
     *  @default null
		 */
		public function get showEffect () : IAbstractEffect;
		/**
		 *  @private
		 */
		public function set showEffect (value:IAbstractEffect) : void;

		/**
		 *  The class to use for creating ToolTips.
     *  
	 *  <p>The ToolTipClass is not marshaled across applicationDomains in a sandbox
	 *  as they may not be supportable in different versions.  Child
	 *  applications should only be interested in setting the tooltip
	 *  for objects within themselves</p>
     *
     *  @default mx.controls.ToolTip
		 */
		public function get toolTipClass () : Class;
		/**
		 *  @private
		 */
		public function set toolTipClass (value:Class) : void;

		/**
		 *  @private
		 */
		public static function getInstance () : IToolTipManager2;

		/**
		 *  @private
		 */
		public function ToolTipManagerImpl ();

		/**
		 *  @private
     *  Initializes the class.
     *
     *  <p>This method sets up three Timer objects that ToolTipManager
     *  starts and stops while tracking the mouse.
     *  The repeatCount is set to 1 so that they fire only once.
     *  Their duration is set later, just before they are started.
     *  The timers are never destroyed once they are created here.</p>
     *
     *  <p>This method is called by targetChanged(); Flex waits to initialize
     *  the class until mouse-tracking happens in order to optimize
     *  startup time.</p>
		 */
		function initialize () : void;

		/**
		 *  Registers a target UIComponent or UITextField, and the text
     *  for its ToolTip, with the ToolTipManager.
     *  This causes the ToolTipManager to display a ToolTip
     *  when the mouse hovers over the target.
     *
     *  <p>This method is called by the setter
     *  for the toolTip property in UIComponent and UITextField.</p>
     *
     *  @param target The UIComponent or UITextField that owns the ToolTip.
     *
     *  @param oldToolTip The old text that was displayed
     *  in the ToolTip.
     * 
     *  @param newToolTip The new text to display in the ToolTip.
     *  If null, no ToolTip will be displayed when the mouse hovers
     *  over the target.
		 */
		public function registerToolTip (target:DisplayObject, oldToolTip:String, newToolTip:String) : void;

		/**
		 *  Registers a target UIComponent, and the text
     *  for its error tip, with the ToolTipManager.
     *  This causes the ToolTipManager to display an error tip
     *  when the mouse hovers over the target.
     *
     *  <p>This method is called by the setter
     *  for the errorString property in UIComponent.</p>
     *
     *  @param target The UIComponent or UITextField that owns the ToolTip.
     * 
     *  @param oldErrorString The old text that was displayed
     *  in the error tip.
     *
     *  @param newErrorString The new text to display in the error tip.
     *  If null, no error tip will be displayed when the mouse hovers
     *  over the target.
		 */
		public function registerErrorString (target:DisplayObject, oldErrorString:String, newErrorString:String) : void;

		/**
		 *  @private
     *  Returns true if the mouse is over the specified target.
		 */
		private function mouseIsOver (target:DisplayObject) : Boolean;

		/**
		 *  @private
     *  Shows the tip immediately when the toolTip or errorTip property 
     *  becomes non-null and the mouse is over the target.
		 */
		private function showImmediately (target:DisplayObject) : void;

		/**
		 *  @private
     *  Hides the tip immediately when the toolTip or errorTip property 
     *  becomes null and the mouse is over the target.
		 */
		private function hideImmediately (target:DisplayObject) : void;

		/**
		 *  Replaces the ToolTip, if necessary.
     *
     *  <p>Determines whether the UIComponent or UITextField object
     *  with the ToolTip assigned to it that is currently under the mouse
     *  pointer is the most recent such object.
     *  If not, it removes the old ToolTip and displays the new one.</p>
     *
     *  @param displayObject The UIComponent or UITextField that is currently under the mouse.
		 */
		function checkIfTargetChanged (displayObject:DisplayObject) : void;

		/**
		 *  Searches from the <code>displayObject</code> object up the chain
     *  of parent objects until it finds a UIComponent or UITextField object
     *  with a <code>toolTip</code> or <code>errorString</code> property.
     *  Treats an empty string as a valid <code>toolTip</code> property.
     *  Sets the <code>currentTarget</code> property.
		 */
		function findTarget (displayObject:DisplayObject) : void;

		/**
		 *  Removes any ToolTip that is currently displayed and displays
     *  the ToolTip for the UIComponent that is currently under the mouse
     *  pointer, as determined by the <code>currentTarget</code> property.
		 */
		function targetChanged () : void;

		/**
		 *  Creates an invisible new ToolTip.
     *
     *  <p>If the ToolTipManager's <code>enabled</code> property is
     *  <code>true</code> this method is automatically called
     *  when the user moves the mouse over an object that has
     *  the <code>toolTip</code> property set,
     *  The ToolTipManager makes subsequent calls to
     *  <code>initializeTip()</code>, <code>positionTip()</code>,
     *  and <code>showTip()</code> to complete the display
     *  of the ToolTip.</p>
     *
     *  <p>The type of ToolTip that is created is determined by the
     *  <code>toolTipClass</code> property.
     *  By default, this is the ToolTip class.
     *  This class can be styled to appear as either a normal ToolTip
     *  (which has a yellow background by default) or as an error tip
     *  for validation errors (which is red by default).</p>
     *
     *  <p>After creating the ToolTip with the <code>new</code>
     *  operator, this method stores a reference to it in the
     *  <code>currentToolTip</code> property.
     *  It then uses addChild() to add this ToolTip to the
     *  SystemManager's toolTips layer.</p>
		 */
		function createTip () : void;

		/**
		 *  Initializes a newly created ToolTip with the appropriate text,
     *  based on the object under the mouse.
     *
     *  <p>If the ToolTipManager's <code>enabled</code> property is
     *  <code>true</code> this method is automatically called
     *  when the user moves the mouse over an object that has
     *  the <code>toolTip</code> property set.
     *  The ToolTipManager calls <code>createTip()</code> before
     *  this method, and <code>positionTip()</code> and
     *  <code>showTip()</code> after.</p>
     *
     *  <p>If a normal ToolTip is being displayed, this method
     *  sets its text as specified by the <code>toolTip</code>
     *  property of the object under the mouse.
     *  If an error tip is being displayed, the text is as
     *  specified by the <code>errorString</code> property
     *  of the object under the mouse.</p>
     *
     *  <p>This method also makes the ToolTip the appropriate
     *  size for the text that it needs to display.</p>
		 */
		function initializeTip () : void;

		/**
		 *  @private
     *  Objects added to the SystemManager's ToolTip layer don't get
     *  automatically measured or sized, so ToolTipManager has to
     *  measure it and set its size.
		 */
		public function sizeTip (toolTip:IToolTip) : void;

		/**
		 *  Positions a newly created and initialized ToolTip on the stage.
     *
     *  <p>If the ToolTipManager's <code>enabled</code> property is
     *  <code>true</code> this method is automatically called
     *  when the user moves the mouse over an object that has
     *  the <code>toolTip</code> property set.
     *  The ToolTipManager calls <code>createTip()</code> and
     *  <code>initializeTip()</code> before this method,
     *  and <code>showTip()</code> after.</p>
     *
     *  <p>If a normal ToolTip is being displayed, this method positions
     *  its upper-left corner near the lower-right of the arrow cursor.
     *  This method ensures that the ToolTip is completely in view.
		 */
		function positionTip () : void;

		/**
		 *  Shows a newly created, initialized, and positioned ToolTip.
     *
     *  <p>If the ToolTipManager's <code>enabled</code> property is
     *  <code>true</code> this method is automatically called
     *  when the user moves the mouse over an object that has
     *  the <code>toolTip</code> property set.
     *  The ToolTipManager calls <code>createTip()</code>,
     *  <code>initializeTip()</code>, and <code>positionTip()</code>
     *  before this method.</p>
     *
     *  <p>This method first dispatches a <code>"showToolTip"</code>
     *  event from the object under the mouse.
     *  This gives you a chance to do special processing on a
     *  particular object's ToolTip just before it becomes visible.
     *  It then makes the ToolTip visible, which triggers
     *  the ToolTipManager's <code>showEffect</code> if one is specified.
		 */
		function showTip () : void;

		/**
		 *  Hides the current ToolTip.
		 */
		function hideTip () : void;

		/**
		 *  Removes any currently visible ToolTip.
     *  If the ToolTip is starting to show or hide, this method
     *  removes the ToolTip immediately without completing the effect.
		 */
		function reset () : void;

		/**
		 *  Creates an instance of the ToolTip class with the specified text
     *  and displays it at the specified location in stage coordinates.
     *
     *  <p>ToolTips appear in their own layer, on top of everything
     *  except cursors.</p>
     *
     *  <p>The standard way of using ToolTips is to let the ToolTipManager
     *  automatically show and hide them as the user moves the mouse over
     *  the objects that have the <code>toolTip</code> property set.
     *  You can turn off this automatic ToolTip management by setting
     *  the ToolTipManager's <code>enabled</code> property to
     *  <code>false</code>.</p>
     *
     *  <p>By contrast, this method&#x2014;along with <code>hideToolTip()</code>&#x2014;gives 
     *  you programmatic control over ToolTips.
     *  You can show them when and where you choose,
     *  and you can even show more than one at once if you need to.
     *  (The ToolTipManager never does this, because it is generally
     *  confusing to the user).</p>
     *
     *  <p>This method first creates a new instance of ToolTip and calls the 
     *  <code>addChild()</code> method to put it into the SystemManager's
     *  toolTips layer.
     *  If you are showing an error tip, it sets the appropriate styles.
     *  Then it sets the text for the ToolTip, sizes the ToolTip based on
     *  its text, and positions it where you specified.</p>
     *
     *  <p>You must save the reference to the ToolTip that this method
     *  returns so that you can pass it to the <code>hideToolTip()</code> method.</p>
     *
     *  @param text The text to display in the ToolTip instance.
     *
     *  @param x The horizontal coordinate of the ToolTip in stage coordinates.
     *  In case of multiple stages, the relevant stage is determined
     *  from the <code>context</code> argument.
     *
     *  @param y The vertical coordinate of the ToolTip in stage coordinates.
     *  In case of multiple stages, the relevant stage is determined
     *  from the <code>context</code> argument.
     *
     *  @param errorTipBorderStyle The border style of an error tip. This method 
     *  argument can be null, "errorTipRight", "errorTipAbove", or "errorTipBelow". 
     *  If it is null, then the <code>createToolTip()</code> method creates a normal ToolTip. If it is 
     *  "errorTipRight", "errorTipAbove", or "errorTipBelow", then the <code>createToolTip()</code> 
     *  method creates an error tip, and this parameter determines where the arrow 
     *  of the error tip points to (the error's target). For example, if you pass "errorTipRight", Flex 
     *  positions the error tip (via the x and y arguments) to the 
     *  right of the error target; the arrow is on the left edge of the error tip.
     *
     *  @param context This property is not currently used.
     *
     *  @return The newly created ToolTip.
     *
		 */
		public function createToolTip (text:String, x:Number, y:Number, errorTipBorderStyle:String = null, context:IUIComponent = null) : IToolTip;

		/**
		 *  Destroys a specified ToolTip that was created by the <code>createToolTip()</code> method.
     *
     *  <p>This method calls the <code>removeChild()</code> method to remove the specified
     *  ToolTip from the SystemManager's ToolTips layer.
     *  It will then be garbage-collected unless you keep a
     *  reference to it.</p>
     *
     *  <p>You should not call this method on the ToolTipManager's
     *  <code>currentToolTip</code>.</p>
     *
     *  @param toolTip The ToolTip instance to destroy.
		 */
		public function destroyToolTip (toolTip:IToolTip) : void;

		/**
		 *  @private
		 */
		function showEffectEnded () : void;

		/**
		 *  @private
		 */
		function hideEffectEnded () : void;

		/**
		 *  @private
		 */
		private function getSystemManager (target:DisplayObject) : ISystemManager;

		/**
		 *  @private
		 */
		private function getGlobalBounds (obj:DisplayObject, parent:DisplayObject) : Rectangle;

		/**
		 *  @private
     *  This handler is called when the mouse moves over an object
     *  with a toolTip.
		 */
		function toolTipMouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  This handler is called when the mouse moves out of an object
     *  with a toolTip.
		 */
		function toolTipMouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  This handler is called when the mouse moves over an object
     *  with an errorString.
		 */
		function errorTipMouseOverHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  This handler is called when the mouse moves out of an object
     *  with an errorString.
		 */
		function errorTipMouseOutHandler (event:MouseEvent) : void;

		/**
		 *  @private
     *  This handler is called when the showTimer fires.
     *  It creates the tooltip and starts its showEffect.
		 */
		function showTimer_timerHandler (event:TimerEvent) : void;

		/**
		 *  @private
     *  This handler is called when the hideTimer fires.
     *  It starts the hideEffect.
		 */
		function hideTimer_timerHandler (event:TimerEvent) : void;

		/**
		 *  @private
     *  This handler is called when the showEffect or hideEffect ends.
     *  When the showEffect ends, it starts the hideTimer,
     *  which will automatically start hiding the tooltip when it fires,
     *  even if the mouse is still over the target.
     *  When the hideEffect ends, the tooltip is removed.
		 */
		function effectEndHandler (event:EffectEvent) : void;

		/**
		 *  @private
     *  This handler is called when the user clicks the mouse
     *  while a normal tooltip is displayed.
     *  It immediately hides the tooltip.
		 */
		function systemManager_mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		function changeHandler (event:Event) : void;

		/**
		 *  Marshal dragManager
		 */
		private function marshalToolTipManagerHandler (event:Event) : void;
	}
}
