package mx.printing
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import mx.core.Application;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;

include "../core/Version.as"
	/**
	 *  The FlexPrintJob class is a wrapper for the flash.printing.PrintJob class.
 *  It supports automatically slicing and paginating the output on multilple pages,
 *  and scaling the grid contents to fit the printer's page size.
 *
 *  @includeExample examples/FormPrintHeader.mxml -noswf
 *  @includeExample examples/FormPrintFooter.mxml -noswf
 *  @includeExample examples/FormPrintView.mxml -noswf
 *  @includeExample examples/PrintDataGridExample.mxml
 *
	 */
	public class FlexPrintJob
	{
		/**
		 *  @private
		 */
		private var printJob : PrintJob;
		/**
		 *  @private
     *  Storage for the pageHeight property.
		 */
		private var _pageHeight : Number;
		/**
		 *  @private
     *  Storage for the pageWidth property.
		 */
		private var _pageWidth : Number;
		/**
		 *  @private
     *  Storage for the printAsBitmap property.
		 */
		private var _printAsBitmap : Boolean;

		/**
		 *  The height  of the printable area on the printer page; 
     *  it does not include any user-set margins. 
     *  It is set after start() method returns.
		 */
		public function get pageHeight () : Number;

		/**
		 *  The width of the printable area on the printer page;
     *  it does not include any user-set margins.
     *  This property is set after <code>start()</code> method returns.
		 */
		public function get pageWidth () : Number;

		/**
		 *  Specifies whether to print the job content as a bitmap (<code>true</code>)
     *  or in vector format (<code>false</code>). 
     *  Printing as a bitmap supports output that includes a bitmap image with 
     *  alpha transparency or color effects. 
     *  If the content does not include any bitmap images with
     *  alpha transparency or color effects, you can print in higher quality
     *  vector format by setting the <code>printAsBitmap</code> property to 
     *  <code>false</code>.
     * 
     *  @default true
		 */
		public function get printAsBitmap () : Boolean;
		/**
		 *  @private
		 */
		public function set printAsBitmap (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function FlexPrintJob ();

		/**
		 *  Initializes the PrintJob object.
     *  Displays the operating system printer dialog to the user.
     *  Flex sets the <code>pageWidth</code> and <code>pageHeight</code>
     *  properties after this call returns.
     *
     *  @return <code>true</code> if the user clicks OK
     *  when the print dialog box appears, or <code>false</code> if the user
     *  clicks Cancel or if an error occurs.
		 */
		public function start () : Boolean;

		/**
		 *  Adds a UIComponent object to the list of objects being printed.
     *  Call this method after the <code>start()</code> method returns.
     *  Each call to this method starts a new page, so you should format 
     *  your objects in page-sized chunks. 
     *  You can use the PrintDataGrid class to span a data grid across
     *  multiple pages.
     * 
     *  @see PrintDataGrid
     *  @see FlexPrintJobScaleType
     *
     *  @param obj The Object to be printed.
     * 
     *  @param scaleType The scaling technique to use to control how the 
     *  object fits on one or more printed pages. 
     *  Must be one of the constant values defined in the FlexPrintJobScaleType
     *  class.
		 */
		public function addObject (obj:IUIComponent, scaleType:String = "matchWidth") : void;

		/**
		 *  Sends the added objects to the printer to start printing.
     *  Call this method after you have used the <code>addObject()</code>
     *  method to add the print pages.
		 */
		public function send () : void;

		/**
		 *  @private
     *  Prepare the target and its parents to print.
     *  If the content is inside a Container with scrollBars,
     *  it still gets printed all right.
		 */
		private function prepareToPrintObject (target:IUIComponent) : Array;

		/**
		 *  @private
     *  Reverts the target and its parents back from Print state,
		 */
		private function finishPrintObject (target:IUIComponent, arrPrintData:Array) : void;
	}
}
