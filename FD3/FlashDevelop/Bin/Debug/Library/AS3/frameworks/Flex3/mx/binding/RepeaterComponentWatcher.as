package mx.binding
{
	import flash.events.Event;
	import mx.core.mx_internal;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class RepeaterComponentWatcher extends PropertyWatcher
	{
		/**
		 *  @private
		 */
		private var clones : Array;
		/**
		 *  @private
		 */
		private var original : Boolean;

		/**
		 *  @private
     *
     *  Create a RepeaterComponentWatcher
     *
     *  @param prop The name of the property to watch.
     *  @param event The event type that indicates the property has changed.
     *  @param listeners The binding objects that are listening to this Watcher.
     *  @param propertyGetter A helper function used to access non-public variables.
		 */
		public function RepeaterComponentWatcher (propertyName:String, events:Object, listeners:Array, propertyGetter:Function = null);

		/**
		 *  @private
		 */
		public function updateChildren () : void;

		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;

		/**
		 *  @private
		 */
		private function updateClones () : void;

		/**
		 *  Invokes super's notifyListeners() on each of the clones.
		 */
		public function notifyListeners (commitEvent:Boolean) : void;
	}
}
