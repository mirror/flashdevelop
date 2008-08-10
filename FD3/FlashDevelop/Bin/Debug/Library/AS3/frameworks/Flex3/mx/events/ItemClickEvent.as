/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import flash.display.InteractiveObject;
	public class ItemClickEvent extends Event {
		/**
		 * The index of the associated navigation item.
		 */
		public var index:int;
		/**
		 * The item in the data provider of the associated navigation item.
		 */
		public var item:Object;
		/**
		 * The label of the associated navigation item.
		 */
		public var label:String;
		/**
		 * The child object that generated the event; for example,
		 *  the button that a user clicked in a ButtonBar control.
		 */
		public var relatedObject:InteractiveObject;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param label             <String (default = null)> The label of the associated navigation item.
		 * @param index             <int (default = -1)> The index of the associated navigation item.
		 * @param relatedObject     <InteractiveObject (default = null)> The child object that generated the event.
		 * @param item              <Object (default = null)> The item in the data provider for the associated navigation item.
		 */
		public function ItemClickEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, label:String = null, index:int = -1, relatedObject:InteractiveObject = null, item:Object = null);
		/**
		 * The ItemClickEvent.ITEM_CLICK constant defines the value of the
		 *  type property of the event object for an itemClick event.
		 */
		public static const ITEM_CLICK:String = "itemClick";
	}
}
