/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	import flash.utils.Proxy;
	import flash.utils.IExternalizable;
	import mx.core.IPropertyChangeNotifier;
	import flash.events.Event;
	import mx.events.PropertyChangeEvent;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	public dynamic  class ObjectProxy extends Proxy implements IExternalizable, IPropertyChangeNotifier {
		/**
		 * A reference to the EventDispatcher for this proxy.
		 */
		protected var dispatcher:EventDispatcher;
		/**
		 * A hashmap of property change notifiers that this proxy is
		 *  listening for changes from; the key of the map is the property name.
		 */
		protected var notifiers:Object;
		/**
		 * The object being proxied.
		 */
		object_proxy function get object():Object;
		/**
		 * Contains a list of all of the property names for the proxied object.
		 *  Descendants need to fill this list by overriding the
		 *  setupPropertyList() method.
		 */
		protected var propertyList:Array;
		/**
		 * Indicates what kind of proxy to create
		 *  when proxying complex properties.
		 *  Subclasses should assign this value appropriately.
		 */
		protected var proxyClass:Class;
		/**
		 * The qualified type name associated with this object.
		 */
		object_proxy function get type():QName;
		object_proxy function set type(value:QName):void;
		/**
		 * The unique identifier for this object.
		 */
		public function get uid():String;
		public function set uid(value:String):void;
		/**
		 * Initializes this proxy with the specified object, id and proxy depth.
		 *
		 * @param item              <Object (default = null)> Object to proxy.
		 *                            If no item is specified, an anonymous object will be constructed
		 *                            and assigned.
		 * @param uid               <String (default = null)> String containing the unique id
		 *                            for this object instance.
		 *                            Required for IPropertyChangeNotifier compliance as every object must
		 *                            provide a unique way of identifying it.
		 *                            If no value is specified, a random id will be assigned.
		 * @param proxyDepth        <int (default = -1)> An integer indicating how many levels in a complex
		 *                            object graph should have a proxy created during property access.
		 *                            The default is -1, meaning "proxy to infinite depth".
		 */
		public function ObjectProxy(item:Object = null, uid:String = null, proxyDepth:int = -1);
		/**
		 * Registers an event listener object
		 *  so that the listener receives notification of an event.
		 *  For more information, see the flash.events.EventDispatcher class.
		 *
		 * @param type              <String> 
		 * @param listener          <Function> 
		 * @param useCapture        <Boolean (default = false)> 
		 * @param priority          <int (default = 0)> 
		 * @param useWeakReference  <Boolean (default = false)> 
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
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
		 * Dispatches an event into the event flow.
		 *  For more information, see the flash.events.EventDispatcher class.
		 *
		 * @param event             <Event> 
		 */
		public function dispatchEvent(event:Event):Boolean;
		/**
		 * Provides a place for subclasses to override how a complex property that
		 *  needs to be either proxied or daisy chained for event bubbling is managed.
		 *
		 * @param name              <*> Typically a string containing the name of the property,
		 *                            or possibly a QName where the property name is found by
		 *                            inspecting the localName property.
		 * @param value             <*> The property value.
		 * @return                  <*> The property value or an instance of ObjectProxy.
		 */
		object_proxy function getComplexProperty(name:*, value:*):*;
		/**
		 * Returns the specified property value of the proxied object.
		 *
		 * @param name              <*> Typically a string containing the name of the property,
		 *                            or possibly a QName where the property name is found by
		 *                            inspecting the localName property.
		 * @return                  <*> The value of the property.
		 *                            In some instances this value may be an instance of
		 *                            ObjectProxy.
		 */
		flash_proxy override function getProperty(name:*):*;
		/**
		 * Checks whether there are any event listeners registered
		 *  for a specific type of event.
		 *  This allows you to determine where an object has altered handling
		 *  of an event type in the event flow hierarchy.
		 *  For more information, see the flash.events.EventDispatcher class.
		 *
		 * @param type              <String> 
		 */
		public function hasEventListener(type:String):Boolean;
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
		 * Called when a complex property is updated.
		 *
		 * @param event             <PropertyChangeEvent> 
		 */
		public function propertyChangeHandler(event:PropertyChangeEvent):void;
		/**
		 * Since Flex only uses ObjectProxy to wrap anonymous objects,
		 *  the server flex.messaging.io.ObjectProxy instance serializes itself
		 *  as a Map that will be returned as a plain ActionScript object.
		 *  You can then set the object_proxy object property to this value.
		 *
		 * @param input             <IDataInput> 
		 */
		public function readExternal(input:IDataInput):void;
		/**
		 * Removes an event listener.
		 *  If there is no matching listener registered with the EventDispatcher object,
		 *  a call to this method has no effect.
		 *  For more information, see the flash.events.EventDispatcher class.
		 *
		 * @param type              <String> 
		 * @param listener          <Function> 
		 * @param useCapture        <Boolean (default = false)> 
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		/**
		 * Updates the specified property on the proxied object
		 *  and sends notification of the update to the handler.
		 *
		 * @param name              <*> Object containing the name of the property that
		 *                            should be updated on the proxied object.
		 * @param value             <*> Value that should be set on the proxied object.
		 */
		flash_proxy override function setProperty(name:*, value:*):void;
		/**
		 * This method creates an array of all of the property names for the
		 *  proxied object.
		 *  Descendants must override this method if they wish to add more
		 *  properties to this list.
		 *  Be sure to call super.setupPropertyList before making any
		 *  changes to the propertyList property.
		 */
		protected function setupPropertyList():void;
		/**
		 * Checks whether an event listener is registered with this object
		 *  or any of its ancestors for the specified event type.
		 *  This method returns true if an event listener is triggered
		 *  during any phase of the event flow when an event of the specified
		 *  type is dispatched to this object or any of its descendants.
		 *  For more information, see the flash.events.EventDispatcher class.
		 *
		 * @param type              <String> 
		 */
		public function willTrigger(type:String):Boolean;
		/**
		 * Since Flex only serializes the inner ActionScript object that it wraps,
		 *  the server flex.messaging.io.ObjectProxy populates itself
		 *  with this anonymous object's contents and appears to the user as a Map.
		 *
		 * @param output            <IDataOutput> 
		 */
		public function writeExternal(output:IDataOutput):void;
	}
}
