/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public final  class ScrollPolicy {
		/**
		 * Show the scrollbar if the children exceed the owner's dimension.
		 *  The size of the owner is not adjusted to account
		 *  for the scrollbars when they appear, so this may cause the
		 *  scrollbar to obscure the contents of the control or container.
		 */
		public static const AUTO:String = "auto";
		/**
		 * Never show the scrollbar.
		 */
		public static const OFF:String = "off";
		/**
		 * Always show the scrollbar.
		 *  The size of the scrollbar is automatically added to the size
		 *  of the owner's contents to determine the size of the owner
		 *  if explicit sizes are not specified.
		 */
		public static const ON:String = "on";
	}
}
