package mx.core
{
	import flash.geom.Rectangle;

	/**
	 *  The IRectangularBorder interface defines the interface that all classes  *  used for rectangular border skins should implement. *
	 */
	public interface IRectangularBorder extends IBorder
	{
		/**
		 *  @copy mx.skins.RectangularBorder#backgroundImageBounds
		 */
		public function get backgroundImageBounds () : Rectangle;
		public function set backgroundImageBounds (value:Rectangle) : void;
		/**
		 *  @copy mx.skins.RectangularBorder#hasBackgroundImage
		 */
		public function get hasBackgroundImage () : Boolean;

		/**
		 *  @copy mx.skins.RectangularBorder#layoutBackgroundImage()
		 */
		public function layoutBackgroundImage () : void;
	}
}
