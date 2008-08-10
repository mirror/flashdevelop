/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.xml {
	public interface IXMLEncoder {
		/**
		 * The function to be used to escape XML special characters before encoding
		 *  any simple content.
		 */
		public function get xmlSpecialCharsFilter():Function;
		public function set xmlSpecialCharsFilter(value:Function):void;
		/**
		 * Encodes an ActionScript value as XML.
		 *
		 * @param value             <*> The ActionScript value to encode as XML.
		 * @param name              <QName (default = null)> The QName of an XML Schema element that
		 *                            describes how to encode the value, or the name to be used for the
		 *                            encoded XML node when a type parameter is also specified.
		 * @param type              <QName (default = null)> The QName of an XML Schema simpleType or
		 *                            complexType definition that describes how to encode the
		 *                            value.
		 * @param definition        <XML (default = null)> If neither a top-level element nor type exists in the
		 *                            schema to describe how to encode this value, a custom element definition
		 *                            can be provided.
		 */
		public function encode(value:*, name:QName = null, type:QName = null, definition:XML = null):XMLList;
		/**
		 * Resets the encoder to its initial state, including resetting any
		 *  Schema scope to the top level.
		 */
		public function reset():void;
	}
}
