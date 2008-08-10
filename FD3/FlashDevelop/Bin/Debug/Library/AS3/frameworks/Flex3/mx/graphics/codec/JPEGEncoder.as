/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics.codec {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	public class JPEGEncoder implements IImageEncoder {
		/**
		 * The MIME type for the JPEG encoded image.
		 *  The value is "image/jpeg".
		 */
		public function get contentType():String;
		/**
		 * Constructor.
		 *
		 * @param quality           <Number (default = 50.0)> A value between 0.0 and 100.0.
		 *                            The smaller the quality value,
		 *                            the smaller the file size of the resultant image.
		 *                            The value does not affect the encoding speed.
		 *                            Note that even though this value is a number between 0.0 and 100.0,
		 *                            it does not represent a percentage.
		 *                            The default value is 50.0.
		 */
		public function JPEGEncoder(quality:Number = 50.0);
		/**
		 * Converts the pixels of BitmapData object
		 *  to a JPEG-encoded ByteArray object.
		 *
		 * @param bitmapData        <BitmapData> The input BitmapData object.
		 */
		public function encode(bitmapData:BitmapData):ByteArray;
		/**
		 * Converts a ByteArray object containing raw pixels
		 *  in 32-bit ARGB (Alpha, Red, Green, Blue) format
		 *  to a new JPEG-encoded ByteArray object.
		 *  The original ByteArray is left unchanged.
		 *  Transparency is not supported; however you still must represent
		 *  each pixel as four bytes in ARGB format.
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
