package mx.skins.halo
{
	import flash.display.Graphics;
	import mx.core.IFlexDisplayObject;
	import mx.core.SpriteAsset;

include "../../core/Version.as"
	/**
	 *  The default drag proxy image for a drag and drop operation.
 *  
 *  @see mx.managers.DragManager
	 */
	public class DefaultDragImage extends SpriteAsset implements IFlexDisplayObject
	{
		/**
		 *  @private
		 */
		public function get measuredWidth () : Number;

		/**
		 *  @private
		 */
		public function get measuredHeight () : Number;

		/**
		 *  Constructor.
		 */
		public function DefaultDragImage ();

		/**
		 *  @private
		 */
		public function move (x:Number, y:Number) : void;

		/**
		 *  @private
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;

		/**
		 *  @private
		 */
		private function draw (w:Number, h:Number) : void;
	}
}
