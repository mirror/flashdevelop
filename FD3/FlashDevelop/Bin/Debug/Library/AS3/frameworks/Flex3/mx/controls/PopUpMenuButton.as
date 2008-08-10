/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.controls.menuClasses.IMenuDataDescriptor;
	import mx.core.IUIComponent;
	public class PopUpMenuButton extends PopUpButton {
		/**
		 * The data descriptor accesses and manipulates data in the data provider.
		 */
		public function get dataDescriptor():IMenuDataDescriptor;
		public function set dataDescriptor(value:IMenuDataDescriptor):void;
		/**
		 * DataProvider for popUpMenu.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * Name of the field in the dataProvider Array that contains the text to
		 *  show for each menu item.
		 *  The labelFunction property, if set, overrides this property.
		 *  If the data provider is an Array of Strings, Flex uses each String
		 *  value as the label.
		 *  If the data provider is an E4X XML object, you must set this property
		 *  explicitly; for example, use @label to specify the label attribute.
		 */
		public function get labelField():String;
		public function set labelField(value:String):void;
		/**
		 * A function that determines the text to display for each menu item.
		 *  If you omit this property, Flex uses the contents of the field or attribute
		 *  determined by the labelField property.
		 *  If you specify this property, Flex ignores any labelField
		 *  property value.
		 */
		public function get labelFunction():Function;
		public function set labelFunction(value:Function):void;
		/**
		 * A reference to the pop-up Menu object.
		 */
		public function set popUp(value:IUIComponent):void;
		/**
		 * Specifies whether to display the top-level node or nodes of the data provider.
		 *  If this is set to false, the control displays
		 *  only descendants of the first top-level node.
		 *  Any other top-level nodes are ignored.
		 *  You normally set this property to false for
		 *  E4X format XML data providers, where the top-level node is the document
		 *  object.
		 */
		public function get showRoot():Boolean;
		public function set showRoot(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function PopUpMenuButton();
	}
}
