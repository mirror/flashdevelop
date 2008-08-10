/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.core {
	import mx.core.ScrollControlBase;
	import flash.display.DisplayObject;
	import flash.events.Event;
	public class ScrollControlBaseAutomationImpl extends UIComponentAutomationImpl {
		/**
		 * Constructor.
		 *
		 * @param obj               <ScrollControlBase> ScrollControlBase object to be automated.
		 */
		public function ScrollControlBaseAutomationImpl(obj:ScrollControlBase);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
		/**
		 * Replays ScrollEvents. ScrollEvents are replayed
		 *  by calling ScrollBar.scrollIt on the appropriate (horizontal or vertical)
		 *  scrollBar.
		 *
		 * @param event             <Event> 
		 */
		public override function replayAutomatableEvent(event:Event):Boolean;
	}
}
