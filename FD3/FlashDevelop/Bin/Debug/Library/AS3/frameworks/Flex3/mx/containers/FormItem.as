/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	import mx.controls.Label;
	public class FormItem extends Container {
		/**
		 * Direction of the FormItem subcomponents.
		 *  Possible MXML values are "vertical"
		 *  or "horizontal".
		 *  The default MXML value is "vertical".
		 *  Possible ActionScript values are FormItemDirection.VERTICAL
		 *  or FormItemDirection.HORIZONTAL.
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * A read-only reference to the FormItemLabel subcomponent
		 *  displaying the label of the FormItem.
		 */
		public function get itemLabel():Label;
		/**
		 * Text label for the FormItem. This label appears to the left of the
		 *  child components of the form item. The position of the label is
		 *  controlled by the textAlign style property.
		 */
		public function get label():String;
		public function set label(value:String):void;
		/**
		 * If true, display an indicator
		 *  that the FormItem children require user input.
		 *  If false, indicator is not displayed.
		 */
		public function get required():Boolean;
		public function set required(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function FormItem();
		/**
		 * Calculates the preferred, minimum and maximum sizes of the FormItem.
		 *  See the UIComponent.measure() method for more information
		 *  about the measure() method.
		 */
		protected override function measure():void;
		/**
		 * Responds to size changes by setting the positions and sizes
		 *  of this container's children.
		 *  See the UIComponent.updateDisplayList() method
		 *  for more information about the updateDisplayList() method.
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
