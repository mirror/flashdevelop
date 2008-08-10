/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.sampler {
	/**
	 * Clears the current set of Sample objects. This method is usually called after calling getSamples()
	 *  and iterating over the Sample objects.
	 */
	public function clearSamples():void;
	/**
	 * Returns the number of times a get function was executed. Use
	 *  isGetterSetter() to verify that you have a get/set function before you use
	 *  getGetterInvocationCount().
	 *
	 * @param obj               <Object> A method instance or a class.
	 * @param qname             <QName> If qname is undefined return the number of iterations of the constructor function.
	 * @return                  <Number> The number of times a get method was executed.
	 */
	public function getGetterInvocationCount(obj:Object, qname:QName):Number;
	/**
	 * Returns the number of times a method was executed. If the parameter obj
	 *  is a Class and the parameter qname is undefined then this method
	 *  returns the number of iterations of the constructor function.
	 *
	 * @param obj               <Object> A method instance or a class. A class can be used to get the invocation count of
	 *                            instance functions when a method instance isn't available. If obj is undefined,
	 *                            this method returns the count of the package-scoped function named by qname.
	 * @param qname             <QName> If qname is undefined return the number of iterations of the constructor function.
	 * @return                  <Number> The number of times a method was executed.
	 */
	public function getInvocationCount(obj:Object, qname:QName):Number;
	/**
	 * Returns an object containing all members of a specified object, including private members. You can then
	 *  iterate over the returned object to see all values. This method is similar to the flash.utils.describeType()
	 *  method but also allows you to see private members and skips the intermediate step of creating an XML object.
	 *
	 * @param o                 <Object> The object to analyze.
	 * @param instanceNames     <Boolean (default = false)> If object is a Class and instanceNames is true report the instance names as if o was an instance of class instead of the class's member names.
	 * @return                  <Object> An Object that you must iterate over with a for each..in loop to retrieve the QNames for
	 *                            each property.
	 */
	public function getMemberNames(o:Object, instanceNames:Boolean = false):Object;
	/**
	 * Returns the number of samples collected.
	 *
	 * @return                  <Number> An iterator of Sample instances.
	 */
	public function getSampleCount():Number;
	/**
	 * Returns an object of memory usage Sample instances from the last sampling session.
	 *
	 * @return                  <Object> An iterator of Sample instances.
	 */
	public function getSamples():Object;
	/**
	 * Returns the number of times a set function was executed. Use
	 *  isGetterSetter() to verify that you have a get/set function before you use
	 *  getSetterInvocationCount().
	 *
	 * @param obj               <Object> A method instance or a class.
	 * @param qname             <QName> If qname is undefined return the number of iterations of the constructor function.
	 * @return                  <Number> The number of times a set method was executed.
	 */
	public function getSetterInvocationCount(obj:Object, qname:QName):Number;
	/**
	 * Returns the size in memory of a specified object when used with the Flash Player 9.0.xx.0 or later debugger version. If
	 *  used with a Flash Player that is not the debugger version, this method returns 0.
	 *
	 * @param o                 <*> The object to analyze for memory usage.
	 * @return                  <Number> The byte count of memory used by the specified object.
	 */
	public function getSize(o:*):Number;
	/**
	 * Checks to see if a property is defined by a get/set function. If you want to use
	 *  getInvocationCount() on a get/set function for a property,
	 *  first call isGetterSetter() to check to see if it is a get/set function,
	 *  and then use either getSetterInvocationCount
	 *  or getGetterInvocationCount to get the respective counts.
	 *
	 * @param obj               <Object> A method instance or a class.
	 * @param qname             <QName> If qname is undefined return the number of iterations of the constructor function.
	 * @return                  <Boolean> A Boolean value indicating if the property is defined by a get/set function (true)
	 *                            or not (false).
	 */
	public function isGetterSetter(obj:Object, qname:QName):Boolean;
	/**
	 * Stops the sampling process momentarily. Restart the sampling process using startSampling().
	 */
	public function pauseSampling():void;
	/**
	 * Begins the process of collecting memory usage Sample objects.
	 */
	public function startSampling():void;
	/**
	 * Ends the process of collecting memory usage Sample objects and frees resources dedicated to the sampling process.
	 *  You start the sampling process with startSampling().
	 */
	public function stopSampling():void;
}
