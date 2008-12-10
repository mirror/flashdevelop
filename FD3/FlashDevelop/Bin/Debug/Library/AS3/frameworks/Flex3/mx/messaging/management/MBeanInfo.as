package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of metadata for a MBean.
	 */
	public class MBeanInfo
	{
		/**
		 * The class name for the MBean.
		 */
		public var className : String;
		/**
		 * The description for the MBean.
		 */
		public var description : String;
		/**
		 * The attributes exposed by the MBean.
		 */
		public var attributes : Array;
		/**
		 * The constructors exposed by the MBean.
		 */
		public var constructors : Array;
		/**
		 * The operations provided by the MBean.
		 */
		public var operations : Array;

		/**
		 *  Creates a new instance of an empty MBeanInfo.
		 */
		public function MBeanInfo ();
		/**
		 *  Returns a string representation of the MBean info.     *      *  @return String representation of the MBean info.
		 */
		public function toString () : String;
	}
}
