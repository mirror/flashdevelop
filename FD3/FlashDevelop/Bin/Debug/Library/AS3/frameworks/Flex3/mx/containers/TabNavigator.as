package mx.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import mx.controls.Button;
	import mx.controls.TabBar;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.core.IProgrammaticSkin;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.events.ItemClickEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.styles.StyleProxy;
	import flash.ui.Keyboard;

include "../styles/metadata/FillStyles.as"
include "../styles/metadata/FocusStyles.as"
	/**
	 *  Name of CSS style declaration that specifies styles for the first tab.
 *  If this is unspecified, the default value
 *  of the <code>tabStyleName</code> style property is used.
	 */
	[Style(name="firstTabStyleName", type="String", inherit="no")] 

	/**
	 *  Horizontal positioning of tabs at the top of this TabNavigator container.
 *  The possible values are <code>"left"</code>, <code>"center"</code>,
 *  and <code>"right"</code>.
 *  The default value is <code>"left"</code>.
 *
 *  <p>If the value is <code>"left"</code>, the left edge of the first tab
 *  is aligned with the left edge of the TabNavigator container.
 *  If the value is <code>"right"</code>, the right edge of the last tab
 *  is aligned with the right edge of the TabNavigator container.
 *  If the value is <code>"center"</code>, the tabs are centered on the top
 *  of the TabNavigator container.</p>
 *
 *  <p>To see a difference between the alignments,
 *  the total width of all the tabs must be less than
 *  the width of the TabNavigator container.</p>
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 

	/**
	 *  Separation between tabs, in pixels.
 *  The default value is -1, so that the borders of adjacent tabs overlap.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  Name of CSS style declaration that specifies styles for the last tab.
 *  If this is unspecified, the default value
 *  of the <code>tabStyleName</code> style property is used.
	 */
	[Style(name="lastTabStyleName", type="String", inherit="no")] 

	/**
	 *  Name of CSS style declaration that specifies styles for the text
 *  of the selected tab.
	 */
	[Style(name="selectedTabTextStyleName", type="String", inherit="no")] 

	/**
	 *  Height of each tab, in pixels.
 *  The default value is <code>undefined</code>.
 *  When this property is <code>undefined</code>, the height of each tab is
 *  determined by the font styles applied to this TabNavigator container.
 *  If you set this property, the specified value overrides this calculation.
	 */
	[Style(name="tabHeight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Name of CSS style declaration that specifies styles for the tabs.
 *  
 *  @default undefined
	 */
	[Style(name="tabStyleName", type="String", inherit="no")] 

	/**
	 *  Width of each tab, in pixels.
 *  The default value is <code>undefined</code>.
 *  When this property is <code>undefined</code>, the width of each tab is
 *  determined by the width of its label text, using the font styles applied
 *  to this TabNavigator container.
 *  If the total width of the tabs would be greater than the width of the
 *  TabNavigator container, the calculated tab width is decreased, but
 *  only to a minimum of 30 pixels.
 *  If you set this property, the specified value overrides this calculation.
 *
 *  <p>The label text on a tab is truncated if it does not fit in the tab.
 *  If a tab label is truncated, a tooltip with the full label text is
 *  displayed when a user rolls the mouse over the tab.</p>
	 */
	[Style(name="tabWidth", type="Number", format="Length", inherit="no")] 

	/**
	 *  The horizontal offset, in pixels, of the tab bar from the left edge 
 *  of the TabNavigator container. 
 *  A positive value moves the tab bar to the right. A negative
 *  value move the tab bar to the left. 
 * 
 *  @default 0
	 */
	[Style(name="tabOffset", type="Number", format="Length", inherit="no")] 

	[Exclude(name="defaultButton", kind="property")] 

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

	[Exclude(name="fillAlphas", kind="style")] 

	[Exclude(name="fillColors", kind="style")] 

	[Exclude(name="horizontalScrollBarStyleName", kind="style")] 

	[Exclude(name="verticalScrollBarStyleName", kind="style")] 

include "../core/Version.as"
	/**
	 *  The TabNavigator container extends the ViewStack container by including
 *  a TabBar container for navigating between its child containers.
 *
 *  <p>Like a ViewStack container, a TabNavigator container has a collection
 *  of child containers, in which only one child at a time is visible.
 *  Flex automatically creates a TabBar container at the top of the
 *  TabNavigator container, with a tab corresponding to each child container.
 *  Each tab can have its own label and icon.
 *  When the user clicks a tab, the corresponding child container becomes
 *  visible as the selected child of the TabNavigator container.</p>
 *
 *  <p>When you change the currently visible child container,
 *  you can use the <code>hideEffect</code> property of the container being
 *  hidden and the <code>showEffect</code> property of the newly visible child
 *  container to apply an effect to the child containers.
 *  The TabNavigator container waits for the <code>hideEffect</code> of the
 *  child container being hidden to complete before it reveals the new child
 *  container.
 *  You can interrupt a currently playing effect if you change the
 *  <code>selectedIndex</code> property of the TabNavigator container
 *  while an effect is playing. </p>
 *  
 *  <p>To define the appearance of tabs in a TabNavigator, you can define style properties in a 
 *  Tab type selector, as the following example shows:</p>
 *  <pre>
 *  &lt;mx:Style&gt;
 *    Tab {
 *       fillColors: #006699, #cccc66;
 *       upSkin: ClassReference("CustomSkinClass");
 *       overSkin: ClassReference("CustomSkinClass");
 *       downSkin: ClassReference("CustomSkinClass");
 *    }  
 *  &lt;/mx:Style&gt;
 *  </pre>
 * 
 *  <p>The Tab type selector defines values on the hidden mx.controls.tabBarClasses.Tab 
 *  class. The default values for the Tab type selector are defined in the 
 *  defaults.css file.</p>
 * 
 *  <p>You can also define the styles in a class selector that you specify using 
 *  the <code>tabStyleName</code> style property; for example:</p>
 *  <pre>
 *  &lt;mx:Style&gt;
 *    TabNavigator {
 *       tabStyleName:myTabStyle;
 *    }
 *
 *    .myTabStyle {
 *       fillColors: #006699, #cccc66;
 *       upSkin: ClassReference("CustomSkinClass");
 *       overSkin: ClassReference("CustomSkinClass");
 *       downSkin: ClassReference("CustomSkinClass");
 *    }
 *  &lt;/mx:Style&gt;
 *  </pre>
 *
 *  <p>A TabNavigator container has the following default sizing characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>The default or explicit width and height of the first active child 
 *               plus the tabs, at their default or explicit heights and widths. 
 *               Default tab height is determined by the font, style, and skin applied 
 *               to the TabNavigator container.</td>
 *        </tr>
 *        <tr>
 *           <td>Container resizing rules</td>
 *           <td>By default, TabNavigator containers are only sized once to fit the size 
 *               of the first child container. They do not resize when you navigate to 
 *               other child containers. To force TabNavigator containers to resize when 
 *               you navigate to a different child container, set the resizeToContent 
 *               property to true.</td>
 *        </tr>
 *        <tr>
 *           <td>Child layout rules</td>
 *           <td>If the child is larger than the TabNavigator container, it is clipped. If 
 *               the child is smaller than the TabNavigator container, it is aligned to 
 *               the upper-left corner of the TabNavigator container.</td>
 *        </tr>
 *        <tr>
 *           <td>Default padding</td>
 *           <td>0 pixels for the top, bottom, left, and right values.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:TabNavigator&gt;</code> tag inherits all of the
 *  tag attributes of its superclass,
 *  an
	 */
	public class TabNavigator extends ViewStack implements IFocusManagerComponent
	{
		/**
		 *  @private
		 */
		private static const MIN_TAB_WIDTH : Number = 30;
		/**
		 *  A reference to the TabBar inside this TabNavigator.
		 */
		protected var tabBar : TabBar;
		private static var _tabBarStyleFilters : Object;

		/**
		 *  @private
     *  The baselinePosition of a TabNavigator is calculated
	 *  for the label of the first tab.
  	 *  If there are no children, a child is temporarily added
  	 *  to do the computation.
		 */
		public function get baselinePosition () : Number;

		/**
		 *  @private
		 */
		protected function get contentHeight () : Number;

		/**
		 *  @private
		 */
		protected function get contentY () : Number;

		/**
		 *  @private
     *  Height of the tab.
		 */
		private function get tabBarHeight () : Number;

		/**
		 *  The set of styles to pass from the TabNavigator to the tabBar.
     *  @see mx.styles.StyleProxy
     *  @review
		 */
		protected function get tabBarStyleFilters () : Object;

		/**
		 *  Constructor.
		 */
		public function TabNavigator ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the default sizes and mininum and maximum values of this
     *  TabNavigator container.
     *  See the <code>UIComponent.measure()</code> method for more information
     *  about the <code>measure()</code> method.
     *
     *  <p>The TabNavigator container uses the same measurement logic as the
     *  <code>ViewStack</code> container, with two modifications:
     *  First, it increases the value of the
     *  <code>measuredHeight</code> and
     *  <code>measuredMinHeight</code> properties to accomodate the tabs.
     *  Second, it increases the value of the
     *  <code>measuredWidth</code> property if necessary
     *  to ensure that each tab can be at least 30 pixels wide.</p>
     * 
     *  @see mx.core.UIComponent#measure()
     *  @see mx.containers.ViewStack#measure()
		 */
		protected function measure () : void;

		/**
		 *  Responds to size changes by setting the positions and sizes
     *  of this container's tabs and children.
     *
     *  For more information about the <code>updateDisplayList()</code> method,
     *  see the <code>UIComponent.updateDisplayList()</code> method.
     *
     *  <p>A TabNavigator container positions its TabBar container at the top.
     *  The width of the TabBar is set to the width of the
     *  TabNavigator, and the height of the TabBar is set
     *  based on the <code>tabHeight</code> property.</p>
     *
     *  <p>A TabNavigator container positions and sizes its child containers
     *  underneath the TabBar, using the same logic as in
     *  ViewStack container.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
     * 
     *  @see mx.core.UIComponent#updateDisplayList()
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;

		/**
		 *  @private
		 */
		protected function adjustFocusRect (object:DisplayObject = null) : void;

		/**
		 *  @private
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  Returns the tab of the navigator's TabBar control at the specified
     *  index.
     *
     *  @param index Index in the navigator's TabBar control.
     *
     *  @return The tab at the specified index.
		 */
		public function getTabAt (index:int) : Button;

		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;

		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;

		/**
		 *  @private
		 */
		function getTabBar () : TabBar;
	}
}
