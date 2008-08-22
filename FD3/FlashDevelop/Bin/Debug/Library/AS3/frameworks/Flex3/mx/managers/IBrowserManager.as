/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.managers {
	import flash.events.IEventDispatcher;
	public interface IBrowserManager extends IEventDispatcher {
		/**
		 * The portion of current URL before the '#' as it appears
		 *  in the browser address bar.
		 */
		public function get base():String;
		/**
		 * The portion of current URL after the '#' as it appears
		 *  in the browser address bar. Use the setURLFragment() method to change this value.
		 */
		public function get fragment():String;
		/**
		 * The title of the application as it should appear in the
		 *  browser history.
		 */
		public function get title():String;
		/**
		 * The current URL as it appears in the browser address bar.
		 */
		public function get url():String;
		/**
		 * Initializes the BrowserManager. The BrowserManager will get the initial URL. If it
		 *  has a fragment, it will dispatch a BROWSER_URL_CHANGE event.
		 *  This method sets the value of the Application.application.historyManagementEnabled
		 *  property to false because the HistoryManager generally interferes with your
		 *  application's handling of URL fragments.
		 *
		 * @param value             <String (default = null)> The fragment to use if no fragment is in the initial URL.
		 * @param title             <String (default = null)> The title to use if no fragment is in the initial URL.
		 */
		public function init(value:String = null, title:String = null):void;
		/**
		 * Initializes the BrowserManager. The HistoryManager calls this method to
		 *  prepare the BrowserManager for further calls from the HistoryManager. You cannot use
		 *  the HistoryManager and call the setFragment() method from the application.
		 *  As a result, the init() method usually sets
		 *  the value of the Application.application.historyManagementEnabled property to false to disable
		 *  the HistoryManager.
		 */
		public function initForHistoryManager():void;
		/**
		 * Changes the fragment of the URL after the '#' in the browser.
		 *  An attempt will be made to track this URL in the browser's
		 *  history.
		 *
		 * @param value             <String> 
		 */
		public function setFragment(value:String):void;
		/**
		 * Changes the text in the browser's title bar.
		 *  This method does not affect the browser's history.
		 *
		 * @param value             <String> 
		 */
		public function setTitle(value:String):void;
	}
}
