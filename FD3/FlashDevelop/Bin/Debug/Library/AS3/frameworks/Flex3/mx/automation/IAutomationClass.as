/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	import flash.events.Event;
	public interface IAutomationClass {
		/**
		 * The class name.
		 */
		public function get name():String;
		/**
		 * An Object containing a map to map a property name to descriptor.
		 */
		public function get propertyNameMap():Object;
		/**
		 * The name of the class's superclass.
		 */
		public function get superClassName():String;
		/**
		 * Returns an IAutomationEventDescriptor object
		 *  for the specified event object.
		 *
		 * @param event             <Event> The event for which the descriptor is required.
		 */
		public function getDescriptorForEvent(event:Event):IAutomationEventDescriptor;
		/**
		 * Returns an IAutomationEventDescriptor object from the event's name.
		 *
		 * @param eventName         <String> The event name for which the descriptor is required.
		 * @return                  <IAutomationEventDescriptor> The event descriptor for the name passed if one is available.
		 *                            Otherwise null.
		 */
		public function getDescriptorForEventByName(eventName:String):IAutomationEventDescriptor;
		/**
		 * Returns an IAutomationMethodDescriptorfrom object
		 *  from the method's name.
		 *
		 * @param methodName        <String> The method name for which the descriptor is required.
		 * @return                  <IAutomationMethodDescriptor> The method descriptor for the name passed if one is available.
		 *                            Otherwise, null.
		 */
		public function getDescriptorForMethodByName(methodName:String):IAutomationMethodDescriptor;
		/**
		 * Returns the list of properties this class supports.
		 *
		 * @param objForInitialization<Object (default = null)> Object which can be used to find the
		 *                            ActionScript type of the properties.
		 * @param forVerification   <Boolean (default = true)> If true, indicates that properties used
		 *                            for verification should be included in the return value.
		 * @param forDescription    <Boolean (default = true)> If true, indicates that properties used
		 *                            for object identitication should be included in the return value.
		 * @return                  <Array> Array containing property descriptions.
		 */
		public function getPropertyDescriptors(objForInitialization:Object = null, forVerification:Boolean = true, forDescription:Boolean = true):Array;
	}
}
