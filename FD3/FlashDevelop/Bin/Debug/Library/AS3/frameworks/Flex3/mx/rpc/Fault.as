/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.rpc {
	public class Fault extends Error {
		/**
		 */
		protected var _faultCode:String;
		/**
		 */
		protected var _faultDetail:String;
		/**
		 */
		protected var _faultString:String;
		/**
		 * A simple code describing the fault.
		 */
		public function get faultCode():String;
		/**
		 * Any extra details of the fault.
		 */
		public function get faultDetail():String;
		/**
		 * Text description of the fault.
		 */
		public function get faultString():String;
		/**
		 * The cause of the fault. The value will be null if the cause is
		 *  unknown or whether this fault represents the root itself.
		 */
		public var rootCause:Object;
		/**
		 * Creates a new Fault object.
		 *
		 * @param faultCode         <String> 
		 * @param faultString       <String> 
		 * @param faultDetail       <String (default = null)> 
		 */
		public function Fault(faultCode:String, faultString:String, faultDetail:String = null);
		/**
		 */
		public function toString():String;
	}
}
