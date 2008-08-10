/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.printing {
	public class PrintJobOptions {
		/**
		 * Specifies whether the content in the print job is printed as a bitmap or as a vector.
		 *  The default value is false, for vector printing.
		 */
		public var printAsBitmap:Boolean = false;
		/**
		 * Creates a new PrintJobOptions object. You pass this object
		 *  to the options parameter of the PrintJob.addPage() method.
		 *
		 * @param printAsBitmap     <Boolean (default = false)> If true, this object is printed as a bitmap.
		 *                            If false, this object is printed as a vector.
		 *                            If the content that you're printing includes a bitmap image,
		 *                            set the printAsBitmap property to true to include any
		 *                            alpha transparency and color effects.
		 *                            If the content does not include bitmap images, omit this parameter to print
		 *                            the content in higher quality vector format (the default option).
		 */
		public function PrintJobOptions(printAsBitmap:Boolean = false);
	}
}
