package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.utils.Proxy;
	import mx.automation.IAutomationObject;
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.core.ApplicationGlobals;
	import mx.core.FlexSprite;
	import mx.core.IChildList;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModule;
	import mx.core.IInvalidating;
	import mx.core.ISWFLoader;
	import mx.core.IUIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Blur;
	import mx.effects.IEffect;
	import mx.effects.Fade;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.MoveEvent;
	import mx.events.SWFBridgeRequest;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.managers.SystemManagerProxy;
	import mx.styles.IStyleClient;
	import mx.utils.NameUtil;
	import mx.events.InterManagerRequest;
	import mx.core.UIComponent;
	import mx.events.SandboxMouseEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.geom.Point;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.effects.Effect;
	import mx.events.SandboxMouseEvent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManagerImpl;

	/**
	 *  @private *  The PopUpManager singleton class creates new top-level windows and *  places or removes those windows from the layer on top of all other *  visible windows.  See the SystemManager for a description of the layering. *  It is used for popup dialogs, menus, and dropdowns in the ComboBox control  *  and in similar components. *  *  <p>The PopUpManager also provides modality, so that windows below the popup *  cannot receive mouse events, and also provides an event if the user clicks *  the mouse outside the window so the developer can choose to dismiss *  the window or warn the user.</p> *  *  @see PopUpManagerChildList
	 */
	public class PopUpManagerImpl implements IPopUpManager
	{
		/**
		 *  @private
		 */
		private static var instance : IPopUpManager;
		/**
		 *  @private     *  The class used to create the shield that makes a window appear modal.
		 */
		local var modalWindowClass : Class;
		/**
		 *  @private     *  An array of information about currently active popups
		 */
		private var popupInfo : Array;

		/**
		 *  @private
		 */
		public static function getInstance () : IPopUpManager;
		/**
		 *  @private
		 */
		public function PopUpManagerImpl ();
		/**
		 *  Creates a top-level window and places it above other windows in the     *  z-order.     *  It is good practice to call the <code>removePopUp()</code> method      *  to remove popups created by using the <code>createPopUp()</code> method.     *     *  If the class implements IFocusManagerContainer, the window will have its     *  own FocusManager so that, if the user uses the TAB key to navigate between     *  controls, only the controls in the window will be accessed.     *     *  <p><b>Example</b></p>      *     *  <pre>pop = mx.managers.PopUpManager.createPopUp(pnl, TitleWindow, false); </pre>     *       *  <p>Creates a popup window based on the TitleWindow class, using <code>pnl</code> as the MovieClip      *  for determining where to place the popup. It is defined to be a non-modal window      *  meaning that other windows can receive mouse events</p>     *     *  @param parent DisplayObject to be used for determining which SystemManager's layers     *  to use and optionally the reference point for centering the new     *  top level window.  It may not be the actual parent of the popup as all popups     *  are parented by the SystemManager.     *      *  @param className Class of object that is to be created for the popup.     *  The class must implement IFlexDisplayObject.     *     *  @param modal If <code>true</code>, the window is modal which means that     *  the user will not be able to interact with other popups until the window     *  is removed.     *     *  @param childList The child list in which to add the popup.     *  One of <code>PopUpManagerChildList.APPLICATION</code>,      *  <code>PopUpManagerChildList.POPUP</code>,      *  or <code>PopUpManagerChildList.PARENT</code> (default).     *     *  @return Reference to new top-level window.     *     *  @see PopUpManagerChildList
		 */
		public function createPopUp (parent:DisplayObject, className:Class, modal:Boolean = false, childList:String = null) : IFlexDisplayObject;
		/**
		 *  Pops up a top-level window.     *  It is good practice to call <code>removePopUp()</code> to remove popups     *  created by using the <code>createPopUp()</code> method.     *  If the class implements IFocusManagerContainer, the window will have its     *  own FocusManager so that, if the user uses the TAB key to navigate between     *  controls, only the controls in the window will be accessed.     *     *  <p><b>Example</b></p>      *     *  <pre>var tw = new TitleWindow();     *    tw.title = "My Title";     *    mx.managers.PopUpManager.addPopUp(tw, pnl, false);</pre>     *     *  <p>Creates a popup window using the <code>tw</code> instance of the      *  TitleWindow class and <code>pnl</code> as the Sprite for determining     *  where to place the popup.     *  It is defined to be a non-modal window.</p>     *       *  @param window The IFlexDisplayObject to be popped up.     *     *  @param parent DisplayObject to be used for determining which SystemManager's layers     *  to use and optionally  the reference point for centering the new     *  top level window.  It may not be the actual parent of the popup as all popups     *  are parented by the SystemManager.     *     *  @param modal If <code>true</code>, the window is modal which means that     *  the user will not be able to interact with other popups until the window     *  is removed.     *     *  @param childList The child list in which to add the pop-up.     *  One of <code>PopUpManagerChildList.APPLICATION</code>,      *  <code>PopUpManagerChildList.POPUP</code>,      *  or <code>PopUpManagerChildList.PARENT</code> (default).     *     *  @see PopUpManagerChildList
		 */
		public function addPopUp (window:IFlexDisplayObject, parent:DisplayObject, modal:Boolean = false, childList:String = null) : void;
		private function getTopLevelSystemManager (parent:DisplayObject) : ISystemManager;
		/**
		 *  Centers a popup window over whatever window was used in the call      *  to the <code>createPopUp()</code> or <code>addPopUp()</code> method.     *     *  <p>Note that the position of the popup window may not     *  change immediately after this call since Flex may wait to measure and layout the     *  popup window before centering it.</p>     *     *  @param The IFlexDisplayObject representing the popup.
		 */
		public function centerPopUp (popUp:IFlexDisplayObject) : void;
		/**
		 *  Removes a popup window popped up by      *  the <code>createPopUp()</code> or <code>addPopUp()</code> method.     *       *  @param window The IFlexDisplayObject representing the popup window.
		 */
		public function removePopUp (popUp:IFlexDisplayObject) : void;
		/**
		 *  Makes sure a popup window is higher than other objects in its child list     *  The SystemManager does this automatically if the popup is a top level window     *  and is moused on,      *  but otherwise you have to take care of this yourself.     *     *  @param The IFlexDisplayObject representing the popup.
		 */
		public function bringToFront (popUp:IFlexDisplayObject) : void;
		/**
		 *  @private     *      *  Create the modal window.      *  This is called in two different cases.     *      1. Create a modal window for a local pop up.     *      2. Create a modal window for a remote pop up. In this case o.owner will be null.
		 */
		private function createModalWindow (parentReference:DisplayObject, o:PopUpData, childrenList:IChildList, visibleFlag:Boolean, sm:ISystemManager, sbRoot:DisplayObject) : void;
		private function dispatchModalWindowRequest (type:String, sm:ISystemManager, sbRoot:DisplayObject, o:PopUpData, visibleFlag:Boolean) : void;
		/**
		 *  @private     *      *  Update a mask to exclude the area of the exclude parameter from the area      *  of the modal window parameter.     *      *  @param sm The system manager that hosts the modal window     *  @param modalWindow The base area of the mask     *  @param exclude The area to exlude from the mask, may be null.     *  @param excludeRect An optionally rectangle that is included in the area     *  to exclude. The rectangle is in global coordinates.     *  @param mask A non-null sprite. The mask is rewritten for each call.     *
		 */
		static function updateModalMask (sm:ISystemManager, modalWindow:DisplayObject, exclude:IUIComponent, excludeRect:Rectangle, mask:Sprite) : void;
		/**
		 *  @private
		 */
		private function endEffects (o:PopUpData) : void;
		private function showModalWindow (o:PopUpData, sm:ISystemManager, sendRequest:Boolean = true) : void;
		/**
		 *  @private     *  Show the modal transparency blocker, playing effects if needed.
		 */
		private function showModalWindowInternal (o:PopUpData, transparencyDuration:Number, transparency:Number, transparencyColor:Number, transparencyBlur:Number, sm:ISystemManager, sbRoot:DisplayObject) : void;
		/**
		 *  @private     *  Hide the modal transparency blocker, playing effects if needed.     *
		 */
		private function hideModalWindow (o:PopUpData, destroy:Boolean = false) : void;
		/**
		 *  @private     *  Returns the PopUpData (or null) for a given popupInfo.owner
		 */
		private function findPopupInfoByOwner (owner:Object) : PopUpData;
		/**
		 *  @private     *  Returns the PopUpData for the highest remote modal window on display.
		 */
		private function findHighestRemoteModalPopupInfo () : PopUpData;
		/**
		 *  @private     *  Add mouse out listeners for modal and non-modal windows.
		 */
		private function addMouseOutEventListeners (o:PopUpData) : void;
		/**
		 *  @private     *  Remove mouse out listeners for modal and non-modal windows.
		 */
		private function removeMouseOutEventListeners (o:PopUpData) : void;
		/**
		 *  @private     *  Set by PopUpManager on modal windows so they show when the parent shows.
		 */
		private function popupShowHandler (event:FlexEvent) : void;
		/**
		 *  @private     *  Set by PopUpManager on modal windows so they hide when the parent hide
		 */
		private function popupHideHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function showOwnerHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function hideOwnerHandler (event:FlexEvent) : void;
		/**
		 *  @private     *       *  Create a modal window and optionally show it.
		 */
		private function createModalWindowRequestHandler (event:Event) : void;
		/**
		 *  @private     *       *  Show a modal window.
		 */
		private function showModalWindowRequest (event:Event) : void;
		/**
		 *  @private     *       *  Hide a modal window and optionally remove it.
		 */
		private function hideModalWindowRequest (event:Event) : void;
		/**
		 *  @private     *  Set by PopUpManager on modal windows to monitor when the parent window gets killed.     *  PopUps self-manage their memory -- when they are removed using removePopUp OR     *  manually removed with removeChild, they will clean themselves up when they leave the     *  display list (including all references to PopUpManager).
		 */
		private function popupRemovedHandler (event:Event) : void;
		/**
		 *  @private     *  Show the modal window after the fade effect finishes
		 */
		private function fadeInEffectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private     *  Remove the modal window after the fade effect finishes
		 */
		private function fadeOutDestroyEffectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private     *  Remove the modal window after the fade effect finishes
		 */
		private function fadeOutCloseEffectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private
		 */
		private function effectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private     *  If not modal, use this kind of mouseDownOutside logic
		 */
		private static function nonmodalMouseDownOutsideHandler (owner:DisplayObject, evt:MouseEvent) : void;
		/**
		 *  @private     *  If not modal, use this kind of mouseWheelOutside logic
		 */
		private static function nonmodalMouseWheelOutsideHandler (owner:DisplayObject, evt:MouseEvent) : void;
		/**
		 *  @private     *  This mouseWheelOutside handler just dispatches the event.
		 */
		private static function dispatchMouseWheelOutsideEvent (owner:DisplayObject, evt:MouseEvent) : void;
		/**
		 *  @private     *  This mouseDownOutside handler just dispatches the event.
		 */
		private static function dispatchMouseDownOutsideEvent (owner:DisplayObject, evt:MouseEvent) : void;
	}
	/**
	 *  @private
	 */
	internal class PopUpData
	{
		/**
		 *  @private     *      *  The popup in the normal case but will null in the case where only a      *  modal window is displayed over an application.
		 */
		public var owner : DisplayObject;
		/**
		 *  @private
		 */
		public var parent : DisplayObject;
		/**
		 *  @private
		 */
		public var topMost : Boolean;
		/**
		 *  @private
		 */
		public var modalWindow : DisplayObject;
		/**
		 *  @private
		 */
		public var _mouseDownOutsideHandler : Function;
		/**
		 *  @private
		 */
		public var _mouseWheelOutsideHandler : Function;
		/**
		 *  @private
		 */
		public var fade : Effect;
		/**
		 *  @private
		 */
		public var blur : Effect;
		/**
		 *  @private     *
		 */
		public var blurTarget : Object;
		/**
		 *   @private     *      *   The host of the modal dialog.
		 */
		public var systemManager : ISystemManager;
		/**
		 *   @private     *      *   Is this popup just a modal window for a popup      *   in an untrusted sandbox?
		 */
		public var isRemoteModalWindow : Boolean;
		/**
		 *   @private
		 */
		public var modalTransparencyDuration : Number;
		/**
		 *   @private
		 */
		public var modalTransparency : Number;
		/**
		 *   @private
		 */
		public var modalTransparencyBlur : Number;
		/**
		 *   @private
		 */
		public var modalTransparencyColor : Number;
		/**
		 *   @private     *      *   Object to exclude from the modal dialog. The area of the      *   display object will be excluded from the modal dialog.
		 */
		public var exclude : IUIComponent;
		/**
		 *   @private     *      *   Flag to determine if the exclude property should be used     *   or ignored. Typically the exclude field is used when a     *   SystemManager contains its exclude child. But this isn't     *   true when the child is in a pop up window. In this case     *   useExclude is false.
		 */
		public var useExclude : Boolean;
		/**
		 *   @private     *      *   Rectangle to exclude from the <code>exclude</code> component     *   which is in turn excluded from the modal dialog.     *   This is passed within a sandbox so A.2 can tell A what     *   the size of A.2.3 was. Each top-level application     *   calculates excludeRect if there is mutual trust with its parent.      *   If there is no trust this property will be null.
		 */
		public var excludeRect : Rectangle;
		/**
		 *   @private     *      *   Mask created from the modalWindow and exclude fields.
		 */
		public var modalMask : Sprite;

		/**
		 *  Constructor.
		 */
		public function PopUpData ();
		/**
		 *  @private
		 */
		public function mouseDownOutsideHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		public function mouseWheelOutsideHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		public function marshalMouseOutsideHandler (event:Event) : void;
		/**
		 *  @private     *  Set by PopUpManager on modal windows to make sure they cover the whole screen
		 */
		public function resizeHandler (event:Event) : void;
	}
}
