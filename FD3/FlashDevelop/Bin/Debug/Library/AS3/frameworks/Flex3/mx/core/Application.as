/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class Application extends LayoutContainer {
		/**
		 * A reference to the top-level application.
		 */
		public static function get application():Object;
		/**
		 * The ApplicationControlBar for this Application.
		 */
		public var controlBar:IUIComponent;
		/**
		 * Specifies the frame rate of the application.
		 */
		public var frameRate:Number;
		/**
		 * If false, the history manager will be disabled.
		 *  Setting to false is recommended when using the BrowserManager.
		 */
		public var historyManagementEnabled:Boolean = true;
		/**
		 * Specifies a string that appears in the title bar of the browser.
		 *  This property provides the same functionality as the
		 *  HTML <title> tag.
		 */
		public var pageTitle:String;
		/**
		 * The parameters property returns an Object containing name-value
		 *  pairs representing the parameters provided to this Application.
		 */
		public function get parameters():Object;
		/**
		 * Specifies the path of a SWC component class or ActionScript
		 *  component class that defines a custom progress bar.
		 *  A SWC component must be in the same directory as the MXML file
		 *  or in the WEB-INF/flex/user_classes directory of your Flex
		 *  web application.
		 */
		public var preloader:Object;
		/**
		 * If true, the application's history state is reset
		 *  to its initial state whenever the application is reloaded.
		 *  Applications are reloaded when any of the following occurs:
		 *  The user clicks the browser's Refresh button.
		 *  The user navigates to another web page, and then clicks
		 *  the browser's Back button to return to the Flex application.
		 *  The user loads a Flex application from the browser's
		 *  Favorites or Bookmarks menu.
		 */
		public var resetHistory:Boolean = true;
		/**
		 * Specifies the maximum depth of Flash Player or AIR
		 *  call stack before the player stops.
		 *  This is essentially the stack overflow limit.
		 */
		public var scriptRecursionLimit:int;
		/**
		 * Specifies the maximum duration, in seconds, that an ActionScript
		 *  event handler can execute before Flash Player or AIR assumes
		 *  that it is hung, and aborts it.
		 *  The maximum allowable value that you can set is 60 seconds.
		 */
		public var scriptTimeLimit:Number;
		/**
		 * The URL from which this Application's SWF file was loaded.
		 */
		public function get url():String;
		/**
		 * If true, specifies to display the application preloader.
		 */
		public var usePreloader:Boolean;
		/**
		 * URL where the application's source can be viewed. Setting this
		 *  property inserts a "View Source" menu item into the application's
		 *  default context menu.  Selecting the menu item opens the
		 *  viewSourceURL in a new window.
		 */
		public function get viewSourceURL():String;
		public function set viewSourceURL(value:String):void;
		/**
		 * Constructor.
		 */
		public function Application();
		/**
		 * Add a container to the Application's creation queue.
		 *
		 * @param id                <Object> The id of the container to add to the queue or a
		 *                            pointer to the container itself
		 * @param preferredIndex    <int (default = -1)> (optional) A positive integer that determines
		 *                            the container's position in the queue relative to the other
		 *                            containers presently in the queue.
		 * @param callbackFunc      <Function (default = null)> This parameter is ignored.
		 * @param parent            <IFlexDisplayObject (default = null)> This parameter is ignored.
		 */
		public function addToCreationQueue(id:Object, preferredIndex:int = -1, callbackFunc:Function = null, parent:IFlexDisplayObject = null):void;
	}
}
