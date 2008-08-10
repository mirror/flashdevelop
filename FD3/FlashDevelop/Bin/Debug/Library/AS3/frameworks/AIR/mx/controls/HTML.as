/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package mx.controls {
	import mx.core.ScrollControlBase;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.managers.IFocusManagerComponent;
	import flash.html.HTMLHost;
	import mx.core.IFactory;
	import mx.controls.listClasses.BaseListData;
	import flash.system.ApplicationDomain;
	public class HTML extends ScrollControlBase implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFocusManagerComponent {
		/**
		 * The height, in pixels, of the HTML content.
		 */
		public function get contentHeight():Number;
		/**
		 * The width, in pixels, of the HTML content.
		 */
		public function get contentWidth():Number;
		/**
		 * Lets you pass a value to the component
		 *  when you use it in an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * The JavaScript window object
		 *  for the root frame of the HTML DOM inside this control.
		 */
		public function get domWindow():Object;
		/**
		 * The overall length of the history list,
		 *  including back and forward entries.
		 *  This property has the same value
		 *  as the window.history.length
		 *  JavaScript property of the the HTML content.
		 */
		public function get historyLength():int;
		/**
		 * The current position in the history list.
		 */
		public function get historyPosition():int;
		public function set historyPosition(value:int):void;
		/**
		 * The HTMLHost object is used to handle changes
		 *  to certain user interface elements in the HTML content,
		 *  such as the window.document.title property.
		 */
		public function get htmlHost():HTMLHost;
		public function set htmlHost(value:HTMLHost):void;
		/**
		 * The internal HTMLLoader object that renders
		 *  the HTML content for this control.
		 */
		public var htmlLoader:HTMLLoader;
		/**
		 * The IFactory that creates an HTMLLoader-derived instance
		 *  to use as the htmlLoader.
		 */
		public function get htmlLoaderFactory():IFactory;
		public function set htmlLoaderFactory(value:IFactory):void;
		/**
		 * Specifies an HTML-formatted String for display by the control.
		 */
		public function get htmlText():String;
		public function set htmlText(value:String):void;
		/**
		 * When a component is used as a drop-in item renderer or drop-in
		 *  item editor, Flex initializes the listData property
		 *  of the component with the appropriate data from the List control.
		 *  The component can then use the listData property
		 *  to initialize the data property of the drop-in
		 *  item renderer or drop-in item editor.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * A flag which indicates whether the JavaScript load event
		 *  corresponding to the previous loading operation
		 *  has been delivered to the HTML DOM in this control.
		 */
		public function get loaded():Boolean;
		/**
		 * The URL of an HTML page to be displayed by this control.
		 */
		public function get location():String;
		public function set location(value:String):void;
		/**
		 * Whether this control's HTML content
		 *  has a default opaque white background or not.
		 */
		public function get paintsDefaultBackground():Boolean;
		public function set paintsDefaultBackground(value:Boolean):void;
		/**
		 * The type of PDF support on the user's system,
		 *  defined as an integer code value.
		 */
		public static function get pdfCapability():int;
		/**
		 * The ApplicationDomain to use for HTML's window.runtime
		 *  scripting.
		 */
		public function get runtimeApplicationDomain():ApplicationDomain;
		public function set runtimeApplicationDomain(value:ApplicationDomain):void;
		/**
		 * The user agent string to be used in content requests
		 *  from this control.
		 */
		public function get userAgent():String;
		public function set userAgent(value:String):void;
		/**
		 * Constructor.
		 */
		public function HTML();
		/**
		 * Cancels any load operation in progress.
		 */
		public function cancelLoad():void;
		/**
		 * Returns the HTMLHistoryItem at the specified position
		 *  in this control's history list.
		 *
		 * @param position          <int> The position in the history list.
		 * @return                  <HTMLHistoryItem> A HTMLHistoryItem object
		 *                            for the history entry  at the specified position.
		 */
		public function getHistoryAt(position:int):HTMLHistoryItem;
		/**
		 * Navigates back in this control's history list, if possible.
		 */
		public function historyBack():void;
		/**
		 * Navigates forward in this control's history list, if possible.
		 */
		public function historyForward():void;
		/**
		 * Navigates the specified number of steps in this control's history list.
		 *
		 * @param steps             <int> The number of steps in the history list
		 *                            to move forward (positive) or backward (negative).
		 */
		public function historyGo(steps:int):void;
		/**
		 * Reloads the HTML content from the current location.
		 */
		public function reload():void;
	}
}
