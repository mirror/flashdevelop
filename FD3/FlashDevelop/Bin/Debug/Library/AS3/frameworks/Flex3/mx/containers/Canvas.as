/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	import mx.core.Container;
	import mx.containers.utilityClasses.IConstraintLayout;
	public class Canvas extends Container implements IConstraintLayout {
		/**
		 * An Array of ConstraintColumn instances that partition this container.
		 *  The ConstraintColumn instance at index 0 is the left-most column;
		 *  indices increase from left to right.
		 */
		public function get constraintColumns():Array;
		public function set constraintColumns(value:Array):void;
		/**
		 * An Array of ConstraintRow instances that partition this container.
		 *  The ConstraintRow instance at index 0 is the top-most row;
		 *  indices increase from top to bottom.
		 */
		public function get constraintRows():Array;
		public function set constraintRows(value:Array):void;
		/**
		 * Constructor.
		 */
		public function Canvas();
		/**
		 * Calculates the preferred minimum and preferred maximum sizes
		 *  of the Canvas.
		 */
		protected override function measure():void;
		/**
		 * Sets the size of each child of the container.
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
