/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.core.IIMESupport;
	import mx.managers.IFocusManagerComponent;
	import mx.core.EdgeMetrics;
	import flash.events.Event;
	import mx.events.FlexEvent;
	public class ComboBase extends UIComponent implements IIMESupport, IFocusManagerComponent {
		/**
		 * Set of styles to pass from the ComboBase to the down arrow button
		 */
		protected function get arrowButtonStyleFilters():Object;
		/**
		 * Returns an EdgeMetrics object that has four properties:
		 *  left, top, right,
		 *  and bottom.
		 *  The value of each property is equal to the thickness of the
		 *  corresponding side of the border, expressed in pixels.
		 */
		protected function get borderMetrics():EdgeMetrics;
		/**
		 * The ICollectionView of items this component displays.
		 */
		protected var collection:ICollectionView;
		/**
		 * The set of items this component displays. This property is of type
		 *  Object because the derived classes can handle a variety of data
		 *  types such as Arrays, XML, ICollectionViews, and other classes.  All
		 *  are converted into an ICollectionView and that ICollectionView is
		 *  returned if you get the value of this property; you will not get the
		 *  value you set if it was not an ICollectionView.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * A flag that indicates whether the control is editable,
		 *  which lets the user directly type entries that are not specified
		 *  in the dataProvider, or not editable, which requires the user select
		 *  from the items in the dataProvider.
		 */
		public function get editable():Boolean;
		public function set editable(value:Boolean):void;
		/**
		 * Specifies the IME (input method editor) mode.
		 *  The IME enables users to enter text in Chinese, Japanese, and Korean.
		 *  Flex sets the specified IME mode when the control gets the focus,
		 *  and sets it back to the previous value when the control loses the focus.
		 */
		public function get imeMode():String;
		public function set imeMode(value:String):void;
		/**
		 * The main IViewCursor used to fetch items from the
		 *  dataProvider and pass the items to the renderers.
		 *  At the end of any sequence of code, it must always be positioned
		 *  at the topmost visible item on screen.
		 */
		protected var iterator:IViewCursor;
		/**
		 * Set of characters that a user can or cannot enter into the text field.
		 */
		public function get restrict():String;
		public function set restrict(value:String):void;
		/**
		 * The index in the data provider of the selected item.
		 *  If there is a prompt property, the selectedIndex
		 *  value can be set to -1 to show the prompt.
		 *  If there is no prompt, property then selectedIndex
		 *  will be set to 0 once a dataProvider is set.
		 */
		public function get selectedIndex():int;
		public function set selectedIndex(value:int):void;
		/**
		 * The item in the data provider at the selectedIndex.
		 */
		public function get selectedItem():Object;
		public function set selectedItem(value:Object):void;
		/**
		 * Contents of the text field.  If the control is non-editable
		 *  setting this property has no effect. If the control is editable,
		 *  setting this property sets the contents of the text field.
		 */
		public function get text():String;
		public function set text(value:String):void;
		/**
		 * The internal TextInput subcomponent that displays
		 *  the current selection.
		 */
		protected var textInput:TextInput;
		/**
		 * The set of styles to pass from the ComboBase to the text input.
		 *  These styles are ignored if you set
		 *  the textInputStyleName style property.
		 */
		protected function get textInputStyleFilters():Object;
		/**
		 * The value of the selected item. If the item is a Number or String,
		 *  the value is the item. If the item is an object, the value is
		 *  the data property, if it exists, or the label
		 *  property, if it exists.
		 */
		public function get value():Object;
		/**
		 * Constructor.
		 */
		public function ComboBase();
		/**
		 * Determines default values of the height and width to use for the
		 *  entries in the drop-down list.
		 *  Each subclass of ComboBase must implement this method and return
		 *  an Object containing two properties: width and
		 *  height.
		 *
		 * @param numItems          <int> The number of items to check to determine the size
		 * @return                  <Object> An Object with width and height
		 *                            properties
		 */
		protected function calculatePreferredSizeFromData(numItems:int):Object;
		/**
		 * Responds to changes to the data provider.  The component will adjust
		 *  the selectedIndex property if items are added or removed
		 *  before the component's selected item.
		 *
		 * @param event             <Event> The CollectionEvent dispatched from the collection
		 */
		protected function collectionChangeHandler(event:Event):void;
		/**
		 * Performs some action when the drop-down button is pressed.  This is
		 *  an abstract base class implementation, so it has no effect and is
		 *  overridden by the subclasses.
		 *
		 * @param event             <FlexEvent> 
		 */
		protected function downArrowButton_buttonDownHandler(event:FlexEvent):void;
		/**
		 * Determines the UID for a dataProvider item.
		 *  Every dataProvider item must have or will be assigned a unique
		 *  identifier (UID).
		 *
		 * @param data              <Object> A dataProvider item
		 * @return                  <String> A unique identifier.
		 */
		protected function itemToUID(data:Object):String;
		/**
		 * Determines the measuredWidth and
		 *  measuredHeight properties of the control.
		 *  The measured width is the width of the widest text
		 *  in the dataProvider
		 *  plus the width of the drop-down button.
		 *  The measured height is the larger of either the button or the text.
		 *  If no data provider has been set or there are no items
		 *  in the data provider, the measuredWidth property is set to
		 *  UIComponent.DEFAULT_MEASURED_WIDTH and the
		 *  measuredHeight property is set
		 *  to UIComponent.DEFAULT_MEASURED_HEIGHT.
		 */
		protected override function measure():void;
		/**
		 * Handles changes to the TextInput that serves as the editable
		 *  text field in the component.  The method sets
		 *  selectedIndex to -1 (and therefore
		 *  selectedItem to null).
		 *
		 * @param event             <Event> 
		 */
		protected function textInput_changeHandler(event:Event):void;
		/**
		 * Sizes and positions the internal components in the given width
		 *  and height.  The drop-down button is placed all the way to the right
		 *  and the text field fills the remaining area.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
