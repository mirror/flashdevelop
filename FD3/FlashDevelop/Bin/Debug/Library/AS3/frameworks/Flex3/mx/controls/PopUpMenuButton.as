package mx.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.collections.CursorBookmark;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;

	/**
	 *  Dispatched when a user selects an item from the pop-up menu.
 *
 *  @eventType mx.events.MenuEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.MenuEvent")] 

	/**
	 *  The name of a CSS style declaration used by the dropdown menu.  
 *  This property allows you to control the appearance of the dropdown menu.
 *  The default value sets the <code>fontWeight</code> to <code>normal</code> and 
 *  the <code>textAlign</code> to <code>left</code>.
 *
 *  @default "popUpMenu"
	 */
	[Style(name="popUpStyleName", type="String", inherit="no")] 

	[Exclude(name="toggle", kind="property")] 

	[Exclude(name="selectedDisabledIcon", kind="style")] 

	[Exclude(name="selectedDisabledSkin", kind="style")] 

	[Exclude(name="selectedDownIcon", kind="style")] 

	[Exclude(name="selectedDownSkin", kind="style")] 

	[Exclude(name="selectedOverIcon", kind="style")] 

	[Exclude(name="selectedOverSkin", kind="style")] 

	[Exclude(name="selectedUpIcon", kind="style")] 

	[Exclude(name="selectedUpSkin", kind="style")] 

