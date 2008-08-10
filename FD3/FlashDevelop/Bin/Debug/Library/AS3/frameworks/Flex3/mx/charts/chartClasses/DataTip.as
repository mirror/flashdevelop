/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.charts.chartClasses {
	import mx.core.UIComponent;
	import mx.core.IDataRenderer;
	public class DataTip extends UIComponent implements IDataRenderer {
		/**
		 * The HitData structure describing the data point
		 *  that the DataTip is rendering.
		 */
		public function get data():Object;
		public function set data(value:Object):void;
		/**
		 * Specifies the maximum width of the bounding box, in pixels,
		 *  for new DataTip controls.
		 */
		public static var maxTipWidth:Number = 300;
		/**
		 * Constructor.
		 */
		public function DataTip();
		/**
		 * Create child objects of the component.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
		 */
		protected override function createChildren():void;
		/**
		 * Calculates the default size, and optionally the default minimum size,
		 *  of the component. This is an advanced method that you might override when
		 *  creating a subclass of UIComponent.
		 */
		protected override function measure():void;
		/**
		 * Draws the object and/or sizes and positions its children.
		 *  This is an advanced method that you might override
		 *  when creating a subclass of UIComponent.
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
