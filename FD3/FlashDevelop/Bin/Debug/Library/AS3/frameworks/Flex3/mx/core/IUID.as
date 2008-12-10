package mx.core
{
	/**
	 *  The IUID interface defines the interface for objects that must have  *  Unique Identifiers (UIDs) to uniquely identify the object. *  UIDs do not need to be universally unique for most uses in Flex. *  One exception is for messages send by data services.
	 */
	public interface IUID
	{
		/**
		 *  The unique identifier for this object.
		 */
		public function get uid () : String;
		/**
		 *  @private
		 */
		public function set uid (value:String) : void;

	}
}
