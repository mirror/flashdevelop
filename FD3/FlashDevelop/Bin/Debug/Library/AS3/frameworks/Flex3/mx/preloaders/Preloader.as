/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.preloaders {
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	public class Preloader extends Sprite {
		/**
		 * Constructor
		 */
		public function Preloader();
		/**
		 * Called by the SystemManager to initialize a Preloader object.
		 *
		 * @param showDisplay       <Boolean> Determines if the display class should be displayed.
		 * @param displayClassName  <Class> The IPreloaderDisplay class to use
		 *                            for displaying the preloader status.
		 * @param backgroundColor   <uint> Background color of the application.
		 * @param backgroundAlpha   <Number> Background alpha of the application.
		 * @param backgroundImage   <Object> Background image of the application.
		 * @param backgroundSize    <String> Background size of the application.
		 * @param displayWidth      <Number> Width of the application.
		 * @param displayHeight     <Number> Height of the application.
		 * @param libs              <Array (default = null)> Array of string URLs for the runtime shared libraries.
		 * @param sizes             <Array (default = null)> Array of uint values containing the byte size for each URL
		 *                            in the libs argument
		 * @param rslList           <Array (default = null)> Array of object of type RSLItem and CdRSLItem.
		 *                            This array describes all the RSLs to load.
		 *                            The libs and sizes parameters are ignored and must be set to null.
		 * @param resourceModuleURLs<Array (default = null)> Array of Strings specifying URLs
		 *                            from which to preload resource modules.
		 */
		public function initialize(showDisplay:Boolean, displayClassName:Class, backgroundColor:uint, backgroundAlpha:Number, backgroundImage:Object, backgroundSize:String, displayWidth:Number, displayHeight:Number, libs:Array = null, sizes:Array = null, rslList:Array = null, resourceModuleURLs:Array = null):void;
		/**
		 * Called by the SystemManager after it has finished instantiating
		 *  an instance of the application class. Flex calls this method; you
		 *  do not call it yourself.
		 *
		 * @param app               <IEventDispatcher> The application object.
		 */
		public function registerApplication(app:IEventDispatcher):void;
	}
}
