package mx.messaging.config
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import mx.utils.object_proxy;
	import mx.utils.ObjectUtil;

	/**
	 *  The ConfigMap class provides a mechanism to store the properties returned  *  by the server with the ordering of the properties maintained.
	 */
	flash_proxy dynamic class ConfigMap extends Proxy
	{
		/**
		 *  Contains a list of all of the property names for the proxied object.
		 */
		local var propertyList : Array;
		/**
		 *  Storage for the object property.
		 */
		private var _item : Object;

		/**
		 * Constructor.     *     * @param item An Object containing name/value pairs.
		 */
		public function ConfigMap (item:Object = null);
		/**
		 *  Returns the specified property value of the proxied object.     *     *  @param name Typically a string containing the name of the property,     *  or possibly a QName where the property name is found by      *  inspecting the <code>localName</code> property.     *     *  @return The value of the property.
		 */
		flash_proxy function getProperty (name:*) : *;
		/**
		 *  Returns the value of the proxied object's method with the specified name.     *     *  @param name The name of the method being invoked.     *     *  @param rest An array specifying the arguments to the     *  called method.     *     *  @return The return value of the called method.
		 */
		flash_proxy function callProperty (name:*, ...rest) : *;
		/**
		 *  Deletes the specified property on the proxied object and     *  sends notification of the delete to the handler.     *      *  @param name Typically a string containing the name of the property,     *  or possibly a QName where the property name is found by      *  inspecting the <code>localName</code> property.     *     *  @return A Boolean indicating if the property was deleted.
		 */
		flash_proxy function deleteProperty (name:*) : Boolean;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *       *  @param name The property name that should be tested      *  for existence.     *     *  @return If the property exists, <code>true</code>;      *  otherwise <code>false</code>.     *     *  @see flash.utils.Proxy#hasProperty()
		 */
		flash_proxy function hasProperty (name:*) : Boolean;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *     *  @param index The zero-based index value of the object's     *  property.     *     *  @return The property's name.     *     *  @see flash.utils.Proxy#nextName()
		 */
		flash_proxy function nextName (index:int) : String;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *     *  @see flash.utils.Proxy#nextNameIndex()
		 */
		flash_proxy function nextNameIndex (index:int) : int;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *     *  @param index The zero-based index value of the object's     *  property.     *     *  @return The property's value.     *     *  @see flash.utils.Proxy#nextValue()
		 */
		flash_proxy function nextValue (index:int) : *;
		/**
		 *  Updates the specified property on the proxied object     *  and sends notification of the update to the handler.     *     *  @param name Object containing the name of the property that     *  should be updated on the proxied object.     *     *  @param value Value that should be set on the proxied object.
		 */
		flash_proxy function setProperty (name:*, value:*) : void;
	}
}
