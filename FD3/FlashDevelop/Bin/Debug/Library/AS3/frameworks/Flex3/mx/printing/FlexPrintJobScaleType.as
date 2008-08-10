/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.printing {
	public final  class FlexPrintJobScaleType {
		/**
		 * Scales the object to fill at least one page completely;
		 *  that is, it selects the larger of the MATCH_WIDTH or MATCH_HEIGHT
		 *  scale types.
		 */
		public static const FILL_PAGE:String = "fillPage";
		/**
		 * Scales the object to fill the available page height.
		 *  If the resulting object width exceeds the page width, the output
		 *  spans multiple pages.
		 */
		public static const MATCH_HEIGHT:String = "matchHeight";
		/**
		 * Scales the object to fill the available page width.
		 *  If the resulting object height exceeds the page height, the output
		 *  spans multiple pages.
		 */
		public static const MATCH_WIDTH:String = "matchWidth";
		/**
		 * Does not scale the output.
		 *  The printed page has the same dimensions as the object on the screen.
		 *  If the object height, width, or both dimensions exceed the page width
		 *  or height, the output spans multiple pages.
		 */
		public static const NONE:String = "none";
		/**
		 * Scales the object to fit on a single page, filling one dimension;
		 *  that is, it selects the smaller of the MATCH_WIDTH or MATCH_HEIGHT
		 *  scale types.
		 */
		public static const SHOW_ALL:String = "showAll";
	}
}
