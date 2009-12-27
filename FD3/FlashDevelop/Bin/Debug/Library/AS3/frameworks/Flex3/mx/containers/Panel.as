package mx.containers
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextLineMetrics;
	import flash.utils.getQualifiedClassName;
	import mx.automation.IAutomationObject;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.containers.utilityClasses.CanvasLayout;
	import mx.containers.utilityClasses.ConstraintColumn;
	import mx.containers.utilityClasses.ConstraintRow;
	import mx.containers.utilityClasses.IConstraintLayout;
	import mx.containers.utilityClasses.Layout;
	import mx.controls.Button;
	import mx.core.Container;
	import mx.core.ContainerLayout;
	import mx.core.EdgeMetrics;
	import mx.core.EventPriority;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.core.IFontContextComponent;
	import mx.core.IUIComponent;
	import mx.core.IUITextField;
	import mx.core.UIComponent;
	import mx.core.UIComponentCachePolicy;
	import mx.core.UITextField;
	import mx.core.UITextFormat;
	import mx.core.mx_internal;
	import mx.effects.EffectManager;
	import mx.events.CloseEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.ISystemManager;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleProxy;

include "../styles/metadata/AlignStyles.as"
include "../styles/metadata/GapStyles.as"
include "../styles/metadata/ModalTransparencyStyles.as"
	/**
	 *  Alpha of the title bar, control bar and sides of the Panel.
 *  The default value is 0.4.
	 */
	[Style(name="borderAlpha", type="Number", inherit="no")] 

	/**
	 *  Thickness of the bottom border of the Panel control.
 *  If this style is not set and the Panel control contains a ControlBar
 *  control, the bottom border thickness equals the thickness of the top border
 *  of the panel; otherwise the bottom border thickness equals the thickness
 *  of the left border.
 *
 *  @default NaN
	 */
	[Style(name="borderThicknessBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Thickness of the left border of the Panel.
 *
 *  @default 10
	 */
	[Style(name="borderThicknessLeft", type="Number", format="Length", inherit="no")] 

	/**
	 *  Thickness of the right border of the Panel.
 *
 *  @default 10
	 */
	[Style(name="borderThicknessRight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Thickness of the top border of the Panel.
 *
 *  @default 2
	 */
	[Style(name="borderThicknessTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  Name of the CSS style declaration that specifies styles to apply to 
 *  any control bar child subcontrol.
 * 
 *  @default null
	 */
	[Style(name="controlBarStyleName", type="String", inherit="no")] 

	/**
	 *  Radius of corners of the window frame.
 *
 *  @default 4
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no")] 

	/**
	 *  Boolean property that controls the visibility
 *  of the Panel container's drop shadow.
 *
 *  @default true
	 */
	[Style(name="dropShadowEnabled", type="Boolean", inherit="no")] 

	/**
	 *  Array of two colors used to draw the footer
 *  (area for the ControlBar container) background. 
 *  The first color is the top color. 
 *  The second color is the bottom color.
 *  The default values are <code>null</code>, which
 *  makes the control bar background the same as
 *  the panel background.
 *
 *  @default null
	 */
	[Style(name="footerColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 

	/**
	 *  Array of two colors used to draw the header.
 *  The first color is the top color.
 *  The second color is the bottom color.
 *  The default values are <code>null</code>, which
 *  makes the header background the same as the
 *  panel background.
 *
 *  @default null
	 */
	[Style(name="headerColors", type="Array", arrayType="uint", format="Color", inherit="yes")] 

	/**
	 *  Height of the header.
 *  The default value is based on the style of the title text.
	 */
	[Style(name="headerHeight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Alphas used for the highlight fill of the header.
 *
 *  @default [0.3,0]
	 */
	[Style(name="highlightAlphas", type="Array", arrayType="Number", inherit="no")] 

	/**
	 *  Number of pixels between the container's lower border
 *  and its content area.
 *
 *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the container's top border
 *  and its content area.
 *
 *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  Flag to enable rounding for the bottom two corners of the container.
 *  Does not affect the upper two corners, which are normally round. 
 *  To configure the upper corners to be square, 
 *  set <code>cornerRadius</code> to 0.
 *
 *  @default false
	 */
	[Style(name="roundedBottomCorners", type="Boolean", inherit="no")] 

	/**
	 *  Direction of drop shadow.
 *  Possible values are <code>"left"</code>, <code>"center"</code>,
 *  and <code>"right"</code>.
 *
 *  @default "center"
	 */
	[Style(name="shadowDirection", type="String", enumeration="left,center,right", inherit="no")] 

	/**
	 *  Distance of drop shadow.
 *  Negative values move the shadow above the panel.
 *
 *  @default 2
	 */
	[Style(name="shadowDistance", type="Number", format="Length", inherit="no")] 

	/**
	 *  Style declaration name for the status in the title bar.
 *
 *  @default "windowStatus"
	 */
	[Style(name="statusStyleName", type="String", inherit="no")] 

	/**
	 *  The title background skin.
 *
 *  @default mx.skins.halo.TitleBackground
	 */
	[Style(name="titleBackgroundSkin", type="Class", inherit="no")] 

	/**
	 *  Style declaration name for the text in the title bar.
 *  The default value is <code>"windowStyles"</code>,
 *  which causes the title to have boldface text.
 *
 *  @default "windowStyles"
	 */
	[Style(name="titleStyleName", type="String", inherit="no")] 

	[Effect(name="resizeEndEffect", event="resizeEnd")] 

	[Effect(name="resizeStartEffect", event="resizeStart")] 

	[Exclude(name="focusIn", kind="event")] 

	[Exclude(name="focusOut", kind="event")] 

	[Exclude(name="focusBlendMode", kind="style")] 

	[Exclude(name="focusSkin", kind="style")] 

	[Exclude(name="focusThickness", kind="style")] 

	[Exclude(name="focusInEffect", kind="effect")] 

	[Exclude(name="focusOutEffect", kind="effect")] 

include "../core/Version.as"
	/**
	 *  A Panel container consists of a title bar, a caption, a border,
 *  and a  content area for its children.
 *  Typically, you use Panel containers to wrap top-level application modules.
 *  For example, you could include a shopping cart in a Panel container.
 *  
 *  <p>The Panel container has the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>Height is large enough to hold all of its children at the default height of the children, 
 *               plus any vertical gaps between the children, the top and bottom padding, the top and bottom borders, 
 *               and the title bar.<br/>
 *               Width is the larger of the default width of the widest child plus the left and right padding of the 
 *               container, or the width of the title text, plus the border.</td>
 *        </tr>
 *        <tr>
 *           <td>Padding</td>
 *           <td>4 pixels for the top, bottom, left, and right values.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:Panel&gt;</code> tag inherits all of the tag 
 *  attributes of its superclass and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:Panel
 *   <strong>Properties</strong>
 *   layout="vertical|horizontal|absolute"
 *   status=""
 *   title=""
 *   titleIcon="null"
 *   <strong>Styles</strong>
 *   borderAlpha="0.4"
 *   borderThicknessBottom="NaN"
 *   borderThicknessLeft="10"
 *   borderThicknessRight="10"
 *   borderThicknessTop="2"
 *   controlBarStyleName="null"
 *   cornerRadius="4"
 *   dropShadowEnabled="true|false"
 *   footerColors="null"
 *   headerColors="null"
 *   headerHeight="<i>Based on style of title</i>"
 *   highlightAlphas="[0.3,0]"
 *   horizontalAlign="left|center|right"
 *   horizontalGap="8"
 *   modalTransparency="0.5"
 *   modalTransparencyBlur="3"
 *   modalTransparencyColor="#DDDDDD"
 *   modalTransparencyDuration="100"
 *   paddingBottom="0"
 *   paddingTop="0"
 *   roundedBottomCorners="false|true"
 *   shadowDirection="center|left|right"
 *   shadowDistance="2"
 *   statusStyleName="windowStatus"
 *   titleBackgroundSkin="TitleBackground"
 *   titleStyleName="windowStyles"
 *   verticalAlign="top|middle|bottom"
 *   verticalGap="6"
 *   <strong>Effects</strong>
 *   resizeEndEffect="Dissolve"
 *   resizeStartEffect="Dissolve"
 *   &gt;
 *      ...
 *      <i>child tags</i>
 *      ...
 *  &lt;/mx:Panel&gt;
 *  </pre>
 *  
 *  @includeExample examples/SimplePanelExample.mxml
 *
 *  @see mx.containers.ControlBar
 *  @see mx.containers.VBox
	 */
	public class Panel extends Container implements IConstraintLayout
	{
		/**
		 *  @private
		 */
		private static const HEADER_PADDING : Number = 14;
		/**
		 *  @private
     *  Placeholder for mixin by PanelAccImpl.
		 */
		static var createAccessibilityImplementation : Function;
		/**
		 *  @private
		 */
		private var layoutObject : Layout;
		/**
		 *  @private
     *  Is there a close button? Panel itself never has one,
     *  but its subclass TitleWindow can set this flag to true.
		 */
		var _showCloseButton : Boolean;
		/**
		 *  @private
     *  A reference to this Panel container's title bar skin.
     *  This is a child of the titleBar.
		 */
		var titleBarBackground : IFlexDisplayObject;
		/**
		 *  @private
     *  A reference to this Panel container's title icon.
		 */
		var titleIconObject : Object;
		/**
		 *  @private
     *  A reference to this Panel container's close button, if any.
     *  This is a sibling of the titleBar, not its child.
		 */
		var closeButton : Button;
		/**
		 *  @private
     *  true until the component has finished initializing
		 */
		private var initializing : Boolean;
		/**
		 *  @private
		 */
		private var panelViewMetrics : EdgeMetrics;
		/**
		 *  @private
     *  Horizontal location where the user pressed the mouse button
     *  on the titlebar to start dragging, relative to the original
     *  horizontal location of the Panel.
		 */
		private var regX : Number;
		/**
		 *  @private
     *  Vertical location where the user pressed the mouse button
     *  on the titlebar to start dragging, relative to the original
     *  vertical location of the Panel.
		 */
		private var regY : Number;
		/**
		 *  @private
		 */
		private var checkedForAutoSetRoundedCorners : Boolean;
		/**
		 *  @private
		 */
		private var autoSetRoundedCorners : Boolean;
		private static var _closeButtonStyleFilters : Object;
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
		 *  A reference to this Panel container's control bar, if any.
		 */
		protected var controlBar : IUIComponent;
		/**
		 *  @private
     *  Storage for the layout property.
		 */
		private var _layout : String;
		/**
		 *  @private
     *  Storage for the status property.
		 */
		private var _status : String;
		/**
		 *  @private
		 */
		private var _statusChanged : Boolean;
		/**
		 *  The UITextField sub-control that displays the status.
     *  The status field is a child of the <code>titleBar</code> sub-control.
     * 
     *  @see #titleBar
		 */
		protected var statusTextField : IUITextField;
		/**
		 *  @private
     *  Storage for the title property.
		 */
		private var _title : String;
		/**
		 *  @private
		 */
		private var _titleChanged : Boolean;
		/**
		 *  The TitleBar sub-control that displays the Panel container's title bar.
		 */
		protected var titleBar : UIComponent;
		/**
		 *  @private
     *  Storage for the titleIcon property.
		 */
		private var _titleIcon : Class;
		/**
		 *  @private
		 */
		private var _titleIconChanged : Boolean;
		/**
		 *  The UITextField sub-control that displays the title.
     *  The title field is a child of the <code>titleBar</code> sub-control.
     * 
     *  @see #titleBar
		 */
		protected var titleTextField : IUITextField;

		/**
		 *  @private
     *  The baselinePosition of a Panel is calculated for its title.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
		 */
		public function set cacheAsBitmap (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  The set of styles to pass from the Panel to the close button.
     *  @see mx.styles.StyleProxy
     *  @review
		 */
		protected function get closeButtonStyleFilters () : Object;

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
		 *  Proxy to the controlBar property which is protected and can't be accessed externally
		 */
		function get _controlBar () : IUIComponent;

		/**
		 *  @inheritDoc
		 */
		public function get fontContext () : IFlexModuleFactory;
		/**
		 *  @private
		 */
		public function set fontContext (moduleFactory:IFlexModuleFactory) : void;

		/**
		 *  Specifies the layout mechanism used for this container. 
     *  Panel containers can use <code>"vertical"</code>, <code>"horizontal"</code>, 
     *  or <code>"absolute"</code> positioning. 
     *  Vertical positioning lays out the child components vertically from
     *  the top of the container to the bottom in the specified order.
     *  Horizontal positioning lays out the child components horizontally
     *  from the left of the container to the right in the specified order.
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
		 *  Text in the status area of the title bar.
     *
     *  @default ""
		 */
		public function get status () : String;
		/**
		 *  @private
		 */
		public function set status (value:String) : void;

		/**
		 *  Title or caption displayed in the title bar.
     *
     *  @default ""
     *
     *  @tiptext Gets or sets the title/caption displayed in the title bar
     *  @helpid 3991
		 */
		public function get title () : String;
		/**
		 *  @private
		 */
		public function set title (value:String) : void;

		/**
		 *  The icon displayed in the title bar.
     *
     *  @default null
		 */
		public function get titleIcon () : Class;
		/**
		 *  @private
		 */
		public function set titleIcon (value:Class) : void;

		/**
		 *  @private
		 */
		function get usePadding () : Boolean;

		/**
		 *  @private  
     *
     *  Returns the thickness of the edges of the object, including  
     *  the border, title bar, and scroll bars, if visible.
     *  @return Object with left, right, top, and bottom properties
     *  containing the edge thickness, in pixels.
		 */
		public function get viewMetrics () : EdgeMetrics;

		/**
		 *  Constructor.
		 */
		public function Panel ();

		/**
		 *  @private
		 */
		public function getChildIndex (child:DisplayObject) : int;

		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
     *  Create child objects.
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the default mininum and maximum sizes
     *  of the Panel container.
     *  For more information
     *  about the <code>measure()</code> method, see the <code>
     *  UIComponent.measure()</code> method.
     *
     *  <p>The <code>measure()</code> method first calls
     *  <code>VBox.measure()</code> method, and then ensures that the
     *  <code>measuredWidth</code> and
     *  <code>measuredMinWidth</code> properties are wide enough
     *  to display the title and the ControlBar.</p>
     * 
     *  @see mx.core.UIComponent#measure()
		 */
		protected function measure () : void;

		/**
		 *  @private
     *  Draw by making everything visible, then laying out.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;

		/**
		 *  @private
     *  Creates the title text field child
     *  and adds it as a child of this component.
     * 
     *  @param childIndex The index of where to add the child.
     *  If -1, the text field is appended to the end of the list.
		 */
		function createTitleTextField (childIndex:int) : void;

		/**
		 *  @private
     *  Removes the title text field from this component.
		 */
		function removeTitleTextField () : void;

		/**
		 *  @private
     *  Creates the status text field child
     *  and adds it as a child of this component.
     * 
     *  @param childIndex The index of where to add the child.
     *  If -1, the text field is appended to the end of the list.
		 */
		function createStatusTextField (childIndex:int) : void;

		/**
		 *  @private
     *  Removes the status text field from this component.
		 */
		function removeStatusTextField () : void;

		/**
		 *  @private.
     *  Returns a Rectangle containing the largest piece of header
     *  text (can be either the title or status, whichever is bigger).
		 */
		private function measureHeaderText () : Rectangle;

		/**
		 *  Returns the height of the header.
     * 
     *  @return The height of the header, in pixels.
		 */
		protected function getHeaderHeight () : Number;

		/**
		 *  @private
     *  Proxy to getHeaderHeight() for PanelSkin
     *  since we can't change its function signature
		 */
		function getHeaderHeightProxy () : Number;

		/**
		 *  @private
		 */
		private function showTitleBar (show:Boolean) : void;

		/**
		 *  @private
		 */
		private function setControlBar (newControlBar:IUIComponent) : void;

		/**
		 *  Called when the user starts dragging a Panel
     *  that has been popped up by the PopUpManager.
		 */
		protected function startDragging (event:MouseEvent) : void;

		/**
		 *  Called when the user stops dragging a Panel
     *  that has been popped up by the PopUpManager.
		 */
		protected function stopDragging () : void;

		/**
		 *  @private
     *  Some other components which use a Panel as an internal
     *  subcomponent need access to the title bar,
     *  but can't access the titleBar var because it is protected
     *  and therefore available only to subclasses.
		 */
		function getTitleBar () : UIComponent;

		/**
		 *  @private
     *  Some other components which use a Panel as an internal
     *  subcomponent need access to the UITextField that displays the title,
     *  but can't access the titleTextField var because it is protected
     *  and therefore available only to subclasses.
		 */
		function getTitleTextField () : IUITextField;

		/**
		 *  @private
     *  Some other components which use a Panel as an internal
     *  subcomponent need access to the UITextField that displays the status,
     *  but can't access the statusTextField var because it is protected
     *  and therefore available only to subclasses.
		 */
		function getStatusTextField () : IUITextField;

		/**
		 *  @private
     *  Some other components which use a Panel as an internal
     *  subcomponent need access to the control bar,
     *  but can't access the controlBar var because it is protected
     *  and therefore available only to subclasses.
		 */
		function getControlBar () : IUIComponent;

		/**
		 *  @private
		 */
		private function titleBar_mouseDownHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function systemManager_mouseMoveHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function systemManager_mouseUpHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function stage_mouseLeaveHandler (event:Event) : void;

		/**
		 *  @private
		 */
		private function closeButton_clickHandler (event:MouseEvent) : void;
	}
}
