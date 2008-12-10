package mx.binding
{
	import mx.core.mx_internal;

	/**
	 *  @private
	 */
	public class ArrayElementWatcher extends Watcher
	{
		/**
		 *  @private
		 */
		private var document : Object;
		/**
		 *  @private
		 */
		private var accessorFunc : Function;
		/**
		 *  @private
		 */
		public var arrayWatcher : Watcher;

		/**
		 *  @private	 *  Constructor
		 */
		public function ArrayElementWatcher (document:Object, accessorFunc:Function, listeners:Array);
		/**
		 *  @private
		 */
		public function updateParent (parent:Object) : void;
		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;
	}
}
