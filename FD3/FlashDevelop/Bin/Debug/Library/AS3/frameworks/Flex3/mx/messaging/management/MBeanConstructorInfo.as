package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of metadata for a MBean constructor.
	 */
	public class MBeanConstructorInfo extends MBeanFeatureInfo
	{
		/**
		 * The parameter data types that make up the constructor signature.
		 */
		public var signature : Array;

		/**
		 *  Creates a new instance of an empty MBeanConstructorInfo.
		 */
		public function MBeanConstructorInfo ();
	}
}
