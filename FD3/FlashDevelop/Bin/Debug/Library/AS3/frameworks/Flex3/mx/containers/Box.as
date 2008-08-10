/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	public class Box extends Container {
		/**
		 * The direction in which this Box container lays out its children.
		 *  Possible MXML values are
		 *  "horizontal" and "vertical".
		 *  Possible values in ActionScript are BoxDirection.HORIZONTAL
		 *  and BoxDirection.VERTICAL.
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * Constructor.
		 */
		public function Box();
		/**
		 * Calculates the default sizes and minimum and maximum values of the Box
		 *  container.
		 */
		protected override function measure():void;
		/**
		 * Method used to convert number of pixels to a
		 *  percentage relative to the contents of this container.
		 *
		 * @param pxl               <Number> The number of pixels for which a percentage
		 *                            value is desired.
		 * @return                  <Number> The percentage value that would be equivalent
		 *                            to pxl under the current layout conditions
		 *                            of this container.
		 *                            A negative value indicates that the container must grow
		 *                            in order to accommodate the requested size.
		 */
		public function pixelsToPercent(pxl:Number):Number;
		/**
		 * Sets the size and position of each child of the Box container.
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
