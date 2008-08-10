/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.xml {
	public interface IXMLSchemaInstance {
		/**
		 * When encoding ActionScript instances as XML the encoder may require
		 *  a type definition for the concrete implementation when the associated
		 *  XML Schema complexType is abstract. This property allows a typed
		 *  instance to specify the concrete implementation as a QName to represent
		 *  the xsi:type.
		 */
		public function get xsiType():QName;
		public function set xsiType(value:QName):void;
	}
}
