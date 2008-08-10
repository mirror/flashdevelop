/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.scrollClasses {
	import mx.core.UIComponent;
	public class ScrollBar extends UIComponent {
		/**
		 * Specifies whether the ScrollBar is for horizontal or vertical scrolling.
		 *  Valid values in MXML are "vertical" and "horizontal".
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * Set of styles to pass from the ScrollBar to the down arrow.
		 */
		protected function get downArrowStyleFilters():Object;
		/**
		 * Amount to scroll when an arrow button is pressed, in pixels.
		 */
		public function get lineScrollSize():Number;
		public function set lineScrollSize(value:Number):void;
		/**
		 * Number which represents the maximum scroll position.
		 */
		public function get maxScrollPosition():Number;
		public function set maxScrollPosition(value:Number):void;
		/**
		 * Number that represents the minimum scroll position.
		 */
		public function get minScrollPosition():Number;
		public function set minScrollPosition(value:Number):void;
		/**
		 * Amount to move the scroll thumb when the scroll bar
		 *  track is pressed, in pixels.
		 */
		public function get pageScrollSize():Number;
		public function set pageScrollSize(value:Number):void;
		/**
		 * The number of lines equivalent to one page.
		 */
		public function get pageSize():Number;
		public function set pageSize(value:Number):void;
		/**
		 * Number that represents the current scroll position.
		 *  The value is between minScrollPosition and
		 *  maxScrollPosition inclusively.
		 */
		public function get scrollPosition():Number;
		public function set scrollPosition(value:Number):void;
		/**
		 * Set of styles to pass from the ScrollBar to the thumb.
		 */
		protected function get thumbStyleFilters():Object;
		/**
		 * Set of styles to pass from the ScrollBar to the up arrow.
		 */
		protected function get upArrowStyleFilters():Object;
		/**
		 * Constructor.
		 */
		public function ScrollBar();
		/**
		 * Sets the range and viewport size of the ScrollBar control.
		 *  The ScrollBar control updates the state of the arrow buttons and
		 *  size of the scroll thumb accordingly.
		 *
		 * @param pageSize          <Number> Number which represents the size of one page.
		 * @param minScrollPosition <Number> Number which represents the bottom of the
		 *                            scrolling range.
		 * @param maxScrollPosition <Number> Number which represetns the top of the
		 *                            scrolling range.
		 * @param pageScrollSize    <Number (default = 0)> Number which represents the increment to move when
		 *                            the scroll track is pressed.
		 */
		public function setScrollProperties(pageSize:Number, minScrollPosition:Number, maxScrollPosition:Number, pageScrollSize:Number = 0):void;
		/**
		 * The width of a vertical scrollbar, or the height of a horizontal
		 *  scrollbar, in pixels.
		 */
		public static const THICKNESS:Number = 16;
	}
}
