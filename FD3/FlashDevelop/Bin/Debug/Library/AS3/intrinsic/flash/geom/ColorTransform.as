package flash.geom
{
	/// The ColorTransform class lets you adjust the color values in a display object.
	public class ColorTransform
	{
		/// A decimal value that is multiplied with the red channel value.
		public var redMultiplier:Number;

		/// A decimal value that is multiplied with the green channel value.
		public var greenMultiplier:Number;

		/// A decimal value that is multiplied with the blue channel value.
		public var blueMultiplier:Number;

		/// A decimal value that is multiplied with the alpha transparency channel value.
		public var alphaMultiplier:Number;

		/// A number from -255 to 255 that is added to the red channel value after it has been multiplied by the redMultiplier value.
		public var redOffset:Number;

		/// A number from -255 to 255 that is added to the green channel value after it has been multiplied by the greenMultiplier value.
		public var greenOffset:Number;

		/// A number from -255 to 255 that is added to the blue channel value after it has been multiplied by the blueMultiplier value.
		public var blueOffset:Number;

		/// A number from -255 to 255 that is added to the alpha transparency channel value after it has been multiplied by the alphaMultiplier value.
		public var alphaOffset:Number;

		/// The RGB color value for a ColorTransform object.
		public var color:uint;

		/// Creates a ColorTransform object for a display object.
		public function ColorTransform(redMultiplier:Number=1.0, greenMultiplier:Number=1.0, blueMultiplier:Number=1.0, alphaMultiplier:Number=1.0, redOffset:Number=0, greenOffset:Number=0, blueOffset:Number=0, alphaOffset:Number=0);

		/// Concatenates the ColorTranform object specified by the second parameter with the current ColorTransform object and sets the current object as the result, which is an additive combination of the two color transformations.
		public function concat(second:flash.geom.ColorTransform):void;

		/// Formats and returns a string that describes all of the properties of the ColorTransform object.
		public function toString():String;

	}

}

