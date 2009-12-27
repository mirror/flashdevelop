package mx.core
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.events.IEventDispatcher;
	import mx.managers.ISystemManager;

include "../core/Version.as"
	/**
	 *  A SWFBridgeGroup represents all of the sandbox bridges that an 
 *  application needs to communicate with its parent and children.
	 */
	public class SWFBridgeGroup implements ISWFBridgeGroup
	{
		/**
		 *  @private
     *  The DisplayObject that owns this group.
		 */
		private var _groupOwner : ISystemManager;
		/**
		 *  @private
	 *  Allows communication with children that are in different sandboxes.
	 *  The sandbox bridge is used as a hash to find the display object.
		 */
		private var _childBridges : Dictionary;
		/**
		 *  @private
		 */
		private var _parentBridge : IEventDispatcher;

		/**
		 *  Allows communication with the parent
     *  if the parent is in a different sandbox.
     *  May be <code>null</code> if the parent is in the same sandbox
     *  or this is the top-level root application.
		 */
		public function get parentBridge () : IEventDispatcher;
		/**
		 *  @private
		 */
		public function set parentBridge (bridge:IEventDispatcher) : void;

		/**
		 *  Constructor.
     * 
     *  @param owner The DisplayObject that owns this group.
     *  This should be the SystemManager of an application.
		 */
		public function SWFBridgeGroup (owner:ISystemManager);

		/**
		 *  @inheritDoc
		 */
		public function addChildBridge (bridge:IEventDispatcher, bridgeProvider:ISWFBridgeProvider) : void;

		/**
		 *  @inheritDoc
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;

		/**
		 *  @inheritDoc
		 */
		public function getChildBridgeProvider (bridge:IEventDispatcher) : ISWFBridgeProvider;

		/**
		 *  @inheritDoc
		 */
		public function getChildBridges () : Array;

		/**
		 *  @inheritDoc
		 */
		public function containsBridge (bridge:IEventDispatcher) : Boolean;
	}
}
