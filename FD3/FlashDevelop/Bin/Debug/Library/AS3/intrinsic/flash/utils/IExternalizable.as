/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.utils {
	public interface IExternalizable {
		/**
		 * A class implements this method to decode itself from a data stream by calling the methods of the IDataInput
		 *  interface. This method must read the values in the same sequence and with the same types as
		 *  were written by the writeExternal() method.
		 *
		 * @param input             <IDataInput> The name of the class that implements the IDataInput interface.
		 */
		public function readExternal(input:IDataInput):void;
		/**
		 * A class implements this method to encode itself for a data stream by calling the methods of the IDataOutput
		 *  interface.
		 *
		 * @param output            <IDataOutput> The name of the class that implements the IDataOutput interface.
		 */
		public function writeExternal(output:IDataOutput):void;
	}
}
