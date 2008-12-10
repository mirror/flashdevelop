package mx.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import mx.utils.NameUtil;

	/**
	 *  FlexBitmap is a subclass of the Player's Bitmap class. *  It overrides the <code>toString()</code> method *  to return a string indicating the location of the object *  within the hierarchy of DisplayObjects in the application.
	 */
	public class FlexBitmap extends Bitmap
	{
		/**
		 *  Constructor.	 *	 *  <p>Sets the <code>name</code> property to a string	 *  returned by the <code>createUniqueName()</code>	 *  method of the mx.utils.NameUtils class.	 *  This string is the name of the object's class concatenated	 *  with an integer that is unique within the application,	 *  such as <code>"FlexBitmap12"</code>.</p>	 *	 *  @param bitmapData The data for the bitmap. 	 *	 *  @param pixelSnapping Whether or not the bitmap is snapped	 *  to the nearest pixel.	 *	 *  @param smoothing Whether or not the bitmap is smoothed when scaled. 	 *	 *  @see flash.display.DisplayObject#name	 *  @see mx.utils.NameUtil#createUniqueName()
		 */
		public function FlexBitmap (bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false);
		/**
		 *  Returns a string indicating the location of this object	 *  within the hierarchy of DisplayObjects in the Application.	 *  This string, such as <code>"MyApp0.HBox5.FlexBitmap12"</code>,	 *  is built by the <code>displayObjectToString()</code> method	 *  of the mx.utils.NameUtils class from the <code>name</code>	 *  property of the object and its ancestors.	 *  	 *  @return A String indicating the location of this object	 *  within the DisplayObject hierarchy. 	 *	 *  @see flash.display.DisplayObject#name	 *  @see mx.utils.NameUtil#displayObjectToString()
		 */
		public function toString () : String;
	}
}
