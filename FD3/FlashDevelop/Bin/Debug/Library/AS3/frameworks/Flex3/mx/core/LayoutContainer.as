package mx.core
{
	import flash.display.DisplayObject;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	import flash.utils.describeType;
	import flash.utils.setInterval;
	import mx.containers.BoxDirection;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.containers.utilityClasses.CanvasLayout;
	import mx.containers.utilityClasses.ConstraintColumn;
	import mx.containers.utilityClasses.ConstraintRow;
	import mx.containers.utilityClasses.IConstraintLayout;
	import mx.containers.utilityClasses.Layout;
	import mx.effects.EffectManager;
	import mx.events.FlexEvent;
	import mx.managers.ISystemManager;
	import mx.managers.LayoutManager;
	import mx.managers.SystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;

include "../styles/metadata/AlignStyles.as"
include "../styles/metadata/GapStyles.as"
	/**
	 *  Number of pixels between the bottom border
 *  and its content area.  
 *
 *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the top border
 *  and its content area. 
 *
 *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	[Exclude(name="direction", kind="property")] 

	[Exclude(name="icon", kind="property")] 

	[Exclude(name="label", kind="property")] 

	[Exclude(name="tabIndex", kind="property")] 

	[Exclude(name="toolTip", kind="property")] 

	[Exclude(name="x", kind="property")] 

	[Exclude(name="y", kind="property")] 

include "../core/Version.as"
	/**
	 *  Flex defines a default, or Application, container that lets you start
 *  adding content to your module or Application without explicitly defining
 *  another container.
 *  Flex creates this container from the <code>&lt;mx:Application&gt;</code>
 *  tag, the first tag in an MXML application file, or from the
 *  <code>&lt;mx:Module&gt;</code> tag, the first tag in an MXML module file.
 *  While you might find it convenient to use the Application or Module container
 *  as the only  container in your application, in most cases you explicitly
 *  define at least one more container before you add any controls
 *  to your application or module.
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Application&gt;</code> tag inherits all of the tag 
 *  attributes of its superclass and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:Application
 *    <strong>Properties</strong>
 *    layout="vertical|horizontal|absolute"
 *    xmlns:<i>No default</i>="<i>No default</i>"
 * 
 *    <strong>Styles</strong> 
 *    horizontalAlign="center|left|right"
 *    horizontalGap="8"
 *    paddingBottom="0"
 *    paddingTop="0"
 *    verticalAlign="top|bottom|middle"
 *    verticalGap="6"
 *  
 *  /&gt;
 *  </pre>
 *
 *  @see flash.events.EventDispatcher
	 */
	public class LayoutContainer extends Container implements IConstraintLayout
	{
		/**
		 *  @private
		 */
		static var useProgressiveLayout : Boolean;
		/**
		 *  @private
     *  The mx.containers.utilityClasses.Layout subclass that is doing the layout
		 */
		protected var layoutObject : Layout;
		/**
		 *  The mx.containers.utilityClasses.Layout subclass that is doing the layout
		 */
		protected var canvasLayoutClass : Class;
		/**
		 *  The mx.containers.utilityClasses.Layout subclass that is doing the layout
		 */
		protected var boxLayoutClass : Class;
		/**
		 *  @private
		 */
		private var resizeHandlerAdded : Boolean;
		/**
		 *  @private
     *  Placeholder for Preloader object reference.
		 */
		private var preloadObj : Object;
		/**
		 *  @private
     *  Used in progressive layout.
		 */
		private var creationQueue : Array;
		/**
		 *  @private
     *  Used in progressive layout.
		 */
		private var processingCreationQueue : Boolean;
		/**
		 *  @private
     *  Storage for the constraintColumns property.
		 */
		private var _constraintColumns : Array;
		/**
		 *  @private
     *  Storage for the constraintRows property.
		 */
		private var _constraintRows : Array;
		/**
		 *  @private
     *  Storage for layout property.
		 */
		private var _layout : String;

		/**
		 *  @copy mx.containers.utilityClasses.IConstraintLayout#constraintColumns
		 */
		public function get constraintColumns () : Array;
		/**
		 *  @private
		 */
		public function set constraintColumns (value:Array) : void;

		/**
		 *  @copy mx.containers.utilityClasses.IConstraintLayout#constraintRows
		 */
		public function get constraintRows () : Array;
		/**
		 *  @private
		 */
		public function set constraintRows (value:Array) : void;

		/**
		 *  Specifies the layout mechanism used for this application. 
     *  Applications can use <code>"vertical"</code>, <code>"horizontal"</code>, 
     *  or <code>"absolute"</code> positioning. 
     *  Vertical positioning lays out each child component vertically from
     *  the top of the application to the bottom in the specified order.
     *  Horizontal positioning lays out each child component horizontally
     *  from the left of the application to the right in the specified order.
     *  Absolute positioning does no automatic layout and requires you to
     *  explicitly define the location of each child component. 
     *
     *  @default "vertical"
		 */
		public function get layout () : String;
		/**
		 *  @private
		 */
		public function set layout (value:String) : void;

		/**
		 *  @private
		 */
		function get usePadding () : Boolean;

		/**
		 *  Constructor.
		 */
		public function LayoutContainer ();

		/**
		 *  @private
     *  Calculates the preferred, mininum and maximum sizes of the
     *  Application. See the <code>UIComponent.measure()</code> method for more
     *  information.
     *  <p>
     *  The <code>measure()</code> method first calls
     *  <code>Box.measure()</code> method, then makes sure the
     *  <code>measuredWidth</code> and <code>measuredMinWidth</code>
     *  are wide enough to display the application's control bar.
		 */
		protected function measure () : void;

		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}
