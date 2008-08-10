/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class DefaultListEffect extends Parallel {
		/**
		 * Hex value that represents the color used when fading
		 *  the added and removed item.
		 */
		public function get color():Number;
		public function set color(value:Number):void;
		/**
		 * The duration in milliseconds for fading
		 *  in renderers for added and removed items.
		 */
		public function get fadeInDuration():Number;
		public function set fadeInDuration(value:Number):void;
		/**
		 * The duration in milliseconds used for
		 *  fading out renderers for added and removed items.
		 */
		public function get fadeOutDuration():Number;
		public function set fadeOutDuration(value:Number):void;
		/**
		 * The duration in milliseconds of
		 *  applied to renderers for added and removed items.
		 */
		public function get growDuration():Number;
		public function set growDuration(value:Number):void;
		/**
		 * The offset in milliseconds between the effects applied
		 *  to the renderers representing multiple items deleted
		 *  at the same time. If 0, all renderers will fade and shrink
		 *  simultaneously.
		 */
		public function get removedElementOffset():Number;
		public function set removedElementOffset(value:Number):void;
		/**
		 * The duration in milliseconds
		 *  applied to renderers for added and removed items.
		 */
		public function get shrinkDuration():Number;
		public function set shrinkDuration(value:Number):void;
	}
}
