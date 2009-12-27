package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;

	/**
	 *  A sandbox bridge group is a group of bridges that represent
 *  applications that this application can communicate with.
 *  This application can not share memory with, or can not have access to, 
 *  the other applications in the group, but uses the bridge
 *  to communicate with these applications.
	 */
	public interface ISWFBridgeGroup
	{
		/**
		 *  The bridge that is used to communicate
     *  with this group's parent application.
		 */
		public function get parentBridge () : IEventDispatcher;
		/**
		 *  @private
		 */
		public function set parentBridge (bridge:IEventDispatcher) : void;

		/**
		 *  Adds a new bridge to the pod.
     * 
     *  @param bridge The bridge to communicate with the child content.
     * 
     *  @param bridgeProvider The DisplayObject that loaded the content
     *  represented by the bridge. Usually this is will be an instance of the SWFLoader class.
		 */
		public function addChildBridge (bridge:IEventDispatcher, bridgeProvider:ISWFBridgeProvider) : void;

		/**
		 *  Removes the child bridge.
     * 
     *  @param bridge The bridge to remove.
		 */
		public function removeChildBridge (bridge:IEventDispatcher) : void;

		/**
		 *  Gets the owner of a bridge and also the DisplayObject
     *  that loaded the child.
     *  This method is useful when an event is received
     *  and the <code>event.target</code> is the bridge.
     *  The bridge can then be converted into the owning DisplayObject.
     *
     *  @param bridge The target bridge.
     * 
     *  @return The object that loaded the child.
		 */
		public function getChildBridgeProvider (bridge:IEventDispatcher) : ISWFBridgeProvider;

		/**
		 *  Gets all of the child bridges in this group.
     * 
     *  @return An array of all the child bridges in this group.
     *  Each object in the array is of type <code>IEventDispatcher</code>.
		 */
		public function getChildBridges () : Array;

		/**
		 *  Tests if the given bridge is one of the sandbox bridges in this group.
     *  
     *  @param bridge The bridge to test.
     * 
     *  @return <code>true</code> if the handle is found; otherwise <code>false</code>.
		 */
		public function containsBridge (bridge:IEventDispatcher) : Boolean;
	}
}
