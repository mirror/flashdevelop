package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of metadata for a MBean attribute.
	 */
	public class MBeanAttributeInfo extends MBeanFeatureInfo
	{
		/**
		 * The data type of the attribute.
		 */
		public var type : String;
		/**
		 * Indicates if the attribute is readable.
		 */
		public var readable : Boolean;
		/**
		 * Indicates if the attribute is writable.
		 */
		public var writable : Boolean;
		/**
		 * Indicates if the server-side getter for the attribute has an 'is' prefix.
		 */
		public var isIs : Boolean;

		/**
		 *  Creates a new instance of an empty MBeanAttributeInfo.
		 */
		public function MBeanAttributeInfo ();
	}
}
