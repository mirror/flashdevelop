/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.IUIComponent;
	public class PopUpButton extends Button {
		/**
		 * If true, specifies to pop up the
		 *  popUp when you click the main button.
		 *  The popUp always appears when you press the Spacebar,
		 *  or when you click the pop-up button, regardless of the setting of
		 *  the openAlways property.
		 */
		public function get openAlways():Boolean;
		public function set openAlways(value:Boolean):void;
		/**
		 * Specifies the UIComponent object, or object defined by a subclass
		 *  of UIComponent, to pop up.
		 *  For example, you can specify a Menu, TileList, or Tree control.
		 */
		public function get popUp():IUIComponent;
		public function set popUp(value:IUIComponent):void;
		/**
		 * Constructor.
		 */
		public function PopUpButton();
		/**
		 * Closes the UIComponent object opened by the PopUpButton control.
		 */
		public function close():void;
		/**
		 * Opens the UIComponent object specified by the popUp property.
		 */
		public function open():void;
	}
}
