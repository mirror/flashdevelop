/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	public class Automation {
		/**
		 * The IAutomationManager instance.
		 */
		public static function get automationManager():IAutomationManager;
		public function set automationManager(value:IAutomationManager):void;
		/**
		 * The available IAutomationObjectHelper instance.
		 */
		public static function get automationObjectHelper():IAutomationObjectHelper;
		/**
		 */
		public static function get errorShown():Boolean;
		public function set errorShown(value:Boolean):void;
		/**
		 * Contains true if the automation module has been initialized.
		 */
		public static function get initialized():Boolean;
		/**
		 * The currently active mouse simulator.
		 */
		public static function get mouseSimulator():IAutomationMouseSimulator;
		public function set mouseSimulator(value:IAutomationMouseSimulator):void;
		/**
		 */
		public static function get recordedLinesCount():Number;
		public function set recordedLinesCount(value:Number):void;
		/**
		 */
		public static var recordReplayLimit:Number = 30;
		/**
		 */
		public function set restrictionNeeded(value:Boolean):void;
		/**
		 */
		public static function decrementRecordedLinesCount():Number;
		/**
		 */
		public static function incrementRecordedLinesCount():Number;
		/**
		 */
		public static function isLicensePresent():Boolean;
		/**
		 * Registers the component class and delegate class association with Automation.
		 *
		 * @param compClass         <Class> The component class.
		 * @param delegateClass     <Class> The delegate class associated with the component.
		 */
		public static function registerDelegateClass(compClass:Class, delegateClass:Class):void;
	}
}
