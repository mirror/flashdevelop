/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import flash.display.InteractiveObject;
	public interface IFlexContextMenu {
		/**
		 * Sets the context menu of an InteractiveObject.  This will do
		 *  all the necessary steps to add ourselves as the context
		 *  menu for this InteractiveObject, such as adding listeners, etc..
		 *
		 * @param component         <InteractiveObject> InteractiveObject to set context menu on
		 */
		public function setContextMenu(component:InteractiveObject):void;
		/**
		 * Unsets the context menu of a InteractiveObject.  This will do
		 *  all the necessary steps to remove ourselves as the context
		 *  menu for this InteractiveObject, such as removing listeners, etc..
		 *
		 * @param component         <InteractiveObject> InteractiveObject to unset context menu on
		 */
		public function unsetContextMenu(component:InteractiveObject):void;
	}
}
