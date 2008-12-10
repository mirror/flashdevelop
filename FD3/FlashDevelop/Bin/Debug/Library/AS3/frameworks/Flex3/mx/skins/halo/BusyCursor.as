package mx.skins.halo
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import mx.core.FlexShape;
	import mx.core.FlexSprite;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

	/**
	 *  Defines the appearance of the cursor that appears while an operation is taking place. For example,  *  while the SWFLoader class loads an asset.
	 */
	public class BusyCursor extends FlexSprite
	{
		/**
		 *  @private
		 */
		private var minuteHand : Shape;
		/**
		 *  @private
		 */
		private var hourHand : Shape;

		/**
		 *  Constructor.
		 */
		public function BusyCursor ();
		private function handleAdded (event:Event) : void;
		private function handleRemoved (event:Event) : void;
		/**
		 *  @private
		 */
		private function enterFrameHandler (event:Event) : void;
	}
}
