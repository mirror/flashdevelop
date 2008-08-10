/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.controls {
	import mx.controls.Menu;
	import flash.display.DisplayObject;
	public class MenuAutomationImpl extends ListAutomationImpl {
		/**
		 * Flag indicating whehter to record the show event or not.
		 *  We should use triggerEvent property on MenuEvent.
		 */
		public var showHideFromKeys:Boolean = false;
		/**
		 * Constructor.
		 *
		 * @param obj               <Menu> Menu object to be automated.
		 */
		public function MenuAutomationImpl(obj:Menu);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
	}
}
