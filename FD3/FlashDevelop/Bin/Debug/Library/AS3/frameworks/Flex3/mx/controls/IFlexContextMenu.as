package mx.controls
{
	import flash.display.InteractiveObject;

	/**
	 *  The IFlexContextMenu interface defines the interface for a  *  Flex context menus.   * *  @see mx.core.UIComponent#flexContextMenu
	 */
	public interface IFlexContextMenu
	{
		/**
		 *  Sets the context menu of an InteractiveObject.  This will do 	 *  all the necessary steps to add ourselves as the context 	 *  menu for this InteractiveObject, such as adding listeners, etc..	 * 	 *  @param component InteractiveObject to set context menu on
		 */
		public function setContextMenu (component:InteractiveObject) : void;
		/**
		 *  Unsets the context menu of a InteractiveObject.  This will do 	 *  all the necessary steps to remove ourselves as the context 	 *  menu for this InteractiveObject, such as removing listeners, etc..	 * 	 *  @param component InteractiveObject to unset context menu on
		 */
		public function unsetContextMenu (component:InteractiveObject) : void;
	}
}
