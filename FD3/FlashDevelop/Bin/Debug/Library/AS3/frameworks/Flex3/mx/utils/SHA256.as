/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	import flash.utils.ByteArray;
	public class SHA256 {
		/**
		 * Computes the digest of a message using the SHA-256 hash algorithm.
		 *
		 * @param byteArray         <ByteArray> - the message, may not be null.
		 *                            return String - 64 character hexidecimal representation of the digest.
		 */
		public static function computeDigest(byteArray:ByteArray):String;
		/**
		 * Identifies this hash is of type "SHA-256".
		 */
		public static const TYPE_ID:String = "SHA-256";
	}
}
