/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.containers {
	import mx.containers.TabNavigator;
	import flash.display.DisplayObject;
	import flash.events.Event;
	public class TabNavigatorAutomationImpl extends ViewStackAutomationImpl {
		/**
		 * Constructor.
		 *
		 * @param obj               <TabNavigator> TabNavigator object to be automated.
		 */
		public function TabNavigatorAutomationImpl(obj:TabNavigator);
		/**
		 */
		protected override function componentInitialized():void;
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
		/**
		 * Replays ItemClickEvents by dispatching a MouseEvent to the item that was
		 *  clicked.
		 *
		 * @param interaction       <Event> 
		 */
		public override function replayAutomatableEvent(interaction:Event):Boolean;
	}
}
