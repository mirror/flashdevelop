﻿package mx.validators
{
	/**
	 *  The ValidationResult class contains the results of a validation.  * *  <p>The ValidationResultEvent class defines the event object *  that is passed to event listeners for the <code>valid</code> *  and <code>invalid</code> validator events.  *  The class also defines the <code>results</code> property, *  which contains an Array of ValidationResult objects, *  one for each field examined by the validator. *  This lets you access the ValidationResult objects *  from within an event listener.</p> * *  @see mx.events.ValidationResultEvent
	 */
	public class ValidationResult
	{
		/**
		 *  The validation error code	 *  if the value of the <code>isError</code> property is <code>true</code>.
		 */
		public var errorCode : String;
		/**
		 *  The validation error message	 *  if the value of the <code>isError</code> property is <code>true</code>.
		 */
		public var errorMessage : String;
		/**
		 *  Contains <code>true</code> if the field generated a validation failure.
		 */
		public var isError : Boolean;
		/**
		 *  The name of the subfield that the result is associated with.	 *  Some validators, such as CreditCardValidator and DateValidator,	 *  validate multiple subfields at the same time.
		 */
		public var subField : String;

		/**
		 *  Constructor	 *     *  @param isError Pass <code>true</code> if there was a validation error.     *     *  @param subField Name of the subfield of the validated Object.     *     *  @param errorCode  Validation error code.     *     *  @param errorMessage Validation error message.
		 */
		public function ValidationResult (isError:Boolean, subField:String = "", errorCode:String = "", errorMessage:String = "");
	}
}
