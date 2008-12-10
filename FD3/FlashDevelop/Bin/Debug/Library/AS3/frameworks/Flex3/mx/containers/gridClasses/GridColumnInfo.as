package mx.containers.gridClasses
{
	import mx.containers.utilityClasses.FlexChildInfo;
	import mx.core.UIComponent;

	/**
	 *  @private *  Internal helper class used to exchange information between *  Grid and GridRow.
	 */
	public class GridColumnInfo extends FlexChildInfo
	{
		/**
		 *  Output: the actual position of each column,	 *  as determined by updateDisplayList().
		 */
		public var x : Number;

		/**
		 *  Constructor.
		 */
		public function GridColumnInfo ();
	}
}
