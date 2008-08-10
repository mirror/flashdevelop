/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import mx.controls.listClasses.IListItemRenderer;
	public class TreeEvent extends Event {
		/**
		 * Whether to animate an opening or closing operation; used for
		 *  ITEM_OPENING type events only.
		 */
		public var animate:Boolean;
		/**
		 * Whether to dispatch an event (ITEM_OPEN or
		 *  ITEM_CLOSE) after the open or close animation
		 *  is complete. Used for ITEM_OPENING type events only.
		 */
		public var dispatchEvent:Boolean;
		/**
		 * Storage for the item property.
		 *  If you populate the Tree from XML data, access
		 *  the properties for the node as
		 *  event.item.&64;attribute_name.
		 */
		public var item:Object;
		/**
		 * The ListItemRenderer for the node that closed or opened.
		 */
		public var itemRenderer:IListItemRenderer;
		/**
		 * Used for an ITEM_OPENING type events only.
		 *  Indicates whether the item
		 *  is opening true, or closing false.
		 */
		public var opening:Boolean;
		/**
		 * The low level MouseEvent or KeyboardEvent that triggered this
		 *  event or null if this event was triggered programatically.
		 */
		public var triggerEvent:Event;
		/**
		 * Constructor.
		 *  Normally called by the Flex Tree control; not used in application code.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior associated with the event
		 *                            can be prevented.
		 * @param item              <Object (default = null)> The Tree node (item) to which this event applies.
		 * @param itemRenderer      <IListItemRenderer (default = null)> The item renderer object for the cell.
		 * @param triggerEvent      <Event (default = null)> If the node opened or closed in response to a
		 *                            user action, indicates the type of input action.
		 */
		public function TreeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, item:Object = null, itemRenderer:IListItemRenderer = null, triggerEvent:Event = null);
		/**
		 * The TreeEvent.ITEM_CLOSE event type constant indicates that a tree
		 *  branch closed or collapsed.
		 */
		public static const ITEM_CLOSE:String = "itemClose";
		/**
		 * The TreeEvent.ITEM_OPEN event type constant indicates that a tree
		 *  branch opened or expanded.
		 */
		public static const ITEM_OPEN:String = "itemOpen";
		/**
		 * The TreeEvent.ITEM_OPENING event type constant is dispatched immediately
		 *  before a tree opens or closes.
		 */
		public static const ITEM_OPENING:String = "itemOpening";
	}
}
