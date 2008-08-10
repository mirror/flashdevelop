/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IRawChildrenContainer {
		/**
		 * Returns an IChildList representing all children.
		 *  This is used by FocusManager to find non-content children that may
		 *  still receive focus (for example, components in ControlBars).
		 */
		public function get rawChildren():IChildList;
	}
}
