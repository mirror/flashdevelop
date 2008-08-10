/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IMXMLObject {
		/**
		 * Called after the implementing object has been created and all
		 *  component properties specified on the MXML tag have been initialized.
		 *
		 * @param document          <Object> The MXML document that created this object.
		 * @param id                <String> The identifier used by document to refer
		 *                            to this object.
		 *                            If the object is a deep property on document,
		 *                            id is null.
		 */
		public function initialized(document:Object, id:String):void;
	}
}
