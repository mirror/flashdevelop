/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class DefaultTileListEffect extends Parallel {
		/**
		 * Hex value that represents the color used when fading
		 *  the added and removed item.
		 */
		public function get color():Number;
		public function set color(value:Number):void;
		/**
		 * The duration in milliseconds
		 *  used to fade in renderers for added and removed items.
		 */
		public function get fadeInDuration():Number;
		public function set fadeInDuration(value:Number):void;
		/**
		 * The duration in milliseconds used to
		 *  fade out renderers for removed and replaced items.
		 */
		public function get fadeOutDuration():Number;
		public function set fadeOutDuration(value:Number):void;
		/**
		 * The duration in milliseconds
		 *  applied to renderers for items moved in the control
		 *  as part of the effect.
		 */
		public function get moveDuration():Number;
		public function set moveDuration(value:Number):void;
	}
}
