/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc.soap {
	import mx.rpc.Fault;
	public class SOAPFault extends Fault {
		/**
		 * The detail property is the same as faultDetail but exists
		 *  to match the case of the detail element in a SOAP Fault.
		 */
		public function get detail():String;
		public function set detail(value:String):void;
		/**
		 * The raw XML of this SOAP Fault.
		 */
		public var element:XML;
		/**
		 * A SOAP Fault may provide information about who caused the fault through
		 *  a faultactor property.
		 */
		public var faultactor:String;
		/**
		 * The faultcode property is similar to faultCode but exists to both
		 *  match the case of the faultcode element in a SOAP Fault and to provide
		 *  the fully qualified name of the code.
		 */
		public var faultcode:QName;
		/**
		 * The faultstring property is the same as faultString but exists
		 *  to match the case of the faultstring element in a SOAP envelope Fault.
		 */
		public function get faultstring():String;
		public function set faultstring(value:String):void;
		/**
		 */
		public override function toString():String;
	}
}
