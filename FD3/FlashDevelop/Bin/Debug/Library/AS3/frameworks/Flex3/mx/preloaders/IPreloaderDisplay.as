/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.preloaders {
	import flash.display.Sprite;
	public interface IPreloaderDisplay extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * Alpha level of the SWF file or image defined by
		 *  the backgroundImage property, or the color defined by
		 *  the backgroundColor property.
		 *  Valid values range from 0 to 1.0.
		 */
		public function get backgroundAlpha():Number;
		public function set backgroundAlpha(value:Number):void;
		/**
		 * Background color of a download progress bar.
		 *  You can have either a backgroundColor or a
		 *  backgroundImage, but not both.
		 */
		public function get backgroundColor():uint;
		public function set backgroundColor(value:uint):void;
		/**
		 * The background image of the application,
		 *  which is passed in by the preloader.
		 *  You can specify either a backgroundColor
		 *  or a backgroundImage, but not both.
		 */
		public function get backgroundImage():Object;
		public function set backgroundImage(value:Object):void;
		/**
		 * Scales the image specified by backgroundImage
		 *  to different percentage sizes.
		 *  A value of "100%" stretches the image
		 *  to fit the entire component.
		 *  To specify a percentage value, you must include the percent sign (%).
		 *  A value of "auto", maintains
		 *  the original size of the image.
		 */
		public function get backgroundSize():String;
		public function set backgroundSize(value:String):void;
		/**
		 * The Preloader class passes in a reference to itself to the display class
		 *  so that it can listen for events from the preloader.
		 */
		public function set preloader(value:Sprite):void;
		/**
		 * The height of the stage,
		 *  which is passed in by the Preloader class.
		 */
		public function get stageHeight():Number;
		public function set stageHeight(value:Number):void;
		/**
		 * The width of the stage,
		 *  which is passed in by the Preloader class.
		 */
		public function get stageWidth():Number;
		public function set stageWidth(value:Number):void;
		/**
		 * Called by the Preloader after the download progress bar
		 *  has been added as a child of the Preloader.
		 *  This should be the starting point for configuring your download progress bar.
		 */
		public function initialize():void;
	}
}
