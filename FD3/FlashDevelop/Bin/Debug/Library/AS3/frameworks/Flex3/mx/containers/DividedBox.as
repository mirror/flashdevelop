/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.containers {
	public class DividedBox extends Box {
		/**
		 * The class for the divider between the children.
		 */
		protected var dividerClass:Class;
		/**
		 * If true, the children adjacent to a divider
		 *  are continuously resized while the user drags it.
		 *  If false, they are not resized
		 *  until the user releases the divider.
		 */
		public var liveDragging:Boolean = false;
		/**
		 * The number of dividers.
		 *  The count is always numChildren - 1.
		 */
		public function get numDividers():int;
		/**
		 * If true, the DividedBox automatically resizes to the size
		 *  of its children.
		 */
		public function get resizeToContent():Boolean;
		public function set resizeToContent(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function DividedBox();
		/**
		 * Returns a reference to the specified BoxDivider object
		 *  in this DividedBox container.
		 *
		 * @param i                 <int> Zero-based index of a divider, counting from
		 *                            the left for a horizontal DividedBox,
		 *                            or from the top for a vertical DividedBox.
		 * @return                  <BoxDivider> A BoxDivider object.
		 */
		public function getDividerAt(i:int):BoxDivider;
		/**
		 * Move a specific divider a given number of pixels.
		 *
		 * @param i                 <int> Zero-based index of a divider, counting from
		 *                            the left for a horizontal DividedBox,
		 *                            or from the top for a vertical DividedBox.
		 * @param amt               <Number> The number of pixels to move the divider.
		 *                            A negative number can be specified in order to move
		 *                            a divider up or left. The divider movement is
		 *                            constrained in the same manner as if a user
		 *                            had moved it.
		 */
		public function moveDivider(i:int, amt:Number):void;
	}
}
