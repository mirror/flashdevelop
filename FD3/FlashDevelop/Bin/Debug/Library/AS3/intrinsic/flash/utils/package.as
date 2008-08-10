/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/*** Modified manually [Philippe 2008-May-31]           ***/
/**********************************************************/
package flash.utils {
	/**
	 * Proxy methods namespace
	 */
	public namespace flash_proxy;
	/**
	 * Cancels a specified setInterval() call.
	 *
	 * @param id                <uint> The ID of the setInterval() call, which you set to a variable,
	 *                            as in the following:
	 */
	public function clearInterval(id:uint):void;
	/**
	 * Cancels a specified setTimeout() call.
	 *
	 * @param id                <uint> The ID of the setTimeout() call, which you set to a variable,
	 *                            as in the following:
	 */
	public function clearTimeout(id:uint):void;
	/**
	 * Produces an XML object that describes the ActionScript object named as the parameter of
	 *  the method. This method implements the programming concept of reflection for the
	 *  ActionScript language.
	 *
	 * @param value             <*> The object for which a type description is desired. Any ActionScript value
	 *                            may be passed to this method including all available ActionScript types, object
	 *                            instances, primitive types such as uint, and class objects.
	 * @return                  <XML> An XML object containing details about the object that was passed in as a parameter.
	 *                            It provides the following information about the object:
	 *                            The class of the object
	 *                            The attributes of the class
	 *                            The inheritance tree from the class to its base classes
	 *                            The interfaces implemented by the class
	 *                            The declared instance properties of the class
	 *                            The declared static properties of the class
	 *                            The instance methods of the class
	 *                            The static methods of the class
	 *                            For each method of the class, the name, number of parameters, return type,
	 *                            and parameter types
	 *                            Note: describeType() only shows public properties and methods, and will not show
	 *                            properties and methods that are private, package internal or in custom namespaces.
	 */
	public function describeType(value:*):XML;
	/**
	 * Returns an escaped copy of the input string encoded as either UTF-8 or system code page, depending on the value of System.useCodePage.
	 *  Use of System.useCodePage allows legacy content encoded in local code pages to be accessed by the player, but only on systems using that legacy code page.
	 *  For example, Japanese data encoded as Shift-JIS will only be escaped and unescaped properly on an OS using a Japanese default code page.
	 *
	 * @param value             <String> The string to be escaped.
	 * @return                  <String> An escaped copy of the input string.  If System.useCodePage is true, the escaped string is encoded in the system code page.
	 *                            If System.useCodePage is false, the escaped string is encoded in UTF-8.
	 *                            For example, the input string "Cre" will be escaped as "Cr%C3%BCe" on all systems if System.useCodePage is false.
	 *                            If system.useCodePage is true, and the system uses a Latin code page, "Cre" will be escaped as "Cr%FCe".
	 *                            If the system uses a non Latin code page that does not contain the letter '' the result will probably be "Cr?e".
	 */
	public function escapeMultiByte(value:String):String;
	/**
	 * Returns a reference to the class object of the class specified by the name parameter.
	 *
	 * @param name              <String> The name of a class.
	 * @return                  <Object> Returns a reference to the class object of the class specified by the name parameter.
	 */
	public function getDefinitionByName(name:String):Object;
	/**
	 * Returns the fully qualified class name of an object.
	 *
	 * @param value             <*> The object for which a fully qualified class name is desired. Any ActionScript value
	 *                            may be passed to this method including all available ActionScript types, object
	 *                            instances, primitive types such as uint, and class objects.
	 * @return                  <String> A string containing the fully qualified class name.
	 */
	public function getQualifiedClassName(value:*):String;
	/**
	 * Returns the fully qualified class name of the base class of the object specified by the value
	 *  parameter. This function provides a quicker way of retrieving the base class name than describeType(), but also
	 *  doesn't provide all the information describeType() does.
	 *
	 * @param value             <*> Any value.
	 * @return                  <String> A fully qualified base class name, or null if none exists.
	 */
	public function getQualifiedSuperclassName(value:*):String;
	/**
	 * Returns the number of milliseconds that have elapsed since Flash Player was initialized, and is used
	 *  to compute relative time. For a calendar date (timestamp), see the Date object.
	 *
	 * @return                  <int> The number of milliseconds since Flash Player was initialized. If the player starts playing one
	 *                            SWF file, and another SWF file is loaded later, the return value is relative to when the first SWF file was
	 *                            loaded.
	 */
	public function getTimer():int;
	/**
	 * Runs a function at a specified interval (in milliseconds).
	 *
	 * @param closure           <Function> The name of the function to execute. Do not include quotation marks or
	 *                            parentheses, and do not specify parameters of the function to call. For example, use
	 *                            functionName, not functionName() or functionName(param).
	 * @param delay             <Number> The interval, in milliseconds.
	 * @return                  <uint> Unique numeric identifier for the timed process. Use this identifier to cancel
	 *                            the process, by calling the clearInterval() method.
	 */
	public function setInterval(closure:Function, delay:Number, ... arguments):uint;
	/**
	 * Runs a specified function after a specified delay (in milliseconds).
	 *
	 * @param closure           <Function> The name of the function to execute. Do not include quotation marks or
	 *                            parentheses, and do not specify parameters of the function to call. For example, use
	 *                            functionName, not functionName() or functionName(param).
	 * @param delay             <Number> The delay, in milliseconds, until the function is executed.
	 * @return                  <uint> Unique numeric identifier for the timed process. Use this identifier to cancel
	 *                            the process, by calling the clearTimeout() method.
	 */
	public function setTimeout(closure:Function, delay:Number, ... arguments):uint;
	/**
	 * Returns an unescaped copy of the input string, which is decoded from either system code page page or UTF-8 depending on the value of System.useCodePage.
	 *  Use of System.useCodePage allows legacy content encoded in local code pages to be accessed by the player, but only on systems using that legacy code page.
	 *  For example, Japanese data encoded as Shift-JIS will only be escaped and unescaped properly on an OS using a Japanese default code page.
	 *
	 * @param value             <String> The escaped string to be unescaped.
	 * @return                  <String> An unescaped copy of the input string.  If System.useCodePage is true, the escaped string is decoded from the system code page.
	 *                            If System.useCodePage is false, the escaped string is decoded from UTF-8.
	 *                            For example, if the input string is "Cr%C3%BCe" and System.useCodePage is false, the result will be "Cre" on all systems.
	 *                            If System.useCodePage is true and the input string is "Cr%FCe", and the system uses a Latin code page, the result will also be "Cre".
	 *                            Unescaping "Cr%C3%BCe" with System.useCodePage set to true will produce different undesired results on different systems, such as "Crֳ¼e" on a Latin system.
	 *                            Similarly, unescaping "Cr%FCe" with System.useCodePage set to false could produce "Cre" or "Cr?e" or other variations depending on the code page of the system.
	 */
	public function unescapeMultiByte(value:String):String;
}
