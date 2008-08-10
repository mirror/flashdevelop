/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.states {
	import flash.events.EventDispatcher;
	public class State extends EventDispatcher {
		/**
		 * The name of the view state upon which this view state is based, or
		 *  null if this view state is not based on a named view state.
		 *  If this value is null, the view state is based on a root
		 *  state that consists of the properties, styles, event handlers, and
		 *  children that you define for a component without using a State class.
		 */
		public var basedOn:String;
		/**
		 * The name of the view state.
		 *  State names must be unique for a given component.
		 *  This property must be set.
		 */
		public var name:String;
		/**
		 * The overrides for this view state, as an Array of objects that implement
		 *  the IOverride interface. These overrides are applied in order when the
		 *  state is entered, and removed in reverse order when the state is exited.
		 */
		public var overrides:Array;
		/**
		 * Constructor.
		 */
		public function State();
	}
}
