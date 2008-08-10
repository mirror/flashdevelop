/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class BrowserChangeEvent extends Event {
		/**
		 * The previous value of the url property in the BrowserManager.
		 */
		public var lastURL:String;
		/**
		 * The new value of the url property in the BrowserManager.
		 */
		public var url:String;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param url               <String (default = null)> Current URL in the browser.
		 * @param lastURL           <String (default = null)> Previous URL in the browser.
		 */
		public function BrowserChangeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, url:String = null, lastURL:String = null);
		/**
		 * The BrowserChangeEvent.APPLICATION_URL_CHANGE constant defines the value of the
		 *  type property of the event object for a applicationURLChange event.
		 */
		public static const APPLICATION_URL_CHANGE:String = "applicationURLChange";
		/**
		 * The BrowserChangeEvent.BROWSER_URL_CHANGE constant defines the value of the
		 *  type property of the event object for a browserURLChange event.
		 */
		public static const BROWSER_URL_CHANGE:String = "browserURLChange";
		/**
		 * The BrowserChangeEvent.URL_CHANGE constant defines the value of the
		 *  type property of the event object for a urlChange event.
		 */
		public static const URL_CHANGE:String = "urlChange";
	}
}
