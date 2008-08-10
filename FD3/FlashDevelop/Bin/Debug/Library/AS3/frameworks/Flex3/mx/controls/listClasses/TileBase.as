/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls.listClasses {
	import flash.display.Sprite;
	public class TileBase extends ListBase {
		/**
		 * The direction in which this control lays out its children.
		 *  Possible values are TileBaseDirection.HORIZONTAL
		 *  and TileBaseDirection.VERTICAL.
		 *  The default value is TileBaseDirection.HORIZONTAL.
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * The maximum number of columns that the control can have.
		 *  If 0, then there are no limits to the number of
		 *  columns.  This value is ignored
		 *  if the direction is TileBaseDirection.VERTICAL
		 *  because the control will have as many columns as it needs to
		 *  to display all the data.
		 */
		public function get maxColumns():int;
		public function set maxColumns(value:int):void;
		/**
		 * The maximum number of rows that the control can have.
		 *  If 0, then there is no limit to the number of
		 *  rows.  This value is ignored
		 *  if the direction is TileBaseDirection.HORIZONTAL
		 *  because the control will have as many rows as it needs to
		 *  to display all the data.
		 */
		public function get maxRows():int;
		public function set maxRows(value:int):void;
		/**
		 * cache of measuring objects by factory
		 */
		protected var measuringObjects:Dictionary;
		/**
		 * Constructor.
		 */
		public function TileBase();
		/**
		 * Called from updateDisplayList() to adjust the size and position of
		 *  listContent.
		 *
		 * @param unscaledWidth     <Number (default = -1)> 
		 * @param unscaledHeight    <Number (default = -1)> 
		 */
		protected override function adjustListContent(unscaledWidth:Number = -1, unscaledHeight:Number = -1):void;
		/**
		 * Get the appropriate renderer, using the default renderer if none specified
		 *
		 * @param data              <Object> 
		 */
		public override function createItemRenderer(data:Object):IListItemRenderer;
		/**
		 * Draws the background for an individual tile.
		 *  Takes a Sprite object, applies the background dimensions
		 *  and color, and returns the sprite with the values applied.
		 *
		 * @param s                 <Sprite> The Sprite that contains the individual tile backgrounds.
		 * @param rowIndex          <int> The index of the row that contains the tile.
		 * @param columnIndex       <int> The index of the column that contains the tile.
		 * @param width             <Number> The width of the background.
		 * @param height            <Number> The height of the background.
		 * @param color             <uint> The fill color for the background.
		 * @param item              <IListItemRenderer> The item renderer for the tile.
		 * @return                  <DisplayObject> The background Sprite.
		 */
		protected function drawTileBackground(s:Sprite, rowIndex:int, columnIndex:int, width:Number, height:Number, color:uint, item:IListItemRenderer):DisplayObject;
		/**
		 * Draws the backgrounds, if any, behind all of the tiles.
		 *  This implementation makes a Sprite names "tileBGs" if
		 *  it doesn't exist, adds it to the back
		 *  of the z-order in the listContent, and
		 *  calls drawTileBackground() for each visible
		 *  tile.
		 */
		protected function drawTileBackgrounds():void;
		/**
		 * Creates a new ListData instance and populates the fields based on
		 *  the input data provider item.
		 *
		 * @param data              <Object> The data provider item used to populate the ListData.
		 * @param uid               <String> The UID for the item.
		 * @param rowNum            <int> The index of the item in the data provider.
		 * @param columnNum         <int> The columnIndex associated with this item.
		 * @return                  <BaseListData> A newly constructed ListData object.
		 */
		protected function makeListData(data:Object, uid:String, rowNum:int, columnNum:int):BaseListData;
		/**
		 * Adjusts the renderers in response to a change
		 *  in scroll position.
		 *
		 * @param pos               <int> The new scroll position.
		 * @param deltaPos          <int> The change in position.  It is always
		 *                            a positive number.
		 * @param scrollUp          <Boolean> true if scroll position
		 *                            is getting smaller.
		 */
		protected override function scrollHorizontally(pos:int, deltaPos:int, scrollUp:Boolean):void;
	}
}
