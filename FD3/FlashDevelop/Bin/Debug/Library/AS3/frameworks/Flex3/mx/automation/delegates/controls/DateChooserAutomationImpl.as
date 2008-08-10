/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.controls {
	import mx.automation.delegates.core.UIComponentAutomationImpl;
	import mx.controls.DateChooser;
	import flash.display.DisplayObject;
	import flash.events.Event;
	public class DateChooserAutomationImpl extends UIComponentAutomationImpl {
		/**
		 * Constructor.
		 *
		 * @param obj               <DateChooser> DateChooser object to be automated.
		 */
		public function DateChooserAutomationImpl(obj:DateChooser);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
		/**
		 * Replays DateChooserChangeEvent.CHANGE and DateChooserEvent.SCROLL
		 *  events. Replays change by simply setting the date to the one recorded.
		 *  Replays scroll by clicking on the month forward or month back button
		 *  depending on the direction of the scroll.
		 *
		 * @param event             <Event> The event to replay.
		 * @return                  <Boolean> Whether or not a replay was successful.
		 */
		public override function replayAutomatableEvent(event:Event):Boolean;
	}
}
