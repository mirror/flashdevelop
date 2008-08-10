/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	public class Form extends Container {
		/**
		 * The maximum width, in pixels, of the labels of the FormItems containers in this Form.
		 */
		public function get maxLabelWidth():Number;
		/**
		 * Constructor.
		 */
		public function Form();
		/**
		 * Calculates the preferred, minimum and maximum sizes of the Form.
		 *  For more information about the measure method,
		 *  see the UIComponent.measure() method.
		 */
		protected override function measure():void;
		/**
		 * Responds to size changes by setting the positions
		 *  and sizes of this container's children.
		 *  For more information about the updateDisplayList() method,
		 *  see the UIComponent.updateDisplayList() method.
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
