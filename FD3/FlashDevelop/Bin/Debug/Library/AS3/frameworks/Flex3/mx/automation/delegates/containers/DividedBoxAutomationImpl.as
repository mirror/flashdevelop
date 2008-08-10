/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.containers {
	import mx.automation.delegates.core.ContainerAutomationImpl;
	import mx.containers.DividedBox;
	import flash.display.DisplayObject;
	import flash.events.Event;
	public class DividedBoxAutomationImpl extends ContainerAutomationImpl {
		/**
		 * Constructor.
		 *
		 * @param obj               <DividedBox> DividedBox object to be automated.
		 */
		public function DividedBoxAutomationImpl(obj:DividedBox);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
		/**
		 * Replays DIVIDER_RELEASE events by dispatching
		 *  a DIVIDER_PRESS event, moving the divider in question,
		 *  and dispatching a DIVIDER_RELEASE event.
		 *
		 * @param interaction       <Event> 
		 */
		public override function replayAutomatableEvent(interaction:Event):Boolean;
	}
}
