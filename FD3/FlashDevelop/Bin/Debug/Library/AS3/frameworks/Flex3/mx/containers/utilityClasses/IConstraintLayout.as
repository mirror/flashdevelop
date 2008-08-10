/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers.utilityClasses {
	public interface IConstraintLayout {
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
	}
}
