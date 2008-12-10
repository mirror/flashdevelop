package mx.core
{
	/**
	 *  The IIMESupport interface defines the interface for any component that supports IME  *  (input method editor). *  IME is used for entering characters in Chinese, Japanese, and Korean. *  *  @see flash.system.IME
	 */
	public interface IIMESupport
	{
		/**
		 *  The IME mode of the component.
		 */
		public function get imeMode () : String;
		/**
		 *  @private
		 */
		public function set imeMode (value:String) : void;

	}
}
