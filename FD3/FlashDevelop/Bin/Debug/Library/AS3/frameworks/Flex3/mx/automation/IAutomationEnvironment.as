/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	public interface IAutomationEnvironment {
		/**
		 * Returns the automation class corresponding to the given object.
		 *
		 * @param obj               <IAutomationObject> Instance of the delegate of a testable object.
		 * @return                  <IAutomationClass> Automation class for obj.
		 */
		public function getAutomationClassByInstance(obj:IAutomationObject):IAutomationClass;
		/**
		 * Returns the automation class for the given name.
		 *
		 * @param automationClass   <String> A class name that corresponds to the value of
		 *                            the AutomationClass.name property.
		 * @return                  <IAutomationClass> Automation class corresponding to the given name,
		 *                            or null if none was found.
		 */
		public function getAutomationClassByName(automationClass:String):IAutomationClass;
	}
}
