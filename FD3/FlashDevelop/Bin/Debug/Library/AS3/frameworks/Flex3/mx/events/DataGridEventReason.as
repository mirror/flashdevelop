/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	public final  class DataGridEventReason {
		/**
		 * Specifies that the user cancelled editing and that they do not
		 *  want to save the edited data. Even if you call the preventDefault() method
		 *  from within your event listener for the itemEditEnd event,
		 *  Flex still calls the destroyItemEditor() editor to close the editor.
		 */
		public static const CANCELLED:String = "cancelled";
		/**
		 * Specifies that the user moved focus to a new column in the same row.
		 *  Within an event listener, you can let the focus change occur, or prevent it.
		 *  For example, your event listener might check that the user entered a valid value
		 *  for the item currently being edited. If not, you can prevent the user from moving
		 *  to a new item by calling the preventDefault() method.
		 *  In this case, the item editor remains open, and the user continues to edit
		 *  the current item. If you call the preventDefault() method and
		 *  also call the destroyItemEditor() method, you block the move to the new item,
		 *  but the item editor closes.
		 */
		public static const NEW_COLUMN:String = "newColumn";
		/**
		 * Specifies that the user moved focus to a new row.
		 *  You handle this reason much like you handle NEW_COLUMN.
		 */
		public static const NEW_ROW:String = "newRow";
		/**
		 * Specifies that the list control lost focus, was scrolled,
		 *  or is somehow in a state where editing is not allowed.
		 *  Even if you call the preventDefault() method from within your event
		 *  listener for the itemEditEnd event,
		 *  Flex still calls the destroyItemEditor() editor to close the editor.
		 */
		public static const OTHER:String = "other";
	}
}
