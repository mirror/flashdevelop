/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates.core {
	import mx.automation.IAutomationObject;
	import mx.core.UITextField;
	import flash.display.DisplayObject;
	public class UITextFieldAutomationImpl implements IAutomationObject {
		/**
		 * This value generally corresponds to the rendered appearance of the
		 *  object and should be usable for correlating the identifier with
		 *  the object as it appears visually within the application.
		 */
		public function get automationValue():Array;
		/**
		 * Constructor.
		 *
		 * @param obj               <UITextField> UITextField object to be automated.
		 */
		public function UITextFieldAutomationImpl(obj:UITextField);
		/**
		 * Registers the delegate class for a component class with automation manager.
		 *
		 * @param root              <DisplayObject> 
		 */
		public static function init(root:DisplayObject):void;
	}
}
