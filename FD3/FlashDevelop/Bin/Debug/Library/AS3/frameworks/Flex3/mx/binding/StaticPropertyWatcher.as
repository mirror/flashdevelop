package mx.binding
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import mx.core.EventPriority;
	import mx.events.PropertyChangeEvent;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class StaticPropertyWatcher extends Watcher
	{
		/**
		 *  The parent class of this static property.
		 */
		private var parentObj : Class;
		/**
		 *  The events that indicate the static property has changed
		 */
		protected var events : Object;
		/**
		 *  Storage for the propertyGetter property.
		 */
		private var propertyGetter : Function;
		/**
		 *  Storage for the propertyName property.
		 */
		private var _propertyName : String;

		/**
		 *  The name of the property this Watcher is watching.
		 */
		public function get propertyName () : String;

		/**
		 *  Create a StaticPropertyWatcher
     *
     *  @param prop The name of the static property to watch.
     *  @param event The event type that indicates the static property has changed.
     *  @param listeners The binding objects that are listening to this Watcher.
     *  @param propertyGetter A helper function used to access non-public variables.
		 */
		public function StaticPropertyWatcher (propertyName:String, events:Object, listeners:Array, propertyGetter:Function = null);

		/**
		 *  If the parent has changed we need to update ourselves
		 */
		public function updateParent (parent:Object) : void;

		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;

		/**
		 *  @private
		 */
		private function traceInfo () : String;

		/**
		 *  @private
		 */
		private function eventNamesToString () : String;

		/**
		 *  Gets the actual property then updates
     *  the Watcher's children appropriately.
		 */
		private function updateProperty () : void;

		/**
		 *  The generic event handler.
     *  The only event we'll hear indicates that the property has changed.
		 */
		public function eventHandler (event:Event) : void;
	}
}
