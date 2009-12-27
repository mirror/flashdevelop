package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.effects.EffectManager;
	import mx.events.MoveEvent;
	import mx.styles.IStyleClient;

include "../../core/Version.as"
	/**
	 *  The MoveInstance class implements the instance class
 *  for the Move effect.
 *  Flex creates an instance of this class when it plays a Move effect;
 *  you do not create one yourself.
 *  
 *  <p>Every effect class that is a subclass of the TweenEffect class 
 *  supports the following events:</p>
 *  
 *  <ul>
 *    <li><code>tweenEnd</code>: Dispatched when the tween effect ends. </li>
 *  
 *    <li><code>tweenUpdate</code>: Dispatched every time a TweenEffect 
 *      class calculates a new value.</li> 
 *  </ul>
 *  
 *  <p>The event object passed to the event listener for these events is of type TweenEvent. 
 *  The TweenEvent class  defines the property <code>value</code>, which contains 
 *  the tween value calculated by the effect. 
 *  For the Move effect, 
 *  the <code>TweenEvent.value</code> property contains a 2-item Array, where: </p>
 *  <ul>
 *    <li>value[0]:Number  A value between the values of the <code>Move.xFrom</code> 
 *    and <code>Move.xTo</code> property.</li>
 *  
 *    <li>value[1]:Number  A value between the values of the <code>Move.yFrom</code> 
 *    and <code>Move.yTo</code> property.</li>
 *  </ul>
 *
 *  @see mx.effects.Move
 *  @see mx.events.TweenEvent
	 */
	public class MoveInstance extends TweenEffectInstance
	{
		/**
		 *  @private 
	 *  Stores the left style of the target
		 */
		private var left : *;
		/**
		 *  @private 
	 *  Stores the right style of the target
		 */
		private var right : *;
		/**
		 *  @private 
	 *  Stores the top style of the target
		 */
		private var top : *;
		/**
		 *  @private 
	 *  Stores the bottom style of the target
		 */
		private var bottom : *;
		/**
		 *  @private 
	 *  Stores the horizontalCenter style of the target
		 */
		private var horizontalCenter : *;
		/**
		 *  @private 
	 *  Stores the verticalCenter style of the target
		 */
		private var verticalCenter : *;
		/**
		 *  @private
		 */
		private var forceClipping : Boolean;
		/**
		 *  @private
		 */
		private var checkClipping : Boolean;
		private var oldWidth : Number;
		private var oldHeight : Number;
		/**
		 *  Number of pixels to move the components along the x axis.
	 *  Values can be negative.
		 */
		public var xBy : Number;
		/**
		 *  Initial position's x coordinate.
		 */
		public var xFrom : Number;
		/**
		 *  Destination position's x coordinate.
		 */
		public var xTo : Number;
		/**
		 *  Number of pixels to move the components along the y axis.
	 *  Values can be negative.
		 */
		public var yBy : Number;
		/**
		 *  Initial position's y coordinate.
		 */
		public var yFrom : Number;
		/**
		 *  Destination position's y coordinate.
		 */
		public var yTo : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function MoveInstance (target:Object);

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
	}
}
