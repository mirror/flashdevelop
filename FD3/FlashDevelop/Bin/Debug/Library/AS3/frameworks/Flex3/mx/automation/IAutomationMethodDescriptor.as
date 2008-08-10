/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	import flash.events.Event;
	public interface IAutomationMethodDescriptor {
		/**
		 * The name of the method.
		 */
		public function get name():String;
		/**
		 * The return type of the method.
		 */
		public function get returnType():String;
		/**
		 * Returns an Array of argument descriptors for this method.
		 *
		 * @param obj               <IAutomationObject> Instance of the IAutomationObject that
		 *                            supports this method.
		 * @return                  <Array> Array of argument descriptors for this method.
		 */
		public function getArgDescriptors(obj:IAutomationObject):Array;
		/**
		 * Encodes an automation event arguments into an Array.
		 *  Not all method descriptors support recording.
		 *
		 * @param target            <IAutomationObject> Automation event that is being recorded.
		 * @param event             <Event> 
		 * @return                  <Array> Array of argument descriptors.
		 */
		public function record(target:IAutomationObject, event:Event):Array;
		/**
		 * Decodes an argument array and invokes a method.
		 *
		 * @param target            <IAutomationObject> Automation object to replay the method on.
		 * @param args              <Array> Array of argument values and descriptors to
		 *                            be used to invoke the method.
		 * @return                  <Object> Whatever the method invoked returns.
		 */
		public function replay(target:IAutomationObject, args:Array):Object;
	}
}
