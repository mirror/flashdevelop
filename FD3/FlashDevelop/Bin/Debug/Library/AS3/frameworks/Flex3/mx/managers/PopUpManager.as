/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import mx.core.IFlexDisplayObject;
	import flash.display.DisplayObject;
	public class PopUpManager {
		/**
		 * Pops up a top-level window.
		 *  It is good practice to call removePopUp() to remove popups
		 *  created by using the addPopUp() method.
		 *  If the class implements IFocusManagerContainer, the window will have its
		 *  own FocusManager so that, if the user uses the TAB key to navigate between
		 *  controls, only the controls in the window will be accessed.
		 *
		 * @param window            <IFlexDisplayObject> The IFlexDisplayObject to be popped up.
		 * @param parent            <DisplayObject> DisplayObject to be used for determining which SystemManager's layers
		 *                            to use and optionally  the reference point for centering the new
		 *                            top level window.  It may not be the actual parent of the popup as all popups
		 *                            are parented by the SystemManager.
		 * @param modal             <Boolean (default = false)> If true, the window is modal which means that
		 *                            the user will not be able to interact with other popups until the window
		 *                            is removed.
		 * @param childList         <String (default = null)> The child list in which to add the pop-up.
		 *                            One of PopUpManagerChildList.APPLICATION,
		 *                            PopUpManagerChildList.POPUP,
		 *                            or PopUpManagerChildList.PARENT (default).
		 */
		public static function addPopUp(window:IFlexDisplayObject, parent:DisplayObject, modal:Boolean = false, childList:String = null):void;
		/**
		 * Makes sure a popup window is higher than other objects in its child list
		 *  The SystemManager does this automatically if the popup is a top level window
		 *  and is moused on,
		 *  but otherwise you have to take care of this yourself.
		 *
		 * @param popUp             <IFlexDisplayObject> IFlexDisplayObject representing the popup.
		 */
		public static function bringToFront(popUp:IFlexDisplayObject):void;
		/**
		 * Centers a popup window over whatever window was used in the call
		 *  to the createPopUp() or addPopUp() method.
		 *
		 * @param popUp             <IFlexDisplayObject> IFlexDisplayObject representing the popup.
		 */
		public static function centerPopUp(popUp:IFlexDisplayObject):void;
		/**
		 * Creates a top-level window and places it above other windows in the
		 *  z-order.
		 *  It is good practice to call the removePopUp() method
		 *  to remove popups created by using the createPopUp() method.
		 *  If the class implements IFocusManagerContainer, the window will have its
		 *  own FocusManager so that, if the user uses the TAB key to navigate between
		 *  controls, only the controls in the window will be accessed.
		 *
		 * @param parent            <DisplayObject> DisplayObject to be used for determining which SystemManager's layers
		 *                            to use and optionally the reference point for centering the new
		 *                            top level window.  It may not be the actual parent of the popup as all popups
		 *                            are parented by the SystemManager.
		 * @param className         <Class> Class of object that is to be created for the popup.
		 *                            The class must implement IFlexDisplayObject.
		 * @param modal             <Boolean (default = false)> If true, the window is modal which means that
		 *                            the user will not be able to interact with other popups until the window
		 *                            is removed.
		 * @param childList         <String (default = null)> The child list in which to add the popup.
		 *                            One of PopUpManagerChildList.APPLICATION,
		 *                            PopUpManagerChildList.POPUP,
		 *                            or PopUpManagerChildList.PARENT (default).
		 * @return                  <IFlexDisplayObject> Reference to new top-level window.
		 */
		public static function createPopUp(parent:DisplayObject, className:Class, modal:Boolean = false, childList:String = null):IFlexDisplayObject;
		/**
		 * Removes a popup window popped up by
		 *  the createPopUp() or addPopUp() method.
		 *
		 * @param popUp             <IFlexDisplayObject> The IFlexDisplayObject representing the popup window.
		 */
		public static function removePopUp(popUp:IFlexDisplayObject):void;
	}
}
