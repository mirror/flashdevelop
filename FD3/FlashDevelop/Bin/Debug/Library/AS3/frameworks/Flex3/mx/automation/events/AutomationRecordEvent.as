/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.events {
	import flash.events.Event;
	import mx.automation.IAutomationObject;
	public class AutomationRecordEvent extends Event {
		/**
		 * A serialized representation of the event as an Array
		 *  of it's property values.
		 */
		public var args:Array;
		/**
		 * The delegate of the UIComponent object that is recording this event.
		 */
		public var automationObject:IAutomationObject;
		/**
		 * Contains true if this is a cacheable event, and false if not.
		 */
		public var cacheable:Boolean;
		/**
		 * The automation event name.
		 */
		public var name:String;
		/**
		 * The underlying interaction.
		 */
		public var replayableEvent:Event;
		/**
		 * Constructor.
		 *
		 * @param type              <String (default = "record")> The event type; indicates the action that caused the event.
		 * @param bubbles           <Boolean (default = true)> Whether the event can bubble up the display list hierarchy.
		 * @param cancelable        <Boolean (default = true)> Whether the behavior associated with the event can be prevented.
		 * @param automationObject  <IAutomationObject (default = null)> Delegate of the UIComponent that is dispatching the interaction.
		 * @param replayableEvent   <Event (default = null)> Underlying event that represents the interaction.
		 * @param args              <Array (default = null)> Array of arguments to the method.
		 * @param name              <String (default = null)> Displayable name of the operation.
		 * @param cacheable         <Boolean (default = false)> true if the event should be saved in the event cache,
		 *                            and false if not.
		 */
		public function AutomationRecordEvent(type:String = "record", bubbles:Boolean = true, cancelable:Boolean = true, automationObject:IAutomationObject = null, replayableEvent:Event = null, args:Array = null, name:String = null, cacheable:Boolean = false);
		/**
		 * The AutomationRecordEvent.RECORD constant defines the value of the
		 *  type property of the event object for a record event.
		 */
		public static const RECORD:String = "record";
	}
}
