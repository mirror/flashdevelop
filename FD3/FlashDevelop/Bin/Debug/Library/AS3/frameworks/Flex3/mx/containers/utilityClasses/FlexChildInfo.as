package mx.containers.utilityClasses
{
	import mx.core.IUIComponent;

include "../../core/Version.as"
	/**
	 *  @private
 *  Helper class for the Flex.flexChildrenProportionally() method.
	 */
	public class FlexChildInfo
	{
		/**
		 *  @private
		 */
		public var child : IUIComponent;
		/**
		 *  @private
		 */
		public var size : Number;
		/**
		 *  @private
		 */
		public var preferred : Number;
		/**
		 *  @private
		 */
		public var flex : Number;
		/**
		 *  @private
		 */
		public var percent : Number;
		/**
		 *  @private
		 */
		public var min : Number;
		/**
		 *  @private
		 */
		public var max : Number;
		/**
		 *  @private
		 */
		public var width : Number;
		/**
		 *  @private
		 */
		public var height : Number;

		/**
		 *  Constructor.
		 */
		public function FlexChildInfo ();
	}
}
