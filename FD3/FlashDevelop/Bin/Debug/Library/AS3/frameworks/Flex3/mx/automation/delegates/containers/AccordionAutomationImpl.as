/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.containers {
	import mx.automation.delegates.core.ContainerAutomationImpl;
	import mx.containers.Accordion;
	import flash.display.DisplayObject;
	import flash.events.Event;
	public class AccordionAutomationImpl extends ContainerAutomationImpl {
		/**
		 * Constructor.
		 *
		 * @param obj               <Accordion> Accordion object to be automated.
		 */
		public function AccordionAutomationImpl(obj:Accordion);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
		/**
		 * Replays an IndexChangedEvent event by dispatching
		 *  a MouseEvent to the header that was clicked.
		 *
		 * @param event             <Event> 
		 */
		public override function replayAutomatableEvent(event:Event):Boolean;
	}
}
