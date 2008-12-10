﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import mx.managers.IFocusManager;
	import mx.managers.ISystemManager;

	/**
	 *  The IFocusManagerContainer interface defines the interface that  *  containers implement to host a FocusManager. *  The PopUpManager automatically installs a FocusManager *  in any IFocusManagerContainer it pops up.
	 */
	public interface IFocusManagerContainer extends IEventDispatcher
	{
		/**
		 *  The FocusManager for this component. 	 *  The FocusManager must be in a <code>focusManager</code> property.
		 */
		public function get focusManager () : IFocusManager;
		/**
		 *  @private
		 */
		public function set focusManager (value:IFocusManager) : void;
		/**
		 *  @copy mx.core.UIComponent#systemManager
		 */
		public function get systemManager () : ISystemManager;

		/**
		 *  Determines whether the specified display object is a child 	 *  of the container instance or the instance itself. 	 *  The search includes the entire display list including this container instance. 	 *  Grandchildren, great-grandchildren, and so on each return <code>true</code>.	 *	 *  @param child The child object to test.	 *	 *  @return <code>true</code> if the child object is a child of the container 	 *  or the container itself; otherwise <code>false</code>.
		 */
		public function contains (child:DisplayObject) : Boolean;
	}
}
