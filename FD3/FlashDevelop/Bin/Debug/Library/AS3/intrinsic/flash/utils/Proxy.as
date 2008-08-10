/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.utils {
	public class Proxy {
		/**
		 * Overrides the behavior of an object property that can be called as a function. When a method of
		 *  the object is invoked, this method is called. While some objects can be called as functions,
		 *  some object properties can also be called as functions.
		 *
		 * @param name              <*> The name of the method being invoked.
		 * @return                  <*> The return value of the called method.
		 */
		flash_proxy function callProperty(name:*, ... rest):*;
		/**
		 * Overrides the request to delete a property. When a property is deleted
		 *  with the delete operator, this
		 *  method is called to perform the deletion.
		 *
		 * @param name              <*> The name of the property to delete.
		 * @return                  <Boolean> If the property was deleted, true; otherwise false.
		 */
		flash_proxy function deleteProperty(name:*):Boolean;
		/**
		 * Overrides the use of the descendant operator.
		 *  When the descendant operator is used, this method
		 *  is invoked.
		 *
		 * @param name              <*> The name of the property to descend
		 *                            into the object and search for.
		 * @return                  <*> The results of the descendant operator.
		 */
		flash_proxy function getDescendants(name:*):*;
		/**
		 * Overrides any request for a property's value.  If the property can't be found, the method
		 *  returns undefined. For more information on this behavior, see
		 *  the ECMA-262 Language Specification, 3rd Edition, section 8.6.2.1.
		 *
		 * @param name              <*> The name of the property to retrieve.
		 * @return                  <*> The specified property or undefined if the property is not found.
		 */
		flash_proxy function getProperty(name:*):*;
		/**
		 * Overrides a request to check whether an object has a particular property by name.
		 *
		 * @param name              <*> The name of the property to check for.
		 * @return                  <Boolean> If the property exists, true; otherwise false.
		 */
		flash_proxy function hasProperty(name:*):Boolean;
		/**
		 * Checks whether a supplied QName is also marked as an attribute.
		 *
		 * @param name              <*> The name of the property to check.
		 * @return                  <Boolean> Returns true if the argument for name is a QName that is also
		 *                            marked as an attribute.
		 */
		flash_proxy function isAttribute(name:*):Boolean;
		/**
		 * Allows enumeration of the proxied object's properties by index number to
		 *  retrieve property names. However, you cannot
		 *  enumerate the properties of the Proxy class themselves.
		 *  This function supports implementing for...in and
		 *  for each..in loops on the object to retrieve the desired names.
		 *
		 * @param index             <int> The zero-based index value of the object's property.
		 * @return                  <String> String The property's name.
		 */
		flash_proxy function nextName(index:int):String;
		/**
		 * Allows enumeration of the proxied object's properties by index number. However, you cannot
		 *  enumerate the properties of the Proxy class themselves.
		 *  This function supports implementing for...in and
		 *  for each..in loops on the object to retrieve property index values.
		 *
		 * @param index             <int> The zero-based index value where the enumeration begins.
		 * @return                  <int> The property's index value.
		 */
		flash_proxy function nextNameIndex(index:int):int;
		/**
		 * Allows enumeration of the proxied object's properties by index number to
		 *  retrieve property values. However, you cannot
		 *  enumerate the properties of the Proxy class themselves.
		 *  This function supports implementing for...in and
		 *  for each..in loops on the object to retrieve the desired values.
		 *
		 * @param index             <int> The zero-based index value of the object's property.
		 * @return                  <*> The property's value.
		 */
		flash_proxy function nextValue(index:int):*;
		/**
		 * Overrides a call to change a property's value. If the property can't be found, this method
		 *  creates a property with the specified name and value.
		 *
		 * @param name              <*> The name of the property to modify.
		 * @param value             <*> The value to set the property to.
		 */
		flash_proxy function setProperty(name:*, value:*):void;
	}
}
