/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.filters.BitmapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	public class BitmapData implements IBitmapDrawable {
		/**
		 * The height of the bitmap image in pixels.
		 */
		public function get height():int;
		/**
		 * The rectangle that defines the size and location of the bitmap image. The top and left of the
		 *  rectangle are 0; the width and height are equal to the width and height in pixels of the
		 *  BitmapData object.
		 */
		public function get rect():Rectangle;
		/**
		 * Defines whether the bitmap image supports per-pixel transparency. You can set this value only when you construct
		 *  a BitmapData object by passing in true for the transparent parameter of the constructor. Then, after you create
		 *  a BitmapData object, you can check whether it supports per-pixel transparency by determining if the value of the
		 *  transparent property is true.
		 */
		public function get transparent():Boolean;
		/**
		 * The width of the bitmap image in pixels.
		 */
		public function get width():int;
		/**
		 * Creates a  BitmapData object with a specified width and height.
		 *  If you specify a value for the  fillColor parameter, every pixel in the bitmap is set
		 *  to that color.
		 *
		 * @param width             <int> The width of the bitmap image in pixels.
		 * @param height            <int> The height of the bitmap image in pixels.
		 * @param transparent       <Boolean (default = true)> Specifies whether the bitmap image  supports per-pixel transparency.
		 *                            The default value is true (transparent). To create a fully transparent bitmap, set the value
		 *                            of the transparent parameter to true and the value of the fillColor
		 *                            parameter to 0x00000000 (or to 0). Setting the transparent property to false
		 *                            can result in minor improvements in rendering performance.
		 * @param fillColor         <uint (default = 0xFFFFFFFF)> A 32-bit ARGB color value that you use to fill the bitmap image area.
		 *                            The default value is 0xFFFFFFFF (solid white).
		 */
		public function BitmapData(width:int, height:int, transparent:Boolean = true, fillColor:uint = 0xFFFFFFFF);
		/**
		 * Takes a source image and a filter object and generates the
		 *  filtered image.
		 *
		 * @param sourceBitmapData  <BitmapData> The input bitmap image to use. The source image can be a different
		 *                            BitmapData object or it can refer to the current BitmapData instance.
		 * @param sourceRect        <Rectangle> A rectangle that defines the area of the source image to use as input.
		 * @param destPoint         <Point> The point within the destination image (the current BitmapData
		 *                            instance) that corresponds to the upper-left corner of the source rectangle.
		 * @param filter            <BitmapFilter> The filter object that you use to perform the filtering operation. Each type
		 *                            of filter has certain requirements, as follows:
		 *                            BlurFilter -
		 *                            This filter can use source and destination images
		 *                            that are either opaque or transparent. If the formats of the images do
		 *                            not match, the copy of the source image that is made during the
		 *                            filtering matches the format of the destination image.
		 *                            BevelFilter, DropShadowFilter, GlowFilter, ChromeFilter -
		 *                            The destination image of these filters must be a transparent
		 *                            image. Calling DropShadowFilter or GlowFilter creates an image that
		 *                            contains the alpha channel data of the drop shadow or glow. It does not
		 *                            create the drop shadow onto the destination image. If you use any of these
		 *                            filters with an opaque destination image, an exception
		 *                            is thrown.
		 *                            ConvolutionFilter - This filter can use source and
		 *                            destination images that are either opaque or transparent.
		 *                            ColorMatrixFilter - This filter can use source and
		 *                            destination images that are either opaque or transparent.
		 *                            DisplacementMapFilter - This filter can use source and
		 *                            destination images that are either opaque or transparent, but the
		 *                            source and destination image formats must be the same.
		 */
		public function applyFilter(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, filter:BitmapFilter):void;
		/**
		 * Returns a new BitmapData object that is a clone of the original instance
		 *  with an exact copy of the contained bitmap.
		 *
		 * @return                  <BitmapData> A new BitmapData object that is identical to the original.
		 */
		public function clone():BitmapData;
		/**
		 * Adjusts the color values in a specified area of a bitmap image by using a
		 *  ColorTransform object. If the rectangle
		 *  matches the boundaries of the bitmap image, this method transforms the color values of
		 *  the entire image.
		 *
		 * @param rect              <Rectangle> A Rectangle object that defines the area of the image in which the
		 *                            ColorTransform object is applied.
		 * @param colorTransform    <ColorTransform> A ColorTransform object that describes the color transformation
		 *                            values to apply.
		 */
		public function colorTransform(rect:Rectangle, colorTransform:ColorTransform):void;
		/**
		 * Compares two BitmapData objects. If the two BitmapData objects have the same dimensions
		 *  (width and height), the method returns a new BitmapData object, in which each pixel is
		 *  the "difference" between the pixels in the two source objects:
		 *  If two pixels are equal, the difference pixel is 0x00000000.
		 *  If two pixels have different RGB values (ignoring the alpha value), the difference
		 *  pixel is 0xRRGGBB where RR/GG/BB are the individual difference values between red, green,
		 *  and blue channels (the pixel value in the source object minus the pixel value in the
		 *  otherBitmapData object). Alpha channel differences are ignored in this case.
		 *  If only the alpha channel value is different, the pixel value is 0xZZFFFFFF,
		 *  where ZZ is the difference in the alpha values (the alpha value in the source object
		 *  minus the alpha value in the otherBitmapData object).
		 *
		 * @param otherBitmapData   <BitmapData> The BitmapData object to compare with the source BitmapData object.
		 * @return                  <Object> If the two BitmapData objects have the same dimensions (width and height), the
		 *                            method returns a new BitmapData object that has the difference between the two objects (see the
		 *                            main discussion). If the BitmapData objects are equivalent, the method returns the number 0.
		 *                            If the widths of the BitmapData objects are not equal, the method returns the number -3.
		 *                            If the heights of the BitmapData objects are not equal, the method returns the number -4.
		 */
		public function compare(otherBitmapData:BitmapData):Object;
		/**
		 * Transfers data from one channel of another BitmapData object or the current
		 *  BitmapData object into a channel of the current BitmapData object.
		 *  All of the data in the other channels in the destination BitmapData object are
		 *  preserved.
		 *
		 * @param sourceBitmapData  <BitmapData> The input bitmap image to use. The source image can be a different BitmapData object
		 *                            or it can refer to the current BitmapData object.
		 * @param sourceRect        <Rectangle> The source Rectangle object. To copy only channel data from a smaller area
		 *                            within the bitmap, specify a source rectangle that is smaller than the overall size of the
		 *                            BitmapData object.
		 * @param destPoint         <Point> The destination Point object that represents the upper-left corner of the rectangular area
		 *                            where the new channel data is placed.
		 *                            To copy only channel data
		 *                            from one area to a different area in the destination image, specify a point other than (0,0).
		 * @param sourceChannel     <uint> The source channel. Use a value from the BitmapDataChannel class
		 *                            (BitmapDataChannel.RED, BitmapDataChannel.BLUE,
		 *                            BitmapDataChannel.GREEN, BitmapDataChannel.ALPHA).
		 * @param destChannel       <uint> The destination channel. Use a value from the BitmapDataChannel class
		 *                            (BitmapDataChannel.RED, BitmapDataChannel.BLUE,
		 *                            BitmapDataChannel.GREEN, BitmapDataChannel.ALPHA).
		 */
		public function copyChannel(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, sourceChannel:uint, destChannel:uint):void;
		/**
		 * Provides a fast routine to perform pixel manipulation
		 *  between images with no stretching, rotation, or color effects. This method copies a
		 *  rectangular area of a source image to a
		 *  rectangular area of the same size at the destination point of the destination
		 *  BitmapData object.
		 *
		 * @param sourceBitmapData  <BitmapData> The input bitmap image from which to copy pixels. The source image can be a
		 *                            different BitmapData instance, or it can refer to the current BitmapData
		 *                            instance.
		 * @param sourceRect        <Rectangle> A rectangle that defines the area of the source image to use as input.
		 * @param destPoint         <Point> The destination point that represents the upper-left corner of the rectangular
		 *                            area where the new pixels are placed.
		 * @param alphaBitmapData   <BitmapData (default = null)> A secondary, alpha BitmapData object source.
		 * @param alphaPoint        <Point (default = null)> The point in the alpha BitmapData object source that corresponds to
		 *                            the upper-left corner of the sourceRect parameter.
		 * @param mergeAlpha        <Boolean (default = false)> To use the alpha channel, set the value to
		 *                            true. To copy pixels with no alpha channel, set the value to
		 *                            false.
		 */
		public function copyPixels(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, alphaBitmapData:BitmapData = null, alphaPoint:Point = null, mergeAlpha:Boolean = false):void;
		/**
		 * Frees memory that is used to store the BitmapData object.
		 */
		public function dispose():void;
		/**
		 * Draws the source display object onto the bitmap image, using the
		 *  Flash Player or  AIR vector renderer.
		 *  Flash Player or  AIR vector renderer.
		 *  You can specify matrix, colorTransform,
		 *  blendMode, and a destination clipRect parameter to control
		 *  how the rendering performs. Optionally, you can specify whether the bitmap
		 *  should be smoothed when scaled (this works only if the source object
		 *  is a BitmapData object).
		 *
		 * @param source            <IBitmapDrawable> The display object or BitmapData object to draw to the BitmapData object.
		 *                            (The DisplayObject and BitmapData classes implement the IBitmapDrawable interface.)
		 * @param matrix            <Matrix (default = null)> A Matrix object used to scale, rotate, or translate the coordinates
		 *                            of the bitmap. If you do not want to apply a matrix transformation to the image,
		 *                            set this parameter to an identity matrix, created with the default
		 *                            new Matrix() constructor, or pass a null value.
		 * @param colorTransform    <ColorTransform (default = null)> A ColorTransform object that you use to adjust the color values of
		 *                            the bitmap. If no object is supplied, the bitmap image's colors are not transformed.
		 *                            If you must pass this parameter but you do not want to transform the image, set this
		 *                            parameter to a ColorTransform object created with the default new ColorTransform()
		 *                            constructor.
		 * @param blendMode         <String (default = null)> A string value, from the flash.display.BlendMode class, specifying the
		 *                            blend mode to be applied to the resulting bitmap.
		 * @param clipRect          <Rectangle (default = null)> A Rectangle object that defines the area of the source object to draw.
		 *                            If you do not supply this value, no clipping occurs and the entire source object is drawn.
		 * @param smoothing         <Boolean (default = false)> A Boolean value that determines whether a BitmapData object is
		 *                            smoothed when scaled or rotated, due to a scaling or rotation in the matrix
		 *                            parameter. The smoothing parameter only applies if the source
		 *                            parameter is a BitmapData object. With smoothing set to false,
		 *                            the rotated or scaled BitmapData image can appear pixelated or jagged. For example, the following
		 *                            two images use the same BitmapData object for the source parameter, but the
		 *                            smoothing parameter is set to true on the left and false
		 *                            on the right:
		 *                            Drawing a bitmap with smoothing set to true takes longer
		 *                            than doing so with smoothing set to false.
		 */
		public function draw(source:IBitmapDrawable, matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void;
		/**
		 * Fills a rectangular area of pixels with a specified ARGB color.
		 *
		 * @param rect              <Rectangle> The rectangular area to fill.
		 * @param color             <uint> The ARGB color value that fills the area. ARGB colors are often
		 *                            specified in hexadecimal format; for example, 0xFF336699.
		 */
		public function fillRect(rect:Rectangle, color:uint):void;
		/**
		 * Performs a flood fill operation on an image starting
		 *  at an (x, y) coordinate and filling with a certain color. The
		 *  floodFill() method is similar to the paint bucket tool in various paint
		 *  programs. The color is an ARGB color that contains alpha information and
		 *  color information.
		 *
		 * @param x                 <int> The x coordinate of the image.
		 * @param y                 <int> The y coordinate of the image.
		 * @param color             <uint> The ARGB color to use as a fill.
		 */
		public function floodFill(x:int, y:int, color:uint):void;
		/**
		 * Determines the destination rectangle that the applyFilter() method call affects, given a
		 *  BitmapData object, a source rectangle, and a filter object.
		 *
		 * @param sourceRect        <Rectangle> A rectangle defining the area of the source image to use as input.
		 * @param filter            <BitmapFilter> A filter object that you use to calculate the destination rectangle.
		 * @return                  <Rectangle> A destination rectangle computed by using an image, the sourceRect parameter,
		 *                            and a filter.
		 */
		public function generateFilterRect(sourceRect:Rectangle, filter:BitmapFilter):Rectangle;
		/**
		 * Determines a rectangular region that either fully encloses all pixels of a specified color within the
		 *  bitmap image (if the findColor parameter is set to true) or fully encloses
		 *  all pixels that do not include the specified color (if the findColor parameter is set
		 *  to false).
		 *
		 * @param mask              <uint> A hexadecimal value, specifying the bits of the ARGB color to consider. The color
		 *                            value is combined with this hexadecimal value, by using the & (bitwise AND) operator.
		 * @param color             <uint> A hexadecimal value, specifying the ARGB color to match (if findColor
		 *                            is set to true) or not to match (if findColor
		 *                            is set to false).
		 * @param findColor         <Boolean (default = true)> If the value is set to true, returns the bounds of a color value in an image.
		 *                            If the value is set to false, returns the bounds of where this color doesn't exist in an image.
		 * @return                  <Rectangle> The region of the image that is the specified color.
		 */
		public function getColorBoundsRect(mask:uint, color:uint, findColor:Boolean = true):Rectangle;
		/**
		 * Returns an integer that represents  an RGB pixel value from a BitmapData object at
		 *  a specific point (x, y). The getPixel() method returns an
		 *  unmultiplied pixel value. No alpha information is returned.
		 *
		 * @param x                 <int> The x position of the pixel.
		 * @param y                 <int> The y position of the pixel.
		 * @return                  <uint> A number that represents an RGB pixel value. If the (x, y) coordinates are
		 *                            outside the bounds of the image, the method returns 0.
		 */
		public function getPixel(x:int, y:int):uint;
		/**
		 * Returns an ARGB color value that contains alpha channel data and RGB
		 *  data. This method is similar to the getPixel() method, which returns an
		 *  RGB color without alpha channel data.
		 *
		 * @param x                 <int> The x position of the pixel.
		 * @param y                 <int> The y position of the pixel.
		 * @return                  <uint> A number representing an ARGB pixel value. If the (x, y) coordinates are
		 *                            outside the bounds of the image, 0 is returned.
		 */
		public function getPixel32(x:int, y:int):uint;
		/**
		 * Generates a byte array from a rectangular region of pixel data.
		 *  Writes an unsigned integer (a 32-bit unmultiplied pixel value)
		 *  for each pixel into the byte array.
		 *
		 * @param rect              <Rectangle> A rectangular area in the current BitmapData object.
		 * @return                  <ByteArray> A ByteArray representing the pixels in the given Rectangle.
		 */
		public function getPixels(rect:Rectangle):ByteArray;
		/**
		 * Performs pixel-level hit detection between one bitmap image
		 *  and a point, rectangle, or other bitmap image. No stretching,
		 *  rotation, or other transformation of either object is considered when
		 *  the hit test is performed.
		 *
		 * @param firstPoint        <Point> A position of the upper-left corner of the BitmapData image in an arbitrary coordinate space.
		 *                            The same coordinate space is used in defining the secondBitmapPoint parameter.
		 * @param firstAlphaThreshold<uint> The highest alpha channel value that is considered opaque for this hit test.
		 * @param secondObject      <Object> A  Rectangle, Point, Bitmap, or BitmapData object.
		 * @param secondBitmapDataPoint<Point (default = null)> A point that defines a pixel location in the second BitmapData object.
		 *                            Use this parameter only when the value of secondObject is a
		 *                            BitmapData object.
		 * @param secondAlphaThreshold<uint (default = 1)> The highest alpha channel value that is considered opaque in the second BitmapData object.
		 *                            Use this parameter only when the value of secondObject is a
		 *                            BitmapData object and both BitmapData objects are transparent.
		 * @return                  <Boolean> A value of true if a hit occurs; otherwise, false.
		 */
		public function hitTest(firstPoint:Point, firstAlphaThreshold:uint, secondObject:Object, secondBitmapDataPoint:Point = null, secondAlphaThreshold:uint = 1):Boolean;
		/**
		 * Locks an image so that any objects that reference the BitmapData object, such as Bitmap objects,
		 *  are not updated when this BitmapData object changes. To improve performance, use this method
		 *  along with the unlock() method before and after numerous calls to the
		 *  setPixel() or setPixel32() method.
		 */
		public function lock():void;
		/**
		 * Performs per-channel blending from a source image to a destination image. For each channel
		 *  and each pixel, a new value is computed based on the channel values of the source and destination
		 *  pixels.
		 *
		 * @param sourceBitmapData  <BitmapData> The input bitmap image to use. The source image can be a different
		 *                            BitmapData object, or it can refer to the current BitmapData object.
		 * @param sourceRect        <Rectangle> A rectangle that defines the area of the source image to use as input.
		 * @param destPoint         <Point> The point within the destination image (the current BitmapData
		 *                            instance) that corresponds to the upper-left corner of the source rectangle.
		 * @param redMultiplier     <uint> A hexadecimal uint value by which to multiply the red channel value.
		 * @param greenMultiplier   <uint> A hexadecimal uint value by which to multiply the green channel value.
		 * @param blueMultiplier    <uint> A hexadecimal uint value by which to multiply the blue channel value.
		 * @param alphaMultiplier   <uint> A hexadecimal uint value by which to multiply the alpha transparency value.
		 */
		public function merge(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redMultiplier:uint, greenMultiplier:uint, blueMultiplier:uint, alphaMultiplier:uint):void;
		/**
		 * Fills an image with pixels representing random noise.
		 *
		 * @param randomSeed        <int> The random seed number to use. If you keep all other parameters
		 *                            the same, you can generate different pseudo-random results by varying the random seed value. The noise
		 *                            function is a mapping function, not a true random-number generation function, so it creates the same
		 *                            results each time from the same random seed.
		 * @param low               <uint (default = 0)> The lowest value to generate for each channel (0 to 255).
		 * @param high              <uint (default = 255)> The highest value to generate for each channel (0 to 255).
		 * @param channelOptions    <uint (default = 7)> A number that can be a combination of any of
		 *                            the four color channel values (BitmapDataChannel.RED,
		 *                            BitmapDataChannel.BLUE, BitmapDataChannel.GREEN, and
		 *                            BitmapDataChannel.ALPHA). You can use the logical OR
		 *                            operator (|) to combine channel values.
		 * @param grayScale         <Boolean (default = false)> A Boolean value. If the value is true, a grayscale image is created by setting
		 *                            all of the color channels to the same value.
		 *                            The alpha channel selection is not affected by
		 *                            setting this parameter to true.
		 */
		public function noise(randomSeed:int, low:uint = 0, high:uint = 255, channelOptions:uint = 7, grayScale:Boolean = false):void;
		/**
		 * Remaps the color channel values in an image that has up to four arrays of color palette data, one
		 *  for each channel.
		 *
		 * @param sourceBitmapData  <BitmapData> The input bitmap image to use. The source image can be a different
		 *                            BitmapData object, or it can refer to the current BitmapData instance.
		 * @param sourceRect        <Rectangle> A rectangle that defines the area of the source image to use as input.
		 * @param destPoint         <Point> The point within the destination image (the current BitmapData
		 *                            object) that corresponds to the upper-left corner of the source rectangle.
		 * @param redArray          <Array (default = null)> If redArray is not null, red = redArray[source red value]
		 *                            else red = source rect value.
		 * @param greenArray        <Array (default = null)> If greenArray is not null, green = greenArray[source
		 *                            green value] else green = source green value.
		 * @param blueArray         <Array (default = null)> If blueArray is not null, blue = blueArray[source blue
		 *                            value] else blue = source blue value.
		 * @param alphaArray        <Array (default = null)> If alphaArray is not null, alpha = alphaArray[source
		 *                            alpha value] else alpha = source alpha value.
		 */
		public function paletteMap(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, redArray:Array = null, greenArray:Array = null, blueArray:Array = null, alphaArray:Array = null):void;
		/**
		 * Generates a Perlin noise image.
		 *
		 * @param baseX             <Number> Frequency to use in the x direction. For example, to generate a noise that
		 *                            is sized for a 64 x 128 image, pass 64 for the baseX value.
		 * @param baseY             <Number> Frequency to use in the y direction. For example, to generate a noise that
		 *                            is sized for a 64 x 128 image, pass 128 for the baseY value.
		 * @param numOctaves        <uint> Number of octaves or individual noise functions to combine to create this noise. Larger numbers of octaves create
		 *                            images with greater detail. Larger numbers of octaves also require more processing time.
		 * @param randomSeed        <int> The random seed number to use. If you keep all other parameters the same, you can generate different
		 *                            pseudo-random results by varying the random seed value. The Perlin noise function is a mapping function, not a
		 *                            true random-number generation function, so it creates the same results each time from the same random seed.
		 * @param stitch            <Boolean> A Boolean value. If the value is true, the method attempts to smooth the transition edges of the image to create seamless textures for
		 *                            tiling as a bitmap fill.
		 * @param fractalNoise      <Boolean> A Boolean value. If the value is true, the method generates fractal noise; otherwise,
		 *                            it generates turbulence. An image with turbulence has visible discontinuities in the gradient
		 *                            that can make it better approximate sharper visual effects like flames and ocean waves.
		 * @param channelOptions    <uint (default = 7)> A number that can be a combination of any of
		 *                            the four color channel values (BitmapDataChannel.RED,
		 *                            BitmapDataChannel.BLUE, BitmapDataChannel.GREEN, and
		 *                            BitmapDataChannel.ALPHA). You can use the logical OR
		 *                            operator (|) to combine channel values.
		 * @param grayScale         <Boolean (default = false)> A Boolean value. If the value is true, a grayscale image is created by setting
		 *                            each of the red, green, and blue color channels to
		 *                            identical values. The alpha channel value is not affected if this value is
		 *                            set to true.
		 * @param offsets           <Array (default = null)> An array of points that correspond to x and y offsets for each octave.
		 *                            By manipulating the offset values you can smoothly scroll the layers of a perlinNoise image.
		 *                            Each point in the offset array affects a specific octave noise function.
		 */
		public function perlinNoise(baseX:Number, baseY:Number, numOctaves:uint, randomSeed:int, stitch:Boolean, fractalNoise:Boolean, channelOptions:uint = 7, grayScale:Boolean = false, offsets:Array = null):void;
		/**
		 * Performs a pixel dissolve either from a source image to a destination image or by using the same image.
		 *  Flash Player or AIR uses a randomSeed value
		 *  to generate a random pixel dissolve. The return value
		 *  of the function must be passed in on subsequent calls to
		 *  continue the pixel dissolve until it is finished.
		 *
		 * @param sourceBitmapData  <BitmapData> The input bitmap image to use. The source image can be a different
		 *                            BitmapData object, or it can refer to the current BitmapData instance.
		 * @param sourceRect        <Rectangle> A rectangle that defines the area of the source image to use as input.
		 * @param destPoint         <Point> The point within the destination image (the current BitmapData
		 *                            instance) that corresponds to the upper-left corner of the source rectangle.
		 * @param randomSeed        <int (default = 0)> The random seed to use to start the pixel dissolve.
		 * @param numPixels         <int (default = 0)> The default is 1/30 of the source area (width x height).
		 * @param fillColor         <uint (default = 0)> An ARGB color value that you use to fill pixels whose
		 *                            source value equals its destination value.
		 * @return                  <int> The new random seed value to use for subsequent calls.
		 */
		public function pixelDissolve(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, randomSeed:int = 0, numPixels:int = 0, fillColor:uint = 0):int;
		/**
		 * Scrolls an image by a certain (x, y) pixel amount. Edge
		 *  regions outside the scrolling area are left unchanged.
		 *
		 * @param x                 <int> The amount by which to scroll horizontally.
		 * @param y                 <int> The amount by which to scroll vertically.
		 */
		public function scroll(x:int, y:int):void;
		/**
		 * Sets a single pixel of a BitmapData object. The current
		 *  alpha channel value of the image pixel is preserved during this
		 *  operation. The value of the RGB color parameter is treated as an unmultiplied color value.
		 *
		 * @param x                 <int> The x position of the pixel whose value changes.
		 * @param y                 <int> The y position of the pixel whose value changes.
		 * @param color             <uint> The resulting RGB color for the pixel.
		 */
		public function setPixel(x:int, y:int, color:uint):void;
		/**
		 * Sets the color and alpha transparency values of a single pixel of a BitmapData
		 *  object. This method is similar to the setPixel() method; the main difference is
		 *  that the setPixel32() method takes an
		 *  ARGB color value that contains alpha channel information.
		 *
		 * @param x                 <int> The x position of the pixel whose value changes.
		 * @param y                 <int> The y position of the pixel whose value changes.
		 * @param color             <uint> The resulting ARGB color for the pixel. If the bitmap is opaque
		 *                            (not transparent), the alpha transparency portion of this color value is ignored.
		 */
		public function setPixel32(x:int, y:int, color:uint):void;
		/**
		 * Converts a byte array into a rectangular region of pixel data. For each
		 *  pixel, the ByteArray.readUnsignedInt() method is called and the return value is
		 *  written into the pixel.  If the byte array ends before the full rectangle
		 *  is written, the function returns.  The data in the byte array is
		 *  expected to be 32-bit ARGB pixel values. No seeking is performed
		 *  on the byte array before or after the pixels are read.
		 *
		 * @param rect              <Rectangle> Specifies the rectangular region of the BitmapData object.
		 * @param inputByteArray    <ByteArray> A ByteArray object that consists of 32-bit unmultiplied pixel values
		 *                            to be used in the rectangular region.
		 */
		public function setPixels(rect:Rectangle, inputByteArray:ByteArray):void;
		/**
		 * Tests pixel values in an image against a specified threshold and sets pixels that pass the test to new color values.
		 *  Using the threshold() method, you can isolate and replace color ranges in an image and perform other
		 *  logical operations on image pixels.
		 *
		 * @param sourceBitmapData  <BitmapData> The input bitmap image to use. The source image can be a different
		 *                            BitmapData object or it can refer to the current BitmapData instance.
		 * @param sourceRect        <Rectangle> A rectangle that defines the area of the source image to use as input.
		 * @param destPoint         <Point> The point within the destination image (the current BitmapData
		 *                            instance) that corresponds to the upper-left corner of the source rectangle.
		 * @param operation         <String> One of the following comparison operators, passed as a String: "<", "<=", ">", ">=", "==", "!="
		 * @param threshold         <uint> The value that each pixel is tested against to see if it meets or exceeds the threshhold.
		 * @param color             <uint (default = 0)> The color value that a pixel is set to if the threshold test succeeds. The default value is 0x00000000.
		 * @param mask              <uint (default = 0xFFFFFFFF)> The mask to use to isolate a color component.
		 * @param copySource        <Boolean (default = false)> If the value is true, pixel values from the source image are copied to the destination
		 *                            when the threshold test fails. If the value is false, the source image is not copied when the
		 *                            threshold test fails.
		 * @return                  <uint> The number of pixels that were changed.
		 */
		public function threshold(sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, operation:String, threshold:uint, color:uint = 0, mask:uint = 0xFFFFFFFF, copySource:Boolean = false):uint;
		/**
		 * Unlocks an image so that any objects that reference the BitmapData object, such as Bitmap objects,
		 *  are updated when this BitmapData object changes. To improve performance, use this method
		 *  along with the lock() method before and after numerous calls to the
		 *  setPixel() or setPixel32() method.
		 *
		 * @param changeRect        <Rectangle (default = null)> The area of the BitmapData object that has changed. If you do not specify a value for
		 *                            this parameter, the entire area of the BitmapData object is considered
		 *                            changed.
		 */
		public function unlock(changeRect:Rectangle = null):void;
	}
}
