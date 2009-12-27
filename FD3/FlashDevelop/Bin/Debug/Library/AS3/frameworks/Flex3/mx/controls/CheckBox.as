package mx.controls
{
	import mx.core.FlexVersion;
	import mx.core.IToggleButton;
	import mx.core.mx_internal;

include "../styles/metadata/IconColorStyles.as"
	[Exclude(name="emphasized", kind="property")] 

	[Exclude(name="toggle", kind="property")] 

include "../core/Version.as"
	/**
	 *  The CheckBox control consists of an optional label and a small box
 *  that can contain a check mark or not. 
 *  You can place the optional text label to the left, right, top, or bottom
 *  of the CheckBox.
 *  When a user clicks a CheckBox control or its associated text,
 *  the CheckBox control changes its state
 *  from checked to unchecked or from unchecked to checked.
 *  CheckBox controls gather a set of true or false values
 *  that are not mutually exclusive.
 *
 *  <p>The CheckBox control has the following default characteristics:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Characteristic</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Default size</td>
 *           <td>A size large enough to hold the label</td>
 *        </tr>
 *        <tr>
 *           <td>Minimum size</td>
 *           <td>0 pixels</td>
 *        </tr>
 *        <tr>
 *           <td>Maximum size</td>
 *           <td>No limit</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:CheckBox&gt;</code> tag inherits all of the tag
 *  attributes of its superclass and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:CheckBox
 *    <strong>Styles</strong>
 *    disabledIconColor="0x999999"
 *    iconColor="0x2B333C"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/CheckBoxExample.mxml
	 */
	public class CheckBox extends Button implements IToggleButton
	{
		/**
		 *  @private
     *  Placeholder for mixin by CheckBoxAccImpl.
		 */
		static var createAccessibilityImplementation : Function;

		/**
		 *  @private
     *  A CheckBox doesn't have an emphasized state, so _emphasized
     *  is set false in the constructor and can't be changed via this setter.
		 */
		public function set emphasized (value:Boolean) : void;

		/**
		 *  @private
     *  A CheckBox is always toggleable by definition, so _toggle is set
     *  true in the constructor and can't be changed via this setter.
		 */
		public function set toggle (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function CheckBox ();

		/**
		 *  @private
		 */
		protected function initializeAccessibility () : void;

		/**
		 *  @private
     *  Returns the height that will accomodate the text and icon.
		 */
		protected function measure () : void;
	}
}
