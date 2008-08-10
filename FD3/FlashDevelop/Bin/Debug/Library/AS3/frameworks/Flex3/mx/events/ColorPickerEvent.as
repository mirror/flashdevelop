/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	public class ColorPickerEvent extends Event {
		/**
		 * The RGB color that was rolled over, rolled out of, selected, or
		 *  entered.
		 */
		public var color:uint;
		/**
		 * The zero-based index in the Color's data provider that corresponds
		 *  to the color that was rolled over, rolled out of, or selected.
		 *  If the event type is ColorPickerEvent.ENTER,
		 *  will have default value -1; it is not set in this case because
		 *  the user can enter an RGB string that doesn't match any color
		 *  in the data provider.
		 */
		public var index:int;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event can be prevented.
		 * @param index             <int (default = -1)> The zero-based index in the Color's data provider
		 *                            that corresponds to the color that was rolled over, rolled out of,
		 *                            or selected.
		 * @param color             <uint (default = 0xFFFFFFFF)> The RGB color that was rolled over, rolled out of,
		 *                            selected, or entered.
		 */
		public function ColorPickerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, index:int = -1, color:uint = 0xFFFFFFFF);
		/**
		 * The ColorPickerEvent.CHANGE constant defines the value of the
		 *  type property of the event that is dispatched when the user
		 *  selects a color from the ColorPicker control.
		 */
		public static const CHANGE:String = "change";
		/**
		 * The ColorPickerEvent.ENTER constant defines the value of the
		 *  type property of the event that is dispatched when the user
		 *  presses the Enter key after typing in the color selector box.
		 */
		public static const ENTER:String = "enter";
		/**
		 * The ColorPickerEvent.ITEM_ROLL_OUT constant defines the value of the
		 *  type property of the event that is dispatched when the user
		 *  rolls the mouse out of a swatch in the swatch panel.
		 */
		public static const ITEM_ROLL_OUT:String = "itemRollOut";
		/**
		 * The ColorPickerEvent.ITEM_ROLL_OVER constant defines the value of the
		 *  type property of the event that is dispatched when the user
		 *  rolls the mouse over of a swatch in the swatch panel.
		 */
		public static const ITEM_ROLL_OVER:String = "itemRollOver";
	}
}
