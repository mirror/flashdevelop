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
	import flash.events.EventDispatcher;
	import flash.events.EventPhase;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.system.Capabilities;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	import mx.core.EmbeddedFontRegistry;
	import mx.core.EventPriority;
	import mx.core.FlexSprite;
	import mx.core.ISWFLoader;
	import mx.core.IChildList;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IInvalidating;
	import mx.core.IRawChildrenContainer;
	import mx.core.ISWFBridgeGroup;
	import mx.core.ISWFBridgeProvider;
	import mx.core.IUIComponent;
	import mx.core.RSLItem;
	import mx.core.Singleton;
	import mx.core.SWFBridgeGroup;
	import mx.core.TextFieldFactory;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.messaging.config.LoaderConfig;
	import mx.preloaders.DownloadProgressBar;
	import mx.preloaders.Preloader;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
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
	import mx.utils.EventUtil;
	import mx.utils.NameUtil;
	import mx.utils.ObjectUtil;
	import mx.utils.SecurityUtil;
	import mx.events.ResizeEvent;

	/**
	 *  Dispatched when the application has finished initializing * *  @eventType mx.events.FlexEvent.APPLICATION_COMPLETE
	 */
	[Event(name="applicationComplete", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched every 100 milliseconds when there has been no keyboard *  or mouse activity for 1 second. * *  @eventType mx.events.FlexEvent.IDLE
	 */
	[Event(name="idle", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the Stage is resized. * *  @eventType flash.events.Event.RESIZE
	 */
	[Event(name="resize", type="flash.events.Event")] 

	/**
	 *  The SystemManager class manages an application window. *  Every application that runs on the desktop or in a browser *  has an area where the visuals of the application are  *  displayed.   *  It may be a window in the operating system *  or an area within the browser.  That area is an application window *  and different from an instance of <code>mx.core.Application</code>, which *  is the main, or top-level, window within an application. * *  <p>Every application has a SystemManager.   *  The SystemManager sends an event if *  the size of the application window changes (you cannot change it from *  within the application, but only through interaction with the operating *  system window or browser).  It parents all displayable things within the *  application like the main mx.core.Application instance and all popups,  *  tooltips, cursors, and so on.  Any object parented by the SystemManager is *  considered to be a top-level window, even tooltips and cursors.</p> * *  <p>The SystemManager also switches focus between top-level windows if there  *  are more than one IFocusManagerContainer displayed and users are interacting *  with components within the IFocusManagerContainers.  </p> * *  <p>All keyboard and mouse activity that is not expressly trapped is seen by *  the SystemManager, making it a good place to monitor activity should you need *  to do so.</p> * *  <p>If an application is loaded into another application, a SystemManager *  will still be created, but will not manage an application window, *  depending on security and domain rules. *  Instead, it will be the <code>content</code> of the <code>Loader</code>  *  that loaded it and simply serve as the parent of the sub-application</p> * *  <p>The SystemManager maintains multiple lists of children, one each for tooltips, cursors, *  popup windows.  This is how it ensures that popup windows "float" above the main *  application windows and that tooltips "float" above that and cursors above that. *  If you simply examine the <code>numChildren</code> property or  *  call the <code>getChildAt()</code> method on the SystemManager, you are accessing *  the main application window and any other windows that aren't popped up.  To get the list *  of all windows, including popups, tooltips and cursors, use  *  the <code>rawChildren</code> property.</p> * *  <p>The SystemManager is the first display class created within an application. *  It is responsible for creating an <code>mx.preloaders.Preloader</code> that displays and *  <code>mx.preloaders.DownloadProgressBar</code> while the application finishes loading, *  then creates the <code>mx.core.Application</code> instance.</p>
	 */
	public class SystemManager extends MovieClip implements IChildList
	{
		/**
		 *  @private	 *  The number of milliseconds that must pass without any user activity	 *  before SystemManager starts dispatching 'idle' events.
		 */
		private static const IDLE_THRESHOLD : Number = 1000;
		/**
		 *  @private	 *  The number of milliseconds between each 'idle' event.
		 */
		private static const IDLE_INTERVAL : Number = 100;
		/**
		 *  @private	 *  An array of SystemManager instances loaded as child app domains
		 */
		static var allSystemManagers : Dictionary;
		/**
		 *  @private	 *  The last SystemManager instance loaded as child app domains
		 */
		static var lastSystemManager : SystemManager;
		/**
		 *  @private	 *  This flag remembers whether we're going to call executeCallbacks again
		 */
		private var doneExecutingInitCallbacks : Boolean;
		/**
		 *  @private	 *  This array stores pointers to all the init callback functions for this	 *  system manager.	 *  See registerInitCallback() for more information.
		 */
		private var initCallbackFunctions : Array;
		/**
		 *  @private
		 */
		private var initialized : Boolean;
		/**
		 *  @private	 *  Whether we are in the top-level list or not;	 *  top-level means we are the highest level SystemManager	 *  for this stage.
		 */
		local var topLevel : Boolean;
		/**
		 *  @private	 *  Whether we are the stage root or not.	 *  We are only the stage root if we were the root	 *  of the first SWF that got loaded by the player.	 *  Otherwise we could be top level but not stage root	 *  if we are loaded by some other non-Flex shell	 *  or are sandboxed.
		 */
		private var isStageRoot : Boolean;
		/**
		 *  @private	 *  Whether we are the first SWF loaded into a bootstrap	 *  and therefore, the topLevelRoot
		 */
		private var isBootstrapRoot : Boolean;
		/**
		 *  @private	 *  If we're not top level, then we delegate many things	 *  to the top level SystemManager.
		 */
		private var _topLevelSystemManager : ISystemManager;
		/**
		 * cached value of the stage.
		 */
		private var _stage : Stage;
		/**
		 *  Depth of this object in the containment hierarchy.	 *  This number is used by the measurement and layout code.
		 */
		local var nestLevel : int;
		/**
		 *  @private
		 */
		private var rslSizes : Array;
		/**
		 *  @private	 *  A reference to the preloader.
		 */
		private var preloader : Preloader;
		/**
		 *  @private	 *  The mouseCatcher is the 0th child of the SystemManager,	 *  behind the application, which is child 1.	 *  It is the same size as the stage and is filled with	 *  transparent pixels; i.e., they've been drawn, but with alpha 0.	 *	 *  Its purpose is to make every part of the stage	 *  able to detect the mouse.	 *  For example, a Button puts a mouseUp handler on the SystemManager	 *  in order to capture mouseUp events that occur outside the Button.	 *  But if the children of the SystemManager don't have "drawn-on"	 *  pixels everywhere, the player won't dispatch the mouseUp.	 *  We can't simply fill the SystemManager itself with	 *  transparent pixels, because the player's pixel detection	 *  logic doesn't look at pixels drawn into the root DisplayObject.	 *	 *  Here is an example of what would happen without the mouseCatcher:	 *  Run a fixed-size Application (e.g. width="600" height="600")	 *  in the standalone player. Make the player window larger	 *  to reveal part of the stage. Press a Button, drag off it	 *  into the stage area, and release the mouse button.	 *  Without the mouseCatcher, the Button wouldn't return to its "up" state.
		 */
		private var mouseCatcher : Sprite;
		/**
		 *  @private	 *  The top level window.
		 */
		local var topLevelWindow : IUIComponent;
		/**
		 *  @private	 *  List of top level windows.
		 */
		private var forms : Array;
		/**
		 *  @private	 *  The current top level window.	 *	 * 	Will be of type IFocusManagerContainer if the form	 *  in the top-level system manager's application domain	 *  or a child of that application domain. Otherwise the	 *  form will be of type RemotePopUp.
		 */
		private var form : Object;
		/**
		 *  @private	 *  Number of frames since the last mouse or key activity.
		 */
		local var idleCounter : int;
		/**
		 *  @private	 *  The Timer used to determine when to dispatch idle events.
		 */
		private var idleTimer : Timer;
		/**
		 *  @private	 *  A timer used when it is necessary to wait before incrementing the frame
		 */
		private var nextFrameTimer : Timer;
		/**
		 *  @private	 *  Track which frame was last processed
		 */
		private var lastFrame : int;
		/**
		 *  @private     *  Map a bridge to a FocusManager.      *  This is only for Focus Managers that are     *  not the focus manager for document. Because the bridges are not in document     *  they are bridges inside of pop ups.      *  The returned object is an object of type IFocusManager.
		 */
		private var bridgeToFocusManager : Dictionary;
		/**
		 *  @private
		 */
		private var _height : Number;
		/**
		 *  @private
		 */
		private var _width : Number;
		/**
		 *  @private	 *  Storage for the applicationIndex property.
		 */
		private var _applicationIndex : int;
		/**
		 *  @private	 *  Storage for the cursorChildren property.
		 */
		private var _cursorChildren : SystemChildrenList;
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
		private var _explicitHeight : Number;
		/**
		 *  @private
		 */
		private var _explicitWidth : Number;
		/**
		 *  @private
		 */
		private var _focusPane : Sprite;
		/**
		 *  @private	 *  Storage for the noTopMostIndex property.
		 */
		private var _noTopMostIndex : int;
		/**
		 *  @private	 *  Storage for the numModalWindows property.
		 */
		private var _numModalWindows : int;
		/**
		 *  @private	 *  Storage for the popUpChildren property.
		 */
		private var _popUpChildren : SystemChildrenList;
		/**
		 *  @private	 *  Storage for the rawChildren property.
		 */
		private var _rawChildren : SystemRawChildrenList;
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
		private var _toolTipChildren : SystemChildrenList;
		/**
		 *  @private	 *  Storage for the toolTipIndex property.
		 */
		private var _toolTipIndex : int;
		/**
		 *  @private	 *  Storage for the topMostIndex property.
		 */
		private var _topMostIndex : int;
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
		private var currentSandboxEvent : Event;
		private var dispatchingToSystemManagers : Boolean;

		/**
		 *  The height of this object.  For the SystemManager	 *  this should always be the width of the stage unless the application was loaded	 *  into another application.  If the application was not loaded	 *  into another application, setting this value has no effect.
		 */
		public function get height () : Number;
		/**
		 *  @private	 *  get the main stage if we're loaded into another swf in the same sandbox
		 */
		public function get stage () : Stage;
		/**
		 *  The width of this object.  For the SystemManager	 *  this should always be the width of the stage unless the application was loaded	 *  into another application.  If the application was not loaded	 *  into another application, setting this value will have no effect.
		 */
		public function get width () : Number;
		/**
		 *  The number of non-floating windows.  This is the main application window	 *  plus any other windows added to the SystemManager that are not popups,	 *  tooltips or cursors.
		 */
		public function get numChildren () : int;
		/**
		 *  The application parented by this SystemManager.	 *  SystemManagers create an instance of an Application	 *  even if they are loaded into another Application.	 *  Thus, this may not match mx.core.Application.application	 *  if the SWF has been loaded into another application.	 *  <p>Note that this property is not typed as mx.core.Application	 *  because of load-time performance considerations	 *  but can be coerced into an mx.core.Application.</p>
		 */
		public function get application () : IUIComponent;
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
		 *  The explicit width of this object.  For the SystemManager	 *  this should always be NaN unless the application was loaded	 *  into another application.  If the application was not loaded	 *  into another application, setting this value has no effect.
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;
		/**
		 *  The explicit width of this object.  For the SystemManager	 *  this should always be NaN unless the application was loaded	 *  into another application.  If the application was not loaded	 *  into another application, setting this value has no effect.
		 */
		public function get explicitWidth () : Number;
		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;
		/**
		 *  @copy mx.core.UIComponent#focusPane
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  The measuredHeight is the explicit or measuredHeight of 	 *  the main mx.core.Application window	 *  or the starting height of the SWF if the main window 	 *  has not yet been created or does not exist.
		 */
		public function get measuredHeight () : Number;
		/**
		 *  The measuredWidth is the explicit or measuredWidth of 	 *  the main mx.core.Application window,	 *  or the starting width of the SWF if the main window 	 *  has not yet been created or does not exist.
		 */
		public function get measuredWidth () : Number;
		/**
		 *  @private	 *  The index of the highest child that isn't a topmost/popup window
		 */
		function get noTopMostIndex () : int;
		/**
		 *  @private
		 */
		function set noTopMostIndex (value:int) : void;
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
		 *	The background alpha used by the child of the preloader.
		 */
		public function get preloaderBackgroundAlpha () : Number;
		/**
		 *	The background color used by the child of the preloader.
		 */
		public function get preloaderBackgroundColor () : uint;
		/**
		 *	The background color used by the child of the preloader.
		 */
		public function get preloaderBackgroundImage () : Object;
		/**
		 *	The background size used by the child of the preloader.
		 */
		public function get preloaderBackgroundSize () : String;
		/**
		 *  @inheritDoc
		 */
		public function get popUpChildren () : IChildList;
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
		 * @inheritDoc
		 */
		public function get swfBridge () : IEventDispatcher;
		/**
		 * @inheritDoc
		 */
		public function get childAllowsParent () : Boolean;
		/**
		 * @inheritDoc
		 */
		public function get parentAllowsChild () : Boolean;
		/**
		 *  @private
		 */
		public function get mouseX () : Number;
		/**
		 *  @private
		 */
		public function get mouseY () : Number;
		/**
		 * Override parent property to handle the case where the parent is in	 * a differnt sandbox. If the parent is in the same sandbox it is returned.	 * If the parent is in a diffent sandbox, then null is returned.	 *
		 */
		public function get parent () : DisplayObjectContainer;

		/**
		 *  @private	 *  If a class wants to be notified when the Application instance	 *  has been initialized, then it registers a callback here.	 *  By using a callback mechanism, we avoid adding unwanted	 *  linker dependencies on classes like HistoryManager and DragManager.
		 */
		static function registerInitCallback (initFunction:Function) : void;
		/**
		 *  Constructor.	 *	 *  <p>This is the starting point for all Flex applications.	 *  This class is set to be the root class of a Flex SWF file.     *  Flash Player instantiates an instance of this class,	 *  causing this constructor to be called.</p>
		 */
		public function SystemManager ();
		/**
		 *  @private
		 */
		private function deferredNextFrame () : void;
		/**
		 *  @private
		 */
		public function info () : Object;
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
		 * @private	 * 	 * Used by SystemManagerProxy to add a mouse catcher as a child.
		 */
		function $addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private	 * 	 *  Companion to $addChildAt.
		 */
		function $removeChildAt (index:int) : DisplayObject;
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
		public function contains (child:DisplayObject) : Boolean;
		/**
		 *   A factory method that requests an instance of a	 *  definition known to the module.	 * 	 *  You can provide an optional set of parameters to let building	 *  factories change what they create based on the	 *  input. Passing null indicates that the default definition	 *  is created, if possible. 	 *	 *  This method is overridden in the autogenerated subclass.	 *	 * @param params An optional list of arguments. You can pass	 *  any number of arguments, which are then stored in an Array	 *  called <code>parameters</code>. 	 *	 * @return An instance of the module, or <code>null</code>.
		 */
		public function create (...params) : Object;
		/**
		 *  @private	 *  Creates an instance of the preloader, adds it as a child, and runs it.	 *  This is needed by FlexBuilder. Do not modify this function.
		 */
		function initialize () : void;
		/**
		 *  @private	 *  When this is called, we execute all callbacks queued up to this point.
		 */
		private function executeCallbacks () : void;
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
		 *  A convenience method for determining whether to use the	 *  explicit or measured width.	 *     *  @return A Number that is the <code>explicitWidth</code> if defined,	 *  or the <code>measuredWidth</code> property if not.
		 */
		public function getExplicitOrMeasuredWidth () : Number;
		/**
		 *  A convenience method for determining whether to use the	 *  explicit or measured height.	 *     *  @return A Number that is the <code>explicitHeight</code> if defined,	 *  or the <code>measuredHeight</code> property if not.
		 */
		public function getExplicitOrMeasuredHeight () : Number;
		/**
		 *  Calling the <code>move()</code> method	 *  has no effect as it is directly mapped	 *  to the application window or the loader.	 *	 *  @param x The new x coordinate.	 *	 *  @param y The new y coordinate.
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  Calling the <code>setActualSize()</code> method	 *  has no effect if it is directly mapped	 *  to the application window and if it is the top-level window.	 *  Otherwise attempts to resize itself, clipping children if needed.	 *	 *  @param newWidth The new width.	 *	 *  @param newHeight The new height.
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
		/**
		 *  @private	 *  Call regenerateStyleCache() on all children of this SystemManager.	 *  If the recursive parameter is true, continue doing this	 *  for all descendants of these children.
		 */
		function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  @private	 *  Call styleChanged() and notifyStyleChangeInChildren()	 *  on all children of this SystemManager.	 *  If the recursive parameter is true, continue doing this	 *  for all descendants of these children.
		 */
		function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
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
		 *  @inheritDoc
		 */
		public function getDefinitionByName (name:String) : Object;
		/**
		 *  Returns the root DisplayObject of the SWF that contains the code	 *  for the given object.	 *	 *  @param object Any Object. 	 * 	 *  @return The root DisplayObject
		 */
		public static function getSWFRoot (object:Object) : DisplayObject;
		/**
		 *  @inheritDoc
		 */
		public function isTopLevel () : Boolean;
		/**
		 * @inheritDoc
		 */
		public function isTopLevelRoot () : Boolean;
		/**
		 *  Determines if the given DisplayObject is the 	 *  top-level window.	 *	 *  @param object The DisplayObject to test.	 *	 *  @return <code>true</code> if the given DisplayObject is the 	 *  top-level window.
		 */
		public function isTopLevelWindow (object:DisplayObject) : Boolean;
		/**
		 *  @inheritDoc
		 */
		public function isFontFaceEmbedded (textFormat:TextFormat) : Boolean;
		/**
		 *  @private     *       *  Dispatch an invalidate request to invalidate the size and     *  display list of the parent application.
		 */
		private function dispatchInvalidateRequest () : void;
		/**
		 *  @private	 *  Makes the mouseCatcher the same size as the stage,	 *  filling it with transparent pixels.
		 */
		private function resizeMouseCatcher () : void;
		/**
		 *  @private
		 */
		private function initHandler (event:Event) : void;
		private function docFrameListener (event:Event) : void;
		private function extraFrameListener (event:Event) : void;
		/**
		 *  @private	 *  Once the swf has been fully downloaded,	 *  advance the playhead to the next frame.	 *  This will cause the framescript to run, which runs frameEndHandler().
		 */
		private function preloader_initProgressHandler (event:Event) : void;
		/**
		 *  @private	 *  Remove the preloader and add the application as a child.
		 */
		private function preloader_preloaderDoneHandler (event:Event) : void;
		/**
		 *  @private	 *  This is attached as the framescript at the end of frame 2.	 *  When this function is called, we know that the application	 *  class has been defined and read in by the Player.
		 */
		function docFrameHandler (event:Event = null) : void;
		private function installCompiledResourceBundles () : void;
		private function extraFrameHandler (event:Event = null) : void;
		/**
		 *  @private
		 */
		private function nextFrameTimerHandler (event:TimerEvent) : void;
		/**
		 *  @private	 *  Instantiates an instance of the top level window	 *  and adds it as a child of the SystemManager.
		 */
		private function initializeTopLevelWindow (event:Event) : void;
		/**
		 *  Override this function if you want to perform any logic	 *  when the application has finished initializing itself.
		 */
		private function appCreationCompleteHandler (event:FlexEvent) : void;
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
		 *  @private	 *  Track mouse moves in order to determine idle
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
		/**
		 *  @private	 *  Track mouse moves in order to determine idle.
		 */
		private function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private	 *  Called every IDLE_INTERVAL after the first listener	 *  registers for 'idle' events.	 *  After IDLE_THRESHOLD goes by without any user activity,	 *  we dispatch an 'idle' event.
		 */
		private function idleTimer_timerHandler (event:TimerEvent) : void;
		/**
		 * @private	 * 	 * Handle request to unload	 * Forward event, and do some cleanup
		 */
		private function beforeUnloadHandler (event:Event) : void;
		/**
		 * @private	 * 	 * Handle request to unload	 * Forward event, and do some cleanup
		 */
		private function unloadHandler (event:Event) : void;
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
		 * Forward an AddPlaceholder request up the parent chain, if needed.	 * 	 * @param request request to either add or remove a pop up placeholder.	 * @param addPlaceholder true if adding a placeholder, false it removing a placeholder.	 * @return true if the request was forwared, false otherwise
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
		 *  @private	 * 	 *  Handle request to activate a particular form.	 *
		 */
		private function activateRequestHandler (event:Event) : void;
		/**
		 *  @private	 * 	 *  Handle request to deactivate a particular form.	 *
		 */
		private function deactivateRequestHandler (event:Event) : void;
		/**
		 * Is the child in event.data this system manager or a child of this 	 * system manager?	 *	 * Set the data property to indicate if the display object is a child
		 */
		private function isBridgeChildHandler (event:Event) : void;
		/**
		 * Can this form be activated. The current test is if the given pop up 	 * is visible and is enabled. 	 *	 * Set the data property to indicate if can be activated
		 */
		private function canActivateHandler (event:Event) : void;
		/**
		 * @private	 * 	 * Test if a display object is in an applcation we want to communicate with over a bridge.	 *
		 */
		public function isDisplayObjectInABridgedApplication (displayObject:DisplayObject) : Boolean;
		/**
		 *  @private     *      *  If a display object is in a bridged application, then return the SWFBridge     *  that is used to communcation with that application. Otherwise return null.     *      *  @param displayObject The object to test.     *      *  @return The IEventDispather that represents the SWFBridge that should      *  be used to communicate with this object, if the display object is in a      *  bridge application. If the display object is not in a bridge application,     *  then null is returned.     *
		 */
		private function getSWFBridgeOfDisplayObject (displayObject:DisplayObject) : IEventDispatcher;
		/**
		 * redispatch certian events to other top-level windows
		 */
		private function multiWindowRedispatcher (event:Event) : void;
		/**
		 * Create the requested manager.
		 */
		private function initManagerHandler (event:Event) : void;
		/**
		 *  Adds a child to the requested childList.     *       *  @param layer The child list that the child should be added to. The valid choices are      *  "popUpChildren", "cursorChildren", and "toolTipChildren". The choices match the property      *  names of ISystemManager and that is the list where the child is added.     *       *  @param child The child to add.
		 */
		public function addChildToSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 *  Removes a child from the requested childList.     *       *  @param layer The child list that the child should be removed from. The valid choices are      *  "popUpChildren", "cursorChildren", and "toolTipChildren". The choices match the property      *  names of ISystemManager and that is the list where the child is removed from.     *       *  @param child The child to remove.
		 */
		public function removeChildFromSandboxRoot (layer:String, child:DisplayObject) : void;
		/**
		 * Perform the requested action from a trusted dispatcher.
		 */
		private function systemManagerHandler (event:Event) : void;
		/**
		 * Get the size of our sandbox's screen property.	 * 	 * Only the screen property should need to call this function.	 * 	 * The function assumes the caller does not have access to the stage.	 *
		 */
		private function getSandboxScreen () : Rectangle;
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
		private function getTopLevelSystemManager (parent:DisplayObject) : ISystemManager;
		/**
		 *  Add a bridge to talk to the child owned by <code>owner</code>.	 * 	 *  @param bridge The bridge used to talk to the parent. 	 *  @param owner The display object that owns the bridge.
		 */
		public function addChildBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;
		/**
		 *  Remove a child bridge.     *       *  @param bridge The target bridge to remove.
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;
		/**
		 *  @inheritDoc
		 */
		public function useSWFBridge () : Boolean;
		/**
		 *  Go up the parent chain to get the top level system manager.     *      *  Returns <code>null</code> if not on the display list or we don't have     *  access to the top-level system manager.     *       *  @return The root system manager.
		 */
		public function getTopLevelRoot () : DisplayObject;
		/**
		 *  Go up the parent chain to get the top level system manager in this      *  SecurityDomain.     *       *  @return The root system manager in this SecurityDomain.
		 */
		public function getSandboxRoot () : DisplayObject;
		/**
		 *  @inheritDoc
		 */
		public function getVisibleApplicationRect (bounds:Rectangle = null) : Rectangle;
		/**
		 *  @inheritDoc
		 */
		public function deployMouseShields (deploy:Boolean) : void;
		/**
		 * @private	 * 	 * Notify parent that a new window has been activated.	 * 	 * @param window window that was activated.
		 */
		function dispatchActivatedWindowEvent (window:DisplayObject) : void;
		/**
		 * @private	 * 	 * Notify parent that a window has been deactivated.	 * 	 * @param id window display object or id string that was activated. Ids are used if	 * 		  the message is going outside the security domain.
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
		private function dispatchEventToOtherSystemManagers (event:Event) : void;
		/**
		 *  @inheritDoc
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
		 * request the parent to add an event listener.
		 */
		private function addEventListenerToOtherSystemManagers (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 * request the parent to remove an event listener.
		 */
		private function removeEventListenerFromOtherSystemManagers (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *   @private     *      *   @return true if the message should be processed, false if      *   no other action is required.
		 */
		private function preProcessModalWindowRequest (request:SWFBridgeRequest, sbRoot:DisplayObject) : Boolean;
		private function otherSystemManagerMouseListener (event:SandboxMouseEvent) : void;
		private function sandboxMouseListener (event:Event) : void;
		private function eventListenerRequestHandler (event:Event) : void;
	}
}
