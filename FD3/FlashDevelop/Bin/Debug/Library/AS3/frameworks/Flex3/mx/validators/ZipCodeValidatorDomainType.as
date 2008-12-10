package mx.validators
{
	/**
	 *  The ZipCodeValidatorDomainType class defines the values  *  for the <code>domain</code> property of the ZipCodeValidator class, *  which you use to specify the type of ZIP code to validate. * *  @see mx.validators.ZipCodeValidator
	 */
	public class ZipCodeValidatorDomainType
	{
		/**
		 *  Specifies to validate a United States or Canadian ZIP code.
		 */
		public static const US_OR_CANADA : String = "US or Canada";
		/**
		 *  Specifies to validate a United States ZIP code.
		 */
		public static const US_ONLY : String = "US Only";
		/**
		 *  Specifies to validate a Canadian ZIP code.
		 */
		public static const CANADA_ONLY : String = "Canada Only";

	}
}
