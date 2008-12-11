package flash.html
{
	/// An HTMLHost object defines behaviors of an HTMLLoader object for user interface elements that can be controlled by setting various properties or by calling various methods of the window object of the HTML page.
	public class HTMLHost
	{
		/// [AIR] The HTMLLoader object to which this HostControl object applies.
		public var htmlLoader:flash.html.HTMLLoader;

		/// [AIR] The property that is changed when JavaScript code in the HTMLLoader object calls the window.moveBy(), window.moveTo(), window.resizeBy(), or window.resizeTo() method.
		public var windowRect:flash.geom.Rectangle;

		/// [AIR] Creates an HTMLHost object.
		public function HTMLHost(defaultBehaviors:Boolean=true);

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.focus() method.
		public function windowFocus():void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.blur() method.
		public function windowBlur():void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object sets the window.location property.
		public function updateLocation(locationURL:String):void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object sets the window.status property.
		public function updateStatus(status:String):void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object sets the window.document.title property or when the title element changes, either via the DOM or because of a new page load.
		public function updateTitle(title:String):void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.open() method.
		public function createWindow(windowCreateOptions:flash.html.HTMLWindowCreateOptions):flash.html.HTMLLoader;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.close() method.
		public function windowClose():void;

	}

}

