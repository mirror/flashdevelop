package mx.managers
{
	import flash.display.MovieClip;
	import mx.managers.ISystemManager;
	import mx.core.ISWFBridgeProvider;
	import mx.core.IChildList;
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import mx.managers.IFocusManagerContainer;
	import mx.managers.SystemManagerProxy;
	import mx.managers.SystemManager;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import mx.events.SWFBridgeRequest;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import mx.managers.WindowedSystemRawChildrenList;
	import mx.core.ISWFBridgeGroup;
	import mx.managers.systemClasses.RemotePopUp;
	import mx.core.Window;
	import mx.managers.WindowedSystemChildrenList;
	import mx.events.SWFBridgeEvent;
	import flash.display.InteractiveObject;
	import flash.text.TextFormat;
	import mx.events.SandboxMouseEvent;
	import mx.managers.systemClasses.EventProxy;
	import mx.core.IUIComponent;

	public class WindowedSystemManager extends MovieClip implements ISystemManager, ISWFBridgeProvider
	{
		public var _mouseX : *;
		public var _mouseY : *;
		public var idleCounter : int;
		public var nestLevel : int;
		public var topLevelWindow : IUIComponent;

		public function get $numChildren () : int;

		public function get applicationIndex () : int;
		public function set applicationIndex (value:int) : void;

		public function get bridgeToFocusManager () : Dictionary;
		public function set bridgeToFocusManager (bridgeToFMDictionary:Dictionary) : void;

		public function get childAllowsParent () : Boolean;

		public function get cursorChildren () : IChildList;

		public function get cursorIndex () : int;
		public function set cursorIndex (value:int) : void;

		public function get document () : Object;
		public function set document (value:Object) : void;

		public function get embeddedFontList () : Object;

		public function get focusPane () : Sprite;
		public function set focusPane (value:Sprite) : void;

		public function get height () : Number;

		public function get mouseX () : Number;

		public function get mouseY () : Number;

		public function get noTopMostIndex () : int;
		public function set noTopMostIndex (value:int) : void;

		public function get numChildren () : int;

		public function get numModalWindows () : int;
		public function set numModalWindows (value:int) : void;

		public function get parentAllowsChild () : Boolean;

		public function get popUpChildren () : IChildList;

		public function get preloadedRSLs () : Dictionary;

		public function get rawChildren () : IChildList;

		public function get screen () : Rectangle;

		public function get swfBridge () : IEventDispatcher;

		public function get swfBridgeGroup () : ISWFBridgeGroup;
		public function set swfBridgeGroup (bridgeGroup:ISWFBridgeGroup) : void;

		public function get toolTipChildren () : IChildList;

		public function get toolTipIndex () : int;
		public function set toolTipIndex (value:int) : void;

		public function get topLevelSystemManager () : ISystemManager;

		public function get topMostIndex () : int;
		public function set topMostIndex (value:int) : void;

		public function get width () : Number;

		public function get window () : Window;
		public function set window (value:Window) : void;

		public function $addChild (child:DisplayObject) : DisplayObject;

		public function $addChildAt (child:DisplayObject, index:int) : DisplayObject;

		public function $removeChild (child:DisplayObject) : DisplayObject;

		public function $removeChildAt (index:int) : DisplayObject;

		public function activate (f:IFocusManagerContainer) : void;

		public function addChild (child:DisplayObject) : DisplayObject;

		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;

		public function addChildBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;

		public function addChildBridgeListeners (bridge:IEventDispatcher) : void;

		public function addChildToSandboxRoot (layer:String, child:DisplayObject) : void;

		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

		public function addFocusManager (f:IFocusManagerContainer) : void;

		public function addingChild (child:DisplayObject) : void;

		public function addParentBridgeListeners () : void;

		public function addWindow (win:Window) : void;

		public function allowDomain (...rest) : void;

		public function allowInsecureDomain (...rest) : void;

		public function childAdded (child:DisplayObject) : void;

		public function childRemoved (child:DisplayObject) : void;

		public function cleanup (e:Event) : void;

		public function create (...rest) : Object;

		public function deactivate (f:IFocusManagerContainer) : void;

		public function deployMouseShields (deploy:Boolean) : void;

		public function dispatchActivatedWindowEvent (window:DisplayObject) : void;

		public function dispatchEventFromSWFBridges (event:Event, skip:IEventDispatcher = null, trackClones:Boolean = false, toOtherSystemManagers:Boolean = false) : void;

		public function findFocusManagerContainer (smp:SystemManagerProxy) : IFocusManagerContainer;

		public function getChildAt (index:int) : DisplayObject;

		public function getChildByName (name:String) : DisplayObject;

		public function getChildIndex (child:DisplayObject) : int;

		public function getDefinitionByName (name:String) : Object;

		public function getFocus () : InteractiveObject;

		public function getObjectsUnderPoint (point:Point) : Array;

		public function getSandboxRoot () : DisplayObject;

		public function getTopLevelRoot () : DisplayObject;

		public function getVisibleApplicationRect (bounds:Rectangle = null) : Rectangle;

		public function info () : Object;

		public function isDisplayObjectInABridgedApplication (displayObject:DisplayObject) : Boolean;

		public function isFontFaceEmbedded (textFormat:TextFormat) : Boolean;

		public function isTopLevel () : Boolean;

		public function isTopLevelRoot () : Boolean;

		public function isTopLevelWindow (object:DisplayObject) : Boolean;

		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;

		public function rawChildren_addChild (child:DisplayObject) : DisplayObject;

		public function rawChildren_addChildAt (child:DisplayObject, index:int) : DisplayObject;

		public function rawChildren_contains (child:DisplayObject) : Boolean;

		public function rawChildren_getChildAt (index:int) : DisplayObject;

		public function rawChildren_getChildByName (name:String) : DisplayObject;

		public function rawChildren_getChildIndex (child:DisplayObject) : int;

		public function rawChildren_getObjectsUnderPoint (pt:Point) : Array;

		public function rawChildren_removeChild (child:DisplayObject) : DisplayObject;

		public function rawChildren_removeChildAt (index:int) : DisplayObject;

		public function rawChildren_setChildIndex (child:DisplayObject, newIndex:int) : void;

		public function regenerateStyleCache (recursive:Boolean) : void;

		public function removeChild (child:DisplayObject) : DisplayObject;

		public function removeChildAt (index:int) : DisplayObject;

		public function removeChildBridge (bridge:IEventDispatcher) : void;

		public function removeChildBridgeListeners (bridge:IEventDispatcher) : void;

		public function removeChildFromSandboxRoot (layer:String, child:DisplayObject) : void;

		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;

		public function removeFocusManager (f:IFocusManagerContainer) : void;

		public function removeParentBridgeListeners () : void;

		public function removingChild (child:DisplayObject) : void;

		public function setChildIndex (child:DisplayObject, newIndex:int) : void;

		public function useSWFBridge () : Boolean;

		public function WindowedSystemManager (rootObj:IUIComponent);
	}
}
