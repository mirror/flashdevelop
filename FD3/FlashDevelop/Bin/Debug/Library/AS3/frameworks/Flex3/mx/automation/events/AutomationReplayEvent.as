/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	import mx.automation.IAutomationObject;
	public class AutomationReplayEvent extends Event {
		/**
		 * Delegate of the UIComponent object on which this event will be replayed
		 *  since the target on an event that was not really dispatched
		 *  is not available.
		 */
		public var automationObject:IAutomationObject;
		/**
		 * Event to the replayed.
		 */
		public var replayableEvent:Event;
		/**
		 * Contains true if the replay was successful, and false if not.
		 */
		public var succeeded:Boolean;
		/**
		 * Constructor.
		 *
		 * @param type              <String (default = "replay")> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = false)> Whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = false)> Whether the behavior associated with the event can be prevented.
		 * @param automationObject  <IAutomationObject (default = null)> Delegate of the UIComponent that dispatched the interaction earlier.
		 * @param replayableEvent   <Event (default = null)> Event that needs to be replayed.
		 */
		public function AutomationReplayEvent(type:String = "replay", bubbles:Boolean = false, cancelable:Boolean = false, automationObject:IAutomationObject = null, replayableEvent:Event = null);
		/**
		 * The AutomationReplayEvent.REPLAY constant defines the value of the
		 *  type property of the event object for a replay event.
		 */
		public static const REPLAY:String = "replay";
	}
}
