/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.config {
	import flash.utils.Proxy;
	public dynamic  class ConfigMap extends Proxy {
		/**
		 * Contains a list of all of the property names for the proxied object.
		 */
		object_proxy var propertyList:Array;
		/**
		 * Returns the value of the proxied object's method with the specified name.
		 *
		 * @param name              <*> The name of the method being invoked.
		 * @return                  <*> The return value of the called method.
		 */
		flash_proxy override function callProperty(name:*, ... rest):*;
		/**
		 * Deletes the specified property on the proxied object and
		 *  sends notification of the delete to the handler.
		 *
		 * @param name              <*> Typically a string containing the name of the property,
		 *                            or possibly a QName where the property name is found by
		 *                            inspecting the localName property.
		 * @return                  <Boolean> A Boolean indicating if the property was deleted.
		 */
		flash_proxy override function deleteProperty(name:*):Boolean;
		/**
		 * Returns the specified property value of the proxied object.
		 *
		 * @param name              <*> Typically a string containing the name of the property,
		 *                            or possibly a QName where the property name is found by
		 *                            inspecting the localName property.
		 * @return                  <*> The value of the property.
		 */
		flash_proxy override function getProperty(name:*):*;
		/**
		 * This is an internal function that must be implemented by
		 *  a subclass of flash.utils.Proxy.
		 *
		 * @param name              <*> The property name that should be tested
		 *                            for existence.
		 */
		flash_proxy override function hasProperty(name:*):Boolean;
		/**
		 * This is an internal function that must be implemented by
		 *  a subclass of flash.utils.Proxy.
		 *
		 * @param index             <int> 
		 */
		flash_proxy override function nextName(index:int):String;
		/**
		 * This is an internal function that must be implemented by
		 *  a subclass of flash.utils.Proxy.
		 *
		 * @param index             <int> 
		 */
		flash_proxy override function nextNameIndex(index:int):int;
		/**
		 * This is an internal function that must be implemented by
		 *  a subclass of flash.utils.Proxy.
		 *
		 * @param index             <int> 
		 */
		flash_proxy override function nextValue(index:int):*;
		/**
		 * Updates the specified property on the proxied object
		 *  and sends notification of the update to the handler.
		 *
		 * @param name              <*> Object containing the name of the property that
		 *                            should be updated on the proxied object.
		 * @param value             <*> Value that should be set on the proxied object.
		 */
		flash_proxy override function setProperty(name:*, value:*):void;
	}
}
