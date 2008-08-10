/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.net {
	/**
	 * Looks up a class that previously had an alias registered through a call to the registerClassAlias()
	 *  method.
	 *
	 * @param aliasName         <String> The alias to find.
	 * @return                  <Class> The class associated with the given alias. If not found, an exception will be thrown.
	 */
	public function getClassByAlias(aliasName:String):Class;
	/**
	 * Opens or replaces a window in the application that contains the Flash Player container
	 *  (usually a browser).
	 *
	 * @param request           <URLRequest> A URLRequest object that specifies the URL to navigate to.
	 * @param window            <String (default = null)> The browser window or HTML frame in which to display
	 *                            the document indicated by the request parameter.
	 *                            You can enter the name of a specific window or use one of the following values:
	 *                            "_self" specifies the current frame in the current window.
	 *                            "_blank" specifies a new window.
	 *                            "_parent" specifies the parent of the current frame.
	 *                            "_top" specifies the top-level frame in the current window.
	 *                            If you do not specify a value for this parameter, a new empty window is created.
	 *                            In the stand-alone player, you can either specify a new ("_blank") window
	 *                            or a named window. The other values don't apply.
	 *                            Note: When code in a SWF file that is running in the
	 *                            local-with-filesystem sandbox calls the navigateToURL()
	 *                            function and specifies a custom window name for the window
	 *                            parameter, the window name is transfered into a random name. The name is in
	 *                            the form "_flashXXXXXXXX", where each X represents a random
	 *                            hexadecimal digit. Within the same session (until you close the containing
	 *                            browser window), if you call the function again and specify the same name for
	 *                            the window parameter, the same random string is used.
	 */
	public function navigateToURL(request:URLRequest, window:String = null):void;
	/**
	 * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF).
	 *  When you encode an object into AMF, this function saves the alias for its class, so that you can
	 *  recover the class when decoding the object.
	 *  If the encoding context did not register an alias for an object's class, the object
	 *  is encoded as an anonymous object. Similarly, if the decoding context does not have the same
	 *  alias registered, an anonymous object is created for the decoded data.
	 *
	 * @param aliasName         <String> The alias to use.
	 * @param classObject       <Class> The class associated with the given alias.
	 */
	public function registerClassAlias(aliasName:String, classObject:Class):void;
	/**
	 * Sends a URL request to a server, but ignores any response.
	 *
	 * @param request           <URLRequest> A URLRequest object specifying the URL to send data to.
	 */
	public function sendToURL(request:URLRequest):void;
}
