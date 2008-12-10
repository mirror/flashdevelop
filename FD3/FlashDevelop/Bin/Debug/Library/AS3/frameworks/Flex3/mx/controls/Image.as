﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IDataRenderer;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	/**
	 *  Dispatched when the <code>data</code> property changes. * *  <p>When you use a component as an item renderer, *  the <code>data</code> property contains the data to display. *  You can listen for this event and update the component *  when the <code>data</code> property changes.</p> *  *  @eventType mx.events.FlexEvent.DATA_CHANGE
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 

	/**
	 *  The Image control lets you import JPEG, PNG, GIF, and SWF files  *  at runtime. You can also embed any of these files and SVG files at compile time *  by using <code>&#64;Embed(source='filename')</code>. * *  <p><strong>Note: </strong>Flex also includes the SWFLoader control for loading Flex applications.  *  You typically use the Image control for loading static graphic files and SWF files,  *  and use the SWFLoader control for loading Flex applications. The Image control  *  is also designed to be used in custom item renderers and item editors. </p> * *  <p>Embedded images load immediately, because they are already part of the  *  Flex SWF file. However, they add to the size of your application and slow down  *  the application initialization process. Embedded images also require you to  *  recompile your applications whenever your image files change.</p>  *   *  <p>The alternative to embedding a resource is to load the resource at runtime.  *  You can load a resource from the local file system in which the SWF file runs,  *  or you can access a remote resource, typically though an HTTP request over a network.  *  These images are independent of your Flex application, so you can change them without  *  causing a recompile operation as long as the names of the modified images remain the same.  *  The referenced images add no additional overhead to an application's initial loading time.  *  However, you might experience a delay when you use the images and load them  *  into Flash Player or AIR. </p> *   *  <p>A SWF file can access one type of external resource only, either local or over a network;  *  it cannot access both types. You determine the type of access allowed by the SWF file  *  using the <code>use-network</code> flag when you compile your application.  *  When the <code>use-network</code> flag is set to <code>false</code>, you can access  *  resources in the local file system, but not over the network.  *  The default value is <code>true</code>, which allows you to access resources  *  over the network, but not in the local file system. </p> *   *  <p>When you load images at runtime, you should be aware of the security restrictions *  of Flash Player or AIR.  *  For example, in Flash Player you can load an image from any domain by using a URL,  *  but the default security settings won't allow your code to access the bitmap data *  of the image unless it came from the same domain as the application.  *  To access bitmap data from images on other servers, you must use a crossdomain.xml file. </p> * *  <p>The PNG and GIF formats also support the use of an alpha channel *  for creating transparent images.</p> * *  <p>When you use the Image control as a drop-in item renderer in a List control,  *  either set an explicit row height of the List control, by *  using the <code>rowHeight</code> property,  *  or set the <code>variableRowHeight</code> property of the List control  *  to <code>true</code> to size the row correctly.</p> *  *  <p>If you find memory problems related to Images objects, try explicitly   *  setting the <code>source</code> property to null when you are done using  *  the Image object in your application.</p> *   *  @mxml *   *  <p>The <code>&lt;mx:Image&gt;</code> tag inherits the tag attributes of its superclass,   *  and adds the following tag attribute:</p> * *  <pre> *  &lt;mx:Image *    <strong>Events</strong> *    dataChange="No default" *  /&gt *  </pre> *   *  @see mx.controls.SWFLoader * *  @includeExample examples/SimpleImage.mxml
	 */
	public class Image extends SWFLoader implements IDataRenderer
	{
		/**
		 *  @private
		 */
		private var makeContentVisible : Boolean;
		/**
		 *  @private     *  Flag that will block default data/listData behavior
		 */
		private var sourceSet : Boolean;
		/**
		 *  @private     *  Flag that will block invalidation when a renderer
		 */
		private var settingBrokenImage : Boolean;
		/**
		 *  @private     *  Storage for the data property.
		 */
		private var _data : Object;
		/**
		 *  @private     *  Storage for the listData property.
		 */
		private var _listData : BaseListData;

		/**
		 *  @private
		 */
		public function set source (value:Object) : void;
		/**
		 *  The <code>data</code> property lets you pass a value to the component     *  when you use it in an item renderer or item editor.      *  You typically use data binding to bind a field of the <code>data</code>      *  property to a property of this component.     *     *  <p>When you use the control as a drop-in item renderer, Flex      *  will use the <code>listData.label</code> property, if it exists,     *  as the value of the <code>source</code> property of this control, or     *  use the <code>data</code> property as the <code>source</code> property.</p>     *     *  @default null     *  @see mx.core.IDataRenderer
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  When a component is used as a drop-in item renderer or drop-in     *  item editor, Flex initializes the <code>listData</code> property     *  of the component with the appropriate data from the List control.     *  The component can then use the <code>listData</code> property     *  to initialize the other properties of the drop-in     *  item renderer     *     *  <p>You do not set this property in MXML or ActionScript;     *  Flex sets it when the component is used as a drop-in item renderer     *  or drop-in item editor.</p>     *     *  @default null     *  @see mx.controls.listClasses.IDropInListItemRenderer
		 */
		public function get listData () : BaseListData;
		/**
		 *  @private
		 */
		public function set listData (value:BaseListData) : void;

		/**
		 *  Constructor.
		 */
		public function Image ();
		/**
		 *  @private
		 */
		public function invalidateSize () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		function contentLoaderInfo_completeEventHandler (event:Event) : void;
	}
}
