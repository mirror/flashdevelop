package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import mx.core.ClassFactory;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.ItemClickEvent;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.StyleProxy;

	/**
	 *  Number of pixels between the LinkButton controls in the horizontal direction.
 * 
 *  @default 8
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  Name of CSS style declaration that specifies the styles to use for the link
 *  button navigation items.
 * 
 *  @default ""
	 */
	[Style(name="linkButtonStyleName", type="String", inherit="no")] 

	/**
	 *  Number of pixels between the bottom border and the LinkButton controls.
 * 
 *  @default 2
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the top border and the LinkButton controls.
 * 
 *  @default 2
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  Color of links as you roll the mouse pointer over them.
 *  The default value is based on the current <code>themeColor</code>.
 * 
 *  @default 0xEEFEE6 (light green)
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Background color of the LinkButton control as you press it.
 * 
 *  @default 0xCDFFC1
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Separator color used by the default separator skin.
 * 
 *  @default 0xC4CCCC
	 */
	[Style(name="separatorColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Seperator symbol between LinkButton controls in the LinkBar. 
 * 
 *  @default mx.skins.halo.LinkSeparator
	 */
	[Style(name="separatorSkin", type="Class", inherit="no")] 

	/**
	 *  Separator pixel width, in pixels.
 * 
 *  @default 1
	 */
	[Style(name="separatorWidth", type="Number", format="Length", inherit="yes")] 

	/**
	 *  Text color of the link as you move the mouse pointer over it.
 * 
 *  @default 0x2B333C
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Text color of the link as you press it.
 * 
 *  @default 0x000000
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Number of pixels between children in the vertical direction.
 * 
 *  @default 8
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	[Exclude(name="horizontalLineScrollSize", kind="property")] 

	[Exclude(name="horizontalPageScrollSize", kind="property")] 

	[Exclude(name="horizontalScrollBar", kind="property")] 

	[Exclude(name="horizontalScrollPolicy", kind="property")] 

	[Exclude(name="horizontalScrollPosition", kind="property")] 

	[Exclude(name="maxHorizontalScrollPosition", kind="property")] 

	[Exclude(name="maxVerticalScrollPosition", kind="property")] 

	[Exclude(name="verticalLineScrollSize", kind="property")] 

	[Exclude(name="verticalPageScrollSize", kind="property")] 

	[Exclude(name="verticalScrollBar", kind="property")] 

	[Exclude(name="verticalScrollPolicy", kind="property")] 

	[Exclude(name="verticalScrollPosition", kind="property")] 

	[Exclude(name="scroll", kind="event")] 

	[Exclude(name="click", kind="event")] 

	[Exclude(name="horizontalScrollBarStyleName", kind="style")] 

	[Exclude(name="verticalScrollBarStyleName", kind="style")] 

	[DefaultProperty("dataProvider")] 

	[MaxChildren(0)] 

include "../core/Version.as"
	/**
	 *  A LinkBar control defines a horizontal or vertical row of LinkButton controls
 *  that designate a series of link destinations.
 *  You typically use a LinkBar control to control
 *  the active child container of a ViewStack container,
 *  or to create a stand-alone set of links.
 *
 *  <p>The LinkBar control creates LinkButton controls based on the value of 
 *  its <code>dataProvider</code> property. 
 *  Even though LinkBar is a subclass of Container, do not use methods such as 
 *  <code>Container.addChild()</code> and <code>Container.removeChild()</code> 
 *  to add or remove LinkButton controls. 
 *  Instead, use methods such as <code>addItem()</code> and <code>removeItem()</code> 
 *  to manipulate the <code>dataProvider</code> property. 
 *  The LinkBar control automatically adds or removes the necessary children based on 
 *  changes to the <code>dataProvider</code> property.</p>
 *
 *  <p>A LinkBar control has the following default characteristics:</p>
 *  <table class="innertable">
 *     <tr>
 *        <th>Characteristic</th>
 *        <th>Description</th>
 *     </tr>
 *     <tr>
 *        <td>Preferred size</td>
 *        <td>A width wide enough to contain all label text, plus any padding and separators, and the height of the tallest child.</td>
 *     </tr>
 *     <tr>
 *        <td>Control resizing rules</td>
 *        <td>LinkBar controls do not resize by default. Specify percentage sizes if you want your LinkBar to resize based on the size of its parent container.</td>
 *     </tr>
 *     <tr>
 *        <td>Padding</td>
 *        <td>2 pixels for the top, bottom, left, and right properties.</td>
 *     </tr>
 *  </table>
 *
 *  @mxml
 *  <p>The <code>&lt;mx:LinkBar&gt;</code> tag inherits all of the tag
 *  attributes of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:LinkBar
 *    <b>Properties</b>
 *    selectedIndex="-1"
 *  
 *    <b>Styles</b>
 *    linkButtonStyleName=""
 *    horizontalGap="8"
 *    paddingBottom="2"
 *    paddingTop="2"
 *    rollOverColor="0xEEFEE6"
 *    selectionColor="0xCDFFC1"
 *    separatorColor="<i>No default</i>"
 *    separatorSkin="0x000000"
 *    separatorWidth="1"
 *    textRollOverColor="0x2B333C"
 *    textSelectedColor="0x000000"
 *    verticalGap="8"
 *    &gt;
 *    ...
 *      <i>child tags</i>
 *    ...
 *  &lt;/mx:LinkBar&gt;
 *  </pre>
 *
 *  @includeExample examples/LinkBarExample.mxml
 *
 *  @see mx.controls.NavBar
 *  @see mx.containers.ViewStack
 *  @see mx.controls.LinkButton
 *  @see mx.controls.ToggleButtonBar
 *  @see mx.controls.ButtonBar
	 */
	public class LinkBar extends NavBar
	{
		/**
		 *  @private
		 */
		private static const SEPARATOR_NAME : String = "_separator";
		/**
		 *  @private
     *  Storage for the selectedIndex property.
		 */
		private var _selectedIndex : int;
		/**
		 *  @private
		 */
		private var _selectedIndexChanged : Boolean;

		/**
		 *  The index of the last selected LinkButton control if the LinkBar 
     *  control uses a ViewStack container as its data provider.
     * 
     *  @default -1
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;

		/**
		 *  Constructor.
		 */
		public function LinkBar ();

		/**
		 *  @inheritDoc
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Responds to size changes by setting the positions and sizes
     *  of this LinkBar control's children. 
     *  For more information about the <code>updateDisplayList()</code> method,
     *  see the <code>UIComponent.updateDisplayList()</code> method.
     *
     *  <p>The <code>LinkBar.updateDisplayList()</code> method first calls
     *  the <code>Box.updateDisplayList()</code> method to position the LinkButton controls.
     *  For more details, see the <code>Box.updateDisplayList()</code> method.
     *  After laying out the LinkButton controls, the separators are positioned
     *  between them.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  of the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
     * 
     *  @see mx.core.UIComponent#updateDisplayList()
     *  @see mx.containers.Box#updateDisplayList()
     *
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;

		/**
		 *  @private
		 */
		protected function hiliteSelectedNavItem (index:int) : void;

		/**
		 *  @private
		 */
		protected function resetNavItems () : void;

		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;

		/**
		 *  @private
		 */
		private function defaultClickHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
	}
}
