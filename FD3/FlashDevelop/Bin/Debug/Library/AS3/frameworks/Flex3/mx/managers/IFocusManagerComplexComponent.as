/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	public interface IFocusManagerComplexComponent extends <a href="../../mx/managers/IFocusManagerComponent.html">IFocusManagerComponent</a>  {
		/**
		 * A flag that indicates whether the component currently has internal
		 *  focusable targets
		 */
		public function get hasFocusableContent():Boolean;
		/**
		 * Called by the FocusManager when the component receives focus.
		 *  The component may in turn set focus to an internal component.
		 *  The components setFocus() method will still be called when focused by
		 *  the mouse, but this method will be used when focus changes via the
		 *  keyboard
		 *
		 * @param direction         <String> "bottom" if TAB used with SHIFT key, "top" otherwise
		 */
		public function assignFocus(direction:String):void;
	}
}
