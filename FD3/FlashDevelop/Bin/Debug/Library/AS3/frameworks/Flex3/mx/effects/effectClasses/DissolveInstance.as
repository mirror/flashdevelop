package mx.effects.effectClasses
{
	import flash.events.Event;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.graphics.RoundedRectangle;
	import mx.styles.StyleManager;

include "../../core/Version.as"
	/**
	 *  The DissolveInstance class implements the instance class
 *  for the Dissolve effect.
 *  Flex creates an instance of this class when it plays a Dissolve effect;
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
 *  For the Dissolve effect, 
 *  the <code>TweenEvent.value</code> property contains a Number between the values of the 
 *  <code>Dissolve.alphaFrom</code> and <code>Dissolve.alphaTo</code> properties.</p>
 *
 *  @see mx.effects.Dissolve
 *  @see mx.events.TweenEvent
	 */
	public class DissolveInstance extends TweenEffectInstance
	{
		/**
		 *  @private
		 */
		private var overlay : UIComponent;
		/**
		 *  Initial transparency level between 0.0 and 1.0,
	 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaFrom : Number;
		/**
		 *  Final transparency level between 0.0 and 1.0,
	 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaTo : Number;
		/**
		 *  Hex value that represents the color of the floating rectangle 
	 *  that the effect displays over the target object. 
	 *
	 *  The default value is the color specified by the target component's
	 *  <code>backgroundColor</code> style property, or 0xFFFFFF, if 
	 *  <code>backgroundColor</code> is not set.
		 */
		public var color : uint;
		/**
		 *  @private
		 */
		var persistAfterEnd : Boolean;
		/**
		 *  The area of the target to play the effect upon.
	 *  The dissolve overlay is drawn using this property's dimensions. 
	 *  UIComponents create an overlay over the entire component.
	 *  Containers create an overlay over their content area,
	 *  but not their chrome.
		 */
		public var targetArea : RoundedRectangle;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function DissolveInstance (target:Object);

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
		 *	@private
		 */
		private function overlayCreatedHandler (event:ChildExistenceChangedEvent) : void;
	}
}
