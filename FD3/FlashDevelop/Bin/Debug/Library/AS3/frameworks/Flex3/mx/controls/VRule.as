package mx.controls
{
	import flash.display.Graphics;
	import mx.core.UIComponent;

	/**
	 *  The shadow color of the line. 
 *  <ul>
 *    <li>If <code>strokeWidth</code> is 1, shadowColor
 *    does nothing.</li>
 *    <li>If <code>strokeWidth is 2</code> shadowColor is
 *    the color of the right line.</li>
 *    <li>If <code>strokeWidth</code> is greater than 2, shadowColor
 *    is the color of the bottom and right edges of the rectangle.</li>
 *  </ul>
 *  
 *  @default 0xEEEEEE
	 */
	[Style(name="shadowColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The color of the line. 
 *  <ul>
 *    <li>If <code>strokeWidth</code> is 1, strokeColor is
 *    the color of the entire line.</li>
 *    <li>If <code>strokeWidth</code> is 2, strokeColor is 
 *    the color of the left line.</li>
 *    <li>If <code>strokeWidth</code> is greater than 2, strokeColor is
 *    the color of the top and left edges of the rectangle.</li>
 *  </ul>
 *  
 *  @default 0xC4CCCC
	 */
	[Style(name="strokeColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  The thickness of the rule in pixels. 
 *  <ul>
 *    <li>If <code>strokeWidth</code> is 1, 
 *    the rule is a 1-pixel-wide line.</li>
 *    <li>If <code>strokeWidth</code> is 2,
 *    the rule is two adjacent 1-pixel-wide vertical lines.</li>
 *    <li>If <code>strokeWidth</code> is greater than 2,
 *    the rule is a hollow rectangle with 1-pixel-wide edges.</li>
 *  </ul>
 *  
 *  @default 2
	 */
	[Style(name="strokeWidth", type="Number", format="Length", inherit="yes")] 

include "../core/Version.as"
	/**
	 *  The VRule control creates a single vertical line.
 *  You typically use this control to create a dividing line
 *  within a container.
 *
 *  <p>The HRule control has the following default properties:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>The default height is 100 pixels, default width is 2 pixels. By default, the VRule control is not resizable; set width and height to percentage values to enable resizing.</td>
 *        </tr>
 *        <tr>
 *           <td>strokeWidth</td>
 *           <td>2 pixels.</td>
 *        </tr>
 *        <tr>
 *           <td>strokeColor</td>
 *           <td>0xC4CCCC.</td>
 *        </tr>
 *        <tr>
 *           <td>shadowColor</td>
 *           <td>0xEEEEEE.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:VRule&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:VRule
 *    <strong>Styles</strong>
 *    strokeColor="0xC4CCCC"
 *    shadowColor="0xEEEEEE"
 *    strokeWidth="2"
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/SimpleVRule.mxml
 *  
 *  @see mx.controls.HRule
	 */
	public class VRule extends UIComponent
	{
		/**
		 *  @private
		 */
		private static const DEFAULT_PREFERRED_HEIGHT : Number = 100;

		/**
		 *  Constructor.
		 */
		public function VRule ();

		/**
		 *  @private
		 */
		protected function measure () : void;

		/**
		 *  @private
     *  The appearance of our vertical rule is inspired by
     *  the leading browser's rendering of HTML's <VR>.
     *
     *  The only reliable way to draw the 1-pixel lines that are
     *  the borders of the vertical rule is by filling rectangles!
     *  Otherwise, very short lines become antialised, probably because
     *  the Player is trying to render an endcap.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}
