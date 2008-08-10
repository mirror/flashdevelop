/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import mx.containers.utilityClasses.IConstraintLayout;
	public class LayoutContainer extends Container implements IConstraintLayout {
		/**
		 * The mx.containers.utilityClasses.Layout subclass that is doing the layout
		 */
		protected var boxLayoutClass:Class;
		/**
		 * The mx.containers.utilityClasses.Layout subclass that is doing the layout
		 */
		protected var canvasLayoutClass:Class;
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
		 * Specifies the layout mechanism used for this application.
		 *  Applications can use "vertical", "horizontal",
		 *  or "absolute" positioning.
		 *  Vertical positioning lays out each child component vertically from
		 *  the top of the application to the bottom in the specified order.
		 *  Horizontal positioning lays out each child component horizontally
		 *  from the left of the application to the right in the specified order.
		 *  Absolute positioning does no automatic layout and requires you to
		 *  explicitly define the location of each child component.
		 */
		public function get layout():String;
		public function set layout(value:String):void;
		/**
		 * Constructor.
		 */
		public function LayoutContainer();
	}
}
