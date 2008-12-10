package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import mx.core.Application;
	import mx.core.FlexSprite;
	import mx.core.ISWFLoader;
	import mx.core.IButton;
	import mx.core.IChildList;
	import mx.core.IRawChildrenContainer;
	import mx.core.ISWFBridgeProvider;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.core.SWFBridgeGroup;
	import mx.events.FlexEvent;
	import mx.events.FocusRequestDirection;
	import mx.events.SWFBridgeEvent;
	import mx.events.SWFBridgeRequest;
	import mx.utils.DisplayUtil;
	import flash.display.DisplayObject;

	/**
	 *  The FocusManager class manages the focus on components in response to mouse *  activity or keyboard activity (Tab key).  There can be several FocusManager *  instances in an application.  Each FocusManager instance  *  is responsible for a set of components that comprise a "tab loop".  If you *  hit Tab enough times, focus traverses through a set of components and *  eventually get back to the first component that had focus.  That is a "tab loop" *  and a FocusManager instance manages that loop.  If there are popup windows *  with their own set of components in a "tab loop" those popup windows will have *  their own FocusManager instances.  The main application always has a *  FocusManager instance. * *  <p>The FocusManager manages focus from the "component level". *  In Flex, a UITextField in a component is the only way to allow keyboard entry *  of text. To the Flash Player or AIR, that UITextField has focus. However, from the  *  FocusManager's perspective the component that parents the UITextField has focus. *  Thus there is a distinction between component-level focus and player-level focus. *  Application developers generally only have to deal with component-level focus while *  component developers must understand player-level focus.</p> * *  <p>All components that can be managed by the FocusManager must implement *  mx.managers.IFocusManagerComponent, whereas objects managed by player-level focus do not.</p>   * *  <p>The FocusManager also managers the concept of a defaultButton, which is *  the Button on a form that dispatches a click event when the Enter key is pressed *  depending on where focus is at that time.</p>
	 */
	public class FocusManager implements IFocusManager
	{
		/**
		 * @private	 * 	 * Default value of parameter, ignore.
		 */
		private static const FROM_INDEX_UNSPECIFIED : int = -2;
		private var LARGE_TAB_INDEX : int;
		private var calculateCandidates : Boolean;
		/**
		 *  @private     *  We track whether we've been last activated or saw a TAB     *  This is used in browser tab management
		 */
		private var lastAction : String;
		/**
		 *  @private     *  Tab management changes based on whether were in a browser or not     *  This value is also affected by whether you are a modal dialog or not
		 */
		public var browserMode : Boolean;
		/**
		 *  @private     *  Tab management changes based on whether were in a browser or not     *  If non-null, this is the object that will     *  lose focus to the browser
		 */
		private var browserFocusComponent : InteractiveObject;
		/**
		 *  @private     *  Total set of all objects that can receive focus     *  but might be disabled or invisible.
		 */
		private var focusableObjects : Array;
		/**
		 *  @private     *  Filtered set of objects that can receive focus right now.
		 */
		private var focusableCandidates : Array;
		/**
		 *  @private
		 */
		private var activated : Boolean;
		/**
		 * 	@private    *     * 	true if focus was changed to one of focusable objects. False if focus passed to     * 	the browser.
		 */
		private var focusChanged : Boolean;
		/**
		 * 	@private	 * 	 * 	if non-null, the location to move focus from instead of the object 	 *  that has focus in the stage.
		 */
		private var fauxFocus : DisplayObject;
		/**
		 *  @private	  * 	  *  The focus manager maintains its own bridges so a focus manager in a pop	  *  up can move focus to another focus manager in the same pop up. That is,	  *  A pop ups can be a collection of focus managers working together just	  *  as is done in the System Manager's document.
		 */
		private var swfBridgeGroup : SWFBridgeGroup;
		/**
		 * @private	 * 	 * bridge handle of the last active focus manager.
		 */
		private var lastActiveFocusManager : FocusManager;
		/**
		 * @private	 * 	 * Test if the focus was set locally in this focus manager (true) or	 * if focus was transfer to another focus manager (false)
		 */
		private var focusSetLocally : Boolean;
		/**
		 * @private	 * 	 * True if this focus manager is a popup, false if it is a main application.	 *
		 */
		private var popup : Boolean;
		/**
		 *  @private	  * 	  *  Used when a the skip parameter can't be passed into 	  *  dispatchEventFromSWFBridges() because the caller doesn't take	  *  a skip parameter.
		 */
		private var skipBridge : IEventDispatcher;
		/**
		 *  @private     *  Storage for the showFocusIndicator property.
		 */
		private var _showFocusIndicator : Boolean;
		/**
		 *  @private     *  The current default button.
		 */
		private var defButton : IButton;
		/**
		 *  @private
		 */
		private var _defaultButton : IButton;
		/**
		 *  @private     *  Storage for the defaultButtonEnabled property.
		 */
		private var _defaultButtonEnabled : Boolean;
		/**
		 *  @private     *  Storage for the focusPane property.
		 */
		private var _focusPane : Sprite;
		/**
		 *  @private     *  Storage for the form property.
		 */
		private var _form : IFocusManagerContainer;
		/**
		 *  @private     *  the object that last had focus
		 */
		private var _lastFocus : IFocusManagerComponent;

		/**
		 *  @inheritDoc
		 */
		public function get showFocusIndicator () : Boolean;
		/**
		 *  @private
		 */
		public function set showFocusIndicator (value:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function get defaultButton () : IButton;
		/**
		 *  @private     *  We don't type the value as Button for dependency reasons
		 */
		public function set defaultButton (value:IButton) : void;
		/**
		 *  @inheritDoc
		 */
		public function get defaultButtonEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set defaultButtonEnabled (value:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  @private     *  The form is the property where we store the IFocusManagerContainer     *  that hosts this FocusManager.
		 */
		function get form () : IFocusManagerContainer;
		/**
		 *  @private
		 */
		function set form (value:IFocusManagerContainer) : void;
		/**
		 * 	@private
		 */
		function get lastFocus () : IFocusManagerComponent;
		/**
		 *  @inheritDoc
		 */
		public function get nextTabIndex () : int;

		/**
		 *  Constructor.     *     *  <p>A FocusManager manages the focus within the children of an IFocusManagerContainer.     *  It installs itself in the IFocusManagerContainer during execution     *  of the constructor.</p>     *     *  @param container An IFocusManagerContainer that hosts the FocusManager.     *     *  @param popup If <code>true</code>, indicates that the container     *  is a popup component and not the main application.
		 */
		public function FocusManager (container:IFocusManagerContainer, popup:Boolean = false);
		/**
		 *  Gets the highest tab index currently used in this Focus Manager's form or subform.     *     *  @return Highest tab index currently used.
		 */
		private function getMaxTabIndex () : int;
		/**
		 *  @inheritDoc
		 */
		public function getFocus () : IFocusManagerComponent;
		/**
		 *  @inheritDoc
		 */
		public function setFocus (o:IFocusManagerComponent) : void;
		/**
		 *  @private
		 */
		private function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private  Useful for debugging
		 */
		private function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private     *  restore focus to whoever had it last
		 */
		private function activateHandler (event:Event) : void;
		/**
		 *  @private  Useful for debugging
		 */
		private function deactivateHandler (event:Event) : void;
		/**
		 *  @inheritDoc
		 */
		public function showFocus () : void;
		/**
		 *  @inheritDoc
		 */
		public function hideFocus () : void;
		/**
		 *  The SystemManager activates and deactivates a FocusManager     *  if more than one IFocusManagerContainer is visible at the same time.     *  If the mouse is clicked in an IFocusManagerContainer with a deactivated     *  FocusManager, the SystemManager will call      *  the <code>activate()</code> method on that FocusManager.     *  The FocusManager that was activated will have its <code>deactivate()</code> method     *  called prior to the activation of another FocusManager.     *     *  <p>The FocusManager adds event handlers that allow it to monitor     *  focus related keyboard and mouse activity.</p>
		 */
		public function activate () : void;
		/**
		 *  The SystemManager activates and deactivates a FocusManager     *  if more than one IFocusManagerContainer is visible at the same time.     *  If the mouse is clicked in an IFocusManagerContainer with a deactivated     *  FocusManager, the SystemManager will call      *  the <code>activate()</code> method on that FocusManager.     *  The FocusManager that was activated will have its <code>deactivate()</code> method     *  called prior to the activation of another FocusManager.     *     *  <p>The FocusManager removes event handlers that allow it to monitor     *  focus related keyboard and mouse activity.</p>
		 */
		public function deactivate () : void;
		/**
		 *  @inheritDoc
		 */
		public function findFocusManagerComponent (o:InteractiveObject) : IFocusManagerComponent;
		/**
		 * @private    *     * This version of the method differs from the old one to support SWFLoader    * being in the focusableObjects list but not being a component that    * gets focus. SWFLoader is in the list of focusable objects so    * focus may be passed over a bridge to the components on the other    * side of the bridge.
		 */
		private function findFocusManagerComponent2 (o:InteractiveObject) : DisplayObject;
		/**
		 *  @inheritDoc
		 */
		public function moveFocus (direction:String, fromDisplayObject:DisplayObject = null) : void;
		/**
		 *  @private     *  Returns true if p is a parent of o.
		 */
		private function isParent (p:DisplayObjectContainer, o:DisplayObject) : Boolean;
		private function isEnabledAndVisible (o:DisplayObject) : Boolean;
		/**
		 *  @private
		 */
		private function sortByTabIndex (a:InteractiveObject, b:InteractiveObject) : int;
		/**
		 *  @private
		 */
		private function sortFocusableObjectsTabIndex () : void;
		/**
		 *  @private
		 */
		private function sortByDepth (aa:DisplayObject, bb:DisplayObject) : Number;
		private function getChildIndex (parent:DisplayObjectContainer, child:DisplayObject) : int;
		/**
		 *  @private     *  Calculate what focusableObjects are valid tab candidates.
		 */
		private function sortFocusableObjects () : void;
		/**
		 *  Call this method to make the system     *  think the Enter key was pressed and the defaultButton was clicked
		 */
		function sendDefaultButtonEvent () : void;
		/**
		 *  @private     *  Do a tree walk and add all children you can find.
		 */
		private function addFocusables (o:DisplayObject, skipTopLevel:Boolean = false) : void;
		/**
		 *  @private     *  is it really tabbable?
		 */
		private function isTabVisible (o:DisplayObject) : Boolean;
		private function isValidFocusCandidate (o:DisplayObject, g:String) : Boolean;
		private function getIndexOfFocusedObject (o:DisplayObject) : int;
		private function getIndexOfNextObject (i:int, shiftKey:Boolean, bSearchAll:Boolean, groupName:String) : int;
		/**
		 *  @private
		 */
		private function setFocusToNextObject (event:FocusEvent) : void;
		private function setFocusToComponent (o:Object, shiftKey:Boolean) : void;
		/**
		 *  @private
		 */
		private function setFocusToTop () : void;
		/**
		 *  @private
		 */
		private function setFocusToBottom () : void;
		/**
		 *  @private
		 */
		private function setFocusToNextIndex (index:int, shiftKey:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function getNextFocusManagerComponent (backward:Boolean = false) : IFocusManagerComponent;
		/**
		 * Find the next object to set focus to.	 * 	 * @param backward true if moving in the backwards in the tab order, false if moving forward.	 * @param fromObject object to move focus from, if null move from the current focus.	 * @param formIndex index to move focus from, if specified use fromIndex to find the 	 * 		   			object, not fromObject.
		 */
		private function getNextFocusManagerComponent2 (backward:Boolean = false, fromObject:DisplayObject = null, fromIndex:int = FROM_INDEX_UNSPECIFIED) : FocusInfo;
		/**
		 *  @private
		 */
		private function getTopLevelFocusTarget (o:InteractiveObject) : InteractiveObject;
		/**
		 *  Returns a String representation of the component hosting the FocusManager object,      *  with the String <code>".focusManager"</code> appended to the end of the String.     *     *  @return Returns a String representation of the component hosting the FocusManager object,      *  with the String <code>".focusManager"</code> appended to the end of the String.
		 */
		public function toString () : String;
		/**
		 *  @private     *  Listen for children being added     *  and see if they are focus candidates.
		 */
		private function addedHandler (event:Event) : void;
		/**
		 *  @private     *  Listen for children being removed.
		 */
		private function removedHandler (event:Event) : void;
		/**
		 * After the form is added to the stage, if there are no focusable objects,	 * add the form and its children to the list of focuable objects because 	 * this application may have been loaded before the	 * top-level system manager was added to the stage.
		 */
		private function addedToStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removeFocusables (o:DisplayObject, dontRemoveTabChildrenHandler:Boolean) : void;
		/**
		 *  @private
		 */
		private function showHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function hideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function creationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private     *  Add or remove if tabbing properties change.
		 */
		private function tabIndexChangeHandler (event:Event) : void;
		/**
		 *  @private     *  Add or remove if tabbing properties change.
		 */
		private function tabEnabledChangeHandler (event:Event) : void;
		/**
		 *  @private     *  Add or remove if tabbing properties change.
		 */
		private function tabChildrenChangeHandler (event:Event) : void;
		/**
		 *  @private     *  This gets called when mouse clicks on a focusable object.     *  We block player behavior
		 */
		private function mouseFocusChangeHandler (event:FocusEvent) : void;
		/**
		 *  @private     *  This gets called when the tab key is hit.
		 */
		private function keyFocusChangeHandler (event:FocusEvent) : void;
		/**
		 *  @private     *  Watch for Enter key.
		 */
		private function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private     *  This gets called when the focus changes due to a mouse click.     *     *  Note: If the focus is changing to a TextField, we don't call     *  setFocus() on it because the player handles it;     *  calling setFocus() on a TextField which has scrollable text     *  causes the text to autoscroll to the end, making the     *  mouse click set the insertion point in the wrong place.
		 */
		private function mouseDownHandler (event:MouseEvent) : void;
		/**
		 * @private	 * 	 * A request across a bridge from another FocusManager to change the 	 * focus.
		 */
		private function focusRequestMoveHandler (event:Event) : void;
		private function focusRequestActivateHandler (event:Event) : void;
		private function focusRequestDeactivateHandler (event:Event) : void;
		private function bridgeEventActivateHandler (event:Event) : void;
		/**
		 *  @private     *      *  A request across a bridge from another FocusManager to change the      *  value of the setShowFocusIndicator property.
		 */
		private function setShowFocusIndicatorRequestHandler (event:Event) : void;
		/**
		 * This is called on the top-level focus manager and the parent focus	 * manager for each new bridge of focusable content created. 	 * When the parent focus manager of the new focusable content is	 * called, focusable content will become part of the tab order.	 * When the top-level focus manager is called the bridge becomes	 * one of the focus managers managed by the top-level focus manager.
		 */
		public function addSWFBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;
		/**
		 * @inheritdoc
		 */
		public function removeSWFBridge (bridge:IEventDispatcher) : void;
		/**
		 
		 */
		private function removeFromParentBridge (event:Event) : void;
		/**
		 *  @private	 * 	 *  Send a message to the parent to move focus a component in the parent.	 *  	 *  @param shiftKey - if true move focus to a component 	 * 	 *  @return true if focus moved to parent, false otherwise.
		 */
		private function moveFocusToParent (shiftKey:Boolean) : Boolean;
		/**
		 *  Get the bridge to the parent focus manager.     *      *  @return parent bridge or null if there is no parent bridge.
		 */
		private function getParentBridge () : IEventDispatcher;
		/**
		 *  @private     *        *  Send a request for all other focus managers to update     *  their ShowFocusIndicator property.
		 */
		private function dispatchSetShowFocusIndicatorRequest (value:Boolean, skip:IEventDispatcher) : void;
		/**
		 *  @private	 * 	 *  Broadcast an ACTIVATED_FOCUS_MANAGER message.	 * 	 *  @param eObj if a SandboxBridgeEvent, then propagate the message,	 * 			   if null, start a new message.
		 */
		private function dispatchActivatedFocusManagerEvent (skip:IEventDispatcher = null) : void;
		/**
		 *  A Focus Manager has its own set of child bridges that may be different from the child     *  bridges of its System Manager if the Focus Manager is managing a pop up. In the case of     *  a pop up don't send messages to the SM parent bridge because that will be the form. But     *  do send the messages to the bridges in bridgeFocusManagers dictionary.
		 */
		private function dispatchEventFromSWFBridges (event:Event, skip:IEventDispatcher = null) : void;
		private function getBrowserFocusComponent (shiftKey:Boolean) : InteractiveObject;
	}
	/**
	 * @private *  *  Plain old class to return multiple items of info about the potential *  change in focus.
	 */
	internal class FocusInfo
	{
		public var displayObject : DisplayObject;
		public var wrapped : Boolean;

	}
}
