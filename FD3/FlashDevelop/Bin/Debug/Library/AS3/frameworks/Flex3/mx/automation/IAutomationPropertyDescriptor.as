/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation {
	public interface IAutomationPropertyDescriptor {
		/**
		 * ActionScript type of this property, as a String.
		 */
		public function get asType():String;
		/**
		 * Default value of this property.
		 */
		public function get defaultValue():String;
		/**
		 * Contains true if this property is used for object identification.
		 */
		public function get forDescription():Boolean;
		/**
		 * Contains true if this property is used for object state verification.
		 */
		public function get forVerification():Boolean;
		/**
		 * Name of the property.
		 */
		public function get name():String;
	}
}
