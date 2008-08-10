/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IProgrammaticSkin {
		/**
		 * This function is called by the LayoutManager
		 *  when it's time for this control to draw itself.
		 *  The actual drawing happens in the updateDisplayList
		 *  function, which is called by this function.
		 */
		public function validateDisplayList():void;
		/**
		 * Validate and update the properties and layout of this object
		 *  and redraw it, if necessary.
		 */
		public function validateNow():void;
	}
}
