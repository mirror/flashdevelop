﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import mx.controls.tabBarClasses.Tab;
	import mx.core.ClassFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.ItemClickEvent;

	/**
	 *  Dispatched when a tab navigation item is selected. *  This event is sent only if the data provider is not a ViewStack container. * *  @eventType mx.events.ItemClickEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.ItemClickEvent")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the  *  first tab navigation item.  *   *  @default "tabStyleName"
	 */
	[Style(name="firstTabStyleName", type="String", inherit="no")] 
	/**
	 * Horizontal alignment of all tabs within the TabBar. Since individual  * tabs stretch to fill the entire TabBar, this style is only useful if you * use the tabWidth style and the combined widths of the tabs are less than * than the width of the TabBar. * Possible values are <code>"left"</code>, <code>"center"</code>, * and <code>"right"</code>. * * @default "center"
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  Number of pixels between tab navigation items in the horizontal direction. *  *  @default -1
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the  *  last tab navigation item.  *   *  @default "tabStyleName"
	 */
	[Style(name="lastTabStyleName", type="String", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the text *  of the selected tab navigation item.  *  *  @default "activeTabStyle"
	 */
	[Style(name="selectedTabTextStyleName", type="String", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies the styles to use for the tab *  navigation items. *  *  @default undefined
	 */
	[Style(name="tabStyleName", type="String", inherit="no")] 
	/**
	 *  Height of each tab navigation item, in pixels. *  When this property is <code>undefined</code>, the height of each tab *  is determined by the font styles applied to the container. *  If you set this property, the specified value overrides this calculation. *  *  @default undefined
	 */
	[Style(name="tabHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Width of the tab navigation item, in pixels. *  If undefined, the default tab widths are calculated from the label text. *  *  @default undefined
	 */
	[Style(name="tabWidth", type="Number", format="Length", inherit="no")] 
	/**
	 * Vertical alignment of all tabs within the TabBar. Since individual  * tabs stretch to fill the entire TabBar, this style is only useful if you * use the tabHeight style and the combined heights of the tabs are less than * than the height of the TabBar. * Possible values are <code>"top"</code>, <code>"middle"</code>, * and <code>"bottom"</code>. * * @default "middle"
	 */
	[Style(name="verticalAlign", type="String", enumeration="top,middle,bottom", inherit="no")] 
	/**
	 *  Number of pixels between tab navigation items in the vertical direction. *  *  @default -1
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  The TabBar control lets you create a horizontal or vertical group of tab navigation  *  items by defining the labels and data associated with each tab. Use the  *  TabBar control instead of the TabNavigator container to create tabs that, by default, are not *  associated with multiple views. * *  <p>Using the TabBar control lets the tabs be directly determined by the *  data so that you can change the view or views in any way.</p> * *  <p>A TabBar control has the following default characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Preferred size</td> *           <td>A width wide enough to contain all label text, plus any padding, and a height tall enough for the label text. The default tab height is determined by the font, style, and skin applied to the control. If you set an explicit height using the tabHeight property, that value overrides the default value.</td> *        </tr> *        <tr> *           <td>Control resizing rules</td> *           <td>TabBar controls do not resize by default. Specify percentage sizes if you want your TabBar to resize based on the size of its parent container.</td> *        </tr> *        <tr> *           <td>Padding</td> *           <td>0 pixels for the left and right properties.</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:TabBar&gt;</code> tag inherits all of the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:TabBar *    <b>Styles</b> *    firstTabStyleName="<i>Value of the</i> <code>tabStyleName</code> <i>property</i>" *    horizontalAlign="left|center|right" *    horizontalGap="-1" *    lastTabStyleName="<i>Value of the</i> <code>tabStyleName</code> <i>property</i>" *    selectedTabTextStyleName="activeTabStyle" *    tabHeight="undefined" *    tabStyleName="Tab" *    tabWidth="undefined" *    verticalAlign="top|middle|bottom" *    verticalGap="-1" *  *    <b>Events</b> *    itemClick="<i>No default</i>" *    &gt; *    ... *       <i>child tags</i> *    ... *  &lt;/mx:TabBar&gt; *  </pre> * *  @includeExample examples/TabBarExample.mxml
	 */
	public class TabBar extends ToggleButtonBar
	{
		/**
		 *  @private     *  Placeholder for mixin by TabBarAccImpl.
		 */
		static var createAccessibilityImplementation : Function;

		/**
		 *  Constructor.
		 */
		public function TabBar ();
		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;
		/**
		 *  @private
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;
		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
		/**
		 *  @private     *  TabBars select the tab on mouse down instead of click.
		 */
		private function tab_mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function tab_doubleClickHandler (event:MouseEvent) : void;
	}
}
