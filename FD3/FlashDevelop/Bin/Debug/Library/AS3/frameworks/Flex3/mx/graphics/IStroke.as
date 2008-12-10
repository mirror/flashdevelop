package mx.graphics
{
	import flash.display.Graphics;

	/**
	 *  Defines the interface that classes that define a line must implement.
	 */
	public interface IStroke
	{
		/**
		 *  The line weight, in pixels.	 *  For many chart lines, the default value is 1 pixel.
		 */
		public function get weight () : Number;
		/**
		 *  @private
		 */
		public function set weight (value:Number) : void;

		/**
		 *  Applies the properties to the specified Graphics object.	 *   	 *  @param g The Graphics object to apply the properties to.
		 */
		public function apply (g:Graphics) : void;
	}
}
