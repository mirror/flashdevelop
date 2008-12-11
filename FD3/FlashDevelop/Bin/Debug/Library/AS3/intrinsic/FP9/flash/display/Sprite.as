package flash.display
{
	/// The Sprite class is a basic display list building block: a display list node that can display graphics and can also contain children.
	public class Sprite extends flash.display.DisplayObjectContainer
	{
		/// Specifies the Graphics object that belongs to this sprite where vector drawing commands can occur.
		public var graphics:flash.display.Graphics;

		/// Specifies the button mode of this sprite.
		public var buttonMode:Boolean;

		/// Specifies the display object over which the sprite is being dragged, or on which the sprite was dropped.
		public var dropTarget:flash.display.DisplayObject;

		/// Designates another sprite to serve as the hit area for a sprite.
		public var hitArea:flash.display.Sprite;

		/// A Boolean value that indicates whether the pointing hand (hand cursor) appears when the mouse rolls over a sprite in which the buttonMode property is set to true.
		public var useHandCursor:Boolean;

		/// Controls sound within this sprite.
		public var soundTransform:flash.media.SoundTransform;

		/// Creates a new Sprite instance.
		public function Sprite();

		/// Lets the user drag the specified sprite.
		public function startDrag(lockCenter:Boolean=false, bounds:flash.geom.Rectangle=null):void;

		/// Ends the startDrag() method.
		public function stopDrag():void;

	}

}

