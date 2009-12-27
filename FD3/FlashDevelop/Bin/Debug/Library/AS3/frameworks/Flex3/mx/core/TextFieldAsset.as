package mx.core
{
include "../core/Version.as"
	/**
	 *  TextFieldAsset is a subclass of the flash.text.TextField class
 *  which represents TextField symbols that you embed in a Flex
 *  application from a SWF file produced by Flash.
 *  It implements the IFlexDisplayObject interface, which makes it
 *  possible for a TextFieldAsset to be displayed in an Image control,
 *  or to be used as a container background or a component skin.
 *
 *  <p>This class is included in Flex for completeness, so that any kind
 *  of symbol in a SWF file produced by Flash can be embedded
 *  in a Flex application.
 *  However, Flex applications do not typically use embedded TextFields.
 *  Refer to more commonly-used asset classes such as BitmapAsset
 *  for more information about how embedded assets work in Flex.</p>
	 */
	public class TextFieldAsset extends FlexTextField implements IFlexAsset
	{
		/**
		 *  @private
     *  Storage for the measuredHeight property.
		 */
		private var _measuredHeight : Number;
		/**
		 *  @private
     *  Storage for the measuredWidth property.
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
		public function TextFieldAsset ();

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
