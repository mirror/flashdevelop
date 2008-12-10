package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import mx.core.EventPriority;
	import mx.core.FlexSprite;
	import mx.core.ISWFBridgeGroup;
	import mx.core.ISWFBridgeProvider;
	import mx.core.ISWFLoader;
	import mx.core.IChildList;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModule;
	import mx.core.IUIComponent;
	import mx.core.Singleton;
	import mx.core.SWFBridgeGroup;
	import mx.core.Window;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.EventListenerRequest;
	import mx.events.InvalidateRequestData;
	import mx.events.InterManagerRequest;
	import mx.events.SandboxMouseEvent;
	import mx.events.SWFBridgeRequest;
	import mx.events.SWFBridgeEvent;
	import mx.managers.systemClasses.RemotePopUp;
	import mx.managers.systemClasses.EventProxy;
	import mx.managers.systemClasses.StageEventProxy;
	import mx.managers.systemClasses.PlaceholderData;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.utils.EventUtil;
	import mx.utils.NameUtil;
	import mx.utils.ObjectUtil;
	import mx.utils.SecurityUtil;

	/**
	 *  The WindowedSystemManager class manages any non-Application windows in a  *  Flex-based AIR application. This includes all windows that are instances of  *  the Window component or a Window subclass, but not a WindowedApplication  *  window. For those windows, the WindowedSystemManager serves the same role  *  that a SystemManager serves for a WindowedApplication instance or an  *  Application instance in a browser-based Flex application. *  *  <p>As this comparison suggests, the WindowedSystemManager class serves  *  many roles. For instance, it is the root display object of a Window, and  *  manages tooltips, cursors, popups, and other content for the Window.</p> *  *  @see mx.managers.SystemManager *  *  @playerversion AIR 1.1
	 */
	public class WindowedSystemManager extends MovieClip implements ISystemManager
	{
		/**
		 *  @private	 *  List of top level windows.
		 */
		private var forms : Array;
		/**
		 *  @private	 *  The current top level window.
		 */
		private var form : Object;
		private var topLevel : Boolean;
		private var initialized : Boolean;
		/**
		 *  @private	 *  Number of frames since the last mouse or key activity.
		 */
		local var idleCounter : int;
		/**
		 *  @private	 *  The top level window.
		 */
		local var topLevelWindow : IUIComponent;
		/**
		 *  @private	 *  pointer to Window, for cleanup
		 */
		private var myWindow : Window;
		/**
		 *  @private
		 */
		private var originalSystemManager : SystemManager;
		/**
		 *  @private
		 */
		private var _topLevelSystemManager : ISystemManager;
		/**
		 *  @private	 *  Whether we are the stage root or not.	 *  We are only the stage root if we were the root	 *  of the first SWF that got loaded by the player.	 *  Otherwise we could be top level but not stage root	 *  if we are loaded by some other non-Flex shell	 *  or are sandboxed.
		 */
		private var isStageRoot : Boolean;
		/**
		 *  @private	 *  Whether we are the first SWF loaded into a bootstrap	 *  and therefore, the topLevelRoot
		 */
		private var isBootstrapRoot : Boolean;
		/**
		 *  Depth of this object in the containment hierarchy.	 *  This number is used by the measurement and layout code.
		 */
		local var nestLevel : int;
		/**
		 *  @private	 *  The mouseCatcher is the 0th child of the SystemManager,	 *  behind the application, which is child 1.	 *  It is the same size as the stage and is filled with	 *  transparent pixels; i.e., they've been drawn, but with alpha 0.	 *	 *  Its purpose is to make every part of the stage	 *  able to detect the mouse.	 *  For example, a Button puts a mouseUp handler on the SystemManager	 *  in order to capture mouseUp events that occur outside the Button.	 *  But if the children of the SystemManager don't have "drawn-on"	 *  pixels everywhere, the player won't dispatch the mouseUp.	 *  We can't simply fill the SystemManager itself with	 *  transparent pixels, because the player's pixel detection	 *  logic doesn't look at pixels drawn into the root DisplayObject.	 *	 *  Here is an example of what would happen without the mouseCatcher:	 *  Run a fixed-size Application (e.g. width="600" height="600")	 *  in the standalone player. Make the player window larger	 *  to reveal part of the stage. Press a Button, drag off it	 *  into the stage area, and release the mouse button.	 *  Without the mouseCatcher, the Button wouldn't return to its "up" state.
		 */
		private var mouseCatcher : Sprite;
		/**
		 *  @private     *  Map a bridge to a FocusManager. This is only for Focus Managers that is     *  not the focus manager for document. Since the bridges are not in document     *  they are bridges inside of pop ups.
		 */
		private var bridgeToFocusManager : Dictionary;
		/**
		 *  @private	 *  Storage for the applicationIndex property.
		 */
		private var _applicationIndex : int;
		/**
		 *  @private	 *  Storage for the cursorChildren property.
		 */
		private var _cursorChildren : WindowedSystemChildrenList;
		/**
		 *  @private	 *  Storage for the toolTipIndex property.
		 */
		private var _cursorIndex : int;
		/**
		 *  @private	 *  Storage for the document property.
		 */
		private var _document : Object;
		/**
		 *  @private   	 *  Storage for the fontList property.
		 */
		private var _fontList : Object;
		/**
		 *  @private
		 */
		private var _focusPane : Sprite;
		/**
		 *  @private	 *  Storage for the numModalWindows property.
		 */
		private var _numModalWindows : int;
		/**
		 *  @private	 *  Storage for the popUpChildren property.
		 */
		private var _popUpChildren : WindowedSystemChildrenList;
		/**
		 *  @private	 *  Storage for the noTopMostIndex property.
		 */
		private var _noTopMostIndex : int;
		/**
		 *  @private	 *  Storage for the rawChildren property.
		 */
		private var _rawChildren : WindowedSystemRawChildrenList;
		/**
		 * @private	 * 	 * Represents the related parent and child sandboxs this SystemManager may 	 * communicate with.
		 */
		private var _swfBridgeGroup : ISWFBridgeGroup;
		/**
		 *  @private	 *  Storage for the screen property.
		 */
		private var _screen : Rectangle;
		/**
		 *  @private	 *  Storage for the toolTipChildren property.
		 */
		private var _toolTipChildren : WindowedSystemChildrenList;
		/**
		 *  @private	 *  Storage for the toolTipIndex property.
		 */
		private var _toolTipIndex : int;
		/**
		 *  @private	 *  Storage for the topMostIndex property.
		 */
		private var _topMostIndex : int;
		/**
		 *  @private
		 */
		private var _width : Number;
		/**
		 *  @private
		 */
		private var _window : Window;
		/**
		 *  @private
		 */
		private var _height : Number;
		private var currentSandboxEvent : Event;
		private var dispatchingToSystemManagers : Boolean;
		/**
		 * @private	 * 	 * true if redipatching a resize event.
		 */
		private var isDispatchingResizeEvent : Boolean;
		/**
		 * @private	 * 	 * Used to locate untrusted forms. Maps string ids to Objects.	 * The object make be the SystemManagerProxy of a form or it may be	 * the bridge to the child application where the object lives.
		 */
		private var idToPlaceholder : Object;
		private var eventProxy : EventProxy;
		private var weakReferenceProxies : Dictionary;
		private var strongReferenceProxies : Dictionary;
		local var _mouseX : *;
		local var _mouseY : *;

		/**
		 *  @private	 *  The index of the main mx.core.Application window, which is	 *  effectively its z-order.
		 */
		function get applicationIndex () : int;
		/**
		 *  @private
		 */
		function set applicationIndex (value:int) : void;
		/**
		 *  @inheritDoc
		 */
		public function get cursorChildren () : IChildList;
		/**
		 *  @private	 *  The index of the highest child that is a cursor.
		 */
		function get cursorIndex () : int;
		/**
		 *  @private
		 */
		function set cursorIndex (value:int) : void;
		/**
		 *  @inheritDoc
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;
		/**
		 *  A table of embedded fonts in this application.  The 	 *  object is a table indexed by the font name.
		 */
		public function get embeddedFontList () : Object;
		/**
		 *  @copy mx.core.UIComponent#focusPane
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  @private	 *  This property allows access to the Player's native implementation	 *  of the numChildren property, which can be useful since components	 *  can override numChildren and thereby hide the native implementation.	 *  Note that this "base property" is final and cannot be overridden,	 *  so you can count on it to reflect what is happening at the player level.
		 */
		function get $numChildren () : int;
		/**
		 *  The number of modal windows.  Modal windows don't allow	 *  clicking in another windows which would normally	 *  activate the FocusManager in that window.  The PopUpManager	 *  modifies this count as it creates and destroys modal windows.
		 */
		public function get numModalWindows () : int;
		/**
		 *  @private
		 */
		public function set numModalWindows (value:int) : void;
		/**
		 *  @inheritDoc
		 */
		public function get popUpChildren () : IChildList;
		/**
		 *  @private	 *  The index of the highest child that isn't a topmost/popup window
		 */
		function get noTopMostIndex () : int;
		/**
		 *  @private
		 */
		function set noTopMostIndex (value:int) : void;
		/**
		 *  @inheritDoc
		 */
		public function get rawChildren () : IChildList;
		public function get swfBridgeGroup () : ISWFBridgeGroup;
		public function set swfBridgeGroup (bridgeGroup:ISWFBridgeGroup) : void;
		/**
		 *  @inheritDoc
		 */
		public function get screen () : Rectangle;
		/**
		 *  @inheritDoc
		 */
		public function get toolTipChildren () : IChildList;
		/**
		 *  @private	 *  The index of the highest child that is a tooltip
		 */
		function get toolTipIndex () : int;
		/**
		 *  @private
		 */
		function set toolTipIndex (value:int) : void;
		/**
		 *  Returns the SystemManager responsible for the application window.  This will be	 *  the same SystemManager unless this application has been loaded into another	 *  application.
		 */
		public function get topLevelSystemManager () : ISystemManager;
		/**
		 *  @private	 *  The index of the highest child that is a topmost/popup window
		 */
		function get topMostIndex () : int;
		function set topMostIndex (value:int) : void;
		/**
		 *  The width of this object.  For the SystemManager	 *  this should always be the width of the stage unless the application was loaded	 *  into another application.  If the application was not loaded	 *  into another application, setting this value will have no effect.
		 */
		public function get width () : Number;
		function get window () : Window;
		function set window (value:Window) : void;
		/**
		 *  The height of this object.  For the SystemManager	 *  this should always be the width of the stage unless the application was loaded	 *  into another application.  If the application was not loaded	 *  into another application, setting this value has no effect.
		 */
		public function get height () : Number;
		/**
		 * @inheritdoc
		 */
		public function get swfBridge () : IEventDispatcher;
		/**
		 * @inheritdoc
		 */
		public function get childAllowsParent () : Boolean;
		/**
		 * @inheritdoc
		 */
		public function get parentAllowsChild () : Boolean;
		/**
		 *  The number of non-floating windows.  This is the main application window	 *  plus any other windows added to the SystemManager that are not popups,	 *  tooltips or cursors.
		 */
		public function get numChildren () : int;
		/**
		 *  @private
		 */
		public function get mouseX () : Number;
		/**
		 *  @private
		 */
		public function get mouseY () : Number;

		public function WindowedSystemManager (rootObj:IUIComponent);
		/**
		 *  @inheritDoc
		 */
		public function activate (f:IFocusManagerContainer) : void;
		/**
		 * @private	 * 	 * New version of activate that does not require a	 * IFocusManagerContainer.
		 */
		private function activateForm (f:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function deactivate (f:IFocusManagerContainer) : void;
		/**
		 * @private	 * 	 * New version of deactivate that works with remote pop ups.	 *
		 */
		private function deactivateForm (f:Object) : void;
		/**
		 * @private	 * 	 * @param f form being deactivated	 * 	 * @return the next form to activate, excluding the form being deactivated.
		 */
		private function findLastActiveForm (f:Object) : Object;
		/**
		 * @private	 * 	 * @return true if the form can be activated, false otherwise.
		 */
		private function canActivatePopUp (f:Object) : Boolean;
		/**
		 * @private	 * 	 * Test is a local component can be activated.
		 */
		private function canActivateLocalComponent (o:Object) : Boolean;
		/**
		 * @private	 * 	 * @return true if the form is a RemotePopUp, false if the form is IFocusManagerContainer.	 *
		 */
		private static function isRemotePopUp (form:Object) : Boolean;
		/**
		 * @private	 * 	 * @return true if form1 and form2 are both of type RemotePopUp and are equal, false otherwise.
		 */
		private static function areRemotePopUpsEqual (form1:Object, form2:Object) : Boolean;
		/**
		 * @private	 * 	 * Find a remote form that is hosted by this system manager.	 * 	 * @param window unique id of popUp within a bridged application	 * @param bridge bridge of owning application.	 * 	 * @return RemotePopUp if hosted by this system manager, false otherwise.
		 */
		private function findRemotePopUp (window:Object, bridge:IEventDispatcher) : RemotePopUp;
		/**
		 * Remote a remote form from the forms array.	 * 	 * form Locally created remote form.
		 */
		private function removeRemotePopUp (form:RemotePopUp) : void;
		/**
		 * @private	 * 	 * Activate a form that belongs to a system manager in another	 * sandbox or peer application domain.	 * 	 * @param form	a RemotePopUp object.	 *
		 */
		private function activateRemotePopUp (form:Object) : void;
		private function deactivateRemotePopUp (form:Object) : void;
		/**
		 * Test if two forms are equal.	 * 	 * @param form1 - may be of type a DisplayObjectContainer or a RemotePopUp	 * @param form2 - may be of type a DisplayObjectContainer or a RemotePopUp	 * 	 * @return true if the forms are equal, false otherwise.
		 */
		private function areFormsEqual (form1:Object, form2:Object) : Boolean;
		/**
		 *  @inheritDoc
		 */
		public function addFocusManager (f:IFocusManagerContainer) : void;
		/**
		 *  @inheritDoc
		 */
		public function removeFocusManager (f:IFocusManagerContainer) : void;
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
		 *  This method is overridden in the autogenerated subclass.
		 */
		public function create (...params) : Object;
		/**
		 *  @private	 *  This is attached as the framescript at the end of frame 2.	 *  When this function is called, we know that the application	 *  class has been defined and read in by the Player.
		 */
		protected function docFrameHandler (event:Event = null) : void;
		/**
		 *  @private	 *  Instantiates an instance of the top level window	 *  and adds it as a child of the SystemManager.
		 */
		protected function initializeTopLevelWindow (event:Event) : void;
		/**
		 *  @private	 *  Same as SystemManager's preload done handler.  It adds 	 *  the window to the application (and a mouse catcher)	 * 	 *  Called from initializeTopLevelWindow()
		 */
		private function addChildAndMouseCatcher () : void;
		/**
		 *  @private
		 */
		public function info () : Object;
		/**
		 *  @private	 *  Call regenerateStyleCache() on all children of this SystemManager.	 *  If the recursive parameter is true, continue doing this	 *  for all descendants of these children.
		 */
		function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @private	 *  Call styleChanged() and notifyStyleChangeInChildren()	 *  on all children of this SystemManager.	 *  If the recursive parameter is true, continue doing this	 *  for all descendants of these children.
		 */
		function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @private     *  Disable all the built-in items except "Print...".
		 */
		private function initContextMenu () : void;
		/**
		 * @inheritdoc
		 */
		public function isTopLevelRoot () : Boolean;
		/**
		 * The system manager proxy has only one child that is a focus manager container.	 * Iterate thru the children until we find it.
		 */
		function findFocusManagerContainer (smp:SystemManagerProxy) : IFocusManagerContainer;
		/**
		 * @private	 * 	 * Listen to messages this System Manager needs to service from its children.
		 */
		function addChildBridgeListeners (bridge:IEventDispatcher) : void;
		/**
		 * @private	 * 	 * Remove all child listeners.
		 */
		function removeChildBridgeListeners (bridge:IEventDispatcher) : void;
		/**
		 * @private	 * 	 * Add listeners for events and requests we might receive from our parent if our	 * parent is using a sandbox bridge to communicate with us.
		 */
		function addParentBridgeListeners () : void;
		/**
		 * @private	 * 	 * remove listeners for events and requests we might receive from our parent if 	 * our parent is using a sandbox bridge to communicate with us.
		 */
		function removeParentBridgeListeners () : void;
		/**
		 * Add a bridge to talk to the child owned by <code>owner</code>.	 * 	 * @param bridge the bridge used to talk to the parent. 	 * @param owner the display object that owns the bridge.
		 */
		public function addChildBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;
		/**
		 * Remove a child bridge.
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;
		/**
		 * @inheritdoc
		 */
		public function useSWFBridge () : Boolean;
		/**
		 * Go up our parent chain to get the top level system manager.	 * 	 * returns null if we are not on the display list or we don't have	 * access to the top level system manager.
		 */
		public function getTopLevelRoot () : DisplayObject;
		/**
		 * Go up our parent chain to get the top level system manager in this 	 * SecurityDomain	 *
		 */
		public function getSandboxRoot () : DisplayObject;
		/**
		 *  @inheritdoc
		 */
		public function getVisibleApplicationRect (bounds:Rectangle = null) : Rectangle;
		/**
		 *  @inheritdoc
		 */
		public function deployMouseShields (deploy:Boolean) : void;
		/**
		 * @private     *      * Notify parent that a new window has been activated.     *      * @param window window that was activated.
		 */
		function dispatchActivatedWindowEvent (window:DisplayObject) : void;
		/**
		 * @private     *      * Notify parent that a window has been deactivated.     *      * @param id window display object or id string that was activated. Ids are used if     *        the message is going outside the security domain.
		 */
		private function dispatchDeactivatedWindowEvent (window:DisplayObject) : void;
		/**
		 * @private	 * 	 * Notify parent that an application has been activated.
		 */
		private function dispatchActivatedApplicationEvent () : void;
		/**
		 * Adjust the forms array so it is sorted by last active. 	 * The last active form will be at the end of the forms array.	 * 	 * This method assumes the form variable has been set before calling	 * this function.
		 */
		private function updateLastActiveForm () : void;
		/**
		 * @private	 * 	 * Add placeholder information to this instance's list of placeholder data.
		 */
		private function addPlaceholderId (id:String, previousId:String, bridge:IEventDispatcher, placeholder:Object) : void;
		private function removePlaceholderId (id:String) : void;
		/**
		 * request the parent to add an event listener.
		 */
		private function addEventListenerToOtherSystemManagers (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 * request the parent to remove an event listener.
		 */
		private function removeEventListenerFromOtherSystemManagers (type:String, listener:Function, useCapture:Boolean = false) : void;
		private function dispatchEventToOtherSystemManagers (event:Event) : void;
		/**
		 *  dispatch the event to all sandboxes except the specified one
		 */
		public function dispatchEventFromSWFBridges (event:Event, skip:IEventDispatcher = null, trackClones:Boolean = false, toOtherSystemManagers:Boolean = false) : void;
		/**
		 * request the parent to add an event listener.
		 */
		private function addEventListenerToSandboxes (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false, skip:IEventDispatcher = null) : void;
		/**
		 * request the parent to remove an event listener.
		 */
		private function removeEventListenerFromSandboxes (type:String, listener:Function, useCapture:Boolean = false, skip:IEventDispatcher = null) : void;
		/**
		 *   @private     *      *   @return true if the message should be processed, false if      *   no other action is required.
		 */
		private function preProcessModalWindowRequest (request:SWFBridgeRequest, sbRoot:DisplayObject) : Boolean;
		private function otherSystemManagerMouseListener (event:SandboxMouseEvent) : void;
		private function sandboxMouseListener (event:Event) : void;
		private function eventListenerRequestHandler (event:Event) : void;
		/**
		 *  Returns <code>true</code> if the given DisplayObject is the 	 *  top-level window.	 *	 *  @param object 	 *	 *  @return <code>true</code> if the given DisplayObject is the 	 *  top-level window.
		 */
		public function isTopLevelWindow (object:DisplayObject) : Boolean;
		/**
		 *  @inheritDoc
		 */
		public function getDefinitionByName (name:String) : Object;
		/**
		 *  @inheritDoc
		 */
		public function isTopLevel () : Boolean;
		/**
		 *  @inheritDoc
		 */
		public function isFontFaceEmbedded (textFormat:TextFormat) : Boolean;
		/**
		 *  @private	 *  Keep track of the size and position of the stage.
		 */
		private function Stage_resizeHandler (event:Event = null) : void;
		/**
		 *  @private	 *  Track mouse clicks to see if we change top-level forms.
		 */
		private function mouseDownHandler (event:MouseEvent) : void;
		/**
		 * @private	 * 	 * Get the index of an object in a given child list.	 * 	 * @return index of f in childList, -1 if f is not in childList.
		 */
		private static function getChildListIndex (childList:IChildList, f:Object) : int;
		/**
		 *  @private	 *  Makes the mouseCatcher the same size as the stage,	 *  filling it with transparent pixels.
		 */
		private function resizeMouseCatcher () : void;
		/**
		 *  @private	 *  Only create idle events if someone is listening.
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 * @private	 * 	 * Test if this system manager has any sandbox bridges.	 * 	 * @return true if there are sandbox bridges, false otherwise.
		 */
		private function hasSWFBridges () : Boolean;
		/**
		 *  @private
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
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
		public function getChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildByName (name:String) : DisplayObject;
		/**
		 *  @private
		 */
		public function getChildIndex (child:DisplayObject) : int;
		/**
		 *  @private
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		public function getObjectsUnderPoint (point:Point) : Array;
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
		 *  @private
		 */
		function rawChildren_addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildByName (name:String) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildIndex (child:DisplayObject) : int;
		/**
		 *  @private
		 */
		function rawChildren_setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		function rawChildren_getObjectsUnderPoint (pt:Point) : Array;
		/**
		 *  @private
		 */
		function rawChildren_contains (child:DisplayObject) : Boolean;
		/**
		 * @private	 * 	 * Add a popup request handler for domain local request and 	 * remote domain requests.
		 */
		private function addPopupRequestHandler (event:Event) : void;
		/**
		 * @private	 * 	 * Message from a child system manager to 	 * remove the popup that was added by using the	 * addPopupRequestHandler.
		 */
		private function removePopupRequestHandler (event:Event) : void;
		/**
		 * @private	 * 	 * Handle request to add a popup placeholder.	 * The placeholder represents an untrusted form that is hosted 	 * elsewhere.
		 */
		private function addPlaceholderPopupRequestHandler (event:Event) : void;
		/**
		 * @private	 * 	 * Handle request to add a popup placeholder.	 * The placeholder represents an untrusted form that is hosted 	 * elsewhere.
		 */
		private function removePlaceholderPopupRequestHandler (event:Event) : void;
		/**
		 * Forward a form event update the parent chain. 	 * Takes care of removing object references and substituting	 * ids when an untrusted boundry is crossed.
		 */
		private function forwardFormEvent (event:SWFBridgeEvent) : Boolean;
		/**
		 * Forward an AddPlaceholder request up the parent chain, if needed.	 * 	 * @param eObj PopupRequest as and Object.	 * @param addPlaceholder true if adding a placeholder, false it removing a placeholder.	 * @return true if the request was forwared, false otherwise
		 */
		private function forwardPlaceholderRequest (request:SWFBridgeRequest, addPlaceholder:Boolean) : Boolean;
		/**
		 * One of the system managers in another sandbox deactivated and sent a message	 * to the top level system manager. In response the top-level system manager	 * needs to find a new form to activate.
		 */
		private function deactivateFormSandboxEventHandler (event:Event) : void;
		/**
		 * A form in one of the system managers in another sandbox has been activated. 	 * The form being activate is identified. 	 * In response the top-level system manager needs to activate the given form	 * and deactivate the currently active form, if any.
		 */
		private function activateFormSandboxEventHandler (event:Event) : void;
		/**
		 * One of the system managers in another sandbox activated and sent a message	 * to the top level system manager to deactivate this form. In response the top-level system manager	 * needs to deactivate all other forms except the top level system manager's.
		 */
		private function activateApplicationSandboxEventHandler (event:Event) : void;
		/**
		 *  @private     *      *  Re-dispatch events sent over the bridge to listeners on this     *  system manager. PopUpManager is expected to listen to these     *  events.
		 */
		private function modalWindowRequestHandler (event:Event) : void;
		/**
		 *  @private     *      *  Calculate the visible rectangle of the requesting application in this     *  application. Forward the request to our parent to see this the rectangle     *  is further reduced. Continue up the parent chain until the top level     *  root parent is reached.
		 */
		private function getVisibleRectRequestHandler (event:Event) : void;
		/**
		 *  @private     *      *  Notify the topLevelRoot that we don't want the mouseCursor shown	 *  Forward upward if necessary.
		 */
		private function hideMouseCursorRequestHandler (event:Event) : void;
		/**
		 *  @private     *      *  Ask the topLevelRoot if anybody don't want the mouseCursor shown	 *  Forward upward if necessary.
		 */
		private function showMouseCursorRequestHandler (event:Event) : void;
		/**
		 *  @private     *      *  Ask the topLevelRoot if anybody don't want the mouseCursor shown	 *  Forward upward if necessary.
		 */
		private function resetMouseCursorRequestHandler (event:Event) : void;
		private function resetMouseCursorTracking (event:Event) : void;
		/**
		 * @private	 * 	 * Sent by the SWFLoader to change the size of the application it loaded.
		 */
		private function setActualSizeRequestHandler (event:Event) : void;
		/**
		 * @private	 * 	 * Get the size of this System Manager.	 * Sent by a SWFLoader.
		 */
		private function getSizeRequestHandler (event:Event) : void;
		/**
		 *  @private     *      *  Handle request to activate a particular form.     *
		 */
		private function activateRequestHandler (event:Event) : void;
		/**
		 *  @private     *      *  Handle request to deactivate a particular form.     *
		 */
		private function deactivateRequestHandler (event:Event) : void;
		/**
		 * Is the child in event.data this system manager or a child of this 	 * system manager?	 *	 * Set the data property to indicate if the display object is a child
		 */
		private function isBridgeChildHandler (event:Event) : void;
		/**
		 * Can this form be activated. The current test is if the given pop up      * is visible and is enabled.      *     * Set the data property to indicate if can be activated
		 */
		private function canActivateHandler (event:Event) : void;
		/**
		 * @private	 * 	 * Test if a display object is in an applcation we want to communicate with over a bridge.	 *
		 */
		public function isDisplayObjectInABridgedApplication (displayObject:DisplayObject) : Boolean;
		/**
		 * redispatch certian events to other top-level windows
		 */
		private function multiWindowRedispatcher (event:Event) : void;
		/**
		 * Create the requested manager
		 */
		private function initManagerHandler (event:Event) : void;
		/**
		 *  Add child to requested childList
		 */
		public function addChildToSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 *  Remove child from requested childList
		 */
		public function removeChildFromSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 * perform the requested action from a trusted dispatcher
		 */
		private function systemManagerHandler (event:Event) : void;
		/**
		 * Return the object the player sees as having focus.	 * 	 * @return An object of type InteractiveObject that the	 * 		   player sees as having focus. If focus is currently	 * 		   in a sandbox the caller does not have access to	 * 		   null will be returned.
		 */
		public function getFocus () : InteractiveObject;
		/**
		 *  @private	 *  Cleans up references to Window. Also removes self from topLevelSystemManagers list.
		 */
		function cleanup (e:Event) : void;
		/**
		 *  @private	 *  only registers Window for later cleanup.
		 */
		function addWindow (win:Window) : void;
	}
}
