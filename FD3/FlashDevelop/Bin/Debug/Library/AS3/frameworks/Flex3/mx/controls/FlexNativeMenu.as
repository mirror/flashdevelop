/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-03 13:18] ***/
/**********************************************************/
package mx.controls {
	public class FlexNativeMenu extends EventDispatcher implements ILayoutManagerClient, IFlexContextMenu {
		/**
		 * The object that accesses and manipulates data in the data provider.
		 *  The FlexNativeMenu control delegates to the data descriptor for information
		 *  about its data. This data is then used to parse and move about the
		 *  data source. The data descriptor defined for the FlexNativeMenu is used for
		 *  all child menus and submenus.
		 */
		public function get dataDescriptor():IMenuDataDescriptor;
		public function set dataDescriptor(value:IMenuDataDescriptor):void;
		/**
		 * The hierarchy of objects that are used to define the structure
		 *  of menu items in the NativeMenu. Individual data objects define
		 *  menu items, and items with child items become menus and submenus.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * A flag that indicates that the current data provider has a root node; for example,
		 *  a single top node in a hierarchical structure. XML and Object
		 *  are examples of types that have a root node, while Lists and Arrays do
		 *  not.
		 */
		public function get hasRoot():Boolean;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout: commitment, measurement, and layout (provided that any were required).
		 */
		public function get initialized():Boolean;
		public function set initialized(value:Boolean):void;
		/**
		 * The name of the field in the data provider that determines the
		 *  key equivalent for each menu item.  The set of values is defined
		 *  in the Keyboard class, in the KEYNAME_XXXX constants. For example,
		 *  consult that list for the value for a control character such as Home, Insert, etc.
		 */
		public function get keyEquivalentField():String;
		public function set keyEquivalentField(value:String):void;
		/**
		 * The function that determines the key equivalent for each menu item.
		 *  If you omit this property, Flex uses the contents of the field or
		 *  attribute specified by the keyEquivalentField property.
		 *  If you specify this property, Flex ignores any keyEquivalentField
		 *  property value.
		 */
		public function get keyEquivalentFunction():Function;
		public function set keyEquivalentFunction(value:Function):void;
		/**
		 * The function that determines the key equivalent modifiers for each menu item.
		 *  If you omit this property, Flex uses its own default function to determine the
		 *  Array of modifiers by looking in the data provider data for the presence of
		 *  the following (boolean) fields: altKey, cmdKey,
		 *  ctrlKey, and shiftKey.
		 */
		public function get keyEquivalentModifiersFunction():Function;
		public function set keyEquivalentModifiersFunction(value:Function):void;
		/**
		 * The name of the field in the data provider that determines the
		 *  text to display for each menu item. If the data provider is an Array of
		 *  Strings, Flex uses each string value as the label. If the data
		 *  provider is an E4X XML object, you must set this property explicitly.
		 *  For example, if each XML elementin an E4X XML Object includes a "label"
		 *  attribute containing the text to display for each menu item, set
		 *  the labelField to "@label".
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * The function that determines the text to display for each menu item.
		 *  The label function must find the appropriate field or fields in the
		 *  data provider and return a displayable string.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * The name of the field in the data provider that determines the
		 *  mnemonic index for each menu item.
		 */
		public function get mnemonicIndexField():String;
		public function set mnemonicIndexField(value:String):void;
		/**
		 * The function that determines the mnemonic index for each menu item.
		 */
		public function get mnemonicIndexFunction():Function;
		public function set mnemonicIndexFunction(value:Function):void;
		/**
		 * Returns the flash.display.NativeMenu managed by this object,
		 *  or null if there is not one.
		 *  Any changes made directly to the underlying NativeMenu instance
		 *  may be lost when changes are made to the menu or the underlying
		 *  data provider.
		 */
		public function get nativeMenu():NativeMenu;
		/**
		 * Depth of this object in the containment hierarchy.
		 *  This number is used by the measurement and layout code.
		 *  The value is 0 if this component is not on the DisplayList.
		 */
		public function get nestLevel():int;
		public function set nestLevel(value:int):void;
		/**
		 * Set to true after immediate or deferred child creation,
		 *  depending on which one happens. For a Container object, it is set
		 *  to true at the end of
		 *  the createComponentsFromDescriptors() method,
		 *  meaning after the Container object creates its children from its child descriptors.
		 */
		public function get processedDescriptors():Boolean;
		public function set processedDescriptors(value:Boolean):void;
		/**
		 * A Boolean flag that specifies whether to display the data provider's
		 *  root node.
		 */
		public function get showRoot():Boolean;
		public function set showRoot(value:Boolean):void;
		/**
		 * A flag that determines if an object has been through all three phases
		 *  of layout validation (provided that any were required).
		 */
		public function get updateCompletePendingFlag():Boolean;
		public function set updateCompletePendingFlag(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function FlexNativeMenu();
		/**
		 * Processes the properties set on the component.
		 */
		protected function commitProperties():void;
		/**
		 * Pops up this menu at the specified location.
		 *
		 * @param stage             <Stage> The Stage object on which to display this menu.
		 * @param stageX            <Number> The number of horizontal pixels, relative to the origin
		 *                            of stage, at which to display this menu.
		 * @param stageY            <Number> The number of vertical pixels, relative to the origin
		 *                            of stage, at which to display this menu.
		 */
		public function display(stage:Stage, stageX:Number, stageY:Number):void;
		/**
		 * Marks a component so that its commitProperties()
		 *  method gets called during a later screen update.
		 */
		public function invalidateProperties():void;
		/**
		 * Returns the key equivalent for the given data object
		 *  based on the keyEquivalentField and keyEquivalentFunction
		 *  properties. If the method cannot convert the parameter to a String, it returns an
		 *  empty string.
		 *
		 * @param data              <Object> Object to be displayed.
		 * @return                  <String> The key equivalent based on the data.
		 */
		protected function itemToKeyEquivalent(data:Object):String;
		/**
		 * Returns the key equivalent modifiers for the given data object
		 *  based on the keyEquivalentModifiersFunction property.
		 *  If the method cannot convert the parameter to an Array of modifiers,
		 *  it returns an empty Array.
		 *
		 * @param data              <Object> Object to be displayed.
		 * @return                  <Array> The array of key equivalent modifiers based on the data
		 */
		protected function itemToKeyEquivalentModifiers(data:Object):Array;
		/**
		 * Returns the String to use as the menu item label for the given data
		 *  object, based on the labelField and labelFunction
		 *  properties.
		 *  If the method cannot convert the parameter to a String, it returns a
		 *  single space.
		 *
		 * @param data              <Object> Object to be displayed.
		 * @return                  <String> The string to be displayed based on the data.
		 */
		protected function itemToLabel(data:Object):String;
		/**
		 * Returns the mnemonic index for the given data object
		 *  based on the mnemonicIndexField and mnemonicIndexFunction
		 *  properties. If the method cannot convert the parameter to an integer, it returns -1.
		 *
		 * @param data              <Object> Object to be displayed.
		 * @return                  <int> The mnemonic index based on the data.
		 */
		protected function itemToMnemonicIndex(data:Object):int;
		/**
		 * Extracts the mnemonic index from a label based on the presence of
		 *  an underscore character. It finds the leading underscore character if
		 *  there is one and uses that as the index.
		 *
		 * @param data              <String> 
		 */
		protected function parseLabelToMnemonicIndex(data:String):int;
		/**
		 * Determines the actual label to be used for the NativeMenuItem
		 *  by removing underscore characters and converting escaped underscore
		 *  characters, if there are any.
		 *
		 * @param data              <String> 
		 */
		protected function parseLabelToString(data:String):String;
		/**
		 * Sets the context menu of the InteractiveObject to the underlying native menu.
		 *
		 * @param component         <InteractiveObject> 
		 */
		public function setContextMenu(component:InteractiveObject):void;
		/**
		 * Unsets the context menu of the InteractiveObject that has been set to
		 *  the underlying native menu.
		 *
		 * @param component         <InteractiveObject> 
		 */
		public function unsetContextMenu(component:InteractiveObject):void;
		/**
		 * Validates the position and size of children and draws other
		 *  visuals.
		 *  If the LayoutManager.invalidateDisplayList() method is called with
		 *  this ILayoutManagerClient, then the validateDisplayList() method
		 *  is called when it's time to update the display list.
		 */
		public function validateDisplayList():void;
		/**
		 * Validates and updates the properties and layout of this object
		 *  and redraws it, if necessary.
		 */
		public function validateNow():void;
		/**
		 * Validates the properties of a component.
		 *  If the LayoutManager.invalidateProperties() method is called with
		 *  this ILayoutManagerClient, then the validateProperties() method
		 *  is called when it's time to commit property values.
		 */
		public function validateProperties():void;
		/**
		 * Validates the measured size of the component
		 *  If the LayoutManager.invalidateSize() method is called with
		 *  this ILayoutManagerClient, then the validateSize() method
		 *  is called when it's time to do measurements.
		 *
		 * @param recursive         <Boolean (default = false)> If true, call this method
		 *                            on the objects children.
		 */
		public function validateSize(recursive:Boolean = false):void;
	}
}
