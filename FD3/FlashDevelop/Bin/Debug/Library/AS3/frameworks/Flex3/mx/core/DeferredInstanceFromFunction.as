package mx.core
{
	/**
	 *  A deferred instance factory that uses a generator function *  to create an instance of the required object. *  An application uses the <code>getInstance()</code> method to *  create an instance of an object when it is first needed and get *  a reference to the object thereafter. * *  @see DeferredInstanceFromClass
	 */
	public class DeferredInstanceFromFunction implements IDeferredInstance
	{
		/**
		 * 	@private     *	The generator function.
		 */
		private var generator : Function;
		/**
		 * 	@private	 * 	The generated value.
		 */
		private var instance : Object;

		/**
		 *  Constructor.	 *	 *  @param generator A function that creates and returns an instance	 *  of the required object.
		 */
		public function DeferredInstanceFromFunction (generator:Function);
		/**
		 *	Returns a reference to an instance of the desired object.	 *  If no instance of the required object exists, calls the function	 *  specified in this class' <code>generator</code> constructor parameter.	 * 	 *  @return An instance of the object.
		 */
		public function getInstance () : Object;
	}
}
