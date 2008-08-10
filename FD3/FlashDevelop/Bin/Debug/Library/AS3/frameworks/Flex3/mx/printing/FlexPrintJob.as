/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.printing {
	import mx.core.IUIComponent;
	public class FlexPrintJob {
		/**
		 * The height  of the printable area on the printer page;
		 *  it does not include any user-set margins.
		 *  It is set after start() method returns.
		 */
		public function get pageHeight():Number;
		/**
		 * The width of the printable area on the printer page;
		 *  it does not include any user-set margins.
		 *  This property is set after start() method returns.
		 */
		public function get pageWidth():Number;
		/**
		 * Specifies whether to print the job content as a bitmap (true)
		 *  or in vector format (false).
		 *  Printing as a bitmap supports output that includes a bitmap image with
		 *  alpha transparency or color effects.
		 *  If the content does not include any bitmap images with
		 *  alpha transparency or color effects, you can print in higher quality
		 *  vector format by setting the printAsBitmap property to
		 *  false.
		 */
		public function get printAsBitmap():Boolean;
		public function set printAsBitmap(value:Boolean):void;
		/**
		 * Constructor.
		 */
		public function FlexPrintJob();
		/**
		 * Adds a UIComponent object to the list of objects being printed.
		 *  Call this method after the start() method returns.
		 *  Each call to this method starts a new page, so you should format
		 *  your objects in page-sized chunks.
		 *  You can use the PrintDataGrid class to span a data grid across
		 *  multiple pages.
		 *
		 * @param obj               <IUIComponent> The Object to be printed.
		 * @param scaleType         <String (default = "matchWidth")> The scaling technique to use to control how the
		 *                            object fits on one or more printed pages.
		 *                            Must be one of the constant values defined in the FlexPrintJobScaleType
		 *                            class.
		 */
		public function addObject(obj:IUIComponent, scaleType:String = "matchWidth"):void;
		/**
		 * Sends the added objects to the printer to start printing.
		 *  Call this method after you have used the addObject()
		 *  method to add the print pages.
		 */
		public function send():void;
		/**
		 * Initializes the PrintJob object.
		 *  Displays the operating system printer dialog to the user.
		 *  Flex sets the pageWidth and pageHeight
		 *  properties after this call returns.
		 *
		 * @return                  <Boolean> true if the user clicks OK
		 *                            when the print dialog box appears, or false if the user
		 *                            clicks Cancel or if an error occurs.
		 */
		public function start():Boolean;
	}
}
