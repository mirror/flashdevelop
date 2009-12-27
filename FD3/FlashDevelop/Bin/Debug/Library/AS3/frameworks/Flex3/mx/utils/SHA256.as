package mx.utils
{
	import flash.utils.ByteArray;

	/**
	 * Implementation of SHA-256 hash algorithm as described in
     * Federal Information Processing Standards Publication 180-2
     * at http://csrc.nist.gov/publications/fips/fips180-2/fips180-2.pdf
	 */
	public class SHA256
	{
		/**
		 *  Identifies this hash is of type "SHA-256".
		 */
		public static const TYPE_ID : String = "SHA-256";
		private static var k : Array;

		/**
		 * Computes the digest of a message using the SHA-256 hash algorithm.
        * 
        * @param byteArray - the message, may not be null.
        * 
        * return String - 64 character hexidecimal representation of the digest.
        *
		 */
		public static function computeDigest (byteArray:ByteArray) : String;

		/**
		 * get the next n bytes of the message from the byteArray and move it to the message block.
        *
        * @param byteArray - message
        * @param m - message block (output)
		 */
		private static function getMessageBlock (byteArray:ByteArray, m:ByteArray) : void;

		private static function toHex (n:uint) : String;
	}
}
