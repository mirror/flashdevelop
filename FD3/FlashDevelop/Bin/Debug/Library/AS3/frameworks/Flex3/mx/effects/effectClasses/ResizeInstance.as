package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.containers.Panel;
	import mx.core.Application;
	import mx.core.Container;
	import mx.core.IUIComponent;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;
	import mx.effects.EffectManager;
	import mx.events.EffectEvent;
	import mx.events.ResizeEvent;
	import mx.styles.IStyleClient;

include "../../core/Version.as"
	/**
	 *  The ResizeInstance class implements the instance class
 *  for the Resize effect.
 *  Flex creates an instance of this class when it plays a Resize effect;
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
 *  The TweenEvent class defines the property <code>value</code>, which contains 
 *  the tween value calculated by the effect. 
 *  For the Resize effect, 
 *  the <code>TweenEvent.value</code> property contains a 2-item Array, where: </p>
 *  <ul>
 *    <li>value[0]:Number  A value between the values of the <code>Resize.widthFrom</code> 
 *    and <code>Resize.widthTo</code> property.</li>
 *  
 *    <li>value[1]:Number  A value between the values of the <code>Resize.heightFrom</code> 
 *    and <code>Resize.heightTo</code> property.</li>
 *  </ul>
 *
 *  @see mx.effects.Resize
 *  @see mx.events.TweenEvent
	 */
	public class ResizeInstance extends TweenEffectInstance
	{
		/**
		 *  @private
		 */
		private var restoreVisibleArray : Array;
		/**
		 *  @private
		 */
		private var restoreAutoLayoutArray : Array;
		/**
		 *  @private
		 */
		private var numHideEffectsPlaying : Number;
		/**
		 *  @private
		 */
		private var origPercentHeight : Number;
		/**
		 *  @private
		 */
		private var origPercentWidth : Number;
		/**
		 *  @private
		 */
		private var origExplicitHeight : Number;
		/**
		 *  @private
		 */
		private var origExplicitWidth : Number;
		/**
		 *  @private
		 */
		private var heightSet : Boolean;
		/**
		 *  @private
		 */
		private var widthSet : Boolean;
		/**
		 *  @private
		 */
		private var explicitWidthSet : Boolean;
		/**
		 *  @private
		 */
		private var explicitHeightSet : Boolean;
		/**
		 *  @private
		 */
		private var origVerticalScrollPolicy : String;
		/**
		 *  @private
		 */
		private var origHorizontalScrollPolicy : String;
		/**
		 *  @private
		 */
		private var parentOrigVerticalScrollPolicy : String;
		/**
		 *  @private
		 */
		private var parentOrigHorizontalScrollPolicy : String;
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
	 *  Storage for the heightBy property.
		 */
		private var _heightBy : Number;
		/**
		 *  Initial height. If omitted, Flex uses the current size.
		 */
		public var heightFrom : Number;
		/**
		 *  @private
	 *  Storage for the heightTo property.
		 */
		private var _heightTo : Number;
		/**
		 *  An Array of Panels.
	 *  The children of these Panels are hidden while the Resize effect plays.
		 */
		public var hideChildrenTargets : Array;
		/**
		 *  @private
	 *  Storage for the widthBy property.
		 */
		private var _widthBy : Number;
		/**
		 *  Initial width. If omitted, Flex uses the current size.
		 */
		public var widthFrom : Number;
		/**
		 *  @private
	 *  Storage for the widthTo property.
		 */
		private var _widthTo : Number;

		/**
		 *  Number of pixels by which to modify the height of the component.
	 *  Values may be negative.
		 */
		public function get heightBy () : Number;
		/**
		 *  @private
		 */
		public function set heightBy (value:Number) : void;

		/**
		 *  Final height, in pixels.
		 */
		public function get heightTo () : Number;
		/**
		 *  @private
		 */
		public function set heightTo (value:Number) : void;

		/**
		 *  Number of pixels by which to modify the width of the component.
	 *  Values may be negative.
		 */
		public function get widthBy () : Number;
		/**
		 *  @private
		 */
		public function set widthBy (value:Number) : void;

		/**
		 *  Final width, in pixels.
		 */
		public function get widthTo () : Number;
		/**
		 *  @private
		 */
		public function set widthTo (value:Number) : void;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function ResizeInstance (target:Object);

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
		public function end () : void;

		/**
		 *  @private
		 */
		private function startResizeTween () : void;

		/**
		 *  @private
	 *  Hides children of Panels while the effect is playing.
		 */
		private function hidePanelChildren () : Boolean;

		/**
		 *  @private
		 */
		private function makePanelChildrenInvisible (panel:Container, panelIndex:Number) : void;

		/**
		 * Method is used to explicitely determine widthTo and heightTo, taking into 
	 * account the current state of the component and the inputs to this ResizeEffect
	 * 
	 * @private
		 */
		private function calculateExplicitDimensionChanges () : void;

		/**
		 *  @private
		 */
		private function restorePanelChildren () : void;

		/**
		 *  @private
	 *  This function is called when one of the Panels finishes
	 *  its "hide children" animation.
		 */
		function eventHandler (event:Event) : void;
	}
}
