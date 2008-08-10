/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class CrossDomainRSLItem {
		/**
		 * Create a cross-domain RSL item to load.
		 *
		 * @param rslUrls           <Array> Array of Strings, may not be null. Each String is the url of an RSL to load.
		 * @param policyFileUrls    <Array> Array of Strings, may not be null. Each String contains the url of an
		 *                            policy file which may be required to allow the RSL to be read from another
		 *                            domain. An empty string means there is no policy file specified.
		 * @param digests           <Array> Array of Strings, may not be null. A String contains the value of the digest
		 *                            computed by the hash in the corresponding entry in the hashTypes Array. An empty
		 *                            string may be provided for unsigned RSLs to loaded them without verifying the digest.
		 *                            This is provided as a development cycle convenience and should not be used in a
		 *                            production application.
		 * @param hashTypes         <Array> Array of Strings, may not be null. Each String identifies the type of hash
		 *                            used to compute the digest. Currently the only valid value is SHA256.TYPE_ID.
		 * @param isSigned          <Array> Array of boolean, may not be null. Each boolean value specifies if the RSL to be
		 *                            loaded is a signed or unsigned RSL. If the value is true the RSL is signed.
		 *                            If the value is false the RSL is unsigned.
		 */
		public function CrossDomainRSLItem(rslUrls:Array, policyFileUrls:Array, digests:Array, hashTypes:Array, isSigned:Array);
		/**
		 * Does the current url being processed have a failover?
		 *
		 * @return                  <Boolean> true if a failover url exists, false otherwise.
		 */
		public function hasFailover():Boolean;
		/**
		 * Load an RSL.
		 *
		 * @param progressHandler   <Function> receives ProgressEvent.PROGRESS events, may be null
		 * @param completeHandler   <Function> receives Event.COMPLETE events, may be null
		 * @param ioErrorHandler    <Function> receives IOErrorEvent.IO_ERROR events, may be null
		 * @param securityErrorHandler<Function> receives SecurityErrorEvent.SECURITY_ERROR events, may be null
		 * @param rslErrorHandler   <Function> receives RSLEvent.RSL_ERROR events, may be null
		 */
		public override function load(progressHandler:Function, completeHandler:Function, ioErrorHandler:Function, securityErrorHandler:Function, rslErrorHandler:Function):void;
		/**
		 * Load the next url from the list of failover urls.
		 */
		public function loadFailover():void;
	}
}
