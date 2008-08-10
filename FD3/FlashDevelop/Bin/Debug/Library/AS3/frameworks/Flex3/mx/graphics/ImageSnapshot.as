/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.utils.ByteArray;
	import flash.display.IBitmapDrawable;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import mx.graphics.codec.IImageEncoder;
	public dynamic  class ImageSnapshot {
		/**
		 * The MIME content type for the image encoding format
		 *  that was used to capture this snapshot. For PNG format
		 *  images, the MIME type is "image/png". For JPG or JPEG
		 *  images, the MIME type is "image/jpeg"
		 */
		public function get contentType():String;
		public function set contentType(value:String):void;
		/**
		 * The encoded data representing the image snapshot.
		 */
		public function get data():ByteArray;
		public function set data(value:ByteArray):void;
		/**
		 * The default mx.graphics.codec.IImageEncoder implementation
		 *  used to capture images. The two implementations are PNGEncoder and
		 *  JPEGEncoder. The default encoder uses the PNG format.
		 */
		public static var defaultEncoder:Class;
		/**
		 * The image height in pixels.
		 */
		public function get height():int;
		public function set height(value:int):void;
		/**
		 * An Object containing name/value pairs
		 *  specifying additional properties of the image.
		 */
		public function get properties():Object;
		public function set properties(value:Object):void;
		/**
		 * The image width in pixels.
		 */
		public function get width():int;
		public function set width(value:int):void;
		/**
		 * Constructor.
		 *
		 * @param width             <int (default = 0)> Width of the image.
		 * @param height            <int (default = 0)> Height of the image.
		 * @param data              <ByteArray (default = null)> A byte array to contain the image.
		 * @param contentType       <String (default = null)> The encoder format type for the image,
		 *                            either PNGEncoder or JPEGEncoder.
		 */
		public function ImageSnapshot(width:int = 0, height:int = 0, data:ByteArray = null, contentType:String = null);
		/**
		 * A utility method to grab a raw snapshot of a UI component as BitmapData.
		 *
		 * @param source            <IBitmapDrawable> An object that implements the
		 *                            flash.display.IBitmapDrawable interface.
		 * @param matrix            <Matrix (default = null)> A Matrix object used to scale, rotate, or translate
		 *                            the coordinates of the captured bitmap.
		 *                            If you do not want to apply a matrix transformation to the image,
		 *                            set this parameter to an identity matrix,
		 *                            created with the default new Matrix() constructor, or pass a null value.
		 * @param colorTransform    <ColorTransform (default = null)> A ColorTransform
		 *                            object that you use to adjust the color values of the bitmap. If no object
		 *                            is supplied, the bitmap image's colors are not transformed. If you must pass
		 *                            this parameter but you do not want to transform the image, set this parameter
		 *                            to a ColorTransform object created with the default new ColorTransform() constructor.
		 * @param blendMode         <String (default = null)> A string value, from the flash.display.BlendMode
		 *                            class, specifying the blend mode to be applied to the resulting bitmap.
		 * @param clipRect          <Rectangle (default = null)> A Rectangle object that defines the
		 *                            area of the source object to draw. If you do not supply this value, no clipping
		 *                            occurs and the entire source object is drawn.
		 * @param smoothing         <Boolean (default = false)> A Boolean value that determines whether a
		 *                            BitmapData object is smoothed when scaled.
		 * @return                  <BitmapData> A BitmapData object representing the captured snapshot.
		 */
		public static function captureBitmapData(source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):BitmapData;
		/**
		 * A utility method to grab a snapshot of a component, scaled to a specific
		 *  resolution (in dpi) and encoded into a specific image format.
		 *
		 * @param source            <IBitmapDrawable> An object that implements the
		 *                            flash.display.IBitmapDrawable interface.
		 * @param dpi               <Number (default = 0)> The resolution in dots per inch.
		 *                            If a resolution is not provided,
		 *                            the current on-screen resolution is used by default.
		 * @param encoder           <IImageEncoder (default = null)> The image format used to encode the raw bitmap. The two
		 *                            encoders are PNGEncoder and JPEGEncoder. If an encoder is not provided,
		 *                            the default is PNGEncoder.
		 * @param scaleLimited      <Boolean (default = true)> The maximum width or height of a bitmap in Flash
		 *                            is 2880 pixels - if scaleLimited is set to true the resolution will be
		 *                            reduced proportionately to fit within 2880 pixels, otherwise, if
		 *                            scaleLimited is false, smaller snapshot windows will be taken and
		 *                            stitched together to capture a larger image.
		 *                            The default is true.
		 * @return                  <ImageSnapshot> An ImageSnapshot holding an encoded captured snapshot
		 *                            and associated image metadata.
		 */
		public static function captureImage(source:IBitmapDrawable, dpi:Number = 0, encoder:IImageEncoder = null, scaleLimited:Boolean = true):ImageSnapshot;
		/**
		 * A utility method to convert an ImageSnapshot into a Base-64 encoded
		 *  String for transmission in text based serialization formats such as XML.
		 *
		 * @param snapshot          <ImageSnapshot> An image captured as an
		 *                            mx.graphics.ImageSnapshot.
		 * @return                  <String> A string representing the base64 encoded snapshot.
		 */
		public static function encodeImageAsBase64(snapshot:ImageSnapshot):String;
		/**
		 * The maximum width and height of a Bitmap.
		 */
		public static const MAX_BITMAP_DIMENSION:int = 2880;
	}
}
