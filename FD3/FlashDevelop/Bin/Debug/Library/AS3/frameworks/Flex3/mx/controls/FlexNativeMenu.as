package mx.controls
{
	import flash.display.InteractiveObject;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.xml.XMLNode;
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.core.Application;
	import mx.core.EventPriority;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexNativeMenuEvent;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.ISystemManager;

	/**
	 *  Dispatched before a menu or submenu is displayed. * *  @eventType mx.events.FlexNativeMenuEvent.MENU_SHOW
	 */
	[Event(name="menuShow", type="mx.events.FlexNativeMenuEvent")] 
	/**
	 *  Dispatched when a menu item is selected. * *  @eventType mx.events.FlexNativeMenuEvent.ITEM_CLICK
	 */
	[Event(name="itemClick", type="mx.events.FlexNativeMenuEvent")] 

	/**
	 *  The FlexNativeMenu component provides a wrapper for AIR's NativeMenu class. The FlexNativeMenu *  provides a way to define native operating system menus (such as window, application, and *  context menus) using techniques that are familiar to Flex developers and consistent with *  other Flex menu components, such as using MXML and data providers to specify menu structure. *  However, unlike Flex menu components, the menus that are defined by a FlexNativeMenu *  component are rendered by the host operating system as part of an AIR application, rather *  than being created as visual components by Flex. * *  <p>Like other Flex menu components, to define the structure of a menu represented by a *  FlexNativeMenu component, you create a data provider such as an XML hierarchy or an array *  of objects containing data to be used to define the menu. Several properties can be set to *  define how the data provider data is interpreted, such as the <code>labelField</code> property *  to specify the data field that is used for the menu item label, the <code>keyEquivalentField</code> *  property to specify the field that defines a keyboard equivalent shortcut for the menu item, *  and the <code>mnemonicIndexField</code> property to specify the field that defines the index *  position of the character in the label that is used as the menu item's mnemonic.</p> * *  <p>The data provider for FlexNativeMenu items can specify several attributes that determine how *  the item is displayed and behaves, as the following XML data provider shows:</p> *  <pre> *   &lt;mx:XML format=&quot;e4x&quot; id=&quot;myMenuData&quot;&gt; *     &lt;root&gt; *        &lt;menuitem label=&quot;MenuItem A&quot;&gt; *            &lt;menuitem label=&quot;SubMenuItem A-1&quot; enabled=&quot;False&quot;/&gt; *            &lt;menuitem label=&quot;SubMenuItem A-2&quot;/&gt; *        &lt;/menuitem&gt; *        &lt;menuitem label=&quot;MenuItem B&quot; type=&quot;check&quot; toggled=&quot;true&quot;/&gt; *        &lt;menuitem label=&quot;MenuItem C&quot; type=&quot;check&quot; toggled=&quot;false&quot;/&gt; *        &lt;menuitem type=&quot;separator&quot;/&gt; *        &lt;menuitem label=&quot;MenuItem D&quot;&gt; *            &lt;menuitem label=&quot;SubMenuItem D-1&quot;/&gt; *            &lt;menuitem label=&quot;SubMenuItem D-2&quot;/&gt; *            &lt;menuitem label=&quot;SubMenuItem D-3&quot;/&gt; *        &lt;/menuitem&gt; *    &lt;/root&gt; * &lt;/mx:XML&gt;</pre> * *  <p>The following table lists the attributes you can specify, *  their data types, their purposes, and how the data provider must represent *  them if the menu uses the DefaultDataDescriptor class to parse the data provider:</p> * *  <table class="innertable"> *  <tr> *    <th>Attribute</th> *    <th>Type</th> *    <th>Description</th> *  </tr> *  <tr> *    <td><code>altKey</code></td> *    <td>Boolean</td> *    <td>Specifies whether the Alt key is required as part of the key equivalent for the item.</td> *  </tr> *  <tr> *    <td><code>cmdKey</code></td> *    <td>Boolean</td> *    <td>Specifies whether the Command key is required as part of the key equivalent for the item.</td> *  </tr> *  <tr> *    <td><code>ctrlKey</code></td> *    <td>Boolean</td> *    <td>Specifies whether the Control key is required as part of the key equivalent for the item.</td> *  </tr> *  <tr> *    <td><code>enabled</code></td> *    <td>Boolean</td> *    <td>Specifies whether the user can select the menu item (<code>true</code>), *      or not (<code>false</code>). If not specified, Flex treats the item as if *      the value were <code>true</code>. *      If you use the default data descriptor, data providers must use an <code>enabled</code> *      XML attribute or object field to specify this characteristic.</td> *  </tr> *  <tr> *    <td><code>keyEquivalent</code></td> *    <td>String</td> *    <td>Specifies a keyboard character which, when pressed, triggers an event as though *        the menu item was selected. The menu's <code>keyEqui
	 */
	public class FlexNativeMenu extends EventDispatcher implements ILayoutManagerClient
	{
		/**
		 *  The character to use to indicate the mnemonic index in a label.  By     *  default, it is the underscore character, so in "C_ut", u would become     *  the character for the mnemonic index.
		 */
		private static var MNEMONIC_INDEX_CHARACTER : String;
		/**
		 *  @private	 *  Storage for the initialized property.
		 */
		private var _initialized : Boolean;
		/**
		 *  @private	 *  Storage for the nestLevel property.
		 */
		private var _nestLevel : int;
		/**
		 *  @private	 *  Storage for the processedDescriptors property.
		 */
		private var _processedDescriptors : Boolean;
		/**
		 *  @private	 *  Storage for the updateCompletePendingFlag property.
		 */
		private var _updateCompletePendingFlag : Boolean;
		/**
		 *  @private     *  Whether this component needs to have its     *  commitProperties() method called.
		 */
		private var invalidatePropertiesFlag : Boolean;
		/**
		 * @private
		 */
		private var _nativeMenu : NativeMenu;
		/**
		 *  @private
		 */
		private var dataDescriptorChanged : Boolean;
		/**
		 *  @private
		 */
		private var _dataDescriptor : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private     *  Storage variable for the original dataProvider
		 */
		local var _rootModel : ICollectionView;
		/**
		 *  @private     *  Flag to indicate if the model has a root
		 */
		private var _hasRoot : Boolean;
		/**
		 *  @private
		 */
		private var keyEquivalentFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var _keyEquivalentField : String;
		/**
		 *  @private
		 */
		private var _keyEquivalentFunction : Function;
		/**
		 *  @private
		 */
		private var keyEquivalentModifiersFunctionChanged : Boolean;
		/**
		 *  @private
		 */
		private var _keyEquivalentModifiersFunction : Function;
		/**
		 *  @private
		 */
		private var labelFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var _labelField : String;
		/**
		 *  @private
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
		 */
		private var mnemonicIndexFieldChanged : Boolean;
		/**
		 *  @private
		 */
		private var _mnemonicIndexField : String;
		/**
		 *  @private
		 */
		private var _mnemonicIndexFunction : Function;
		/**
		 *  @private     *  Storage variable for showRoot flag.
		 */
		private var _showRoot : Boolean;
		/**
		 *  @private
		 */
		private var showRootChanged : Boolean;

		/**
		 *  @copy mx.core.UIComponent#initialized
		 */
		public function get initialized () : Boolean;
		/**
		 *  @private
		 */
		public function set initialized (value:Boolean) : void;
		/**
		 *  @copy mx.core.UIComponent#nestLevel
		 */
		public function get nestLevel () : int;
		/**
		 *  @private
		 */
		public function set nestLevel (value:int) : void;
		/**
		 *  @copy mx.core.UIComponent#processedDescriptors
		 */
		public function get processedDescriptors () : Boolean;
		/**
		 *  @private
		 */
		public function set processedDescriptors (value:Boolean) : void;
		/**
		 *  A flag that determines if an object has been through all three phases	 *  of layout validation (provided that any were required).
		 */
		public function get updateCompletePendingFlag () : Boolean;
		/**
		 *  @private
		 */
		public function set updateCompletePendingFlag (value:Boolean) : void;
		/**
		 *  Returns the flash.display.NativeMenu managed by this object,      *  or null if there is not one.      *      *  Any changes made directly to the underlying NativeMenu instance	  *  may be lost when changes are made to the menu or the underlying	  *  data provider.
		 */
		public function get nativeMenu () : NativeMenu;
		/**
		 *  The object that accesses and manipulates data in the data provider.     *  The FlexNativeMenu control delegates to the data descriptor for information     *  about its data. This data is then used to parse and move about the     *  data source. The data descriptor defined for the FlexNativeMenu is used for     *  all child menus and submenus.     *     *  <p>When you specify this property as an attribute in MXML, you must     *  use a reference to the data descriptor, not the string name of the     *  descriptor. Use the following format for setting the property:</p>     *     * <pre>&lt;mx:FlexNativeMenu id="flexNativeMenu" dataDescriptor="{new MyCustomDataDescriptor()}"/&gt;</pre>     *     *  <p>Alternatively, you can specify the property in MXML as a nested     *  subtag, as the following example shows:</p>     *     *  <pre>&lt;mx:FlexNativeMenu&gt;     *  &lt;mx:dataDescriptor&gt;     *     &lt;myCustomDataDescriptor&gt;     *  &lt;/mx:dataDescriptor&gt;     *  ...</pre>     *     *  <p>The default value is an internal instance of the     *  DefaultDataDescriptor class.</p>
		 */
		public function get dataDescriptor () : IMenuDataDescriptor;
		/**
		 *  @private
		 */
		public function set dataDescriptor (value:IMenuDataDescriptor) : void;
		/**
		 *  The hierarchy of objects that are used to define the structure	 *  of menu items in the NativeMenu. Individual data objects define	 *  menu items, and items with child items become menus and submenus.     *     *  <p>The FlexNativeMenu control handles the source data object as follows:</p>	 *     *  <ul>     *    <li>A String containing valid XML text is converted to an XML object.</li>     *    <li>An XMLNode is converted to an XML object.</li>     *    <li>An XMLList is converted to an XMLListCollection.</li>     *    <li>Any object that implements the ICollectionView interface is cast to     *        an ICollectionView.</li>     *    <li>An Array is converted to an ArrayCollection.</li>     *    <li>Any other type object is wrapped in an Array with the object as its sole     *        entry.</li>     *  </ul>     *     *  @default "undefined"
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  @copy mx.controls.Menu#hasRoot
		 */
		public function get hasRoot () : Boolean;
		/**
		 *  The name of the field in the data provider that determines the     *  key equivalent for each menu item.  The set of values is defined	 *  in the Keyboard class, in the <code>KEYNAME_XXXX</code> constants. For example,	 *  consult that list for the value for a control character such as Home, Insert, etc.     *     *  <p>Setting the <code>keyEquivalentFunction</code> property causes this property to be ignored.</p>     *     *  @default "keyEquivalent"     *  @see flash.ui.Keyboard
		 */
		public function get keyEquivalentField () : String;
		/**
		 *  @private
		 */
		public function set keyEquivalentField (value:String) : void;
		/**
		 *  The function that determines the key equivalent for each menu item.     *  If you omit this property, Flex uses the contents of the field or     *  attribute specified by the <code>keyEquivalentField</code> property.     *  If you specify this property, Flex ignores any <code>keyEquivalentField</code>     *  property value.     *     *  <p>The <code>keyEquivalentFunction</code> property is good for handling formatting,     *  localization, and platform independence.</p>     *     *  <p>The key equivalent function must take a single argument, which is the item     *  in the data provider, and must return a String.</p>	 *     *  <pre><code>myKeyEquivalentFunction(item:Object):String</code></pre>     *     *  @default "undefined"     *  @see flash.ui.Keyboard
		 */
		public function get keyEquivalentFunction () : Function;
		/**
		 *  @private
		 */
		public function set keyEquivalentFunction (value:Function) : void;
		/**
		 *  The function that determines the key equivalent modifiers for each menu item.     *     *  If you omit this property, Flex uses its own default function to determine the     *  Array of modifiers by looking in the data provider data for the presence of	 *  the following (boolean) fields: <code>altKey</code>, <code>cmdKey</code>,	 *  <code>ctrlKey</code>, and <code>shiftKey</code>.     *     *  <p>The <code>keyEquivalentModifiersFunction</code> property is good for handling     *  formatting, localization, and platform independence.</p>     *     *  <p>The key equivalent modifiers function must take a single argument, which     *  is the item in the data provider, and must return an array of modifier key names.</p>	 *     *  <pre><code>myKeyEquivalentModifiersFunction(item:Object):Array</code></pre>     *     *  @default "undefined"
		 */
		public function get keyEquivalentModifiersFunction () : Function;
		/**
		 *  @private
		 */
		public function set keyEquivalentModifiersFunction (value:Function) : void;
		/**
		 *  The name of the field in the data provider that determines the     *  text to display for each menu item. If the data provider is an Array of     *  Strings, Flex uses each string value as the label. If the data     *  provider is an E4X XML object, you must set this property explicitly.     *  For example, if each XML elementin an E4X XML Object includes a "label"	 *  attribute containing the text to display for each menu item, set	 *  the labelField to <code>"&#064;label"</code>.     *     *  <p>In a label, you can specify the character to be used as the mnemonic index     *  by preceding it with an underscore. For example, a label value of <code>"C_ut"</code>	 *  sets the mnemonic index to 1. Only the first underscore present is used for this	 *  purpose.  To display a literal underscore character in the label, you can escape it	 *  using a double underscore. For example, a label value of <code>"C__u_t"</code> would	 *  result in a menu item with the label "C_ut" and a mnemonic index of 3 (the "t"	 *  character). If the field defined in the <code>mnemonicIndexField</code> property	 *  is present and set to a value greater than zero, that value takes precedence over	 *  any underscore-specified mnemonic index value.</p>     *     *  <p>Setting the <code>labelFunction</code> property causes this property to be ignored.</p>     *     *  @default "label"
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  The function that determines the text to display for each menu item.     *  The label function must find the appropriate field or fields in the     *  data provider and return a displayable string.     *     *  <p>If you omit this property, Flex uses the contents of the field or     *  attribute specified by the <code>labelField</code> property.     *  If you specify this property, Flex ignores any <code>labelField</code>     *  property value.</p>     *     *  <p>The <code>labelFunction</code> property can be helpful for handling formatting,     *  localization, and platform-independence.</p>     *     *  <p>The label function must take a single argument, which is the item     *  in the data provider, and must return a String.</p>	 *     *  <pre><code>myLabelFunction(item:Object):String</code></pre>     *     *  @default "undefined"
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  The name of the field in the data provider that determines the     *  mnemonic index for each menu item.     *     *  <p>If the field specified by this property contains a number greater	 *  than zero, that mnemonic index     *  takes precedence over one specified by an underscore in the label.</p>     *     *  <p>Setting the <code>mnemonicIndexFunction</code> property causes	 *  this property to be ignored.</p>     *     *  @default "mnemonicIndex"	 *	 *  @see #labelField
		 */
		public function get mnemonicIndexField () : String;
		/**
		 *  @private
		 */
		public function set mnemonicIndexField (value:String) : void;
		/**
		 *  The function that determines the mnemonic index for each menu item.     *     *  <p>If you omit this property, Flex uses the contents of the field or     *  attribute specified by the <code>mnemonicIndexField</code> property.     *  If you specify this property, Flex ignores any <code>mnemonicIndexField</code>     *  property value.</p>     *     *  <p>If this property is defined and the function returns a number greater than	 *  zero for a data item, the returned mnemonic index     *  takes precedence over one specified by an underscore in the label.</p>     *     *  <p>The <code>mnemonicIndexFunction</code> property is good for handling formatting,     *  localization, and platform independence.</p>     *     *  <p>The mnemonic index function must take a single argument which is the item     *  in the data provider and return an int.</p>	 *     *  <pre><code>myMnemonicIndexFunction(item:Object):int</code></pre>     *     *  @default "undefined"
		 */
		public function get mnemonicIndexFunction () : Function;
		/**
		 *  @private
		 */
		public function set mnemonicIndexFunction (value:Function) : void;
		/**
		 *  A Boolean flag that specifies whether to display the data provider's     *  root node.     *     *  <p>If the data provider has a root node, and the <code>showRoot</code> property     *  is set to <code>false</code>, the top-level menu items displayed by the	 *  FlexNativeMenu control correspond to the immediate descendants of the root node.</p>     *     *  <p>This flag has no effect when using a data provider without a root nodes,     *  such as a List or Array.</p>     *     *  @default true     *  @see #hasRoot
		 */
		public function get showRoot () : Boolean;
		/**
		 *  @private
		 */
		public function set showRoot (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FlexNativeMenu ();
		private function keyEquivalentModifiersDefaultFunction (data:Object) : Array;
		/**
		 *  @copy mx.core.UIComponent#invalidateProperties()
		 */
		public function invalidateProperties () : void;
		/**
		 *  @private
		 */
		public function validatePropertiesTimerHandler (event:TimerEvent) : void;
		/**
		 *  @inheritDoc
		 */
		public function validateProperties () : void;
		/**
		 *  @inheritDoc
		 */
		public function validateSize (recursive:Boolean = false) : void;
		/**
		 *  @inheritDoc
		 */
		public function validateDisplayList () : void;
		/**
		 *  Validates and updates the properties and layout of this object	 *  and redraws it, if necessary.
		 */
		public function validateNow () : void;
		/**
		 *  Sets the context menu of the InteractiveObject to the underlying native menu.
		 */
		public function setContextMenu (component:InteractiveObject) : void;
		/**
		 *  Unsets the context menu of the InteractiveObject that has been set to	 *  the underlying native menu.
		 */
		public function unsetContextMenu (component:InteractiveObject) : void;
		/**
		 *  Processes the properties set on the component.	 *	 *  @see mx.core.UIComponent#commitProperties()
		 */
		protected function commitProperties () : void;
		/**
		 *  Creates a menu and adds appropriate listeners     *     *  @private
		 */
		private function createMenu () : NativeMenu;
		/**
		 *  Clears out all items in a given menu     *     *  @private
		 */
		private function clearMenu (menu:NativeMenu) : void;
		/**
		 *  Populates a menu and the related submenus given a collection     *     *  @private
		 */
		private function populateMenu (menu:NativeMenu, collection:ICollectionView) : NativeMenu;
		/**
		 *  Adds the NativeMenuItem to the NativeMenu.  This methods looks at the     *  properties of the data sent in and sets them properly on the NativeMenuItem.     *     *  @private
		 */
		private function insertMenuItem (menu:NativeMenu, index:int, data:Object) : void;
		/**
		 *  @copy flash.display.NativeMenu#display()
		 */
		public function display (stage:Stage, x:int, y:int) : void;
		/**
		 *  Returns the key equivalent for the given data object     *  based on the <code>keyEquivalentField</code> and <code>keyEquivalentFunction</code>	 *  properties. If the method cannot convert the parameter to a String, it returns an     *  empty string.     *     *  @param data Object to be displayed.     *     *  @return The key equivalent based on the data.
		 */
		protected function itemToKeyEquivalent (data:Object) : String;
		/**
		 *  Returns the key equivalent modifiers for the given data object     *  based on the <code>keyEquivalentModifiersFunction</code> property.     *  If the method cannot convert the parameter to an Array of modifiers,     *  it returns an empty Array.     *     *  @param data Object to be displayed.     *     *  @return The array of key equivalent modifiers based on the data
		 */
		protected function itemToKeyEquivalentModifiers (data:Object) : Array;
		/**
		 *  Returns the String to use as the menu item label for the given data	 *  object, based on the <code>labelField</code> and <code>labelFunction</code>	 *  properties.     *  If the method cannot convert the parameter to a String, it returns a     *  single space.     *     *  @param data Object to be displayed.     *     *  @return The string to be displayed based on the data.
		 */
		protected function itemToLabel (data:Object) : String;
		/**
		 *  Returns the mnemonic index for the given data object     *  based on the <code>mnemonicIndexField</code> and <code>mnemonicIndexFunction</code>	 *  properties. If the method cannot convert the parameter to an integer, it returns -1.     *     *  @param data Object to be displayed.     *     *  @return The mnemonic index based on the data.
		 */
		protected function itemToMnemonicIndex (data:Object) : int;
		/**
		 *  Determines the actual label to be used for the NativeMenuItem     *  by removing underscore characters and converting escaped underscore	 *  characters, if there are any.
		 */
		protected function parseLabelToString (data:String) : String;
		/**
		 *  Extracts the mnemonic index from a label based on the presence of	 *  an underscore character. It finds the leading underscore character if     *  there is one and uses that as the index.
		 */
		protected function parseLabelToMnemonicIndex (data:String) : int;
		/**
		 *  @private
		 */
		private function itemSelectHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function menuDisplayHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function collectionChangeHandler (ce:CollectionEvent) : void;
	}
}
