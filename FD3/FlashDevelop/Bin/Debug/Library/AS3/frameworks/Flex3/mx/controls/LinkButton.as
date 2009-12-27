package mx.controls
{
	import flash.text.TextLineMetrics;
	import mx.core.FlexVersion;
	import mx.core.mx_internal;

	/**
	 *  Corner radius of the highlighted rectangle around a LinkButton.
 * 
 *  @default 4
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no")] 

	/**
	 *  Color of a LinkButton as a user moves the mouse pointer over it.
 * 
 *  @default 0xEEFEE6
	 */
	[Style(name="rollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Background color of a LinkButton as a user presses it.
 * 
 *  @default 0xB7F39B
	 */
	[Style(name="selectionColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Text color of a LinkButton as a user moves the mouse pointer over it.
 * 
 *  @default 0x2B333C
	 */
	[Style(name="textRollOverColor", type="uint", format="Color", inherit="yes")] 

	/**
	 *  Text color of a LinkButton as a user presses it.
 * 
 *  @default 0x2B333C
	 */
	[Style(name="textSelectedColor", type="uint", format="Color", inherit="yes")] 

	[Exclude(name="emphasized", kind="property")] 

	[Exclude(name="borderColor", kind="style")] 

	[Exclude(name="fillAlphas", kind="style")] 

	[Exclude(name="fillColors", kind="style")] 

	[Exclude(name="highlightAlphas", kind="style")] 

include "../core/Version.as"
	/**
	 *  The LinkButton control is a borderless Button control
 *  whose contents are highlighted when a user moves the mouse over it.
 *  These traits are often exhibited by HTML links
 *  contained within a browser page.
 *  In order for the LinkButton control to perform some action,
 *  you must specify a <code>click</code> event handler,  
 *  as you do with a Button control.
 *
 *  <p>The LinkButton control has the following default characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>Width and height large enough for the text</td>
 *        </tr>
 *        <tr>
 *           <td>Minimum size</td>
 *           <td>0 pixels</td>
 *        </tr>
 *        <tr>
 *           <td>Maximum size</td>
 *           <td>Undefined</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:LinkButton&gt;</code> tag inherits all of the tag attributes 
 *  of its superclass, and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:LinkButton
 *    <b>Styles</b>
 *    cornerRadius="4""
 *    rollOverColor="0xEEFEE6"
 *    selectionColor="0xB7F39B"
 *    textRollOverColor="0x2B333C"
 *    textSelectedColor="0x2B333C"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/LinkButtonExample.mxml
 * 
 *  @see mx.controls.LinkBar
	 */
	public class LinkButton extends Button
	{
		/**
		 *  @private
	 *  Placeholder for mixin by LinkButtonAccImpl.
		 */
		static var createAccessibilityImplementation : Function;

		/**
		 *  @private
	 *  A LinkButton doesn't have an emphasized state, so _emphasized
	 *  is set false in the constructor and can't be changed via this setter.
		 */
		public function set emphasized (value:Boolean) : void;

		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function LinkButton ();

		/**
		 *  @private
	 *  Called by the initialize() method of UIComponent
	 *  to hook in the accessibility code.
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
		 */
		protected function measure () : void;
	}
}
