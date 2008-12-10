package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.ZoomInstance;

	/**
	 *  The Zoom effect zooms the object in or out on a center point. * *  <p>When you apply a Zoom effect to text rendered using a system font,  *  Flex scales the text between whole point sizes.  *  While you do not have to use embedded fonts when you apply a Zoom effect  *  to text, the Zoom will appear smoother when you apply it to embedded fonts. </p> *  *  <p><b>Note:</b> The Zoom effect does not work when the  *  <code>Container.autoLayout</code> property is <code>false</code>.</p> *   *  @mxml * *  <p>The <code>&lt;mx:Zoom&gt;</code> tag *  inherits all of the tag attributes of its superclass, *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:Zoom *    id="ID" *    captureRollEvents="false|true" *    originX="Calculated" *    originY="Calculated" *    zoomWidthFrom="0.01" *    zoomWidthTo="1.0" *    zoomHeightFrom="0.01" *    zoomHeightTo="1.0" *  /&gt; *  </pre> *   *  @see mx.effects.effectClasses.ZoomInstance *  @see mx.managers.LayoutManager * *  @includeExample examples/ZoomEffectExample.mxml
	 */
	public class Zoom extends TweenEffect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  If <code>true</code>, prevents Flex from dispatching the <code>rollOut</code> 	 *  and <code>rollOver</code> events if the mouse has not moved. 	 *  Set this property to <code>true</code> when you use the Zoom effect to 	 *  toggle the effect target between a big and small size. 	 *  	 *  <p>For example, you use the <code>rollOverEffect</code> to trigger 	 *  the Zoom effect to reduce the size of the target. 	 *  As the target shrinks, the mouse pointer is no longer over the target, 	 *  triggering a <code>rollOut</code> event, and 	 *  the corresponding <code>rollOutEffect</code>. By setting 	 *  the <code>captureRollEvents</code> property to <code>true</code>, 	 *  you prevent Flex from dispatching the <code>rollOut</code> event 	 *  unless it occurs because you moved the mouse. </p>	 *  	 *  @default false
		 */
		public var captureRollEvents : Boolean;
		/**
		 *  Number that represents the x-position of the zoom origin 	 *  when the effect target is in a container that supports absolute positioning,	 *  such as the Canvas container. The zoom origin is the position on the target 	 *  around which the Zoom effect is centered.	 * 	 *  <p>The value must be between 0 and the width of the target component.</p> 	 * 	 *  The default value is <code>target.width</code> / 2, which is the center of the target.
		 */
		public var originX : Number;
		/**
		 *  Number that represents the y-position of the zoom origin 	 *  when the effect target is in a container that supports absolute positioning,	 *  such as the Canvas container. The zoom origin is the position on the target 	 *  around which the Zoom effect is centered.	 * 	 *  <p>The value must be between 0 and the height of the target component.</p> 	 * 	 *  The default value is <code>target.height</code> / 2, which is the center of the target.
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
		public function Zoom (target:Object = null);
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
