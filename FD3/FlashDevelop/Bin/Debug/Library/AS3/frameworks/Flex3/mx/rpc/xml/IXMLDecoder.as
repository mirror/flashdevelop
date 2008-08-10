/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.xml {
	public interface IXMLDecoder {
		/**
		 * When makeObjectsBindable is set to true, anonymous Objects and Arrays
		 *  are wrapped to make them bindable. Objects are wrapped with
		 *  mx.utils.ObjectProxy and Arrays are wrapped with
		 *  mx.collections.ArrayCollection.
		 */
		public function get makeObjectsBindable():Boolean;
		public function set makeObjectsBindable(value:Boolean):void;
		/**
		 * When recordXSIType is set to true, if an encoded complexType
		 *  has an xsi:type attribute the type information will be
		 *  recorded on the decoded instance if it is strongly typed and implements
		 *  mx.rpc.xml.IXMLSchemaInstance or is an anonymous
		 *  mx.utils.ObjectProxy. This type information can be used
		 *  to post process the decoded objects and identify which concrete
		 *  implementation of a potentially abstract type was used.
		 *  The default is false.
		 */
		public function get recordXSIType():Boolean;
		public function set recordXSIType(value:Boolean):void;
		/**
		 * Maps XML Schema types by QName to ActionScript Classes in order to
		 *  create strongly typed objects when decoding content.
		 */
		public function get typeRegistry():SchemaTypeRegistry;
		public function set typeRegistry(value:SchemaTypeRegistry):void;
		/**
		 * Decodes an XML document to an ActionScript object.
		 *
		 * @param xml               <*> The XML instance to decode to an ActionScript object.
		 *                            This may be an XML instance, an XMLList of length 1 or a String that is
		 *                            valid XML.
		 * @param name              <QName (default = null)> The QName of an XML Schema element that
		 *                            describes how to decode the value, or the name to be used for the
		 *                            decoded value when a type parameter is also specified.
		 * @param type              <QName (default = null)> The QName of an XML Schema simpleType or
		 *                            complexType definition that describes how to decode the
		 *                            value.
		 * @param definition        <XML (default = null)> If neither a top-level element nor type exists in the
		 *                            schema to describe how to decode this value, a custom element definition
		 *                            can be provided.
		 */
		public function decode(xml:*, name:QName = null, type:QName = null, definition:XML = null):*;
		/**
		 * Resets the decoder to its initial state, including resetting any
		 *  Schema scope to the top level and releases the current XML document by
		 *  setting it to null.
		 */
		public function reset():void;
	}
}
