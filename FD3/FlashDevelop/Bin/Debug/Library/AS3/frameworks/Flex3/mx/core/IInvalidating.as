/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.core {
	public interface IInvalidating {
		/**
		 * Calling this method results in a call to the component's
		 *  validateDisplayList() method
		 *  before the display list is rendered.
		 */
		public function invalidateDisplayList():void;
		/**
		 * Calling this method results in a call to the component's
		 *  validateProperties() method
		 *  before the display list is rendered.
		 */
		public function invalidateProperties():void;
		/**
		 * Calling this method results in a call to the component's
		 *  validateSize() method
		 *  before the display list is rendered.
		 */
		public function invalidateSize():void;
		/**
		 * Validates and updates the properties and layout of this object
		 *  by immediately calling validateProperties(),
		 *  validateSize(), and validateDisplayList(),
		 *  if necessary.
		 */
		public function validateNow():void;
	}
}
