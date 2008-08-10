/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package {
	public final  class QName {
		/**
		 * The local name of the QName object.
		 */
		public function get localName():String;
		/**
		 * The Uniform Resource Identifier (URI) of the QName object.
		 */
		public function get uri():String;
		/**
		 * Creates a QName object with a URI from a Namespace object and a localName from a QName object.
		 *  If either parameter is not the expected data type, the parameter is converted to a string and
		 *  assigned to the corresponding property of the new QName object.
		 *  For example, if both parameters are strings, a new QName object is returned with a uri property set
		 *  to the first parameter and a localName property set to the second parameter.
		 *
		 * @param uri               <Namespace> A Namespace object from which to copy the uri value. A parameter of any other type is converted to a string.
		 * @param localName         <QName> A QName object from which to copy the localName value. A parameter of any other type is converted to a string.
		 */
		public function QName(uri:Namespace, localName:QName);
		/**
		 * Creates a QName object that is a copy of another QName object. If the parameter passed
		 *  to the constructor is a QName object, a copy of the QName object is created. If the parameter
		 *  is not a QName object, the parameter is converted to a string and assigned to the
		 *  localName property of the new QName instance.
		 *  If the parameter is undefined or unspecified, a new QName object
		 *  is created with the localName property set to the empty string.
		 *
		 * @param qname             <QName> The QName object to be copied. Objects of any other type are
		 *                            converted to a string that is assigned to the localName property
		 *                            of the new QName object.
		 */
		public function QName(qname:QName);
		/**
		 * Returns a string composed of the URI, and the local name for the
		 *  QName object, separated by "::".
		 *
		 * @return                  <String> The qualified name, as a string.
		 */
		AS3 function toString():String;
		/**
		 * Returns the QName object.
		 *
		 * @return                  <QName> The primitive value of a QName instance.
		 */
		AS3 function valueOf():QName;
	}
}
