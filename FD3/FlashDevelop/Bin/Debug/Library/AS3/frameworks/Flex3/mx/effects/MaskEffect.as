/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	import mx.events.TweenEvent;
	public class MaskEffect extends Effect {
		/**
		 * Function called when the effect creates the mask.
		 *  The default value is a function that returns a Rectangle
		 *  with the same dimensions as the target.
		 */
		public var createMaskFunction:Function;
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
		 *  true, or invisible, false.
		 *  If you specify this effect for a showEffect or
		 *  hideEffect trigger, Flex sets the
		 *  showTarget property for you, either to
		 *  true if the component becomes visible,
		 *  or false if the component becomes invisible.
		 *  If you use this effect with a different effect trigger,
		 *  you should set it yourself, often within the
		 *  event listener for the startEffect event.
		 */
		public function get showTarget():Boolean;
		public function set showTarget(value:Boolean):void;
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
		 * @param target            <Object (default = null)> The Object to animate with this effect.
		 */
		public function MaskEffect(target:Object = null);
		/**
		 * Returns the component properties modified by this effect.
		 *  This method returns an Array containing:
		 *  [ "visible", "width", "height" ].
		 *  Since the WipeDown, WipeLeft, WipeRight, and WipeDown effect
		 *  subclasses all modify these same  properties, those classes
		 *  do not implement this method.
		 *
		 * @return                  <Array> An Array of Strings specifying the names of the
		 *                            properties modified by this effect.
		 */
		public override function getAffectedProperties():Array;
		/**
		 * Called when the TweenEffect dispatches a TweenEvent.
		 *  If you override this method, ensure that you call the super method.
		 *
		 * @param event             <TweenEvent> An event object of type TweenEvent.
		 */
		protected function tweenEventHandler(event:TweenEvent):void;
	}
}
