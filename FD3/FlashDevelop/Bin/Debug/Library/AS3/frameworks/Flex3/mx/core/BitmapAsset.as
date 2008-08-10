/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.display.BitmapData;
	public class BitmapAsset extends FlexBitmap implements IFlexAsset, IFlexDisplayObject {
		/**
		 * The measured height of this object.
		 */
		public function get measuredHeight():Number;
		/**
		 * The measured width of this object.
		 */
		public function get measuredWidth():Number;
		/**
		 * Constructor.
		 *
		 * @param bitmapData        <BitmapData (default = null)> The data for the bitmap image.
		 * @param pixelSnapping     <String (default = "auto")> Whether or not the bitmap is snapped
		 *                            to the nearest pixel.
		 * @param smoothing         <Boolean (default = false)> Whether or not the bitmap is smoothed when scaled.
		 */
		public function BitmapAsset(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false);
		/**
		 * Moves this object to the specified x and y coordinates.
		 *
		 * @param x                 <Number> The new x-position for this object.
		 * @param y                 <Number> The new y-position for this object.
		 */
		public function move(x:Number, y:Number):void;
		/**
		 * Sets the actual size of this object.
		 *
		 * @param newWidth          <Number> The new width for this object.
		 * @param newHeight         <Number> The new height for this object.
		 */
		public function setActualSize(newWidth:Number, newHeight:Number):void;
	}
}
