/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:07] ***/
/**********************************************************/
package flash.security {
	public interface IURIDereferencer {
		/**
		 * Resolves and dereferences the specified URI.
		 *
		 * @param uri               <String> The URI to dereference.
		 * @return                  <IDataInput> The data referenced by the URI.
		 */
		public function dereference(uri:String):IDataInput;
	}
}
