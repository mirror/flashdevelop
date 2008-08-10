/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.skins {
	import mx.core.IRectangularBorder;
	import flash.geom.Rectangle;
	public class RectangularBorder extends Border implements IRectangularBorder {
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
		 * Constructor.
		 */
		public function RectangularBorder();
		/**
		 * Layout the background image.
		 */
		public function layoutBackgroundImage():void;
	}
}
