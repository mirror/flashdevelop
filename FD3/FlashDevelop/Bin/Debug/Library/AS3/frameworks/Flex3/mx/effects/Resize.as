package mx.effects
{
	import mx.effects.effectClasses.ResizeInstance;

include "../core/Version.as"
	/**
	 *  The Resize effect changes the width, height, or both dimensions
 *  of a component over a specified time interval. 
 *  
 *  <p>If you specify only two of the three values of the
 *  <code>widthFrom</code>, <code>widthTo</code>, and
 *  <code>widthBy</code> properties, Flex calculates the third.
 *  If you specify all three, Flex ignores the <code>widthBy</code> value.
 *  If you specify only the <code>widthBy</code> or the
 *  <code>widthTo</code> value, the <code>widthFrom</code> property
 *  is set to be the object's current width.
 *  The same is true for <code>heightFrom</code>, <code>heightTo</code>,
 *  and <code>heightBy</code> property values.</p>
 *  
 *  <p>If you specify a Resize effect for a resize trigger,
 *  and if you do not set the six From, To, and By properties,
 *  Flex sets them to create a smooth transition
 *  between the object's old size and its new size.</p>
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Resize&gt;</code> tag
 *  inherits all of the tag attributes of its superclass, 
 *  and adds the following tab attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:Resize
 *    id="ID"
 *    widthFrom="val"
 *    heightFrom="val"
 *    widthTo="val"
 *    heightTo="val"
 *    widthBy="val"
 *    heightBy="val"
 *    hideChildrenTargets=""
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/ResizeEffectExample.mxml
 *
 *  @see mx.effects.effectClasses.ResizeInstance
 *  @see mx.effects.Tween
	 */
	public class Resize extends TweenEffect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  Number of pixels by which to modify the height of the component.
	 *  Values may be negative.
		 */
		public var heightBy : Number;
		/**
		 *  Initial height, in pixels.
	 *  If omitted, Flex uses the current height.
		 */
		public var heightFrom : Number;
		/**
		 *  Final height, in pixels.
		 */
		public var heightTo : Number;
		/**
		 *  An Array of Panel containers.
	 *  The children of these Panel containers are hidden while the Resize
	 *  effect plays.
	 *
	 *  <p>You use data binding syntax to set this property in MXML, 
	 *  as the following example shows, where panelOne and panelTwo 
	 *  are the names of two Panel containers in your application:</p>
	 *
	 *  <pre>&lt;mx:Resize id="e" heightFrom="100" heightTo="400"
	 *	hideChildrenTargets="{[panelOne, panelTwo]}" /&gt;</pre>
		 */
		public var hideChildrenTargets : Array;
		/**
		 *  Number of pixels by which to modify the width of the component.
	 *  Values may be negative.
		 */
		public var widthBy : Number;
		/**
		 *  Initial width, in pixels.
	 *  If omitted, Flex uses the current width.
		 */
		public var widthFrom : Number;
		/**
		 *  Final width, in pixels.
		 */
		public var widthTo : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function Resize (target:Object = null);

		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;

		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
	}
}
