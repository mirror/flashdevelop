package mx.graphics.codec
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

include "../../core/Version.as"
	/**
	 *  The PNGEncoder class converts raw bitmap images into encoded
 *  images using Portable Network Graphics (PNG) lossless compression.
 *
 *  <p>For the PNG specification, see http://www.w3.org/TR/PNG/</p>.
	 */
	public class PNGEncoder implements IImageEncoder
	{
		/**
		 *  @private
	 *  The MIME type for a PNG image.
		 */
		private static const CONTENT_TYPE : String = "image/png";
		/**
		 *  @private
	 *  Used for computing the cyclic redundancy checksum
	 *  at the end of each chunk.
		 */
		private var crcTable : Array;

		/**
		 *  The MIME type for the PNG encoded image.
     *  The value is <code>"image/png"</code>.
		 */
		public function get contentType () : String;

		/**
		 *  Constructor.
		 */
		public function PNGEncoder ();

		/**
		 *  Converts the pixels of a BitmapData object
	 *  to a PNG-encoded ByteArray object.
     *
     *  @param bitmapData The input BitmapData object.
     *
     *  @return Returns a ByteArray object containing PNG-encoded image data.
		 */
		public function encode (bitmapData:BitmapData) : ByteArray;

		/**
		 *  Converts a ByteArray object containing raw pixels
	 *  in 32-bit ARGB (Alpha, Red, Green, Blue) format
	 *  to a new PNG-encoded ByteArray object.
	 *  The original ByteArray is left unchanged.
     *
     *  @param byteArray The input ByteArray object containing raw pixels.
	 *  This ByteArray should contain
	 *  <code>4 * width * height</code> bytes.
	 *  Each pixel is represented by 4 bytes, in the order ARGB.
	 *  The first four bytes represent the top-left pixel of the image.
	 *  The next four bytes represent the pixel to its right, etc.
	 *  Each row follows the previous one without any padding.
     *
     *  @param width The width of the input image, in pixels.
     *
     *  @param height The height of the input image, in pixels.
     *
     *  @param transparent If <code>false</code>, alpha channel information
	 *  is ignored but you still must represent each pixel 
     *  as four bytes in ARGB format.
     *
     *  @return Returns a ByteArray object containing PNG-encoded image data.
		 */
		public function encodeByteArray (byteArray:ByteArray, width:int, height:int, transparent:Boolean = true) : ByteArray;

		/**
		 *  @private
		 */
		private function initializeCRCTable () : void;

		/**
		 *  @private
		 */
		private function internalEncode (source:Object, width:int, height:int, transparent:Boolean = true) : ByteArray;

		/**
		 *  @private
		 */
		private function writeChunk (png:ByteArray, type:uint, data:ByteArray) : void;
	}
}