include "../core/Version.as"
	/**
	 *  The PopUpMenuButton control creates a PopUpButton control with a main
 *  sub-button and a secondary sub-button.
 *  Clicking on the secondary (right) sub-button drops down a menu that
 *  can be popluated through a <code>dataProvider</code> property. 
 *  Unlike the Menu and MenuBar controls, the PopUpMenuButton control 
 *  supports only a single-level menu. This means that the menu cannot contain
 *  cascading submenus.
 * 
 *  <p>The main sub-button of the PopUpMenuButton control can have a 
 *     text label, an icon, or both on its face.
 *     When a user selects an item from the drop-down menu or clicks 
 *     the main button of the PopUpMenuButton control, the control 
 *     dispatches an <code>itemClick</code> event.
 *     When a user clicks the main button of the 
 *     control, the control also dispatches a <code>click</code> event. 
 *     You can customize the look of a PopUpMenuButton control.</p>
 *
 *  <p>The PopUpMenuButton control has the following sizing 
 *     characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>Sufficient to accommodate the label and any icon on 
 *               the main button, and the icon on the pop-up button. 
 *               The control does not reserve space for the menu.</td>
 *        </tr>
 *        <tr>
 *           <td>Minimum size</td>
 *           <td>0 pixels.</td>
 *        </tr>
 *        <tr>
 *           <td>Maximum size</td>
 *           <td>10000 by 10000.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:PopUpMenuButton&gt;</code> tag inherits all of the tag
 *  attributes of its superclass, and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:PopUpMenuButton
 *    <strong>Properties</strong>
 *    dataDescriptor="<i>instance of DefaultDataDescriptor</i>"
 *    dataProvider="undefined"
 *    iconField="icon"
 *    iconFunction="undefined"
 *    labelField="label"
 *    labelFunction="undefined"
 *    showRoot="false|true"
 *    &nbsp;
 *    <strong>Event</strong>
 *    change=<i>No default</i>
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/PopUpButtonMenuExample.mxml
 *
 *  @see mx.controls.Menu
 *  @see mx.controls.MenuBar
 *
 *  @tiptext Provides ability to pop up a menu and act as a button
 *  @helpid 3441
	 */
	public class PopUpMenuButton extends PopUpButton
	{
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private
		 */
		private var labelSet : Boolean;
		/**
		 *  @private
		 */
		private var popUpMenu : Menu;
		/**
		 *  @private
		 */
		private var selectedIndex : int;
		/**
		 *  @private
		 */
		private var itemRenderer : IListItemRenderer;
		/**
		 *  @private
		 */
		private var explicitIcon : Class;
		/**
		 *  @private
		 */
		private var menuSelectedStyle : Boolean;
		/**
		 *  @private
     *  Storage for the dataDescriptor property.
		 */
		private var _dataDescriptor : IMenuDataDescriptor;
		/**
		 *  @private
     *  Storage for dataProvider property.
		 */
		private var _dataProvider : Object;
		/**
		 *  @private
     *  Storage for the iconField property.
		 */
		private var _iconField : String;
		/**
		 *  @private
     *  Storage for the iconFunction property.
		 */
		private var _iconFunction : Function;
		/**
		 *  @private
     *  Storage for the label property.
		 */
		private var _label : String;
		/**
		 *  @private
     *  Storage for the labelField property.
		 */
		private var _labelField : String;
		/**
		 *  @private
     *  Storage for the labelFunction property.
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
     *  Storage for the showRoot property.
		 */
		var _showRoot : Boolean;
		/**
		 *  @private
		 */
		private var _showRootChanged : Boolean;

		/**
		 *  A reference to the pop-up Menu object.
     *
     *  <p>This property is read-only, and setting it has no effect.
     *  Set the <code>dataProvider</code> property, instead.
     *  (The write-only indicator appears in the syntax summary because the
     *  property in the superclass is read-write and this class overrides
     *  the setter with an empty implementation.)</p>
		 */
		public function set popUp (value:IUIComponent) : void;

		/**
		 *  The data descriptor accesses and manipulates data in the data provider.
     *  <p>When you specify this property as an attribute in MXML, you must
     *  use a reference to the data descriptor, not the string name of the
     *  descriptor. Use the following format for the property:</p>
     *
     *  <pre>&lt;mx:PopUpMenuButton id="menubar" dataDescriptor="{new MyCustomDataDescriptor()}"/&gt;</pre>
     *
     *  <p>Alternatively, you can specify the property in MXML as a nested
     *  subtag, as the following example shows:</p>
     *
     *  <pre>&lt;mx:PopUpMenuButton&gt;
     *  &lt;mx:dataDescriptor&gt;
     *     &lt;myCustomDataDescriptor&gt;
     *  &lt;/mx:dataDescriptor&gt;
     *  ...</pre>
     *
     *  <p>The default value is an internal instance of the
     *  DefaultDataDescriptor class.</p>
		 */
		public function get dataDescriptor () : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		public function set dataDescriptor (value:IMenuDataDescriptor) : void;

		/**
		 *  DataProvider for popUpMenu.
     *
     *  @default null
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;

		/**
		 *  Name of the field in the <code>dataProvider</code> Array that contains the icon to
     *  show for each menu item.
     *  The <code>iconFunction</code> property, if set, overrides this property.
     * 
     *  <p>The renderers will look in the data provider object for a property of 
     *  the name supplied as the iconField.  If the value of the property is a 
     *  Class, it will instantiate that class and expect it to be an instance 
     *  of an IFlexDisplayObject. If the value of the property is a String, 
     *  it will look to see if a Class exists with that name in the application, 
     *  and if it can't find one, it will also look for a property on the 
     *  document with that name and expect that property to map to a Class.</p>
     * 
     *  If the data provider is an E4X XML object, you must set this property
     *  explicitly; for example, use &#064;icon to specify the <code>icon</code> attribute.
     *
     *  @default "icon"
		 */
		public function get iconField () : String;
		/**
		 *  @private
		 */
		public function set iconField (value:String) : void;

		/**
		 *  A function that determines the icon to display for each menu item.
     *  If you omit this property, Flex uses the contents of the field or attribute
     *  determined by the <code>iconField</code> property.
     *  If you specify this property, Flex ignores any <code>iconField</code>
     *  property value.
     *
     *  By default the menu does not try to display icons with the text 
     *  in the rows.  However, by specifying an icon function, you can specify 
     *  a Class for a graphic that will be created and displayed as an icon 
     *  in the row. 
     *
     *  <p>The iconFunction takes a single argument which is the item
     *  in the data provider and returns a Class.</p>
     * 
     *  <blockquote>
     *  <code>iconFunction(item:Object):Class</code>
     *  </blockquote>
     *
     *  @default null
		 */
		public function get iconFunction () : Function;
		/**
		 *  @private
		 */
		public function set iconFunction (value:Function) : void;

		/**
		 *  @private
		 */
		public function set label (value:String) : void;

		/**
		 *  Name of the field in the <code>dataProvider</code> Array that contains the text to
     *  show for each menu item.
     *  The <code>labelFunction</code> property, if set, overrides this property.
     *  If the data provider is an Array of Strings, Flex uses each String
     *  value as the label.
     *  If the data provider is an E4X XML object, you must set this property
     *  explicitly; for example, use &#064;label to specify the <code>label</code> attribute.
     *
     *  @default "label"
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;

		/**
		 *  A function that determines the text to display for each menu item.
     *  If you omit this property, Flex uses the contents of the field or attribute
     *  determined by the <code>labelField</code> property.
     *  If you specify this property, Flex ignores any <code>labelField</code>
     *  property value.
     *
     *  <p>If you specify this property, the label function must find the
     *  appropriate field or fields and return a displayable string.
     *  The <code>labelFunction</code> property is good for handling formatting
     *  and localization.</p>
     *
     *  <p>The label function must take a single argument which is the item
     *  in the dataProvider and return a String.</p>
     * 
     *  <blockquote>
     *  <code>labelFunction(item:Object):String</code>
     *  </blockquote>
     *
     *  @default null
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;

		/**
		 *  Specifies whether to display the top-level node or nodes of the data provider.
     *
     *  If this is set to <code>false</code>, the control displays
     *  only descendants of the first top-level node.
     *  Any other top-level nodes are ignored.
     *  You normally set this property to <code>false</code> for
     *  E4X format XML data providers, where the top-level node is the document
     *  object.
     *
     *  @default true
		 */
		public function get showRoot () : Boolean;
		/**
		 *  @private
		 */
		public function set showRoot (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function PopUpMenuButton ();

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		function getPopUp () : IUIComponent;

		/**
		 *  @private
		 */
		private function setSafeIcon (iconClass:Class) : void;

		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function menuClickHandler (event:MouseEvent) : void;

		/**
		 *  @private
		 */
		private function menuValueCommitHandler (event:FlexEvent) : void;

		/**
		 *  @private
		 */
		private function menuChangeHandler (event:MenuEvent) : void;
	}
}
