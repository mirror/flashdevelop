package mx.containers.gridClasses
{
	import mx.core.UIComponent;

include "../../core/Version.as"
	/**
	 *  @private
 *  Internal helper class used to exchange information between
 *  Grid and GridRow.
	 */
	public class GridRowInfo
	{
		/**
		 *  Input: Measurement for the GridRow.
		 */
		public var flex : Number;
		/**
		 *  Output: The actual height of each row,
	 *  as determined by updateDisplayList().
		 */
		public var height : Number;
		/**
		 *  Input: Measurement for the GridRow.
		 */
		public var max : Number;
		/**
		 *  Input: Measurement for the GridRow.
		 */
		public var min : Number;
		/**
		 *  Input: Measurement for the GridRow.
		 */
		public var preferred : Number;
		/**
		 *  Output: The actual position of each row,
	 *  as determined by updateDisplayList().
		 */
		public var y : Number;

		/**
		 *  Constructor.
		 */
		public function GridRowInfo ();
	}
}
