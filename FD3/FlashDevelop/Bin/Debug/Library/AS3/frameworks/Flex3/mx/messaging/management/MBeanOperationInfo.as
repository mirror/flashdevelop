package mx.messaging.management
{
	import mx.utils.ObjectUtil;

	/**
	 * Client representation of metadata for a MBean operation.
	 */
	public class MBeanOperationInfo extends MBeanFeatureInfo
	{
		/**
		 * The parameter data types that make up the operation signature.
		 */
		public var signature : Array;
		/**
		 * The return data type for the operation.
		 */
		public var returnType : String;
		/**
		 * The impact of the operation. One of four possible values, defined as constants	 * for this class.	 *	 * @see #INFO	 * @see #ACTION	 * @see #ACTION_INFO	 * @see #UNKNOWN
		 */
		public var impact : int;
		/**
		 * The operation is purely informational with no side-effects, read-only.
		 */
		public const INFO : int = 0;
		/**
		 * The operation is write-like, updating the control in some way.
		 */
		public const ACTION : int = 1;
		/**
		 * The operation is both read-like and write-like, updating the control and returning	 * information.
		 */
		public const ACTION_INFO : int = 2;
		/**
		 * The side-effects for the operation are unknown.
		 */
		public const UNKNOWN : int = 3;

		/**
		 *  Creates a new instance of an empty MBeanOperationInfo.
		 */
		public function MBeanOperationInfo ();
	}
}
