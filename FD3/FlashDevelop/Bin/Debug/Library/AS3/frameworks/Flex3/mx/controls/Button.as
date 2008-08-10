/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.managers.IFocusManagerComponent;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.IFontContextComponent;
	import mx.core.IButton;
	import mx.core.IFlexModuleFactory;
	import mx.controls.listClasses.BaseListData;
	import flash.events.MouseEvent;
	public class Button extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IListItemRenderer, IFontContextComponent, IButton {
		/**
		 * Specifies whether to dispatch repeated buttonDown
		 *  events if the user holds down the mouse button.
		 */
		public function get autoRepeat():Boolean;
		public function set autoRepeat(value:Boolean):void;
		/**
		 * The data property lets you pass a value
		 *  to the component when you use it as an item renderer or item editor.
		 *  You typically use data binding to bind a field of the data
		 *  property to a property of this component.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Draws a thick border around the Button control
		 *  when the control is in its up state if emphasized
		 *  is set to true.
		 */
		public function get emphasized():Boolean;
		public function set emphasized(value:Boolean):void;
		/**
		 * The module factory that provides the font context for this component.
		 */
		public function get fontContext():IFlexModuleFactory;
		public function set fontContext(value:IFlexModuleFactory):void;
		/**
		 * Text to appear on the Button control.
		 */
		public function get label():String;
		public function set label(value:String):void;
		/**
		 * Orientation of the label in relation to a specified icon.
		 *  Valid MXML values are right, left,
		 *  bottom, and top.
		 */
		public function get labelPlacement():String;
		public function set labelPlacement(value:String):void;
		/**
		 * When a component is used as a drop-in item renderer or drop-in
		 *  item editor, Flex initializes the listData property
		 *  of the component with the appropriate data from the list control.
		 *  The component can then use the listData property
		 *  to initialize the data property
		 *  of the drop-in item renderer or drop-in item editor.
		 */
		public function get listData():BaseListData;
		public function set listData(value:BaseListData):void;
		/**
		 * Indicates whether a toggle button is toggled
		 *  on (true) or off (false).
		 *  This property can be set only if the toggle property
		 *  is set to true.
		 */
		public function get selected():Boolean;
		public function set selected(value:Boolean):void;
		/**
		 * The name of the field in the data property which specifies
		 *  the value of the Button control's selected property.
		 *  You can set this property when you use the Button control in an item renderer.
		 *  The default value is null, which means that the Button control does
		 *  not set its selected state based on a property in the data property.
		 */
		public var selectedField:String = "null";
		/**
		 * If false, the Button displays its down skin
		 *  when the user presses it but changes to its over skin when
		 *  the user drags the mouse off of it.
		 *  If true, the Button displays its down skin
		 *  when the user presses it, and continues to display this skin
		 *  when the user drags the mouse off of it.
		 */
		public var stickyHighlighting:Boolean = false;
		/**
		 * The internal UITextField object that renders the label of this Button.
		 */
		protected var textField:IUITextField;
		/**
		 * Controls whether a Button is in a toggle state or not.
		 *  If true, clicking the button toggles it
		 *  between a selected and an unselected state.
		 *  You can get or set this state programmatically
		 *  by using the selected property.
		 *  If false, the button does not stay pressed
		 *  after the user releases it.
		 *  In this case, its selected property
		 *  is always false.
		 *  Buttons like this are used for performing actions.
		 *  When toggle is set to false,
		 *  selected is forced to false
		 *  because only toggle buttons can be selected.
		 */
		public function get toggle():Boolean;
		public function set toggle(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function Button();
		/**
		 * The default handler for the MouseEvent.CLICK event.
		 *
		 * @param event             <MouseEvent> event object.
		 */
		protected function clickHandler(event:MouseEvent):void;
		/**
		 * The default handler for the MouseEvent.MOUSE_DOWN event.
		 *
		 * @param event             <MouseEvent> event object.
		 */
		protected function mouseDownHandler(event:MouseEvent):void;
		/**
		 * The default handler for the MouseEvent.MOUSE_UP event.
		 *
		 * @param event             <MouseEvent> event object.
		 */
		protected function mouseUpHandler(event:MouseEvent):void;
		/**
		 * The default handler for the MouseEvent.ROLL_OUT event.
		 *
		 * @param event             <MouseEvent> event object.
		 */
		protected function rollOutHandler(event:MouseEvent):void;
		/**
		 * The default handler for the MouseEvent.ROLL_OVER event.
		 *
		 * @param event             <MouseEvent> event object.
		 */
		protected function rollOverHandler(event:MouseEvent):void;
	}
}
