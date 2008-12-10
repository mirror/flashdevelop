package mx.skins.halo
{
	import flash.display.Graphics;
	import flash.utils.getQualifiedClassName;
	import flash.utils.describeType;
	import mx.containers.BoxDirection;
	import mx.skins.ProgrammaticSkin;

	/**
	 *  The skin for the separator between the Links in a LinkBar.
	 */
	public class LinkSeparator extends ProgrammaticSkin
	{
		/**
		 *  We don't use 'is' to prevent dependency issues
		 */
		private static var boxes : Object;

		/**
		 *  Constructor.
		 */
		public function LinkSeparator ();
		/**
		 *  @private
		 */
		protected function updateDisplayList (w:Number, h:Number) : void;
		private static function isBox (parent:Object) : Boolean;
	}
}
