package mx.binding
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import mx.core.EventPriority;
	import mx.core.mx_internal;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class FunctionReturnWatcher extends Watcher
	{
		/**
		 *  @private
     *  The name of the property, used to actually get the property
	 *  and for comparison in propertyChanged events.
		 */
		private var functionName : String;
		/**
		 *  @private
     *  The document is what we need to use toe execute the parameter function.
		 */
		private var document : Object;
		/**
		 *  @private
     *  The function that will give us the parameters for calling the function.
		 */
		private var parameterFunction : Function;
		/**
		 *  @private
     *  The events that indicate the property has changed.
		 */
		private var events : Object;
		/**
		 *  @private
     *  The parent object of this function.
		 */
		private var parentObj : Object;
		/**
		 *  @private
     *  The watcher holding onto the parent object.
		 */
		public var parentWatcher : Watcher;
		/**
		 *  Storage for the functionGetter property.
		 */
		private var functionGetter : Function;

		/**
		 *  @private
	 *  Constructor.
		 */
		public function FunctionReturnWatcher (functionName:String, document:Object, parameterFunction:Function, events:Object, listeners:Array, functionGetter:Function = null);

		/**
		 *  @private
		 */
		public function updateParent (parent:Object) : void;

		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;

		/**
		 *  @private
     *  Get the new return value of the function.
		 */
		public function updateFunctionReturn () : void;

		/**
		 *  @private
		 */
		private function setupParentObj (newParent:Object) : void;

		/**
		 *  @private
		 */
		public function eventHandler (event:Event) : void;
	}
}
