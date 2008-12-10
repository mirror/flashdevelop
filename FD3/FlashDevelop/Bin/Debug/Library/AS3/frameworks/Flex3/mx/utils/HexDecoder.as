package mx.utils
{
	import flash.utils.ByteArray;

	/**
	 *  Documentation is not currently available. *  Ported to ActionScript from flex/messaging/util/Hex.java *  @private
	 */
	public class HexDecoder
	{
		/**
		 *  @private
		 */
		private var _output : ByteArray;
		/**
		 *  @private
		 */
		private var _work : Array;

		/**
		 *  @private     *  Constructor.
		 */
		public function HexDecoder ();
		/**
		 *  @private
		 */
		public function decode (encoded:String) : void;
		/**
		 * Returns the decimal representation of a hex digit.     * @private
		 */
		public function digit (char:String) : int;
		/**
		 *  @private
		 */
		public function drain () : ByteArray;
		/**
		 *  @private
		 */
		public function flush () : ByteArray;
	}
}
