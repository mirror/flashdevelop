/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.events {
	import flash.events.Event;
	import mx.core.IToolTip;
	public class ToolTipEvent extends Event {
		/**
		 * The ToolTip object to which this event applies.
		 *  This object is normally an instance of ToolTip object,
		 *  but can be any UIComponent object.
		 */
		public var toolTip:IToolTip;
		/**
		 * Constructor.
		 *
		 * @param type              <String> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Specifies whether the event can bubble
		 *                            up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Specifies whether the behavior
		 *                            associated with the event can be prevented.
		 * @param toolTip           <IToolTip (default = null)> The ToolTip object to which this event applies.
		 */
		public function ToolTipEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, toolTip:IToolTip = null);
		/**
		 * The ToolTipEvent.TOOL_TIP_CREATE constant defines the value of the
		 *  type property of the event object for a toolTipCreate event.
		 */
		public static const TOOL_TIP_CREATE:String = "toolTipCreate";
		/**
		 * The ToolTipEvent.TOOL_TIP_END constant defines the value of the
		 *  type property of the event object for a toolTipEnd event.
		 */
		public static const TOOL_TIP_END:String = "toolTipEnd";
		/**
		 * The ToolTipEvent.TOOL_TIP_HIDE constant defines the value of the
		 *  type property of the event object for a toolTipHide event.
		 */
		public static const TOOL_TIP_HIDE:String = "toolTipHide";
		/**
		 * The ToolTipEvent.TOOL_TIP_SHOW constant defines the value of the
		 *  type property of the event object for a toolTipShow event.
		 */
		public static const TOOL_TIP_SHOW:String = "toolTipShow";
		/**
		 * The ToolTipEvent.TOOL_TIP_SHOWN constant defines the value of the
		 *  type property of the event object for a toolTipShown event.
		 */
		public static const TOOL_TIP_SHOWN:String = "toolTipShown";
		/**
		 * The ToolTipEvent.TOOL_TIP_START constant defines the value of the
		 *  type property of the event object for a toolTipStart event.
		 */
		public static const TOOL_TIP_START:String = "toolTipStart";
	}
}
