package mx.rpc.xml
{
	/**
	 * Establishes the datatypes for a particular version of XML Schema. The * default namespace is http://www.w3.org/2001/XMLSchema representing * XML Schema 1.1. *  * @private
	 */
	public class SchemaDatatypes
	{
		public var anyTypeQName : QName;
		public var anySimpleTypeQName : QName;
		public var anyAtomicTypeQName : QName;
		public var stringQName : QName;
		public var booleanQName : QName;
		public var decimalQName : QName;
		public var precisionDecimal : QName;
		public var floatQName : QName;
		public var doubleQName : QName;
		public var durationQName : QName;
		public var dateTimeQName : QName;
		public var timeQName : QName;
		public var dateQName : QName;
		public var gYearMonthQName : QName;
		public var gYearQName : QName;
		public var gMonthDayQName : QName;
		public var gDayQName : QName;
		public var gMonthQName : QName;
		public var hexBinaryQName : QName;
		public var base64BinaryQName : QName;
		public var anyURIQName : QName;
		public var QNameQName : QName;
		public var NOTATIONQName : QName;
		public var normalizedStringQName : QName;
		public var tokenQName : QName;
		public var languageQName : QName;
		public var NMTOKENQName : QName;
		public var NMTOKENSQName : QName;
		public var NameQName : QName;
		public var NCNameQName : QName;
		public var IDQName : QName;
		public var IDREF : QName;
		public var IDREFS : QName;
		public var ENTITY : QName;
		public var ENTITIES : QName;
		public var integerQName : QName;
		public var nonPositiveIntegerQName : QName;
		public var negativeIntegerQName : QName;
		public var longQName : QName;
		public var intQName : QName;
		public var shortQName : QName;
		public var byteQName : QName;
		public var nonNegativeIntegerQName : QName;
		public var unsignedLongQName : QName;
		public var unsignedIntQName : QName;
		public var unsignedShortQName : QName;
		public var unsignedByteQName : QName;
		public var positiveIntegerQName : QName;
		public var yearMonthDurationQName : QName;
		public var dayTimeDurationQName : QName;
		public var timeInstantQName : QName;
		private static var constantsCache : Object;

		public function SchemaDatatypes (xsdURI:String = null);
		public static function getConstants (xsdURI:String = null) : SchemaDatatypes;
	}
}
