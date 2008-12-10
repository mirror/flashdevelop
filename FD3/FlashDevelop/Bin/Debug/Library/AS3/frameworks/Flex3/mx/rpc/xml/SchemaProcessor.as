package mx.rpc.xml
{
	import mx.utils.object_proxy;
	import mx.utils.URLUtil;

	/**
	 * This abstract class traverses an XML Schema to assist with marshalling typed * data between XML and ActionScript. *  * @private
	 */
	public class SchemaProcessor
	{
		protected var strictOccurenceBounds : Boolean;
		private var _schemaManager : SchemaManager;

		public function get schemaManager () : SchemaManager;
		public function set schemaManager (manager:SchemaManager) : void;
		protected function get constants () : SchemaConstants;

		public function SchemaProcessor ();
		/**
		 * Clears the state in preparation for a fresh schema processing operation.
		 */
		public function reset () : void;
		/**
		 * @private
		 */
		public function isBuiltInType (type:QName) : Boolean;
		/**
		 * Determines the length of a given value to check minOccurs/maxOccurs     * ranges. If value is an Array, the count of the elements is returned     * as the length otherwise the length is considered to be 1.     *      * @private
		 */
		public function getValueOccurence (value:*) : uint;
		/**
		 * A utility method to determine whether an attribute actually exists     * on a given node.
		 */
		protected function getAttributeFromNode (name:*, node:XML) : String;
		protected function getSingleElementFromNode (node:XML, ...types:Array) : XML;
		/**
		 * Looks for a maxOccurs constraint on the given definition. The default     * is 1. The constraint value "unbounded" is interpreted as     * <code>uint.MAX_VALUE</code>.
		 */
		protected function getMaxOccurs (definition:XML) : uint;
		/**
		 * Looks for a minOccurs constraint on the given definition. The default     * is 1.
		 */
		protected function getMinOccurs (definition:XML) : uint;
	}
}
