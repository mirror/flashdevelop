/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	import flash.utils.ByteArray;
	public class MovieClipLoaderAsset extends MovieClipAsset implements IFlexAsset, IFlexDisplayObject {
		/**
		 * Backing storage for the measuredHeight property.
		 *  Subclasses should set this value in the constructor.
		 */
		protected var initialHeight:Number = 0;
		/**
		 * Backing storage for the measuredWidth property.
		 *  Subclasses should set this value in the constructor.
		 */
		protected var initialWidth:Number = 0;
		/**
		 * A ByteArray containing the inner content.
		 *  Overridden in subclasses.
		 */
		public function get movieClipData():ByteArray;
		/**
		 * Constructor.
		 */
		public function MovieClipLoaderAsset();
	}
}
