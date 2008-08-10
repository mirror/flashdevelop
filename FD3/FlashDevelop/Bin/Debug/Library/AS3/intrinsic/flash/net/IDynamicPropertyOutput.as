/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	public interface IDynamicPropertyOutput {
		/**
		 * Adds a dynamic property to the binary output of a serialized object.
		 *  When the object is subsequently read (using a method such as
		 *  readObject), it contains the new property.
		 *  You can use this method
		 *  to exclude properties of dynamic objects from serialization; to write values
		 *  to properties of dynamic objects; or to create new properties
		 *  for dynamic objects.
		 *
		 * @param name              <String> The name of the property. You can use this parameter either to specify
		 *                            the name of an existing property of the dynamic object or to create a
		 *                            new property.
		 * @param value             <*> The value to write to the specified property.
		 */
		public function writeDynamicProperty(name:String, value:*):void;
	}
}
