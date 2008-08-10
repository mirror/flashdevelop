/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.html {
	import flash.geom.Rectangle;
	public class HTMLHost {
		/**
		 * The HTMLLoader object to which this HostControl object applies. The htmlHost
		 *  property of that HTMLLoader object is set to this HostControl object.
		 */
		public function get htmlLoader():HTMLLoader;
		/**
		 * The property that is changed when JavaScript code in the HTMLLoader object calls
		 *  the window.moveBy(), window.moveTo(),
		 *  window.resizeBy(), or window.resizeTo() method.
		 */
		public function get windowRect():Rectangle;
		public function set windowRect(value:Rectangle):void;
		/**
		 * Creates an HTMLHost object.
		 *
		 * @param defaultBehaviors  <Boolean (default = true)> Indicates wether root-content behaviors should be provided by default.
		 */
		public function HTMLHost(defaultBehaviors:Boolean = true);
		/**
		 * The function called when JavaScript code in the HTMLLoader object calls the
		 *  window.open() method.
		 *
		 * @param windowCreateOptions<HTMLWindowCreateOptions> An object containing properties in the string passed as the
		 *                            features parameter of the call to window.open().
		 * @return                  <HTMLLoader> An HTMLLoader object that contains the new HTML page. Typically,
		 *                            you create a new HTMLLoader object in this method, add it to the stage of a new
		 *                            NativeWindow object, and then return it.
		 */
		public function createWindow(windowCreateOptions:HTMLWindowCreateOptions):HTMLLoader;
		/**
		 * The function called when JavaScript code in the HTMLLoader object sets the
		 *  window.location property.
		 *
		 * @param locationURL       <String> The value to which the location property
		 *                            of the window property of the HTMLLoader object is set.
		 */
		public function updateLocation(locationURL:String):void;
		/**
		 * The function called when JavaScript code in the HTMLLoader object sets the
		 *  window.status property.
		 *
		 * @param status            <String> The value to which the status property
		 *                            of the window property of the HTMLLoader object is set.
		 */
		public function updateStatus(status:String):void;
		/**
		 * The function called when JavaScript code in the HTMLLoader object sets the
		 *  window.document.title property or when the title
		 *  element changes, either via the DOM or because of a new page load.
		 *
		 * @param title             <String> The value to which the window.document.title property
		 *                            of the HTMLLoader object is set.
		 */
		public function updateTitle(title:String):void;
		/**
		 * The function called when JavaScript code in the HTMLLoader object calls the
		 *  window.blur() method.
		 */
		public function windowBlur():void;
		/**
		 * The function called when JavaScript code in the HTMLLoader object calls the
		 *  window.close() method.
		 */
		public function windowClose():void;
		/**
		 * The function called when JavaScript code in the HTMLLoader object calls the
		 *  window.focus() method.
		 */
		public function windowFocus():void;
	}
}
