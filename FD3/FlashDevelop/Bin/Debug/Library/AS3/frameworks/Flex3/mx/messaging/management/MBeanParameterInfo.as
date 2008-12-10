package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of metadata for a MBean operation parameter.
	 */
	public class MBeanParameterInfo extends MBeanFeatureInfo
	{
		/**
		 * The data type of the operation parameter.
		 */
		public var type : String;

		/**
		 *  Creates a new instance of an empty MBeanParameterInfo.
		 */
		public function MBeanParameterInfo ();
	}
}
