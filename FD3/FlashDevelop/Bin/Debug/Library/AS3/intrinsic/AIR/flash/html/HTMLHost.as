package flash.html
{
	import flash.html.HTMLLoader;
	import flash.geom.Rectangle;
	import flash.html.HTMLWindowCreateOptions;
	import flash.display.NativeWindow;

	/// An HTMLHost object defines behaviors of an HTMLLoader object for user interface elements that can be controlled by setting various properties or by calling various methods of the window object of the HTML page.
	public class HTMLHost extends Object
	{
		/// [AIR] The HTMLLoader object to which this HostControl object applies.
		public function get htmlLoader () : HTMLLoader;

		/// [AIR] The property that is changed when JavaScript code in the HTMLLoader object calls the window.moveBy(), window.moveTo(), window.resizeBy(), or window.resizeTo() method.
		public function get windowRect () : Rectangle;
		public function set windowRect (value:Rectangle) : void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.open() method.
		public function createWindow (windowCreateOptions:HTMLWindowCreateOptions) : HTMLLoader;

		/// [AIR] Creates an HTMLHost object.
		public function HTMLHost (defaultBehaviors:Boolean = true);

		/// [AIR] The function called when JavaScript code in the HTMLLoader object sets the window.location property.
		public function updateLocation (locationURL:String) : void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object sets the window.status property.
		public function updateStatus (status:String) : void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object sets the window.document.title property or when the title element changes, either via the DOM or because of a new page load.
		public function updateTitle (title:String) : void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.blur() method.
		public function windowBlur () : void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.close() method.
		public function windowClose () : void;

		/// [AIR] The function called when JavaScript code in the HTMLLoader object calls the window.focus() method.
		public function windowFocus () : void;
	}
}
