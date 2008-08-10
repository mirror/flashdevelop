/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import flash.display.DisplayObject;
	import flash.system.LoaderContext;
	public class SWFLoader extends UIComponent {
		/**
		 * A flag that indictes whether content starts loading automatically
		 *  or waits for a clal to the load() method.
		 *  If true, the content loads automatically.
		 *  If false, you must call the load() method.
		 */
		public function get autoLoad():Boolean;
		public function set autoLoad(value:Boolean):void;
		/**
		 * The number of bytes of the SWF or image file already loaded.
		 */
		public function get bytesLoaded():Number;
		/**
		 * The total size of the SWF or image file.
		 */
		public function get bytesTotal():Number;
		/**
		 * This property contains the object that represents
		 *  the content that was loaded in the SWFLoader control.
		 */
		public function get content():DisplayObject;
		/**
		 * Height of the scaled content loaded by the control, in pixels.
		 *  Note that this is not the height of the control itself, but of the
		 *  loaded content. Use the height property of the control
		 *  to obtain its height.
		 */
		public function get contentHeight():Number;
		/**
		 * Width of the scaled content loaded by the control, in pixels.
		 *  Note that this is not the width of the control itself, but of the
		 *  loaded content. Use the width property of the control
		 *  to obtain its width.
		 */
		public function get contentWidth():Number;
		/**
		 * A LoaderContext object to use to control loading of the content.
		 *  This is an advanced property.
		 *  Most of the time you can use the trustContent property.
		 */
		public function get loaderContext():LoaderContext;
		public function set loaderContext(value:LoaderContext):void;
		/**
		 * A flag that indicates whether to maintain the aspect ratio
		 *  of the loaded content.
		 *  If true, specifies to display the image with the same ratio of
		 *  height to width as the original image.
		 */
		public function get maintainAspectRatio():Boolean;
		public function set maintainAspectRatio(value:Boolean):void;
		/**
		 * The percentage of the image or SWF file already loaded.
		 */
		public function get percentLoaded():Number;
		/**
		 * A flag that indicates whether to scale the content to fit the
		 *  size of the control or resize the control to the content's size.
		 *  If true, the content scales to fit the SWFLoader control.
		 *  If false, the SWFLoader scales to fit the content.
		 */
		public function get scaleContent():Boolean;
		public function set scaleContent(value:Boolean):void;
		/**
		 * A flag that indicates whether to show a busy cursor while
		 *  the content loads.
		 *  If true, shows a busy cursor while the content loads.
		 *  The default busy cursor is the mx.skins.halo.BusyCursor
		 *  as defined by the busyCursor property of the CursorManager class.
		 */
		public function get showBusyCursor():Boolean;
		public function set showBusyCursor(value:Boolean):void;
		/**
		 * The URL, object, class or string name of a class to
		 *  load as the content.
		 */
		public function get source():Object;
		public function set source(value:Object):void;
		/**
		 * If true, the content is loaded
		 *  into your security domain.
		 *  This means that the load fails if the content is in another domain
		 *  and that domain does not have a crossdomain.xml file allowing your
		 *  domain to access it.
		 *  This property only has an affect on the next load,
		 *  it will not start a new load on already loaded content.
		 */
		public function get trustContent():Boolean;
		public function set trustContent(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function SWFLoader();
		/**
		 * Loads an image or SWF file.
		 *  The url argument can reference a GIF, JPEG, PNG,
		 *  or SWF file; you cannot use this method to load an SVG file.
		 *  Instead,  you must load it using an Embed statement
		 *  with the source property.
		 *
		 * @param url               <Object (default = null)> Absolute or relative URL of the GIF, JPEG, PNG,
		 *                            or SWF file to load.
		 */
		public function load(url:Object = null):void;
	}
}
