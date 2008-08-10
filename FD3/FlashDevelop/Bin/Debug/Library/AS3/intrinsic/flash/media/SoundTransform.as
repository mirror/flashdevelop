/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	public final  class SoundTransform {
		/**
		 * A value, from 0 (none) to 1 (all), specifying how much of the left input is played in the
		 *  left speaker.
		 */
		public function get leftToLeft():Number;
		public function set leftToLeft(value:Number):void;
		/**
		 * A value, from 0 (none) to 1 (all), specifying how much of the left input is played in the
		 *  right speaker.
		 */
		public function get leftToRight():Number;
		public function set leftToRight(value:Number):void;
		/**
		 * The left-to-right panning of the sound, ranging from -1 (full pan left)
		 *  to 1 (full pan right). A value of 0 represents no panning (balanced center between
		 *  right and left).
		 */
		public function get pan():Number;
		public function set pan(value:Number):void;
		/**
		 * A value, from 0 (none) to 1 (all), specifying how much of the right input is played in the
		 *  left speaker.
		 */
		public function get rightToLeft():Number;
		public function set rightToLeft(value:Number):void;
		/**
		 * A value, from 0 (none) to 1 (all), specifying how much of the right input is played in the
		 *  right speaker.
		 */
		public function get rightToRight():Number;
		public function set rightToRight(value:Number):void;
		/**
		 * The volume, ranging from 0 (silent) to 1 (full volume).
		 */
		public function get volume():Number;
		public function set volume(value:Number):void;
		/**
		 * Creates a SoundTransform object.
		 *
		 * @param vol               <Number (default = 1)> The volume, ranging from 0 (silent) to 1 (full volume).
		 * @param panning           <Number (default = 0)> The left-to-right panning of the sound, ranging from -1 (full pan left)
		 *                            to 1 (full pan right). A value of 0 represents no panning (center).
		 */
		public function SoundTransform(vol:Number = 1, panning:Number = 0);
	}
}
