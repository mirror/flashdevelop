package mx.graphics
{
	import flash.display.IBitmapDrawable;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.graphics.codec.IImageEncoder;
	import mx.graphics.codec.PNGEncoder;
	import mx.utils.Base64Encoder;

	/**
	 *  A helper class used to capture a snapshot of any Flash component  *  that implements <code>flash.display.IBitmapDrawable</code>, *  including Flex UIComponents. * *  <p>An instance of this class can be sent via RemoteObject *  to Adobe's LiveCycle Data Services in order to generate *  a PDF file of a client-side image. *  If you need to specify additional properties of the image *  beyond its <code>contentType</code>, <code>width</code>, *  and <code>height</code>, you should set name/value pairs *  on the <code>properties</code> object.</p> * *  <p>In earlier versions of Flex, you set these additional *  properties on the ImageSnapshot instance itself. *  This class is still dynamic in order to allow that, *  but in a future version of Flex it may no longer be dynamic.</p>
	 */
	public dynamic class ImageSnapshot
	{
		/**
		 *  The maximum width and height of a Bitmap.
		 */
		public static const MAX_BITMAP_DIMENSION : int = 2880;
		/**
		 *  The default <code>mx.graphics.codec.IImageEncoder</code> implementation     *  used to capture images. The two implementations are PNGEncoder and      *  JPEGEncoder. The default encoder uses the PNG format.
		 */
		public static var defaultEncoder : Class;
		/**
		 *  @private     *  Storage for the contentType property.
		 */
		private var _contentType : String;
		/**
		 *  @private     *  Storage for the data property.
		 */
		private var _data : ByteArray;
		/**
		 *  @private     *  Storage for the height property.
		 */
		private var _height : int;
		/**
		 *  @private     *  Storage for the properties property.
		 */
		private var _properties : Object;
		/**
		 *  @private     *  Storage for the width property.
		 */
		private var _width : int;

		/**
		 *  The MIME content type for the image encoding format     *  that was used to capture this snapshot. For PNG format     *  images, the MIME type is "image/png". For JPG or JPEG      *  images, the MIME type is "image/jpeg"
		 */
		public function get contentType () : String;
		/**
		 *  @private
		 */
		public function set contentType (value:String) : void;
		/**
		 *  The encoded data representing the image snapshot.
		 */
		public function get data () : ByteArray;
		/**
		 *  @private
		 */
		public function set data (value:ByteArray) : void;
		/**
		 *  The image height in pixels.
		 */
		public function get height () : int;
		/**
		 *  @private
		 */
		public function set height (value:int) : void;
		/**
		 *  An Object containing name/value pairs     *  specifying additional properties of the image.     *     *  <p>You generally supply such information     *  only when sending an ImageSnapshot instance     *  to Adobe's LiveCycle Data Services     *  in order to generate a PDF file.     *  You can either set the entire object     *  or set individual name/value pairs     *  on the pre-existing empty Object.</p>     *     *  @default {}
		 */
		public function get properties () : Object;
		/**
		 *  @private
		 */
		public function set properties (value:Object) : void;
		/**
		 * The image width in pixels.
		 */
		public function get width () : int;
		/**
		 *  @private
		 */
		public function set width (value:int) : void;

		/**
		 *  A utility method to grab a raw snapshot of a UI component as BitmapData.     *      *  @param source An object that implements the     *    <code>flash.display.IBitmapDrawable</code> interface.     *     *  @param matrix A Matrix object used to scale, rotate, or translate     *  the coordinates of the captured bitmap.     *  If you do not want to apply a matrix transformation to the image,     *  set this parameter to an identity matrix,     *  created with the default new Matrix() constructor, or pass a null value.     *     *  @param colorTransform A ColorTransform      *  object that you use to adjust the color values of the bitmap. If no object      *  is supplied, the bitmap image's colors are not transformed. If you must pass      *  this parameter but you do not want to transform the image, set this parameter      *  to a ColorTransform object created with the default new ColorTransform() constructor.     *     *  @param blendMode A string value, from the flash.display.BlendMode      *  class, specifying the blend mode to be applied to the resulting bitmap.     *     *  @param clipRect A Rectangle object that defines the      *  area of the source object to draw. If you do not supply this value, no clipping      *  occurs and the entire source object is drawn.     *     *  @param smoothing A Boolean value that determines whether a      *  BitmapData object is smoothed when scaled.     *     *  @return A BitmapData object representing the captured snapshot.
		 */
		public static function captureBitmapData (source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false) : BitmapData;
		/**
		 *  A utility method to grab a snapshot of a component, scaled to a specific     *  resolution (in dpi) and encoded into a specific image format.     *      *  @param source An object that implements the     *  <code>flash.display.IBitmapDrawable</code> interface.     *     *  @param dpi The resolution in dots per inch.     *  If a resolution is not provided,     *  the current on-screen resolution is used by default.     *     *  @param encoder The image format used to encode the raw bitmap. The two      *  encoders are PNGEncoder and JPEGEncoder. If an encoder is not provided,      *  the default is PNGEncoder.     *     *  @param scaleLimited The maximum width or height of a bitmap in Flash     *  is 2880 pixels - if scaleLimited is set to true the resolution will be     *  reduced proportionately to fit within 2880 pixels, otherwise, if     *  scaleLimited is false, smaller snapshot windows will be taken and     *  stitched together to capture a larger image.     *  The default is true.     *     *  @return An ImageSnapshot holding an encoded captured snapshot     *  and associated image metadata.
		 */
		public static function captureImage (source:IBitmapDrawable, dpi:Number = 0, encoder:IImageEncoder = null, scaleLimited:Boolean = true) : ImageSnapshot;
		/**
		 *  A utility method to convert an ImageSnapshot into a Base-64 encoded     *  String for transmission in text based serialization formats such as XML.     *     *  @param snapshot An image captured as an     *  <code>mx.graphics.ImageSnapshot</code>.     *     *  @return A string representing the base64 encoded snapshot.     *      *  @see #captureImage
		 */
		public static function encodeImageAsBase64 (snapshot:ImageSnapshot) : String;
		/**
		 *  @private     *  Attempts to capture as much of an image for the requested bounds by     *  splitting the scaled source into rectangular windows that fit inside     *  the maximum size of a single BitmapData instance,     *  i.e. 2880 x 2880 pixels, and stitching the windows together     *  into a larger bitmap with the raw pixels returned as a ByteArray.     *  This ByteArray is limited to around 256MB so scaled images with an area     *  equivalent to about 8192 x 8192 will result in out-of-memory errors.
		 */
		private static function captureAll (source:IBitmapDrawable, bounds:Rectangle, matrix:Matrix, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false) : ByteArray;
		/**
		 *  @private     *  Copies the rows of the right hand side of an image onto the ends of     *  the rows of the left hand side of an image. The left and right hand     *  sides must be of equal height.
		 */
		private static function mergePixelRows (left:ByteArray, leftWidth:int, right:ByteArray, rightWidth:int, rightHeight:int) : ByteArray;
		/**
		 *  @private     *  Prepare the target and its parents for image capture.
		 */
		private static function prepareToPrintObject (target:IUIComponent) : Array;
		/**
		 *  @private     *  Reverts the target and its parents back to a pre-capture state.
		 */
		private static function finishPrintObject (target:IUIComponent, normalStates:Array) : void;
		/**
		 *  Constructor.     *     *  @param width Width of the image.     *     *  @param height Height of the image.     *     *  @param data A byte array to contain the image.     *     *  @param contentType The encoder format type for the image,      *  either PNGEncoder or JPEGEncoder.
		 */
		public function ImageSnapshot (width:int = 0, height:int = 0, data:ByteArray = null, contentType:String = null);
	}
}
