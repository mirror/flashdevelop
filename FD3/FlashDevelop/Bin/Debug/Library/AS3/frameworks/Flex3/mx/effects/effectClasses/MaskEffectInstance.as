/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects.effectClasses {
	import mx.effects.EffectInstance;
	import flash.geom.Rectangle;
	public class MaskEffectInstance extends EffectInstance {
		/**
		 * Function called when the effect creates the mask.
		 *  The default value is a function that returns a Rectangle
		 *  with the same dimensions as the effect target.
		 */
		public function get createMaskFunction():Function;
		public function set createMaskFunction(value:Function):void;
		/**
		 * Contains the effect mask, either the default mask created
		 *  by the defaultCreateMask() method,
		 *  or the one specified by the function passed to the
		 *  createMaskFunction property.
		 */
		protected var effectMask:Shape;
		/**
		 * Easing function to use for moving the mask.
		 */
		public var moveEasingFunction:Function;
		/**
		 * Easing function to use for scaling the mask.
		 */
		public var scaleEasingFunction:Function;
		/**
		 * Initial scaleX for mask.
		 */
		public var scaleXFrom:Number;
		/**
		 * Ending scaleX for mask.
		 */
		public var scaleXTo:Number;
		/**
		 * Initial scaleY for mask.
		 */
		public var scaleYFrom:Number;
		/**
		 * Ending scaleY for mask.
		 */
		public var scaleYTo:Number;
		/**
		 * Specifies that the target component is becoming visible,
		 *  false, or invisible, true.
		 */
		public function get showTarget():Boolean;
		public function set showTarget(value:Boolean):void;
		/**
		 * The area where the mask is applied on the target.
		 *  The dimensions are relative to the target itself.
		 *  By default, the area is the entire target and is created like this:
		 *  new Rectangle(0, 0, target.width, target.height);
		 */
		public var targetArea:Rectangle;
		/**
		 * The actual size of the effect target, including any drop shadows.
		 *  Flex calculates the value of this property; you do not have to set it.
		 */
		protected var targetVisualBounds:Rectangle;
		/**
		 * Initial position's x coordinate for mask.
		 */
		public var xFrom:Number;
		/**
		 * Destination position's x coordinate for mask.
		 */
		public var xTo:Number;
		/**
		 * Initial position's y coordinate for mask.
		 */
		public var yFrom:Number;
		/**
		 * Destination position's y coordinate for mask.
		 */
		public var yTo:Number;
		/**
		 * Constructor.
		 *
		 * @param target            <Object> The Object to animate with this effect.
		 */
		public function MaskEffectInstance(target:Object);
		/**
		 * Creates the default mask for the effect.
		 *
		 * @param targ              <Object> The effect target.
		 * @param bounds            <Rectangle> The actual visual bounds of the target which includes drop shadows
		 * @return                  <Shape> A Shape object that defines the mask.
		 */
		protected function defaultCreateMask(targ:Object, bounds:Rectangle):Shape;
		/**
		 * Initializes the move and scale
		 *  properties of the effect.
		 *  All subclasses should override this function.
		 *  Flex calls it after the mask has been created,
		 *  but before the tweens are created.
		 */
		protected function initMaskEffect():void;
		/**
		 * Callback method that is called when the x and y position
		 *  of the mask should be updated by the effect for the last time.
		 *  You do not call this method directly.
		 *  This method implements the method of the superclass.
		 *
		 * @param value             <Object> Contains the final
		 *                            x and y value for the mask position, where value[0]
		 *                            contains the x position of the mask,
		 *                            and value[1] contains the y position.
		 */
		protected function onMoveTweenEnd(value:Object):void;
		/**
		 * Callback method that is called when the x and y position
		 *  of the mask should be updated by the effect.
		 *  You do not call this method directly.
		 *  This method implements the method of the superclass.
		 *
		 * @param value             <Object> Contains an interpolated
		 *                            x and y value for the mask position, where value[0]
		 *                            contains the new x position of the mask,
		 *                            and value[1] contains the new y position.
		 */
		protected function onMoveTweenUpdate(value:Object):void;
		/**
		 * Callback method that is called when the
		 *  scaleX and scaleY properties
		 *  of the mask should be updated by the effect for the last time.
		 *  You do not call this method directly.
		 *  This method implements the method of the superclass.
		 *
		 * @param value             <Object> Contains the final
		 *                            scaleX and scaleY value for the mask,
		 *                            where value[0]
		 *                            contains the scaleX value of the mask,
		 *                            and value[1] contains the scaleY value.
		 */
		protected function onScaleTweenEnd(value:Object):void;
		/**
		 * Callback method that is called when the
		 *  scaleX and scaleY properties
		 *  of the mask should be updated by the effect.
		 *  You do not call this method directly.
		 *  This method implements the method of the superclass.
		 *
		 * @param value             <Object> Contains an interpolated
		 *                            scaleX and scaleY value for the mask,
		 *                            where value[0]
		 *                            contains the new scaleX value of the mask,
		 *                            and value[1] contains the new scaleY value.
		 */
		protected function onScaleTweenUpdate(value:Object):void;
		/**
		 * Pauses the effect until you call the resume() method.
		 */
		public override function pause():void;
		/**
		 * Resumes the effect after it has been paused
		 *  by a call to the pause() method.
		 */
		public override function resume():void;
		/**
		 * Plays the effect in reverse,
		 *  starting from the current position of the effect.
		 */
		public override function reverse():void;
	}
}
