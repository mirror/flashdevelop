package mx.rpc.xml
{
	/**
	 * Encodes an ActionScript object graph to XML based on an XML schema. *
	 */
	public interface IXMLEncoder
	{
		/**
		 * The function to be used to escape XML special characters before encoding     * any simple content.
		 */
		public function get xmlSpecialCharsFilter () : Function;
		public function set xmlSpecialCharsFilter (func:Function) : void;
		/**
		 * When <code>true</code>, null values     * are encoded according to XML Schema rules (requires <code>nillable=true</code>     * to be set in the definition).      * When <code>false</code>, null values are always encoded with the     * <code>xsi:nil="true"</code> attribute.      *     * @default false
		 */
		public function get strictNillability () : Boolean;
		public function set strictNillability (value:Boolean) : void;

		/**
		 * Encodes an ActionScript value as XML.     *      * @param value The ActionScript value to encode as XML.     *     * @param name The QName of an XML Schema <code>element</code> that     * describes how to encode the value, or the name to be used for the     * encoded XML node when a type parameter is also specified.     *     * @param type The QName of an XML Schema <code>simpleType</code> or     * <code>complexType</code> definition that describes how to encode the     * value.     *     * @param definition If neither a top-level element nor type exists in the     * schema to describe how to encode this value, a custom element definition     * can be provided.     *     * @return Returns an XML encoding of the given ActionScript value.
		 */
		public function encode (value:*, name:QName = null, type:QName = null, definition:XML = null) : XMLList;
		/**
		 * Resets the encoder to its initial state, including resetting any      * Schema scope to the top level.
		 */
		public function reset () : void;
	}
}
