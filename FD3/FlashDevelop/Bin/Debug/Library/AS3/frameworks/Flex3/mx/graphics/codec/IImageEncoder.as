/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics.codec {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	public interface IImageEncoder {
		/**
		 * The MIME type for the image format that this encoder produces.
		 */
		public function get contentType():String;
		/**
		 * Encodes a BitmapData object as a ByteArray.
		 *
		 * @param bitmapData        <BitmapData> The input BitmapData object.
		 */
		public function encode(bitmapData:BitmapData):ByteArray;
		/**
		 * Encodes a ByteArray object containing raw pixels
		 *  in 32-bit ARGB (Alpha, Red, Green, Blue) format
		 *  as a new ByteArray object containing encoded image data.
		 *  The original ByteArray is left unchanged.
		 *
		 * @param byteArray         <ByteArray> The input ByteArray object containing raw pixels.
		 *                            This ByteArray should contain
		 *                            4 width height bytes.
		 *                            Each pixel is represented by 4 bytes, in the order ARGB.
		 *                            The first four bytes represent the top-left pixel of the image.
		 *                            The next four bytes represent the pixel to its right, etc.
		 *                            Each row follows the previous one without any padding.
		 * @param width             <int> The width of the input image, in pixels.
		 * @param height            <int> The height of the input image, in pixels.
		 * @param transparent       <Boolean (default = true)> If false,
		 *                            alpha channel information is ignored.
		 */
		public function encodeByteArray(byteArray:ByteArray, width:int, height:int, transparent:Boolean = true):ByteArray;
	}
}
