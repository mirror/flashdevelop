package mx.binding
{
	import mx.collections.errors.ItemPendingError;
	import mx.core.mx_internal;
	import flash.utils.Dictionary;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class Binding
	{
		/**
		 *  @private
     *  Internal storage for isEnabled property.
		 */
		var _isEnabled : Boolean;
		/**
		 *  @private
     *  Indicates that a Binding is executing.
	 *  Used to prevent circular bindings from causing infinite loops.
		 */
		var isExecuting : Boolean;
		/**
		 *  @private
     *  Indicates that the binding is currently handling an event.
     *  Used to prevent us from infinitely causing an event
	 *  that re-executes the the binding.
		 */
		var isHandlingEvent : Boolean;
		/**
		 *  @private
     *  Queue of watchers that fired while we were disabled.
     *  We will resynch with our binding if isEnabled is set to true
     *  and one or more of our watchers fired while we were disabled.
		 */
		var disabledRequests : Dictionary;
		/**
		 *  @private
     *  True as soon as a non-null or non-empty-string value has been used.
     *  We don't auto-validate until this is true
		 */
		private var hasHadValue : Boolean;
		/**
		 *  @private
     *  This is no longer used in Flex 3.0, but it is required to load
     *  Flex 2.0.0 and Flex 2.0.1 modules.
		 */
		public var uiComponentWatcher : int;
		/**
		 *  @private
     *  It's possible that there is a two-way binding set up, in which case
     *  we'll do a rudimentary optimization by not executing ourselves
     *  if our counterpart is already executing.
		 */
		public var twoWayCounterpart : Binding;
		/**
		 *  @private 
     *  True if a wrapped function call does not throw an error.  This is used by
     *  innerExecute() to tell if the srcFunc completed successfully.
		 */
		private var wrappedFunctionSuccessful : Boolean;
		/**
		 *  All Bindings hang off of a document for now,
	 *  but really it's just the root of where these functions live.
		 */
		var document : Object;
		/**
		 *  The function that will return us the value.
		 */
		var srcFunc : Function;
		/**
		 *  The function that takes the value and assigns it.
		 */
		var destFunc : Function;
		/**
		 *  The destination represented as a String.
	 *  This will be used so we can signal validation on a field.
		 */
		var destString : String;
		/**
		 * 	@private
	 *  Used to suppress calls to destFunc when incoming value is either
	 *	a) an XML node identical to the previously assigned XML node, or
	 *  b) an XMLList containing the identical node sequence as the previously assigned XMLList
		 */
		private var lastValue : Object;

		/**
		 *  @private
     *  Indicates that a Binding is enabled.
     *  Used to disable bindings.
		 */
		function get isEnabled () : Boolean;
		/**
		 *  @private
		 */
		function set isEnabled (value:Boolean) : void;

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
		public function Binding (document:Object, srcFunc:Function, destFunc:Function, destString:String);

		/**
		 *  Execute the binding.
	 *  Call the source function and get the value we'll use.
	 *  Then call the destination function passing the value as an argument.
	 *  Finally try to validate the destination.
		 */
		public function execute (o:Object = null) : void;

		/**
		 * @private 
     * Take note of any execute request that occur when we are disabled.
		 */
		private function registerDisabledExecute (o:Object) : void;

		/**
		 * @private 
     * Resynch with any watchers that may have updated while we were disabled.
		 */
		private function processDisabledRequests () : void;

		/**
		 *  @private
	 *  Note: use of this wrapper needs to be reexamined. Currently there's at least one situation where a
	 *	wrapped function invokes another wrapped function, which is unnecessary (i.e., only the inner function
	 *  will throw), and also risks future errors due to the 'wrappedFunctionSuccessful' member variable
	 *  being stepped on. Leaving alone for now to minimize pre-GMC volatility, but should be revisited for
	 *  an early dot release.
	 *  Also note that the set of suppressed error codes below is repeated verbatim in Watcher.wrapUpdate.
	 *  These need to be consolidated and the motivations for each need to be documented.
		 */
		protected function wrapFunctionCall (thisArg:Object, wrappedFunction:Function, object:Object = null, ...args) : Object;

		/**
		 *	@private
	 *  true iff XMLLists x and y contain the same node sequence.
		 */
		private function nodeSeqEqual (x:XMLList, y:XMLList) : Boolean;

		/**
		 *  @private
		 */
		private function innerExecute () : void;

		/**
		 *  This function is called when one of this binding's watchers
	 *  detects a property change.
		 */
		public function watcherFired (commitEvent:Boolean, cloneIndex:int) : void;
	}
}
