package mx.formatters
{
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;

include "../core/Version.as"
	/**
	 *  The DateFormatter class uses a format String to return a formatted date and time String
 *  from an input String or a Date object.
 *  You can create many variations easily, including international formats.
 *
 *  <p>If an error occurs, an empty String is returned and a String describing 
 *  the error is saved to the <code>error</code> property. The <code>error</code> 
 *  property can have one of the following values:</p>
 *
 *  <ul>
 *    <li><code>"Invalid value"</code> means a value that is not a Date object or a 
 *    is not a recognized String representation of a date is
 *    passed to the <code>format()</code> method. (An empty argument is allowed.)</li>
 *    <li> <code>"Invalid format"</code> means either the <code>formatString</code> 
 *    property is set to empty (""), or there is less than one pattern letter 
 *    in the <code>formatString</code> property.</li>
 *  </ul>
 *
 *  <p>The <code>parseDateString()</code> method uses the mx.formatters.DateBase class
 *  to define the localized string information required to convert 
 *  a date that is formatted as a String into a Date object.</p>
 *  
 *  @mxml
 *  
 *  <p>You use the <code>&lt;mx:DateFormatter&gt;</code> tag
 *  to render date and time Strings from a Date object.</p>
 *
 *  <p>The <code>&lt;mx:DateFormatter&gt;</code> tag
 *  inherits all of the tag attributes  of its superclass,
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:DateFormatter
 *    formatString="Y|M|D|A|E|H|J|K|L|N|S|Q"
 *   /> 
 *  </pre>
 *  
 *  @includeExample examples/DateFormatterExample.mxml
 *  
 *  @see mx.formatters.DateBase
	 */
	public class DateFormatter extends Formatter
	{
		/**
		 *  @private
		 */
		private static const VALID_PATTERN_CHARS : String = "Y,M,D,A,E,H,J,K,L,N,S,Q";
		/**
		 *  @private
     *  Storage for the formatString property.
		 */
		private var _formatString : String;
		/**
		 *  @private
		 */
		private var formatStringOverride : String;

		/**
		 *  The mask pattern.
     *  
     *  <p>You compose a pattern String using specific uppercase letters,
     *  for example: YYYY/MM.</p>
     *
     *  <p>The DateFormatter pattern String can contain other text
     *  in addition to pattern letters.
     *  To form a valid pattern String, you only need one pattern letter.</p>
     *      
     *  <p>The following table describes the valid pattern letters:</p>
     *
     *  <table class="innertable">
     *    <tr><th>Pattern letter</th><th>Description</th></tr>
     *    <tr>
     *      <td>Y</td>
     *      <td> Year. If the number of pattern letters is two, the year is 
     *        truncated to two digits; otherwise, it appears as four digits. 
     *        The year can be zero-padded, as the third example shows in the 
     *        following set of examples: 
     *        <ul>
     *          <li>YY = 05</li>
     *          <li>YYYY = 2005</li>
     *          <li>YYYYY = 02005</li>
     *        </ul></td>
     *    </tr>
     *    <tr>
     *      <td>M</td>
     *      <td> Month in year. The format depends on the following criteria:
     *        <ul>
     *          <li>If the number of pattern letters is one, the format is 
     *            interpreted as numeric in one or two digits. </li>
     *          <li>If the number of pattern letters is two, the format 
     *            is interpreted as numeric in two digits.</li>
     *          <li>If the number of pattern letters is three, 
     *            the format is interpreted as short text.</li>
     *          <li>If the number of pattern letters is four, the format 
     *           is interpreted as full text. </li>
     *        </ul>
     *          Examples:
     *        <ul>
     *          <li>M = 7</li>
     *          <li>MM= 07</li>
     *          <li>MMM=Jul</li>
     *          <li>MMMM= July</li>
     *        </ul></td>
     *    </tr>
     *    <tr>
     *      <td>D</td>
     *      <td>Day in month. While a single-letter pattern string for day is valid, 
     *        you typically use a two-letter pattern string.
     * 
     *        <p>Examples:</p>
     *        <ul>
     *          <li>D=4</li>
     *          <li>DD=04</li>
     *          <li>DD=10</li>
     *        </ul></td>
     *    </tr>
     *    <tr>
     *      <td>E</td>
     *      <td>Day in week. The format depends on the following criteria:
     *        <ul>
     *          <li>If the number of pattern letters is one, the format is 
     *            interpreted as numeric in one or two digits.</li>
     *          <li>If the number of pattern letters is two, the format is interpreted 
     *           as numeric in two digits.</li>
     *          <li>If the number of pattern letters is three, the format is interpreted 
     *            as short text. </li>
     *          <li>If the number of pattern letters is four, the format is interpreted 
     *           as full text. </li>
     *        </ul>
     *          Examples:
     *        <ul>
     *          <li>E = 1</li>
     *          <li>EE = 01</li>
     *          <li>EEE = Mon</li>
     *          <li>EEEE = Monday</li>
     *        </ul></td>
     *    </tr>
     *    <tr>
     *      <td>A</td>
     *      <td> am/pm indicator.</td>
     *    </tr>
     *    <tr>
     *      <td>J</td>
     *      <td>Hour in day (0-23).</td>
     *    </tr>
     *    <tr>
     *      <td>H</td>
     *      <td>Hour in day (1-24).</td>
     *    </tr>
     *    <tr>
     *      <td>K</td>
     *      <td>Hour in am/pm (0-11).</td>
     *    </tr>
     *    <tr>
     *      <td>L</td>
     *      <td>Hour in am/pm (1-12).</td>
     *    </tr>
     *    <tr>
     *      <td>N</td>
     *      <td>Minute in hour.
     * 
     *        <p>Examples:</p>
     *        <ul>
     *          <li>N = 3</li>
     *          <li>NN = 03</li>
     *        </ul></td>
     *    </tr>
     *    <tr>
     *      <td>S</td>
     *      <td>Second in minute. 
     * 
     *        <p>Example:</p>
     *        <ul>
     *          <li>SS = 30</li>
     *        </ul><
		 */
		public function get formatString () : String;
		/**
		 *  @private
		 */
		public function set formatString (value:String) : void;

		/**
		 *  Converts a date that is formatted as a String into a Date object.
     *  Month and day names must match the names in mx.formatters.DateBase.
     *  
     *  @see mx.formatters.DateBase
     * 
     *  @param str Date that is formatted as a String. 
     *
     *  @return Date object.
		 */
		public static function parseDateString (str:String) : Date;

		/**
		 *  Constructor.
		 */
		public function DateFormatter ();

		/**
		 *  @private
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Generates a date-formatted String from either a date-formatted String or a Date object. 
     *  The <code>formatString</code> property
     *  determines the format of the output String.
     *  If <code>value</code> cannot be formatted, return an empty String 
     *  and write a description of the error to the <code>error</code> property.
     *
     *  @param value Date to format. This can be a Date object,
     *  or a date-formatted String such as "Thursday, April 22, 2004".
     *
     *  @return Formatted String. Empty if an error occurs. A description 
     *  of the error condition is written to the <code>error</code> property.
		 */
		public function format (value:Object) : String;
	}
}
