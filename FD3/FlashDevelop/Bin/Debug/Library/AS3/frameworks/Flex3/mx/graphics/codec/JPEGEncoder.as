package mx.graphics.codec
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 *  The JPEGEncoder class converts raw bitmap images into encoded *  images using Joint Photographic Experts Group (JPEG) compression. * *  For information about the JPEG algorithm, see the document *  http://www.opennet.ru/docs/formats/jpeg.txt by Cristi Cuturicu.
	 */
	public class JPEGEncoder implements IImageEncoder
	{
		/**
		 *  @private
		 */
		private static const CONTENT_TYPE : String = "image/jpeg";
		/**
		 *  @private
		 */
		private const std_dc_luminance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_dc_luminance_values : Array = [];
		/**
		 *  @private
		 */
		private const std_dc_chrominance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_dc_chrominance_values : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_luminance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_luminance_values : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_chrominance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_chrominance_values : Array = [];
		/**
		 *  @private
		 */
		private const ZigZag : Array = [];
		/**
		 *  @private	 *  Initialized by initHuffmanTbl() in constructor.
		 */
		private var YDC_HT : Array;
		/**
		 *  @private	 *  Initialized by initHuffmanTbl() in constructor.
		 */
		private var UVDC_HT : Array;
		/**
		 *  @private	 *  Initialized by initHuffmanTbl() in constructor.
		 */
		private var YAC_HT : Array;
		/**
		 *  @private	 *  Initialized by initHuffmanTbl() in constructor.
		 */
		private var UVAC_HT : Array;
		/**
		 *  @private	 *  Initialized by initCategoryNumber() in constructor.
		 */
		private var category : Array;
		/**
		 *  @private	 *  Initialized by initCategoryNumber() in constructor.
		 */
		private var bitcode : Array;
		/**
		 *  @private	 *  Initialized by initQuantTables() in constructor.
		 */
		private var YTable : Array;
		/**
		 *  @private	 *  Initialized by initQuantTables() in constructor.
		 */
		private var UVTable : Array;
		/**
		 *  @private	 *  Initialized by initQuantTables() in constructor.
		 */
		private var fdtbl_Y : Array;
		/**
		 *  @private	 *  Initialized by initQuantTables() in constructor.
		 */
		private var fdtbl_UV : Array;
		/**
		 *  @private	 *  The output ByteArray containing the encoded image data.
		 */
		private var byteout : ByteArray;
		/**
		 *  @private
		 */
		private var bytenew : int;
		/**
		 *  @private
		 */
		private var bytepos : int;
		/**
		 *  @private
		 */
		private var DU : Array;
		/**
		 *  @private
		 */
		private var YDU : Array;
		/**
		 *  @private
		 */
		private var UDU : Array;
		/**
		 *  @private
		 */
		private var VDU : Array;

		/**
		 *  The MIME type for the JPEG encoded image.      *  The value is <code>"image/jpeg"</code>.
		 */
		public function get contentType () : String;

		/**
		 *  Constructor.     *     *  @param quality A value between 0.0 and 100.0.      *  The smaller the <code>quality</code> value,      *  the smaller the file size of the resultant image.      *  The value does not affect the encoding speed.     *. Note that even though this value is a number between 0.0 and 100.0,      *  it does not represent a percentage. 	 *  The default value is 50.0.
		 */
		public function JPEGEncoder (quality:Number = 50.0);
		/**
		 *  Converts the pixels of BitmapData object	 *  to a JPEG-encoded ByteArray object.     *     *  @param bitmapData The input BitmapData object.     *     *  @return Returns a ByteArray object containing JPEG-encoded image data.
		 */
		public function encode (bitmapData:BitmapData) : ByteArray;
		/**
		 *  Converts a ByteArray object containing raw pixels	 *  in 32-bit ARGB (Alpha, Red, Green, Blue) format	 *  to a new JPEG-encoded ByteArray object. 	 *  The original ByteArray is left unchanged.	 *  Transparency is not supported; however you still must represent	 *  each pixel as four bytes in ARGB format.     *     *  @param byteArray The input ByteArray object containing raw pixels.	 *  This ByteArray should contain	 *  <code>4 * width * height</code> bytes.	 *  Each pixel is represented by 4 bytes, in the order ARGB.	 *  The first four bytes represent the top-left pixel of the image.	 *  The next four bytes represent the pixel to its right, etc.	 *  Each row follows the previous one without any padding.     *     *  @param width The width of the input image, in pixels.     *     *  @param height The height of the input image, in pixels.     *     *  @param transparent If <code>false</code>,	 *  alpha channel information is ignored.     *     *  @return Returns a ByteArray object containing JPEG-encoded image data.
		 */
		public function encodeByteArray (byteArray:ByteArray, width:int, height:int, transparent:Boolean = true) : ByteArray;
		/**
		 *  @private	 *  Initializes the Huffman tables YDC_HT, UVDC_HT, YAC_HT, and UVAC_HT.
		 */
		private function initHuffmanTbl () : void;
		/**
		 *  @private
		 */
		private function computeHuffmanTbl (nrcodes:Array, std_table:Array) : Array;
		/**
		 *  @private	 *  Initializes the category and bitcode arrays.
		 */
		private function initCategoryNumber () : void;
		/**
		 *  @private	 *  Initializes YTable, UVTable, fdtbl_Y, and fdtbl_UV.
		 */
		private function initQuantTables (sf:int) : void;
		/**
		 *  @private
		 */
		private function internalEncode (source:Object, width:int, height:int, transparent:Boolean = true) : ByteArray;
		/**
		 *  @private
		 */
		private function RGB2YUV (sourceBitmapData:BitmapData, sourceByteArray:ByteArray, xpos:int, ypos:int, width:int, height:int) : void;
		/**
		 *  @private
		 */
		private function processDU (CDU:Array, fdtbl:Array, DC:Number, HTDC:Array, HTAC:Array) : Number;
		/**
		 *  @private
		 */
		private function fDCTQuant (data:Array, fdtbl:Array) : Array;
		/**
		 *  @private
		 */
		private function writeBits (bs:BitString) : void;
		/**
		 *  @private
		 */
		private function writeByte (value:int) : void;
		/**
		 *  @private
		 */
		private function writeWord (value:int) : void;
		/**
		 *  @private
		 */
		private function writeAPP0 () : void;
		/**
		 *  @private
		 */
		private function writeDQT () : void;
		/**
		 *  @private
		 */
		private function writeSOF0 (width:int, height:int) : void;
		/**
		 *  @private
		 */
		private function writeDHT () : void;
		/**
		 *  @private
		 */
		private function writeSOS () : void;
	}
	internal class BitString
	{
		/**
		 *  @private
		 */
		public var len : int;
		/**
		 *  @private
		 */
		public var val : int;

		/**
		 *  Constructor.
		 */
		public function BitString ();
	}
}
