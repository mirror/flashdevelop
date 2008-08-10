/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public class SpriteAsset extends FlexSprite implements IFlexAsset, IFlexDisplayObject, IBorder {
		/**
		 * Returns an EdgeMetrics object for the border that has four properties:
		 *  left, top, right,
		 *  and bottom.
		 *  The value of each property is equal to the thickness of one side
		 *  of the border, in pixels.
		 */
		public function get borderMetrics():EdgeMetrics;
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
		public function SpriteAsset();
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
