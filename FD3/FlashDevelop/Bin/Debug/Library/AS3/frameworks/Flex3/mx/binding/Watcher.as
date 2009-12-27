package mx.binding
{
	import mx.collections.errors.ItemPendingError;
	import mx.core.mx_internal;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class Watcher
	{
		/**
		 *  @private
     *  The binding objects that are listening to this Watcher.
     *  The standard event mechanism isn't used because it's too heavyweight.
		 */
		protected var listeners : Array;
		/**
		 *  @private
     *  Children of this watcher are watching sub values.
		 */
		protected var children : Array;
		/**
		 *  @private
     *  The value itself.
		 */
		public var value : Object;
		/**
		 *  @private
     *  Keep track of cloning when used in Repeaters.
		 */
		protected var cloneIndex : int;

		/**
		 *  Constructor.
		 */
		public function Watcher (listeners:Array = null);

		/**
		 *  @private
     *  This is an abstract method that subclasses implement.
		 */
		public function updateParent (parent:Object) : void;

		/**
		 *  @private
     *  Add a child to this watcher, meaning that the child
	 *  is watching a sub value of ours.
		 */
		public function addChild (child:Watcher) : void;

		/**
		 *  @private
     *  Remove all children beginning at a starting index.
     *  If the index is not specified, it is assumed to be 0.
     *  This capability is used by Repeater, which must remove
     *  cloned RepeaterItemWatchers (and their descendant watchers).
		 */
		public function removeChildren (startingIndex:int) : void;

		/**
		 *  We have probably changed, so go through
	 *  and make sure our children are updated.
		 */
		public function updateChildren () : void;

		/**
		 *  @private
		 */
		private function valueChanged (oldval:Object) : Boolean;

		/**
		 *  @private
		 */
		protected function wrapUpdate (wrappedFunction:Function) : void;

		/**
		 *  @private
     *  Clone this Watcher and all its descendants.
     *  Each clone triggers the same Bindings as the original;
     *  in other words, the Bindings do not get cloned.
     *
     *  This cloning capability is used by Repeater in order
     *  to watch the subproperties of multiple dataProvider items.
     *  For example, suppose a repeated LinkButton's label is
     *    {r.currentItem.firstName} {r.currentItem.lastName}
     *  where r is a Repeater whose dataProvider is
     *    [ { firstName: "Matt",   lastName: "Chotin" },
     *      { firstName: "Gordon", lastName: "Smith"  } ]
     *  The MXML compiler emits a watcher tree (one item of _watchers[])
     *  that looks like this:
     *    PropertyWatcher for "r"
     *      PropertyWatcher for "dataProvider"
     *        RepeaterItemWatcher
     *          PropertyWatcher for "firstName"
     *          PropertyWatcher for "lastName"
     *  At runtime the RepeaterItemWatcher serves as a template
     *  which gets cloned for each dataProvider item:
     *    PropertyWatcher for "r"
     *      PropertyWatcher for "dataProvider"
     *        RepeaterItemWatcher               (index: null)
     *          PropertyWatcher for "firstName" (value: null)
     *          PropertyWatcher for "lastName"  (value: null)
     *        RepeaterItemWatcher               (index: 0)
     *          PropertyWatcher for "firstName" (value: "Matt")
     *          PropertyWatcher for "lastName"  (value: "Chotin")
     *        RepeaterItemWatcher               (index: 1)
     *          PropertyWatcher for "firstName" (value: "Gordon")
     *          PropertyWatcher for "lastName"  (value: "Smith")
		 */
		protected function deepClone (index:int) : Watcher;

		/**
		 *  @private
     *  Clone this watcher object itself, without cloning its children.
     *  The clone is not connec
     *  Subclasses must override this method to copy their properties.
		 */
		protected function shallowClone () : Watcher;

		/**
		 *  @private
		 */
		public function notifyListeners (commitEvent:Boolean) : void;
	}
}
