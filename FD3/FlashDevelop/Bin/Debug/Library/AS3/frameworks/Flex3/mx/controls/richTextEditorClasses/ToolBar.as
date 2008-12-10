package mx.controls.richTextEditorClasses
{
	import mx.controls.VRule;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.IUIComponent;

	/**
	 *  Number of pixels between children in the horizontal direction. *  The default value is 8.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between children in the vertical direction. *  The default value is 8.
	 */
	[Style(name="verticalGap", type="Number", format="Length", inherit="no")] 

	/**
	 *  @private *  The ToolBar container lays out its children in a single horizontal row. *  If the width of the container is less than the measured width, the children  *  wrap to the next line. *  While wrapping, any VRule controls (separators) at the end of a row or the  *  beginning of a row are not drawn. *  *  <p><b>MXML Syntax</b></p> *  *  <p>The <code>&lt;mx:ToolBar&gt;</code> tag inherits all the properties *  of its parent classes but adds no new ones.</p> * *  <pre> *  &lt;mx:ToolBar *    ... *      <i>child tags</i> *    ... *  /&gt; *  </pre> * *  @includeExample examples/ToolBarExample.mxml * *  @see mx.containers.VBox
	 */
	public class ToolBar extends Container
	{
		/**
		 *  Constructor.
		 */
		public function ToolBar ();
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}
