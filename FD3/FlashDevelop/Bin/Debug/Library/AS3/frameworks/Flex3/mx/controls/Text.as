package mx.controls
{
	import mx.core.mx_internal;
	import mx.core.UITextField;
	import mx.events.FlexEvent;

	/**
	 *  The Text control displays multiline, noneditable text. *  Use the Label control if you need only a single line of text. * *  <p>The Text control does not support scroll bars. *  If you need scrolling, you should use a non-editable TextArea control.</p> * *  <p>You can format the text in a Text control using HTML tags, *  which are applied after the control's CSS styles are applied. *  You can also put padding around the four sides of the text.</p> * *  <p>The text in a Text control is selectable by default, *  but you can make it unselectable by setting the <code>selectable</code> *  property to <code>false</code>.</p> * *  <p>If the control is not as wide as the text, the text will wordwrap. *  The text is always aligned top-left in the control.</p> * *  <p>To size a Text component, it's common to specify an explicit width *  and let Flex determine the height as required to display all the text. *  If you specify an explicit height, some of the text may get clipped; *  unlike Label, Text does not truncate its text with "...". *  It's also common to use percentage widths and heights with Text.</p> *  *  <p>If you leave both the width and the height unspecified, *  Flex calculates them based on any explicit line breaks *  in the text, with no wordwrapping within lines. *  For example, if you set the <code>text</code> property, *  the newline character <code>"\n"</code> causes a line break. *  If you set the <code>htmlText</code> property, the HTML markup *  <code>&lt;br&gt;</code> causes a line break. *  If your <code>text</code> or <code>htmlText</code> is lengthy *  and doesn't contain line breaks, you can get a very wide Text *  component; you can set the <code>maxWidth</code> to limit *  how wide the component is allowed to grow.</p> * *  <p>Text controls do not have backgrounds or borders *  and cannot take focus.</p> * *  <p>The Text control has the following default sizing characteristics:</p> *     <table class="innertable"> *        <tr> *           <th>Characteristic</th> *           <th>Description</th> *        </tr> *        <tr> *           <td>Default size</td> *           <td>Flex sizes the control to fit the text, with the width long enough to fit the longest line of text and height tall enough to fit the number of lines. If you do not specify a pixel width, the height is determined by the number of explicit line breaks in the text string. If the text length changes, the control resizes to fit the new text.</td> *        </tr> *        <tr> *           <td>Minimum size</td> *           <td>0 pixels.</td> *        </tr> *        <tr> *           <td>ChMaximum sizear03</td> *           <td>10000 by 10000 pixels</td> *        </tr> *     </table> * *  @mxml * *  <p>The <code>&lt;mx:Text&gt;</code> tag inherits all of the tag attributes *  of its superclass, and adds the following tag attributes:</p> * *  <pre> *  &lt;mx:Text *  leading="2" *  /&gt; *  </pre> * *  @includeExample examples/TextExample.mxml * *  @see mx.controls.Label *  @see mx.controls.TextInput *  @see mx.controls.TextArea *  @see mx.controls.RichTextEditor
	 */
	public class Text extends Label
	{
		/**
		 *  @private
		 */
		private var lastUnscaledWidth : Number;
		/**
		 *  @private
		 */
		private var widthChanged : Boolean;

		/**
		 *  @private
		 */
		public function set explicitWidth (value:Number) : void;
		/**
		 *  @private
		 */
		public function set percentWidth (value:Number) : void;

		/**
		 *  Constructor.
		 */
		public function Text ();
		/**
		 *  @private
		 */
		protected function childrenCreated () : void;
		protected function commitProperties () : void;
		/**
		 *  @private     *     *  If the Text component has an explicit width,     *  its text wordwraps within that width,     *  and the measured height is tall enough to display all the text.     *  (If there is an explicit height or a percent height in this case,     *  the text may get clipped.)     *     *  If it doesn't have an explicit height,     *  the measured height is tall enough to display all the text.     *  If there is an explicit height or a percent height,     *  the text may get clipped.     *     *  If the Text doesn't have an explicit width,     *  the measured width is based on explicit line breaks     *  (e.g, \n, &lt;br&gt;, etc.).     *  For example, if the text is     *     *      The question of the day is:     *      What is the right algorithm for Text?     *     *  with a line break between the two lines, then the measured width     *  will be wide enough to see all of the second line,     *  and the measured height will be tall enough for two lines.     *     *  For lengthy text without explicit line breaks,     *  this will produce unusably wide layout.
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private     *  The cases that requires a second pass through the LayoutManager     *  are <mx:Text width="N%"/> (the control is to use the percentWidth     *  but the measuredHeight) and <mx:Text left="N" right="N"/>     *  (the control is to use the parent's width minus the constraints     *  but the measuredHeight).
		 */
		private function isSpecialCase () : Boolean;
		/**
		 *  @private
		 */
		private function measureUsingWidth (w:Number) : void;
		/**
		 *  @private
		 */
		private function updateCompleteHandler (event:FlexEvent) : void;
	}
}
