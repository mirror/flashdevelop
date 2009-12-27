package mx.binding
{
	import flash.events.Event;
	import mx.core.IRepeaterClient;
	import mx.core.mx_internal;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class RepeatableBinding extends Binding
	{
		/**
		 *  Create a Binding object
	 *
     *  @param document The document that is the target of all of this work.
	 *
     *  @param srcFunc The function that returns us the value
	 *  to use in this Binding.
	 *
     *  @param destFunc The function that will take a value
	 *  and assign it to the destination.
	 *
     *  @param destString The destination represented as a String.
	 *  We can then tell the ValidationManager to validate this field.
		 */
		public function RepeatableBinding (document:Object, srcFunc:Function, destFunc:Function, destString:String);

		/**
		 *  Execute the binding.
     *  Call the source function and get the value we'll use.
     *  Then call the destination function passing the value as an argument.
		 */
		public function execute (o:Object = null) : void;

		/**
		 *  @private
		 */
		private function recursivelyProcessIDArray (o:Object) : void;

		/**
		 *  The only reason a Binding listens to an event
	 *  is because it wants a signal to execute
		 */
		public function eventHandler (event:Event) : void;
	}
}
