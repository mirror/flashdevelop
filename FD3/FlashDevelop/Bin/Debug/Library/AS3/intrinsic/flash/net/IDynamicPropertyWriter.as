/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	public interface IDynamicPropertyWriter {
		/**
		 * Writes the name and value of an IDynamicPropertyOutput object to an object with
		 *  dynamic properties. If ObjectEncoding.dynamicPropertyWriter is set,
		 *  this method is invoked for each object with dynamic properties.
		 *
		 * @param obj               <Object> The object to write to.
		 * @param output            <IDynamicPropertyOutput> The IDynamicPropertyOutput object that contains the name and value
		 *                            to dynamically write to the object.
		 */
		public function writeDynamicProperties(obj:Object, output:IDynamicPropertyOutput):void;
	}
}
