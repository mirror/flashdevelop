package mx.rpc.xml
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import mx.utils.object_proxy;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;

	/**
	 * Wraps the value of an element's or child type's content so that it can be * added as a property to a parent complex type at a later time when processing * against a Schema. *  * @private
	 */
	public dynamic class ContentProxy extends Proxy
	{
		private var _content : *;
		private var _isSimple : Boolean;
		private var _makeObjectsBindable : Boolean;
		private var _propertyList : Array;

		function get makeObjectsBindable () : Boolean;
		function set makeObjectsBindable (value:Boolean) : void;
		function get isSimple () : Boolean;
		function set isSimple (value:Boolean) : void;
		function get content () : *;
		function set content (value:*) : void;

		public function ContentProxy (content:* = undefined, makeObjectsBindable:Boolean = false, isSimple:Boolean = true);
		/**
		 *  Returns the specified property value of the proxied object.     *     *  @param name Typically a string containing the name of the property,     *  or possibly a QName where the property name is found by      *  inspecting the <code>localName</code> property.     *     *  @return The value of the property.     *  In some instances this value may be an instance of      *  <code>ObjectProxy</code>.
		 */
		flash_proxy function getProperty (name:*) : *;
		/**
		 *  Returns the value of the proxied object's method with the specified name.     *     *  @param name The name of the method being invoked.     *     *  @param rest An array specifying the arguments to the     *  called method.     *     *  @return The return value of the called method.
		 */
		flash_proxy function callProperty (name:*, ...rest) : *;
		/**
		 *  Deletes the specified property on the proxied object.     *      *  @param name Typically a string containing the name of the property,     *  or possibly a QName where the property name is found by      *  inspecting the <code>localName</code> property.     *     *  @return A Boolean indicating if the property was deleted.
		 */
		flash_proxy function deleteProperty (name:*) : Boolean;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *       *  @param name The property name that should be tested      *  for existence.     *     *  @see flash.utils.Proxy#hasProperty()
		 */
		flash_proxy function hasProperty (name:*) : Boolean;
		/**
		 *  Updates the specified property on the proxied object.     *     *  @param name Object containing the name of the property that     *  should be updated on the proxied object.     *     *  @param value Value that should be set on the proxied object.
		 */
		flash_proxy function setProperty (name:*, value:*) : void;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *     *  @see flash.utils.Proxy#nextName()
		 */
		flash_proxy function nextName (index:int) : String;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *     *  @see flash.utils.Proxy#nextNameIndex()
		 */
		flash_proxy function nextNameIndex (index:int) : int;
		/**
		 *  This is an internal function that must be implemented by      *  a subclass of flash.utils.Proxy.     *     *  @see flash.utils.Proxy#nextValue()
		 */
		flash_proxy function nextValue (index:int) : *;
		function setupPropertyList () : void;
		function createObject () : *;
	}
}
