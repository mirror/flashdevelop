package mx.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.containers.utilityClasses.Flex;
	import mx.controls.FormItemLabel;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.core.ScrollPolicy;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;

include "../styles/metadata/GapStyles.as"
	/**
	 *  Horizontal alignment of children in the container.
 *  Possible values are <code>"left"</code>, <code>"center"</code>,
 *  and <code>"right"</code>.
 *
 *  @default "left"
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 

	/**
	 *  Number of pixels between the label and child components of the form item.
 *
 *  @default 14
	 */
	[Style(name="indicatorGap", type="Number", format="Length", inherit="yes")] 

	/**
	 *  Specifies the skin to use for the required field indicator. 
 *
 *  The default value is the "mx.containers.FormItem.Required" symbol in the Assets.swf file.
	 */
	[Style(name="indicatorSkin", type="Class", inherit="no")] 

	/**
	 *  Name of the CSS Style declaration to use for the styles for the
 *  FormItem's label.
 *  By default, the label uses the FormItem's inheritable styles or 
 *  those declared by FormItemLabel.  This style should be used instead 
 *  of FormItemLabel.
	 */
	[Style(name="labelStyleName", type="String", inherit="no")] 

	/**
	 *  Width of the form labels.
 *  The default is the length of the longest label in the form.
	 */
	[Style(name="labelWidth", type="Number", format="Length", inherit="yes")] 

	/**
	 *  Number of pixels between the container's bottom border
 *  and the bottom edge of its content area.
 *  
 *  @default 0
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the container's right border
 *  and the right edge of its content area.
 *  
 *  @default 0
	 */
	[Style(name="paddingRight", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the container's top border
 *  and the top edge of its content area.
 *  
 *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	[Exclude(name="focusIn", kind="event")] 

	[Exclude(name="focusOut", kind="event")] 

	[Exclude(name="focusBlendMode", kind="style")] 

	[Exclude(name="focusSkin", kind="style")] 

	[Exclude(name="focusThickness", kind="style")] 

	[Exclude(name="focusInEffect", kind="effect")] 

	[Exclude(name="focusOutEffect", kind="effect")] 

include "../core/Version.as"
	/**
	 *  The FormItem container defines a label and one or more children
 *  arranged horizontally or vertically.
 *  Children can be controls or other containers.
 *  A single Form container can hold multiple FormItem containers.
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:FormItem&gt;</code> tag inherits all of the tag 
 *  attributes of its superclass, except <code>paddingLeft</code>,
 *  and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:FormItem
 *    <strong>Properties</strong>
 *    direction="vertical|horizontal"
 *    label=""
 *    required="false|true"
 *  
 *    <strong>Styles</strong>
 *    horizontalAlign="left|center|right"
 *    horizontalGap="8"
 *    indicatorGap="14"
 *    indicatorSkin="<i>'mx.containers.FormItem.Required' symbol in Assets.swf</i>"
 *    labelStyleName=""
 *    labelWidth="<i>Calculated</i>"
 *    paddingBottom="0"
 *    paddingRight="0"
 *    paddingTop="0"
 *    verticalGap="6"
 *    &gt;
 *    ...
 *      <i>child tags</i>
 *    ...
 *  &lt;/mx:FormItem&gt;
 *  </pre>
 *
 *  @see mx.containers.Form
 *  @see mx.containers.FormItemDirection
 *  @see mx.containers.FormHeading
 *  @see mx.controls.FormItemLabel
 *
 *  @includeExample examples/FormExample.mxml
	 */
	public class FormItem extends Container
	{
		/**
		 *  @private
     *  A reference to the FormItemLabel subcomponent.
		 */
		private var labelObj : Label;
		/**
		 *  @private
     *  A reference to the "required" indicator.
		 */
		private var indicatorObj : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var guessedRowWidth : Number;
		/**
		 *  @private
		 */
		private var guessedNumColumns : int;
		/**
		 *  @private
		 */
		private var numberOfGuesses : int;
		/**
		 *  @private
     *  We use the VBox algorithm when direction="vertical" and make a few adjustments
		 */
		var verticalLayoutObject : BoxLayout;
		/**
		 *  @private
     *  Storage for the label property.
		 */
		private var _label : String;
		private var labelChanged : Boolean;
		/**
		 *  @private
     *  Storage for the direction property.
		 */
		private var _direction : String;
		/**
		 *  @private
     *  Storage for the required property.
		 */
		private var _required : Boolean;

		/**
		 *  Text label for the FormItem. This label appears to the left of the 
     *  child components of the form item. The position of the label is 
     *  controlled by the <code>textAlign</code> style property. 
     *
     *  @default ""
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;

		/**
		 *  Direction of the FormItem subcomponents.
     *  Possible MXML values are <code>"vertical"</code>
     *  or <code>"horizontal"</code>.
     *  The default MXML value is <code>"vertical"</code>.
     *  Possible ActionScript values are <code>FormItemDirection.VERTICAL</code>
     *  or <code>FormItemDirection.HORIZONTAL</code>.
     *
     *  <p>When <code>direction</code> is <code>"vertical"</code>,
     *  the children of the  FormItem are stacked vertically
     *  to the right of the FormItem label.
     *  When <code>direction</code> is <code>"horizontal"</code>,
     *  the children are placed in a single row (if they fit),
     *  or in two equally-sized columns.</p>
     *
     *  <p>If you need more control over the layout of FormItem children,
     *  you can use a container such as Grid or Tile as the direct child
     *  of the FormItem and put the desired controls inside it.</p>
     *
     *  @default FormItemDirection.VERTICAL
     *  @see mx.containers.FormItemDirection
		 */
		public function get direction () : String;
		/**
		 *  @private
		 */
		public function set direction (value:String) : void;

		/**
		 *  A read-only reference to the FormItemLabel subcomponent
     *  displaying the label of the FormItem.
		 */
		public function get itemLabel () : Label;

		/**
		 *  @private
     *  A read-only reference to the FormItemLabel subcomponent
     *  displaying the label of the FormItem.
		 */
		function get labelObject () : Object;

		/**
		 *  If <code>true</code>, display an indicator
     *  that the FormItem children require user input.
     *  If <code>false</code>, indicator is not displayed.
     *
     *  <p>This property controls the indicator display only.
     *  You must attach a validator to the children
     *  if you require input validation.</p>
     *
     *  @default false
		 */
		public function get required () : Boolean;
		/**
		 *  @private
		 */
		public function set required (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FormItem ();

		/**
		 *  @private
		 */
		protected function createChildren () : void;

		/**
		 *  @private
		 */
		protected function commitProperties () : void;

		/**
		 *  Calculates the preferred, minimum and maximum sizes of the FormItem.
     *  See the <code>UIComponent.measure()</code> method for more information
     *  about the <code>measure()</code> method.
     *
     *  <p>The <code>FormItem.measure()</code> method first determines
     *  the number of columns to use.
     *  If the <code>direction</code> property is
     *  <code>FormItemDirection.HORIZONTAL</code>,
     *  all controls will be placed in a single row if possible.
     *  If the controls cannot fit in a single row, they are split
     *  into two columns.  If that does not work, then use
     *  a single column. If <code>direction</code> is
     *  <code>FormItemDirection.VERTICAL</code>, the controls are 
     *  placed in a single column (like <code>VBox</code>).</p>
     *
     *  <p>A FormItem contains two areas: the label area
     *  and the controls area.
     *  The size of the label is the same
     *  regardless of the direction of the controls.
     *  The size of the control area depends on how many rows 
     *  and columns are used.</p>
     *
     *  <p>The width of the label area is determined by the
     *  <code>labelWidth</code> style property.
     *  If this property is <code>undefined</code> (which is the default),
     *  the width of the largest label in the parent Form container
     *  is used.</p>
     *
     *  <p>If all children are on a single row, the width of the
     *  control area is the sum of the widths of all the children
     *  plus <code>horizontalGap</code> space between the children.</p>
     *
     *  <p>If the children are on a single column,
     *  the width of the control area is the width of the widest child.</p>
     *
     *  <p>If the children are on multiple rows and columns,
     *  the width of the widest child is the column width,
     *  and the width of the control area is the column width
     *  multiplied by the number of columns plus the
     *  <code>horizontalGap</code> space between each column.</p>
     *
     *  <p><code>measuredWidth</code> is set to the
     *  width of the label area plus the width of the control area
     *  plus the value of the <code>indicatorGap</code> style property.
     *  The values of the <code>paddingLeft</code> and
     *  <code>paddingRight</code> style properties
     *  and the width of the border are also added.</p>
     *
     *  <p><code>measuredHeight</code> is set to the
     *  sum of the preferred heights of all rows of children,
     *  plus <code>verticalGap</code> space between each child.
     *  The <code>paddingTop</code> and <code>paddingBottom</code>
     *  style properties and the height of the border are also added.</p>
     *
     *  <p><code>measuredMinWidth</code> is set to the width of the
     *  label area plus the minimum width of the control area
     *  plus the value of the <code>indicatorGap</code> style property.
     *  The values of the <code>paddingLeft</code> and
     *  <code>paddingRight</code> style properties
     *  and the width of the border are also added.</p>
     *
     *  <p><code>measuredMinHeight</code> is set to the
     *  sum of the minimum heights of all rows of children,
     *  plus <code>verticalGap</code> space between each child.
     *  The <code>paddingTop</code> and <code>paddingBottom</code>
     *  style properties and the height of the border are also added.</p>
		 */
		protected function measure () : void;

		private function measureVertical () : void;

		private function measureHorizontal () : void;

		private function previousMeasure () : void;

		/**
		 *  Responds to size changes by setting the positions and sizes
     *  of this container's children.
     *  See the <code>UIComponent.updateDisplayList()</code> method
     *  for more information about the <code>updateDisplayList()</code> method.
     *
     *  <p>See the <code>FormItem.measure()</code> method for more
     *  information on how the FormItem controls are positioned.</p>
     *
     *  <p>The label is aligned in the label area according to the <code>textAlign</code> style property.
     *  All labels in a form are aligned with each other.</p>
     *
     *  <p>If the <code>required</code> property is <code>true</code>,
     *  a symbol indicating the field is required is placed between
     *  the label and the controls.</p>
     *
     *  <p>The controls are positioned in columns, as described in the
     *  documentation for the <code>measure()</code> method.
     *  The  <code>horizontalAlign</code> style property
     *  determines where the controls are placed horizontally.</p>
     *
     *  <p>When the <code>direction</code> property is
     *  <code>"vertical"</code>, any child that has no <code>width</code>
     *  specified uses the <code>measuredWidth</code> rounded up
     *  to the nearest 1/4 width of the control area.
     *  This is done to avoid jagged right edges of controls.</p>
     *
     *  <p>This method calls the <code>super.updateDisplayList()</code>
     *  method before doing anything else.</p>
     *
     *  @param unscaledWidth Specifies the width of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleX</code> property of the component.
     *
     *  @param unscaledHeight Specifies the height of the component, in pixels,
     *  in the component's coordinates, regardless of the value of the
     *  <code>scaleY</code> property of the component.
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		private function updateDisplayListVerticalChildren (unscaledWidth:Number, unscaledHeight:Number) : void;

		private function updateDisplayListHorizontalChildren (unscaledWidth:Number, unscaledHeight:Number) : void;

		private function previousUpdateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		function getPreferredLabelWidth () : Number;

		/**
		 *  @private
		 */
		private function calculateLabelWidth () : Number;

		/**
		 *  @private
		 */
		private function calcNumColumns (w:Number) : int;

		/**
		 *  @private
		 */
		private function displayIndicator (xPos:Number, yPos:Number) : void;

		/**
		 *  @private
     *  Returns a numeric value for the align setting.
     *  0 = left/top, 0.5 = center, 1 = right/bottom
		 */
		function getHorizontalAlignValue () : Number;
	}
}
