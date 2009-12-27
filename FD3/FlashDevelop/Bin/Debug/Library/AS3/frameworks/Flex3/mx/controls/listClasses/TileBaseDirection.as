package mx.controls.listClasses
{
include "../../core/Version.as"
	/**
	 *  Values for the <code>direction</code> property of the TileList component.
 *
 *  @see mx.controls.listClasses.TileBase#direction
	 */
	public class TileBaseDirection
	{
		/**
		 *  Arrange children horizontally.
	 *  For controls, such as TileList, that arrange children in
	 *  two dimensions, arrange the children by filling up a row 
	 *  before going on to the next row.
		 */
		public static const HORIZONTAL : String = "horizontal";
		/**
		 *  Arrange chidren vertically.
	 *  For controls, such as TileList, that arrange children in
	 *  two dimensions, arrange the children by filling up a column
	 *  before going on to the next column.
		 */
		public static const VERTICAL : String = "vertical";
	}
}
