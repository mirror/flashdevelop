/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts {
	import mx.containers.Tile;
	public class Legend extends Tile {
		/**
		 * Set of data to be used in the Legend.
		 */
		public function get dataProvider():Object;
		public function set dataProvider(value:Object):void;
		/**
		 * The class used to instantiate LegendItem objects.
		 *  When a legend's content is derived from the chart or data,
		 *  it instantiates one instance of legendItemClass
		 *  for each item described by the dataProvider.
		 *  If you want custom behavior in your legend items,
		 *  you can assign a subclass of LegendItem to this property
		 *  to have the Legend create instances of their derived type instead.
		 */
		public var legendItemClass:Class;
		/**
		 * Constructor.
		 */
		public function Legend();
		/**
		 * Processes the properties set on the component.
		 */
		protected override function commitProperties():void;
		/**
		 * Calculates the preferred, minimum, and maximum sizes of the Legend.
		 */
		protected override function measure():void;
		/**
		 * Sets the size and position of each child of the Legend.
		 *  This is an advanced method for use in subclassing.
		 *  If you override this method, your implementation should call
		 *  the super.updateDisplayList() method.
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
