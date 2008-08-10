/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	import flash.display.DisplayObject;
	public interface IAutomationMouseSimulator {
		/**
		 * Called when a DisplayObject retrieves the mouseX property.
		 *
		 * @param item              <DisplayObject> DisplayObject that simulates mouse movement.
		 * @return                  <Number> The x coordinate of the mouse position relative to item.
		 */
		public function getMouseX(item:DisplayObject):Number;
		/**
		 * Called when a DisplayObject retrieves mouseY property.
		 *
		 * @param item              <DisplayObject> DisplayObject that simulates mouse movement.
		 * @return                  <Number> The y coordinate of the mouse position relative to item.
		 */
		public function getMouseY(item:DisplayObject):Number;
	}
}
