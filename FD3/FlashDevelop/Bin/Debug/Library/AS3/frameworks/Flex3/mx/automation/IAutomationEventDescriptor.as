/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	import flash.events.Event;
	public interface IAutomationEventDescriptor {
		/**
		 * The name of the class implementing this event.
		 */
		public function get eventClassName():String;
		/**
		 * The value of the type property used for this event.
		 */
		public function get eventType():String;
		/**
		 * The name of this event as the agent sees it.
		 *  The AutomationManager fills the AutomationRecordEvent.name
		 *  property with this name.
		 */
		public function get name():String;
		/**
		 * Returns an Array of argument descriptors for this event.
		 *
		 * @param target            <IAutomationObject> Instance of the IAutomationObject that
		 *                            supports this event.
		 * @return                  <Array> Array of argument descriptors for this event.
		 */
		public function getArgDescriptors(target:IAutomationObject):Array;
		/**
		 * Encodes an automation event argument into an Array.
		 *
		 * @param target            <IAutomationObject> Automation object on which to record the event.
		 * @param event             <Event> Automation event that is being recorded.
		 * @return                  <Array> Array of property values of the event described by the PropertyDescriptors.
		 */
		public function record(target:IAutomationObject, event:Event):Array;
		/**
		 * Decodes an argument Array and replays the event.
		 *
		 * @param target            <IAutomationObject> Automation object on which to replay the event.
		 * @param args              <Array> Array of argument values to
		 *                            be used to replay the event.
		 * @return                  <Object> null
		 */
		public function replay(target:IAutomationObject, args:Array):Object;
	}
}
