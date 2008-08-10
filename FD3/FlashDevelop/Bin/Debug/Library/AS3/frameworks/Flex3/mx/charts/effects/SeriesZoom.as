/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.effects {
	public class SeriesZoom extends SeriesEffect {
		/**
		 * Defines the location of the focul point of the zoom.
		 */
		public var horizontalFocus:String;
		/**
		 * Controls the bounding box that Flex uses to calculate
		 *  the focal point of the zooms.
		 */
		public var relativeTo:String = "series";
		/**
		 * Defines the location of the focal point of the zoom.
		 *  For more information, see the description of the
		 *  horizontalFocus property.
		 */
		public var verticalFocus:String;
		/**
		 * Constructor.
		 *
		 * @param target            <Object (default = null)> 
		 */
		public function SeriesZoom(target:Object = null);
	}
}
