package mx.core
{
	import mx.core.FlexSimpleButton;

	/**
	 *  ButtonAsset is a subclass of the flash.display.SimpleButton class *  which represents button symbols that you embed in a Flex *  application from a SWF file produced by Flash. *  It implements the IFlexDisplayObject interface, which makes it *  possible for a SimpleButtonAsset to be displayed in an Image control, *  or to be used as a container background or a component skin. * *  <p>This class is included in Flex for completeness, so that any kind *  of symbol in a SWF file produced by Flash can be embedded *  in a Flex application. *  However, Flex applications do not typically use embedded SimpleButtons. *  Refer to more commonly-used asset classes such as BitmapAsset *  for more information about how embedded assets work in Flex.</p>
	 */
	public class ButtonAsset extends FlexSimpleButton implements IFlexAsset
	{
		/**
		 *  @private     *  Storage for the measuredWidth property.
		 */
		private var _measuredHeight : Number;
		/**
		 *  @private     *  Storage for the measuredWidth property.
		 */
		private var _measuredWidth : Number;

		/**
		 *  @inheritDoc
		 */
		public function get measuredHeight () : Number;
		/**
		 *  @inheritDoc
		 */
		public function get measuredWidth () : Number;

		/**
		 *  Constructor.
		 */
		public function ButtonAsset ();
		/**
		 *  @inheritDoc
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  @inheritDoc
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
	}
}
