package mx.graphics
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.core.mx_internal;
	import mx.events.PropertyChangeEvent;

	/**
	 *  The GradientBase class is the base class for *  LinearGradient, LinearGradientStroke, and RadialGradient.
	 */
	public class GradientBase extends EventDispatcher
	{
		/**
		 *  @private
		 */
		local var colors : Array;
		/**
		 *  @private
		 */
		local var ratios : Array;
		/**
		 *  @private
		 */
		local var alphas : Array;
		/**
		 *  @private	 *  Storage for the entries property.
		 */
		private var _entries : Array;

		/**
		 *  An Array of GradientEntry objects	 *  defining the fill patterns for the gradient fill.	 *	 *  @default []
		 */
		public function get entries () : Array;
		/**
		 *  @private
		 */
		public function set entries (value:Array) : void;

		/**
		 *  Constructor.
		 */
		public function GradientBase ();
		/**
		 *  @private	 *  Extract the gradient information in the public <code>entries</code>	 *  Array into the internal <code>colors</code>, <code>ratios</code>,	 *  and <code>alphas</code> arrays.
		 */
		private function processEntries () : void;
		/**
		 *  Dispatch a gradientChanged event.
		 */
		function dispatchGradientChangedEvent (prop:String, oldValue:*, value:*) : void;
		/**
		 *  @private
		 */
		private function entry_propertyChangeHandler (event:Event) : void;
	}
}
