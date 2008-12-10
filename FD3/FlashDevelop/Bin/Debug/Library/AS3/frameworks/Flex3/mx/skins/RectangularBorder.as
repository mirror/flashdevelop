package mx.skins
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	import mx.core.EdgeMetrics;
	import mx.core.FlexLoader;
	import mx.core.FlexShape;
	import mx.core.IChildList;
	import mx.core.IContainer;
	import mx.core.IRawChildrenContainer;
	import mx.core.mx_internal;
	import mx.core.IRectangularBorder;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  The RectangularBorder class is an abstract base class for various classes *  that draw rectangular borders around UIComponents. * *  <p>This class implements support for the <code>backgroundImage</code>, *  <code>backgroundSize</code>, and <code>backgroundAttachment</code> styles.</p>
	 */
	public class RectangularBorder extends Border implements IRectangularBorder
	{
		/**
		 *  @private     *  The value of the backgroundImage style may be either a string     *  or a Class pointer. Either way, the value of the backgroundImage     *  style is stored here, so that we can detect when it changes.
		 */
		private var backgroundImageStyle : Object;
		/**
		 *  @private     *  Original width of background image, before it is scaled.
		 */
		private var backgroundImageWidth : Number;
		/**
		 *  @private     *  Original height of background image, before it is scaled.
		 */
		private var backgroundImageHeight : Number;
		/**
		 *  @private     *  Used for accessing localized Error messages.
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  The DisplayObject instance that contains the background image, if any.     *  This object is a sibling of the RectangularBorder instance.
		 */
		private var backgroundImage : DisplayObject;
		/**
		 *  @private     *  Storage for backgroundImageBounds property.
		 */
		private var _backgroundImageBounds : Rectangle;

		/**
		 *  Contains <code>true</code> if the RectangularBorder instance     *  contains a background image.
		 */
		public function get hasBackgroundImage () : Boolean;
		/**
		 *  Rectangular area within which to draw the background image.     *     *  This can be larger than the dimensions of the border     *  if the parent container has scrollable content.     *  If this property is null, the border can use     *  the parent's size and <code>viewMetrics</code> property to determine its value.
		 */
		public function get backgroundImageBounds () : Rectangle;
		/**
		 *  @private
		 */
		public function set backgroundImageBounds (value:Rectangle) : void;

		/**
		 *  Constructor.
		 */
		public function RectangularBorder ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function initBackgroundImage (image:DisplayObject) : void;
		/**
		 *  Layout the background image.
		 */
		public function layoutBackgroundImage () : void;
		/**
		 *  @private
		 */
		private function getBackgroundSize () : Number;
		/**
		 *  @private
		 */
		private function errorEventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function completeEventHandler (event:Event) : void;
		/**
		 * Discard old background image.     *      *  @private
		 */
		private function removedHandler (event:Event) : void;
	}
}
