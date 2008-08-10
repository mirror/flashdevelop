/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.display {
	import flash.media.SoundTransform;
	import flash.geom.Rectangle;
	public class Sprite extends DisplayObjectContainer {
		/**
		 * Specifies the button mode of this sprite. If true, this
		 *  sprite behaves as a button, which means that it triggers the display
		 *  of the hand cursor when the mouse passes over the sprite and can
		 *  receive a click event if the enter or space keys are pressed
		 *  when the sprite has focus. You can suppress the display of the hand cursor
		 *  by setting the useHandCursor property to false,
		 *  in which case the pointer is displayed.
		 */
		public function get buttonMode():Boolean;
		public function set buttonMode(value:Boolean):void;
		/**
		 * Specifies the display object over which the sprite is being dragged, or on
		 *  which the sprite was dropped.
		 */
		public function get dropTarget():DisplayObject;
		/**
		 * Specifies the Graphics object that belongs to this sprite where vector
		 *  drawing commands can occur.
		 */
		public function get graphics():Graphics;
		/**
		 * Designates another sprite to serve as the hit area for a sprite. If the hitArea
		 *  property does not exist or the value is null or undefined, the
		 *  sprite itself is used as the hit area. The value of the hitArea property can
		 *  be a reference to a Sprite object.
		 */
		public function get hitArea():Sprite;
		public function set hitArea(value:Sprite):void;
		/**
		 * Controls sound within this sprite.
		 */
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		/**
		 * A Boolean value that indicates whether the pointing hand (hand cursor) appears when the mouse rolls
		 *  over a sprite in which the buttonMode property is set to true.
		 *  The default value of the useHandCursor property is true.
		 *  If useHandCursor is set to true, the pointing hand used for buttons
		 *  appears when the mouse rolls over a button sprite. If useHandCursor is
		 *  false, the arrow pointer is used instead.
		 */
		public function get useHandCursor():Boolean;
		public function set useHandCursor(value:Boolean):void;
		/**
		 * Creates a new Sprite instance. After you create the Sprite instance, call the
		 *  DisplayObjectContainer.addChild() or DisplayObjectContainer.addChildAt()
		 *  method to add the Sprite to a parent DisplayObjectContainer.
		 */
		public function Sprite();
		/**
		 * Lets the user drag the specified sprite. The sprite remains draggable until explicitly
		 *  stopped through a call to the Sprite.stopDrag() method, or until
		 *  another sprite is made draggable. Only one sprite is draggable at a time.
		 *
		 * @param lockCenter        <Boolean (default = false)> Specifies whether the draggable sprite is locked to the center of
		 *                            the mouse position (true), or locked to the point where the user first clicked the
		 *                            sprite (false).
		 * @param bounds            <Rectangle (default = null)> Value relative to the coordinates of the Sprite's parent that specify a constraint
		 *                            rectangle for the Sprite.
		 */
		public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		/**
		 * Ends the startDrag() method. A sprite that was made draggable with the
		 *  startDrag() method remains draggable until a
		 *  stopDrag() method is added, or until another
		 *  sprite becomes draggable. Only one sprite is draggable at a time.
		 */
		public function stopDrag():void;
	}
}
