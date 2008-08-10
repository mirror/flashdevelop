/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	public interface IFocusManagerComponent {
		/**
		 * A flag that indicates whether the component can receive focus when selected.
		 */
		public function get focusEnabled():Boolean;
		public function set focusEnabled(value:Boolean):void;
		/**
		 * A flag that indicates whether the component can receive focus
		 *  when selected with the mouse.
		 *  If false, focus will be transferred to
		 *  the first parent that is mouseFocusEnabled.
		 */
		public function get mouseFocusEnabled():Boolean;
		/**
		 * A flag that indicates whether pressing the Tab key eventually
		 *  moves focus to this component.
		 *  Even if false, you can still be given focus
		 *  by being selected with the mouse or via a call to
		 *  setFocus()
		 */
		public function get tabEnabled():Boolean;
		/**
		 * If tabEnabled, the order in which the component receives focus.
		 *  If -1, then the component receives focus based on z-order.
		 */
		public function get tabIndex():int;
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component should draw or hide a graphic
		 *  that indicates that the component has focus.
		 *
		 * @param isFocused         <Boolean> If true, draw the focus indicator,
		 *                            otherwise hide it.
		 */
		public function drawFocus(isFocused:Boolean):void;
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component may in turn set focus to an internal component.
		 */
		public function setFocus():void;
	}
}
