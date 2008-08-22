/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.geom.Rectangle;
	public interface IRectangularBorder extends IBorder {
		/**
		 * Rectangular area within which to draw the background image.
		 *  This can be larger than the dimensions of the border
		 *  if the parent container has scrollable content.
		 *  If this property is null, the border can use
		 *  the parent's size and viewMetrics property to determine its value.
		 */
		public function get backgroundImageBounds():Rectangle;
		public function set backgroundImageBounds(value:Rectangle):void;
		/**
		 * Contains true if the RectangularBorder instance
		 *  contains a background image.
		 */
		public function get hasBackgroundImage():Boolean;
		/**
		 * Layout the background image.
		 */
		public function layoutBackgroundImage():void;
	}
}
