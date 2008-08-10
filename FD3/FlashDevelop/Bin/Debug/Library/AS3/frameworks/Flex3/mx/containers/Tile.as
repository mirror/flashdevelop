/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	public class Tile extends Container {
		/**
		 * Determines how children are placed in the container.
		 *  Possible MXML values  are "horizontal" and
		 *  "vertical".
		 *  In ActionScript, you can set the direction using the values
		 *  TileDirection.HORIZONTAL or TileDirection.VERTICAL.
		 *  The default value is "horizontal".
		 *  (If the container is a Legend container, which is a subclass of Tile,
		 *  the default value is "vertical".)
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * Height of each tile cell, in pixels.
		 *  If this property is NaN, the default, the height
		 *  of each cell is determined by the height of the tallest child.
		 *  If you set this property, the specified value overrides
		 *  this calculation.
		 */
		public function get tileHeight():Number;
		public function set tileHeight(value:Number):void;
		/**
		 * Width of each tile cell, in pixels.
		 *  If this property is NaN, the defualt, the width
		 *  of each cell is determined by the width of the widest child.
		 *  If you set this property, the specified value overrides
		 *  this calculation.
		 */
		public function get tileWidth():Number;
		public function set tileWidth(value:Number):void;
		/**
		 * Constructor.
		 */
		public function Tile();
		/**
		 * Calculates the default minimum and maximum sizes of the
		 *  Tile container.
		 *  For more information about the measure() method,
		 *  see the UIComponent.measure() method.
		 */
		protected override function measure():void;
		/**
		 * Sets the positions and sizes of this container's children.
		 *  For more information about the updateDisplayList()
		 *  method, see the UIComponent.updateDisplayList() method.
		 *
		 * @param unscaledWidth     <Number> Specifies the width of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleX property of the component.
		 * @param unscaledHeight    <Number> Specifies the height of the component, in pixels,
		 *                            in the component's coordinates, regardless of the value of the
		 *                            scaleY property of the component.
		 */
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void;
	}
}
