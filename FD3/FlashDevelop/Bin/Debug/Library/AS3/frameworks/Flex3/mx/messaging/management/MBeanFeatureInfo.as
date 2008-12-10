package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of metadata for a MBean feature.
	 */
	public class MBeanFeatureInfo
	{
		/**
		 * The name of the MBean feature.
		 */
		public var name : String;
		/**
		 * The description of the MBean feature.
		 */
		public var description : String;

		/**
		 *  Creates a new instance of an empty MBeanFeatureInfo.
		 */
		public function MBeanFeatureInfo ();
		/**
		 *  Returns a string representation of the feature info.     *      *  @return String representation of the feature info.
		 */
		public function toString () : String;
	}
}
