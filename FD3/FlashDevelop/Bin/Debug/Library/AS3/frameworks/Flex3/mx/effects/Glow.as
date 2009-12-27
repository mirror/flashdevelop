package mx.effects
{
	import mx.effects.effectClasses.GlowInstance;
	import mx.styles.StyleManager;

include "../core/Version.as"
	/**
	 *  The Glow effect lets you apply a visual glow effect to a component. 
 *
 *  <p>The Glow effect uses the Flash GlowFilter class
 *  as part of its implementation. 
 *  For more information, see the flash.filters.GlowFilter class.
 *  If you apply a Glow effect to a component, you cannot apply a GlowFilter
 *  or a second Glow effect to the component.</p>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Glow&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:Glow
 *    id="ID"
 *    alphaFrom="val"
 *    alphaTo="val"
 *    blurXFrom="val"
 *    blurXTo="val"
 *    blurYFrom="val"
 *    blurYTo="val"
 *    color="<i>themeColor of the application</i>"
 *    inner="false|true"
 *    knockout="false|true"
 *    strength="2"
 *  /&gt;
 *  </pre>
 *  
 *  @see flash.filters.GlowFilter
 *  @see mx.effects.effectClasses.GlowInstance
 *
 *  @includeExample examples/GlowEffectExample.mxml
	 */
	public class Glow extends TweenEffect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  Starting transparency level between 0.0 and 1.0,
	 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaFrom : Number;
		/**
		 *  Ending transparency level between 0.0 and 1.0,
	 *  where 0.0 means transparent and 1.0 means fully opaque.
		 */
		public var alphaTo : Number;
		/**
		 *  The starting amount of horizontal blur.
	 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurXFrom : Number;
		/**
		 *  The ending amount of horizontal blur.
	 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurXTo : Number;
		/**
		 *  The starting amount of vertical blur.
	 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurYFrom : Number;
		/**
		 *  The ending amount of vertical blur.
	 *  Valid values are from 0.0 to 255.0.
		 */
		public var blurYTo : Number;
		/**
		 *  The color of the glow. 
	 *  The default value is the value of the <code>themeColor</code> style 
	 *  property of the application.
		 */
		public var color : uint;
		/**
		 *  Specifies whether the glow is an inner glow. 
	 *  A value of <code>true</code> indicates an inner glow within
	 *  the outer edges of the object. 
	 *  The default value is <code>false</code>, to specify 
	 *  an outer glow around the outer edges of the object. 
	 *
	 *  @default false
		 */
		public var inner : Boolean;
		/**
		 *  Specifies whether the object has a knockout effect. 
	 *  A value of <code>true</code> makes the object's fill color transparent 
	 *  to reveal the background color of the underlying object. 
	 *  The default value is <code>false</code> to specify no knockout effect. 
	 *
	 *  @default false
		 */
		public var knockout : Boolean;
		/**
		 *  The strength of the imprint or spread. 
	 *  The higher the value, the more color is imprinted and the stronger the 
	 *  contrast between the glow and the background. 
	 *  Valid values are from <code>0</code> to <code>255</code>. 
	 *
	 *  @default 2
		 */
		public var strength : Number;

		/**
		 *  Constructor.
	 *
	 *  @param target The Object to animate with this effect.
		 */
		public function Glow (target:Object = null);

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
