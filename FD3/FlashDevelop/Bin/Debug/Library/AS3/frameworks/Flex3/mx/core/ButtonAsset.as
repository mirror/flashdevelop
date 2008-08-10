/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class ButtonAsset extends FlexSimpleButton implements IFlexAsset, IFlexDisplayObject {
		/**
		 * The measured height of this object.
		 */
		public function get measuredHeight():Number;
		/**
		 * The measured width of this object.
		 */
		public function get measuredWidth():Number;
		/**
		 * Constructor.
		 */
		public function ButtonAsset();
		/**
		 * Moves this object to the specified x and y coordinates.
		 *
		 * @param x                 <Number> The new x-position for this object.
		 * @param y                 <Number> The new y-position for this object.
		 */
		public function move(x:Number, y:Number):void;
		/**
		 * Sets the actual size of this object.
		 *
		 * @param newWidth          <Number> The new width for this object.
		 * @param newHeight         <Number> The new height for this object.
		 */
		public function setActualSize(newWidth:Number, newHeight:Number):void;
	}
}
