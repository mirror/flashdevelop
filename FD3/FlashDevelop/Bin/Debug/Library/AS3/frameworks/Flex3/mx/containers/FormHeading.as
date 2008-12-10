package mx.containers
{
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import mx.controls.Label;
	import mx.core.EdgeMetrics;
	import mx.core.UIComponent;

	/**
	 *  Number of pixels between the label area and the heading text. * *  @default 14
	 */
	[Style(name="indicatorGap", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Width of the form labels. *  The default value is the length of the longest label in the form. *  For FormHeading, the <code>labelWidth</code> *  is space to the left of the heading text.
	 */
	[Style(name="labelWidth", type="Number", format="Length", inherit="yes")] 
	/**
	 *  Number of pixels above the heading text. * *  @default 0
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  The FormHeading container is used to display a heading *  for a group of controls inside a Form container. *  The left side of the heading is aligned *  with the left side of the controls inside the form. *  You can include multiple FormHeading containers within a single Form *  container. * *  @mxml * *  <p>The <code>&lt;mx:FormHeading&gt;</code> tag inherits all of the tag *  attributes of its superclass and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:FormHeading *    <strong>Properties</strong> *    label="" *   *    <strong>Styles</strong> *    color="0x0B333C" *    disabledColor="0xAAB3B3" *    fontAntiAliasType="advanced|normal" *    fontFamily="Verdana" *    fontGridFitType="pixel|subpixel|none" *    fontSharpness="0" *    fontSize="12" *    fontStyle="normal|italic" *    fontThickness="0" *    fontWeight="normal|bold" *    indicatorGap="14" *    labelWidth="<i>Calculated</i>" *    leading="2" *    paddingLeft="0" *    paddingRight="0" *    paddingTop="0" *    textAlign="<i>Calculated</i>" *    textDecoration="none|underline" *    textIndent="0" *  /&gt; *  </pre> * *  @see mx.containers.Form *  @see mx.containers.FormItem *  *  @includeExample examples/FormExample.mxml
	 */
	public class FormHeading extends UIComponent
	{
		/**
		 *  @private
		 */
		private var labelObj : Label;
		/**
		 *  @private	 *  Storage for the label property.
		 */
		private var _label : String;

		/**
		 *  Form heading text.
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function FormHeading ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		private function createLabel () : void;
		/**
		 *  @private
		 */
		private function getLabelWidth () : Number;
	}
}
