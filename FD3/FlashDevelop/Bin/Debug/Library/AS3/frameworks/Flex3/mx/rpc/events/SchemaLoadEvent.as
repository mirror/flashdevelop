package mx.rpc.events
{
	import flash.events.Event;
	import mx.rpc.xml.Schema;

	/**
	 * This event is dispatched when an XML Schema has loaded sucessfully. *  * @private
	 */
	public class SchemaLoadEvent extends XMLLoadEvent
	{
		/**
		 * The full Schema document.
		 */
		public var schema : Schema;
		public static const LOAD : String = "schemaLoad";

		/**
		 * Creates a new SchemaLoadEvent.
		 */
		public function SchemaLoadEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = true, schema:Schema = null, location:String = null);
		/**
		 * Returns a copy of this SchemaLoadEvent.
		 */
		public function clone () : Event;
		/**
		 * Returns a String representation of this SchemaLoadEvent.
		 */
		public function toString () : String;
		/**
		 * A helper method to create a new SchemaLoadEvent.     * @private
		 */
		public static function createEvent (schema:Schema, location:String = null) : SchemaLoadEvent;
	}
}
