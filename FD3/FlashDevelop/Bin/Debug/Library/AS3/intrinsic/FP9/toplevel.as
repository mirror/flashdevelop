package
{
	public namespace AS3;

	/// Decodes an encoded URI into a string.
	public function decodeURI (uri:String) : String;

	/// Decodes an encoded URI component into a string.
	public function decodeURIComponent (uri:String) : String;

	/// Encodes a string into a valid URI (Uniform Resource Identifier).
	public function encodeURI (uri:String) : String;

	/// Encodes a string into a valid URI component.
	public function encodeURIComponent (uri:String) : String;

	/// Converts the parameter to a string and encodes it in a URL-encoded format, where most nonalphanumeric characters are replaced with % hexadecimal sequences.
	public function escape (s:String) : String;

	/// A special value representing positive Infinity.
	public const Infinity : Number;

	/// Returns true if the value is a finite number, or false if the value is Infinity or -Infinity.
	public function isFinite (n:Number) : Boolean;

	/// Returns true if the value is NaN(not a number).
	public function isNaN (n:Number) : Boolean;

	/// Determines whether the specified string is a valid name for an XML element or attribute.
	public function isXMLName (str:*) : Boolean;

	/// A special member of the Number data type that represents a value that is "not a number" (NaN).
	public const NaN : Number;

	/// Converts a string to a floating-point number.
	public function parseFloat (str:String) : Number;

	/// Converts a string to an integer.
	public function parseInt (s:String = "NaN", radix:int = 0) : Number;

	/// Displays expressions, or writes to log files, while debugging.
	public function trace (...rest) : String;

	/// A special value that applies to untyped variables that have not been initialized or dynamic object properties that are not initialized.
	public const undefined : *;

	/// Evaluates the parameter str as a string, decodes the string from URL-encoded format (converting all hexadecimal sequences to ASCII characters), and returns the string.
	public function unescape (s:String) : String;

}
