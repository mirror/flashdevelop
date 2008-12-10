package mx.effects.effectClasses
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import mx.core.mx_internal;
	import mx.effects.EffectManager;
	import mx.events.FlexEvent;

	/**
	 *  The ZoomInstance class implements the instance class for the Zoom effect. *  Flex creates an instance of this class when it plays a Zoom effect; *  you do not create one yourself. * *  <p>Every effect class that is a subclass of the TweenEffect class  *  supports the following events:</p> *   *  <ul> *    <li><code>tweenEnd</code>: Dispatched when the tween effect ends. </li> *   *    <li><code>tweenUpdate</code>: Dispatched every time a TweenEffect  *      class calculates a new value.</li>  *  </ul> *   *  <p>The event object passed to the event listener for these events is of type TweenEvent.  *  The TweenEvent class defines the property <code>value</code>, which contains  *  the tween value calculated by the effect.  *  For the Zoom effect,  *  the <code>TweenEvent.value</code> property contains a 2-item Array, where: </p> *  <ul> *    <li>value[0]:Number  A value between the values of the <code>Zoom.zoomWidthFrom</code>  *    and <code>Zoom.zoomWidthTo</code> property.</li> *   *    <li>value[1]:Number  A value between the values of the <code>Zoom.zoomHeightFrom</code>  *    and <code>Zoom.zoomHeightTo</code> property.</li> *  </ul> * *  @see mx.effects.Zoom *  @see mx.events.TweenEvent
	 */
	public class ZoomInstance extends TweenEffectInstance
	{
		/**
		 *  @private
		 */
		private var origScaleX : Number;
		/**
		 *  @private
		 */
		private var origScaleY : Number;
		/**
		 *  @private
		 */
		private var origX : Number;
		/**
		 *  @private
		 */
		private var origY : Number;
		/**
		 *  @private
		 */
		private var newX : Number;
		/**
		 *  @private
		 */
		private var newY : Number;
		/**
		 *  @private
		 */
		private var scaledOriginX : Number;
		/**
		 *  @private
		 */
		private var scaledOriginY : Number;
		/**
		 *  @private
		 */
		private var origPercentWidth : Number;
		/**
		 *  @private
		 */
		private var origPercentHeight : Number;
		/**
		 *  @private
		 */
		private var _mouseHasMoved : Boolean;
		/**
		 *  @private
		 */
		private var show : Boolean;
		/**
		 *  Prevents the <code>rollOut</code> and <code>rollOver</code> events	 *  from being dispatched if the mouse has not moved.	 *  Set this value to <code>true</code> in situations where the target	 *  toggles between a big and small state without moving the mouse.	 *	 *  @default false
		 */
		public var captureRollEvents : Boolean;
		/**
		 *  Number that represents the x-position of the zoom origin,	 *  or registration point.	 *  The default value is <code>target.width / 2</code>,	 *  which is the center of the target.
		 */
		public var originX : Number;
		/**
		 *  Number that represents the y-position of the zoom origin,	 *  or registration point.	 *  The default value is <code>target.height / 2</code>,	 *  which is the center of the target.
		 */
		public var originY : Number;
		/**
		 *  Number that represents the scale at which to start the height zoom, 	 *  as a percent between 0.01 and 1.0. 	 *  The default value is 0.01, which is very small.
		 */
		public var zoomHeightFrom : Number;
		/**
		 *  Number that represents the scale at which to complete the height zoom, 	 *  as a percent between 0.01 and 1.0. 	 *  The default value is 1.0, which is the object's normal size.
		 */
		public var zoomHeightTo : Number;
		/**
		 *  Number that represents the scale at which to start the width zoom, 	 *  as a percent between 0.01 and 1.0. 	 *  The default value is 0.01, which is very small.
		 */
		public var zoomWidthFrom : Number;
		/**
		 *  Number that represents the scale at which to complete the width zoom, 	 *  as a percent between 0.01 and 1.0. 	 *  The default value is 1.0, which is the object's normal size.
		 */
		public var zoomWidthTo : Number;

		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function ZoomInstance (target:Object);
		/**
		 *  @private
		 */
		public function initEffect (event:Event) : void;
		/**
		 *  @private
		 */
		public function play () : void;
		/**
		 *  @private
		 */
		public function onTweenUpdate (value:Object) : void;
		/**
		 *  @private
		 */
		public function onTweenEnd (value:Object) : void;
		/**
		 *  @private
		 */
		public function finishEffect () : void;
		/**
		 *  @private
		 */
		private function applyPropertyChanges () : void;
		/**
		 *  @private
		 */
		private function getScaleFromWidth (value:Number) : Number;
		/**
		 *  @private
		 */
		private function getScaleFromHeight (value:Number) : Number;
		/**
		 *  @private
		 */
		private function mouseEventHandler (event:MouseEvent) : void;
	}
}
