﻿package mx.rpc.xml
{
	/**
	 * Decodes an XML document to an ActionScript object graph based on XML * Schema definitions. *
	 */
	public interface IXMLDecoder
	{
		/**
		 * When makeObjectsBindable is set to <code>true</code>, anonymous Objects and Arrays     * are wrapped to make them bindable. Objects are wrapped with     * <code>mx.utils.ObjectProxy</code> and Arrays are wrapped with     * <code>mx.collections.ArrayCollection</code>.
		 */
		public function get makeObjectsBindable () : Boolean;
		public function set makeObjectsBindable (value:Boolean) : void;
		/**
		 * When recordXSIType is set to <code>true</code>, if an encoded complexType     * has an <code>xsi:type</code> attribute the type information will be     * recorded on the decoded instance if it is strongly typed and implements     * <code>mx.rpc.xml.IXMLSchemaInstance</code> or is an anonymous     * <code>mx.utils.ObjectProxy</code>. This type information can be used     * to post process the decoded objects and identify which concrete     * implementation of a potentially abstract type was used.     * The default is false.
		 */
		public function get recordXSIType () : Boolean;
		public function set recordXSIType (value:Boolean) : void;
		/**
		 * Maps XML Schema types by QName to ActionScript Classes in order to      * create strongly typed objects when decoding content.
		 */
		public function get typeRegistry () : SchemaTypeRegistry;
		public function set typeRegistry (value:SchemaTypeRegistry) : void;

		/**
		 * Decodes an XML document to an ActionScript object.     *      * @param xml The XML instance to decode to an ActionScript object.      * This may be an XML instance, an XMLList of length 1 or a String that is     * valid XML.     *     * @param name The QName of an XML Schema <code>element</code> that     * describes how to decode the value, or the name to be used for the     * decoded value when a type parameter is also specified.     *     * @param type The QName of an XML Schema <code>simpleType</code> or     * <code>complexType</code> definition that describes how to decode the     * value.     *     * @param definition If neither a top-level element nor type exists in the     * schema to describe how to decode this value, a custom element definition     * can be provided.     *     * @return Returns an ActionScript object decoded from the given XML document.
		 */
		public function decode (xml:*, name:QName = null, type:QName = null, definition:XML = null) : *;
		/**
		 * Resets the decoder to its initial state, including resetting any      * Schema scope to the top level and releases the current XML document by     * setting it to null.
		 */
		public function reset () : void;
	}
}
