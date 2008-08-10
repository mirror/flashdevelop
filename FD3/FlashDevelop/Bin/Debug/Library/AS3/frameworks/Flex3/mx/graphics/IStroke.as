/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.graphics {
	import flash.display.Graphics;
	public interface IStroke {
		/**
		 * The line weight, in pixels.
		 *  For many chart lines, the default value is 1 pixel.
		 */
		public function get weight():Number;
		public function set weight(value:Number):void;
		/**
		 * Applies the properties to the specified Graphics object.
		 *
		 * @param g                 <Graphics> The Graphics object to apply the properties to.
		 */
		public function apply(g:Graphics):void;
	}
}
