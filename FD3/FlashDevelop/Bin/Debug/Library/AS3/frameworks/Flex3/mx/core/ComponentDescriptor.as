/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class ComponentDescriptor {
		/**
		 * A reference to the document Object in which the component
		 *  is to be created.
		 */
		public var document:Object;
		/**
		 * An Object containing name/value pairs for the component's
		 *  event handlers, as specified in MXML.
		 */
		public var events:Object;
		/**
		 * The identifier for the component, as specified in MXML.
		 */
		public var id:String;
		/**
		 * An Object containing name/value pairs for the component's properties,
		 *  as specified in MXML.
		 */
		public function get properties():Object;
		/**
		 * A Function that returns an Object containing name/value pairs
		 *  for the component's properties, as specified in MXML.
		 */
		public var propertiesFactory:Function;
		/**
		 * The Class of the component, as specified in MXML.
		 */
		public var type:Class;
		/**
		 * Constructor
		 *
		 * @param descriptorProperties<Object> An Object containing name/value pairs
		 *                            for the properties of the ComponentDescriptor object, such as its
		 *                            type, id, propertiesFactory
		 *                            and events
		 */
		public function ComponentDescriptor(descriptorProperties:Object);
		/**
		 * Invalidates the cached properties property.
		 *  The next time you read the properties property,
		 *  the properties are regenerated from the function specified by the
		 *  value of the propertiesFactory property.
		 */
		public function invalidateProperties():void;
		/**
		 * Returns the string "ComponentDescriptor_" plus the value of the
		 *  id property.
		 *
		 * @return                  <String> The string "ComponentDescriptor_" plus the value of the
		 *                            id property.
		 */
		public function toString():String;
	}
}
