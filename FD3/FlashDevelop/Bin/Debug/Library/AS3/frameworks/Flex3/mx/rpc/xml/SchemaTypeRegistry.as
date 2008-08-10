/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.xml {
	public class SchemaTypeRegistry {
		/**
		 * Looks for a registered Class for the given type.
		 *
		 * @param type              <Object> The QName or String representing the type name.
		 * @return                  <Class> Returns the Class for the given type, or null of the type
		 *                            has not been registered.
		 */
		public function getClass(type:Object):Class;
		/**
		 * @param type              <Object> The QName or String representing the collection type name.
		 */
		public function getCollectionClass(type:Object):Class;
		/**
		 */
		public static function getInstance():SchemaTypeRegistry;
		/**
		 * Maps a type QName to a Class definition. The definition can be a String
		 *  representation of the fully qualified class name or an instance of the
		 *  Class itself.
		 *
		 * @param type              <Object> The QName or String representation of the type name.
		 * @param definition        <Object> The Class itself or class name as a String.
		 */
		public function registerClass(type:Object, definition:Object):void;
		/**
		 * Maps a type name to a collection Class. A collection is either the
		 *  top level Array type, or an implementation of mx.collections.IList.
		 *  The definition can be a String representation of the fully qualified
		 *  class name or an instance of the Class itself.
		 *
		 * @param type              <Object> 
		 * @param definition        <Object> 
		 */
		public function registerCollectionClass(type:Object, definition:Object):void;
		/**
		 * Removes a Class from the registry for the given type.
		 *
		 * @param type              <Object> The QName or String representation of the type name.
		 */
		public function unregisterClass(type:Object):void;
		/**
		 * Removes a collection Class from the registry for the given type.
		 *
		 * @param type              <Object> The QName or String representation of the collection type
		 *                            name.
		 */
		public function unregisterCollectionClass(type:Object):void;
	}
}
