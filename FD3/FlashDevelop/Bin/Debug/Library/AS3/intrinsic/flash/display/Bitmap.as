/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	public class Bitmap extends DisplayObject {
		/**
		 * The BitmapData object being referenced.
		 */
		public function get bitmapData():BitmapData;
		public function set bitmapData(value:BitmapData):void;
		/**
		 * Controls whether or not the Bitmap object is snapped to the nearest pixel. The PixelSnapping
		 *  class includes possible values:
		 *  PixelSnapping.NEVER-No pixel snapping occurs.
		 *  PixelSnapping.ALWAYS-The image is always snapped to the nearest
		 *  pixel, independent of transformation.
		 *  PixelSnapping.AUTO-The image is snapped
		 *  to the nearest pixel if it is drawn with no rotation
		 *  or skew and it is drawn at a scale factor of 99.9% to 100.1%. If these conditions are satisfied,
		 *  the bitmap image is drawn at 100% scale, snapped to the nearest pixel. Internally, this value allows the image
		 *  to be drawn as fast as possible using the vector renderer.
		 */
		public function get pixelSnapping():String;
		public function set pixelSnapping(value:String):void;
		/**
		 * Controls whether or not the bitmap is smoothed when scaled. If true, the bitmap is
		 *  smoothed when scaled. If false, the bitmap is not smoothed when scaled.
		 */
		public function get smoothing():Boolean;
		public function set smoothing(value:Boolean):void;
		/**
		 * Initializes a Bitmap object to refer to the specified BitmapData object.
		 *
		 * @param bitmapData        <BitmapData (default = null)> The BitmapData object being referenced.
		 * @param pixelSnapping     <String (default = "auto")> Whether or not the Bitmap object is snapped to the nearest pixel.
		 */
		public function Bitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false);
	}
}
