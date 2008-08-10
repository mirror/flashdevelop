/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.events {
	import flash.events.MouseEvent;
	import mx.charts.LegendItem;
	public class LegendMouseEvent extends MouseEvent {
		/**
		 * The item in the Legend on which this event was triggered.
		 */
		public var item:LegendItem;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The type of Mouse event. If a mouse event type is given it
		 *                            would be converted into a LegendMouseEvent type.
		 * @param triggerEvent      <MouseEvent (default = null)> The MouseEvent that triggered this LegentMouseEvent.
		 * @param item              <LegendItem (default = null)> The item in the Legend on which this event was triggered.
		 */
		public function LegendMouseEvent(type:String, triggerEvent:MouseEvent = null, item:LegendItem = null);
		/**
		 * Event type constant; indicates that the user clicked the mouse button
		 *  over a legend item.
		 */
		public static const ITEM_CLICK:String = "itemClick";
		/**
		 * Event type constant; indicates that the user clicked the mouse button
		 *  over a legend item.
		 */
		public static const ITEM_MOUSE_DOWN:String = "itemMouseDown";
		/**
		 * Event type constant; indicates that the user rolled the mouse pointer
		 *  away from a legend item.
		 */
		public static const ITEM_MOUSE_OUT:String = "itemMouseOut";
		/**
		 * Event type constant; indicates that the user rolled the mouse pointer
		 *  over  a legend item.
		 */
		public static const ITEM_MOUSE_OVER:String = "itemMouseOver";
		/**
		 * Event type constant; indicates that the user released the mouse button
		 *  while over  a legend item.
		 */
		public static const ITEM_MOUSE_UP:String = "itemMouseUp";
	}
}
