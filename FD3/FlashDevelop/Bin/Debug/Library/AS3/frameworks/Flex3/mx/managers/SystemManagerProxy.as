package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import mx.core.FlexSprite;
	import mx.core.IFlexModuleFactory;
	import mx.core.ISWFBridgeGroup;
	import mx.core.ISWFBridgeProvider;
	import mx.core.mx_internal;
	import mx.events.SWFBridgeEvent;
	import mx.utils.NameUtil;
	import mx.utils.SecurityUtil;
	import mx.events.SWFBridgeRequest;

include "../core/Version.as"
	/**
	 *  @private
 *  This class acts as the SystemManager for a popup window that is 
 *  added to a parent SystemManager from a compatible application.
 *  Instead of the popup window being a child of the host
 *  SystemManager as is normally done, the popup is a child of a
 *  SystemManagerProxy, created in the same application domain. 
 *  The SystemManagerProxy is the actual display object
 *  added to the host SystemManager.
 *  The scheme is done to give the popup window a SystemManager,
 *  with the same version of Flex and created in the same application domain,
 *  that the pop up window will be able to talk to.
	 */
	public class SystemManagerProxy extends SystemManager
	{
		/**
		 *  @private
		 */
		private var _systemManager : ISystemManager;

		/**
		 *  @inheritDoc
		 */
		public function get screen () : Rectangle;

		/**
		 *  @inheritDoc
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;

		/**
		 *  The SystemManager that is being proxied.
     *  This is the SystemManager of the application that created this proxy
     *  and the pop up window that is a child of this proxy.
		 */
		public function get systemManager () : ISystemManager;

		public function get swfBridgeGroup () : ISWFBridgeGroup;
		public function set swfBridgeGroup (bridgeGroup:ISWFBridgeGroup) : void;

		/**
		 *  Constructor.
         * 
         *  @param systemManager The system manager that this class is a proxy for.
         *  This is the system manager in the same application domain as the popup.
		 */
		public function SystemManagerProxy (systemManager:ISystemManager);

		/**
		 *  @inheritDoc
		 */
		public function getDefinitionByName (name:String) : Object;

		/**
		 *  @inheritDoc
		 */
		public function create (...params) : Object;

		/**
		 *  Add a bridge to talk to the child owned by <code>owner</code>.
     * 
     *  @param bridge The bridge used to talk to the parent. 
     *  @param owner The display object that owns the bridge.
		 */
		public function addChildBridge (bridge:IEventDispatcher, owner:DisplayObject) : void;

		/**
		 *  Remove a child bridge.
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;

		/**
		 *  @inheritDoc
		 */
		public function useSWFBridge () : Boolean;

		/**
		 *  @inheritDoc
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;

		/**
		 *  @inheritDoc
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;

		/**
		 *  @inheritDoc
		 */
		public function activate (f:IFocusManagerContainer) : void;

		/**
		 *  @inheritDoc
		 */
		public function deactivate (f:IFocusManagerContainer) : void;

		/**
		 *  @inheritdoc
     * 
     *  proxy to real system manager.
		 */
		public function getVisibleApplicationRect (bounds:Rectangle = null) : Rectangle;

		/**
		 *  Activates the FocusManager in an IFocusManagerContainer for the 
     *  popup window parented by this proxy.
     * 
     *  @param f The top-level window whose FocusManager should be activated.
		 */
		public function activateByProxy (f:IFocusManagerContainer) : void;

		/**
		 *  Deactivates the focus manager for the popup window
     *  parented by this proxy.
     * 
     *  @param f The top-level window whose FocusManager should be deactivated.
		 */
		public function deactivateByProxy (f:IFocusManagerContainer) : void;

		/**
		 *  @private
     *  Handles mouse downs on the pop up window.
		 */
		private function proxyMouseDownHandler (event:MouseEvent) : void;
	}
}
