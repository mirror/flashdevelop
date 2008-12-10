package mx.printing
{
	import flash.events.KeyboardEvent;
	import mx.controls.DataGrid;
	import mx.core.EdgeMetrics;
	import mx.core.ScrollPolicy;
	import mx.core.mx_internal;

	/**
	 *  The PrintDataGrid control is a DataGrid subclass that is styled *  to show a table with line borders and is optimized for printing.  *  It can automatically size to properly fit its container, and removes  *  any partially displayed rows. * *  @mxml *  *  <p>The <code>&lt;mx:PrintDataGrid&gt;</code> tag inherits the tag attributes *  of its superclass; however, you do not use the properties, styles, events, *  and effects (or methods) associated with user interaction. *  The <code>&lt;mx:PrintDataGrid&gt;</code> tag adds the following tag attribute: *  </p> *  <pre> *  &lt;mx:PrintDataGrid *    <b>Properties</b> *    sizeToPage="true|false" *  &gt;  *  ... *  &lt;/mx:PrintDataGrid&gt; *  </pre> *  *  @see FlexPrintJob *  *  @includeExample examples/FormPrintHeader.mxml -noswf *  @includeExample examples/FormPrintFooter.mxml -noswf *  @includeExample examples/FormPrintView.mxml -noswf *  @includeExample examples/PrintDataGridExample.mxml
	 */
	public class PrintDataGrid extends DataGrid
	{
		/**
		 *  @private	 *  Storage for the currentPageHeight property.
		 */
		private var _currentPageHeight : Number;
		/**
		 *  Storage for the originalHeight property.	 *  @private
		 */
		private var _originalHeight : Number;
		/**
		 *  If <code>true</code>, the PrintDataGrid readjusts its height to display	 *  only completely viewable rows.
		 */
		public var sizeToPage : Boolean;

		/**
		 *  @private	 *  Getter needs to be overridden if setter is overridden.
		 */
		public function get height () : Number;
		/**
		 *  @private	 *  Height setter needs to be overridden to update _originalHeight.
		 */
		public function set height (value:Number) : void;
		/**
		 *  @private	 *  Getter needs to be overridden if setter is overridden.
		 */
		public function get percentHeight () : Number;
		/**
		 *  @private     *  percentHeight setter needs to be overridden to update _originalHeight.
		 */
		public function set percentHeight (value:Number) : void;
		/**
		 *  The height of PrintDataGrid that would be, if <code>sizeToPage</code> 	 *  property is <code>true</code> and PrintDataGrid displays only completely	 *  viewable rows and no partial rows. If <code>sizeToPage</code> property 	 *  is <code>true</code>, the value of this property equals 	 *  the <code>height</code> property.
		 */
		public function get currentPageHeight () : Number;
		/**
		 *  The height of PrintDataGrid as set by the user.	 *  If the <code>sizeToPage</code> property is <code>false</code>,	 *  the value of this property equals the <code>height</code> property.
		 */
		public function get originalHeight () : Number;
		/**
		 *  Indicates the data provider contains additional data rows that follow 	 *  the rows that the PrintDataGrid control currently displays.	 *	 *  @return A Boolean value of <code>true</code> if a set of rows is 	 *  available else <code>false</false>.
		 */
		public function get validNextPage () : Boolean;

		/**
		 *  Constructor.	 *	 *  <p>Constructs a DataGrid without scrollbars or user interactivity:	 *  column sorting, resizing, drag scrolling, selection, or keyboard	 *  interaction.	 *  The default height is 100% of the container height, or the height 	 *  required to display all the dataProvider rows, whichever is smaller.</p>
		 */
		public function PrintDataGrid ();
		/**
		 *  @private	 *  Sets the default number of display rows to dataProvider.length.
		 */
		protected function measure () : void;
		/**
		 *  @private	 *  setActualSize() is overridden to update _originalHeight.
		 */
		public function setActualSize (w:Number, h:Number) : void;
		/**
		 *  @private	 *  Overridden configureScrollBars to disable autoScrollUp.
		 */
		protected function configureScrollBars () : void;
		/**
		 *  Puts the next set of data rows in view;	 *  that is, it sets the PrintDataGrid <code>verticalScrollPosition</code>	 *  property to equal <code>verticalScrollPosition</code> + (number of scrollable rows).
		 */
		public function nextPage () : void;
		/**
		 *  @private	 *  ListBase.measure() does'nt calculate measuredHeight in required way	 *  so have to add the code here.
		 */
		private function measureHeight () : void;
		/**
		 *  @private	 *  Overridden keyDown to disable keyboard functionality.
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
	}
}
