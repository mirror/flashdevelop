package mx.binding
{
	import mx.core.mx_internal;
	import mx.utils.XMLNotifier;
	import mx.utils.IXMLNotifiable;

include "../core/Version.as"
	/**
	 *  @private
	 */
	public class XMLWatcher extends Watcher implements IXMLNotifiable
	{
		/**
		 *  The parent object of this property.
		 */
		private var parentObj : Object;
		/**
		 *  Storage for the propertyName property.
		 */
		private var _propertyName : String;

		/**
		 *  The name of the property this Watcher is watching.
		 */
		public function get propertyName () : String;

		/**
		 *  Constructor.
		 */
		public function XMLWatcher (propertyName:String, listeners:Array);

		/**
		 *  If the parent has changed we need to update ourselves
		 */
		public function updateParent (parent:Object) : void;

		/**
		 *  @private
		 */
		protected function shallowClone () : Watcher;

		/**
		 *  Gets the actual property then updates
	 *  the Watcher's children appropriately.
		 */
		private function updateProperty () : void;

		/**
		 *  @private
		 */
		public function xmlNotification (currentTarget:Object, type:String, target:Object, value:Object, detail:Object) : void;
	}
}
