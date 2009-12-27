﻿package mx.containers
{
	import flash.display.DisplayObject;
	import mx.containers.utilityClasses.BoxLayout;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.styles.StyleManager;

include "../styles/metadata/GapStyles.as"
	/**
	 *  Number of pixels between the label and child components.
 *  The default value is 14.
	 */
	[Style(name="indicatorGap", type="Number", format="Length", inherit="yes")] 

	/**
	 *  Width of the form labels.
 *  The default is the length of the longest label in the form.
	 */
	[Style(name="labelWidth", type="Number", format="Length", inherit="yes")] 

	/**
	 *  Number of pixels between the container's bottom border
 *  and the bottom  edge of its content area.
 *  The default value is 16.
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 

	/**
	 *  Number of pixels between the container's top border
 *  and the top edge of its content area.
 *  The default value is 16.
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
	 *  The Form container lets you control the layout of a form,
 *  mark form fields as required or optional, handle error messages,
 *  and bind your form data to the Flex data model to perform
 *  data checking and validation.
 *  It also lets you use style sheets to configure the appearance
 *  of your forms.
 *
 *  <p>The following table describes the components you use to create forms in Flex:</p>
 *     <table class="innertable">
 *        <tr>
 *           <th>Component</th>
 *           <th>Tag</th>
 *           <th>Description</th>
 *        </tr>
 *        <tr>
 *           <td>Form</td>
 *           <td><code>&lt;mx:Form&gt;</code></td>
 *           <td>Defines the container for the entire form, including the overall form layout. 
 *               Use the FormHeading control and FormItem container to define content. 
 *               You can also insert other types of components in a Form container.</td>
 *        </tr>
 *        <tr>
 *           <td>FormHeading</td>
 *           <td><code>&lt;mx:FormHeading&gt;</code></td>
 *           <td>Defines a heading within your form. You can have multiple FormHeading controls within a single Form container.</td>
 *        </tr>
 *        <tr>
 *           <td>FormItem</td>
 *           <td><code>&lt;mx:FormItem&gt;</code></td>
 *           <td>Contains one or more form children arranged horizontally or vertically. Children can be controls or other containers. 
 *               A single Form container can hold multiple FormItem containers.</td>
 *        </tr>
 *     </table>
 *
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Form&gt;</code> tag inherits all the tag 
 *  attributes of its superclass and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:Form
 *    <strong>Styles</strong>
 *    horizontalGap="8"
 *    indicatorGap="14"
 *    labelWidth="<i>Calculated</i>"
 *    paddingBottom="16"
 *    paddingTop="16"
 *    verticalGap="6"
 *    &gt;
 *    ...
 *      <i>child tags</i>
 *    ...
 *  &lt;/mx:Form&gt;
 *  </pre>
 *
 *  @includeExample examples/FormExample.mxml
 *
 *  @see mx.containers.FormHeading
 *  @see mx.containers.FormItem
	 */
	public class Form extends Container
	{
		/**
		 *  @private
		 */
		private static var classInitialized : Boolean;
		/**
		 *  @private
		 */
		var layoutObject : BoxLayout;
		/**
		 *  @private
		 */
		private var measuredLabelWidth : Number;

		/**
		 *  The maximum width, in pixels, of the labels of the FormItems containers in this Form.
		 */
		public function get maxLabelWidth () : Number;

		/**
		 *  @private
	 *  This method gets called once at first instance construction
	 *  rather than during class initialization.
	 *  In order for calls to StyleManager methods to work,
	 *  the factory class for the application or module
	 *  must have already registered StyleManagerImpl with Singleton.
	 *  This may not be the case at class initialization time.
		 */
		private static function initializeClass () : void;

		/**
		 *  Constructor.
		 */
		public function Form ();

		/**
		 *  @private
     *  Discard the cached measuredLabelWidth if a child
     *  is added or removed.
		 */
		public function addChild (child:DisplayObject) : DisplayObject;

		/**
		 *  @private
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;

		/**
		 *  @private
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;

		/**
		 *  @private
		 */
		public function removeChildAt (index:int) : DisplayObject;

		/**
		 *  Calculates the preferred, minimum and maximum sizes of the Form.
     *  For more information about the <code>measure</code> method, 
     *  see the <code>UIComponent.measure()</code> method.
     *  <p>The <code>Form.measure()</code> method sets the
     *  <code>measuredWidth</code> property to the width of the
     *  largest child, plus the values of the <code>paddingLeft</code>
     *  and <code>paddingRight</code> style properties and the
     *  width of the border.</p>
     *
     *  <p>The <code>measuredHeight</code> property is set to the sum
     *  of the <code>measuredHeight</code>S of all children,
     *  plus <code>verticalGap</code> space between each child.
     *  The <code>paddingTop</code> and <code>paddingBottom</code>
     *  style properties and the height of the border are also added.</p>
     *
     *  <p>The <code>measuredMinWidth</code> property is set to the largest
     *  minimum width of the children.
     *  If the child has a percentage value for <code>width</code>,
     *  the <code>minWidth</code> property is used, otherwise the
     *  <code>measuredWidth</code> property is used.
     *  The values of the <code>paddingLeft</code> and
     *  <code>paddingRight</code> style properties and the width
     *  of the border are also added.</p>
     *
     *  <p>The <code>measuredMinHeight</code> property is set to the same value
     *  as that of the <code>measuredHeight</code> property.</p>
		 */
		protected function measure () : void;

		/**
		 *  Responds to size changes by setting the positions
     *  and sizes of this container's children.
     *  For more information about the <code>updateDisplayList()</code> method,
     *  see the <code>UIComponent.updateDisplayList()</code> method. 
     *
     *  <p>The <code>Form.updateDisplayList()</code> method
     *  positions the children in a vertical column,
     *  spaced by the <code>verticalGap</code> style property.
     *  The <code>paddingLeft</code>, <code>paddingRight</code>,
     *  <code>paddingTop</code> and <code>paddingBottom</code>
     *  style properties are applied.</p>
     *
     *  <p>If a child has a percentage width,
     *  it is stretched horizontally to the specified
     *  percentage of the Form container; otherwise, it is set
     *  to its <code>measuredWidth</code> property.
     *  Each child is set to its <code>measuredHeight</code> property.</p>
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

		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;

		/**
		 *  @private
		 */
		function invalidateLabelWidth () : void;

		/**
		 *  @private
		 */
		function calculateLabelWidth () : Number;
	}
}
