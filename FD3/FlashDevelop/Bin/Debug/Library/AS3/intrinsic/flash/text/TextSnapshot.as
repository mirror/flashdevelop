/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.text {
	public class TextSnapshot {
		/**
		 * The number of characters in a TextSnapshot object.
		 */
		public function get charCount():int;
		/**
		 * Searches the specified TextSnapshot object and returns the position of the first
		 *  occurrence of textToFind found at or after beginIndex. If
		 *  textToFind is not found, the method returns -1.
		 *
		 * @param beginIndex        <int> Specifies the starting point to search for the specified text.
		 * @param textToFind        <String> Specifies the text to search for. If you specify a string literal instead of a
		 *                            variable of type String, enclose the string in quotation marks.
		 * @param caseSensitive     <Boolean> Specifies whether the text must match the case of the string in
		 *                            textToFind.
		 * @return                  <int> The zero-based index position of the first occurrence of the specified text, or -1.
		 */
		public function findText(beginIndex:int, textToFind:String, caseSensitive:Boolean):int;
		/**
		 * Returns a Boolean value that specifies whether a TextSnapshot object contains selected text in
		 *  the specified range.
		 *
		 * @param beginIndex        <int> Indicates the position of the first character to be examined.
		 *                            Valid values for beginIndex are 0 through
		 *                            TextSnapshot.charCount - 1. If beginIndex is a negative value,
		 *                            0 is used.
		 * @param endIndex          <int> A value that is one greater than the index of the last character to be examined. Valid values
		 *                            for endIndex are 0 through charCount.
		 *                            The character indexed by the endIndex parameter is not included in the extracted
		 *                            string. If this parameter is omitted, charCount is used. If this value is less than
		 *                            or equal to the value of beginIndex, beginIndex + 1 is used.
		 * @return                  <Boolean> A Boolean value that indicates whether at least one character in the given range has been
		 *                            selected by the corresponding setSelected() method (true); otherwise,
		 *                            false.
		 */
		public function getSelected(beginIndex:int, endIndex:int):Boolean;
		/**
		 * Returns a string that contains all the characters specified by the corresponding
		 *  setSelected() method. If no characters are specified (by the
		 *  setSelected() method), an empty string is returned.
		 *
		 * @param includeLineEndings<Boolean (default = false)> An optional Boolean value that specifies
		 *                            whether newline characters are inserted into the returned string where
		 *                            appropriate. The default value is false.
		 * @return                  <String> A string that contains all the characters specified by the
		 *                            corresponding setSelected() command.
		 */
		public function getSelectedText(includeLineEndings:Boolean = false):String;
		/**
		 * Returns a string that contains all the characters specified by the beginIndex
		 *  and endIndex parameters. If no characters are selected, an empty string is
		 *  returned.
		 *
		 * @param beginIndex        <int> Indicates the position of the first character to be included in the
		 *                            returned string. Valid values for beginIndex are0 through
		 *                            charCount - 1. If beginIndex is a negative value,
		 *                            0 is used.
		 * @param endIndex          <int> A value that is one greater than the index of the last character to be examined. Valid values
		 *                            for endIndex are 0 through charCount. The character
		 *                            indexed by the endIndex parameter is not included in the extracted string. If this
		 *                            parameter is omitted, charCount is used. If this value is less than or
		 *                            equal to the value of beginIndex, beginIndex + 1 is used.
		 * @param includeLineEndings<Boolean (default = false)> An optional Boolean value that specifies whether newline characters
		 *                            are inserted (true) or are not inserted (false) into the returned string.
		 *                            The default value is false.
		 * @return                  <String> A string containing the characters in the specified range, or an empty string if no
		 *                            characters are found in the specified range.
		 */
		public function getText(beginIndex:int, endIndex:int, includeLineEndings:Boolean = false):String;
		/**
		 * Returns an array of objects that contains information about a run of text. Each object corresponds
		 *  to one character in the range of characters specified by the two method parameters.
		 *
		 * @param beginIndex        <int> The index value of the first character in a range of characters in a TextSnapshot
		 *                            object.
		 * @param endIndex          <int> The index value of the last character in a range of characters in a TextSnapshot
		 *                            object.
		 * @return                  <Array> An array of objects in which each object contains information about a specific character
		 *                            in the range of characters specified by the beginIndex and endIndex parameters.
		 *                            Each object contains the following eleven properties:
		 *                            indexInRun-A zero-based integer index of the character
		 *                            (relative to the entire string rather than the selected run of text).
		 *                            selected-A Boolean value that indicates whether the character is selected
		 *                            true; false otherwise.
		 *                            font-The name of the character's font.
		 *                            color-The combined alpha and color value of the character.
		 *                            The first two hexadecimal digits represent the alpha value, and the remaining digits
		 *                            represent the color value.
		 *                            height-The height of the character, in pixels.
		 *                            matrix_a, matrix_b, matrix_c,
		 *                            matrix_d, matrix_tx, and matrix_ty-
		 *                            The values of a matrix that define the geometric transformation on the character.
		 *                            Normal, upright text always has a matrix of the form
		 *                            [1 0 0 1 x y], where x and y
		 *                            are the position of the character within the parent movie clip, regardless of the height of
		 *                            the text. The matrix is in the parent movie clip coordinate system, and
		 *                            does not include any transformations that may be on that movie clip itself (or its parent).
		 *                            corner0x, corner0y, corner1x, corner1y,
		 *                            corner2x, corner2y, corner3x,
		 *                            and corner3y-The corners of the bounding box of
		 *                            the character, based on the coordinate system of the parent movie clip.
		 *                            These values are only available if the font used by the character is embedded in the
		 *                            SWF file.
		 */
		public function getTextRunInfo(beginIndex:int, endIndex:int):Array;
		/**
		 * Lets you determine which character within a TextSnapshot object is on or near the specified
		 *  x, y coordinates of the movie clip containing the text in the TextSnapshot object.
		 *
		 * @param x                 <Number> A number that represents the x coordinate of the movie clip containing the
		 *                            text.
		 * @param y                 <Number> A number that represents the y coordinate of the movie clip containing the
		 *                            text.
		 * @param maxDistance       <Number (default = 0)> An optional number that represents the maximum distance from
		 *                            x, y that can be searched for
		 *                            text. The distance is measured from the center point of each character. The
		 *                            default value is 0.
		 * @return                  <Number> A number representing the index value of the character that is nearest to the specified
		 *                            x, y coordinate. Returns
		 *                            -1 if no character is found, or if the font doesn't contain character metric information.
		 */
		public function hitTestTextNearPos(x:Number, y:Number, maxDistance:Number = 0):Number;
		/**
		 * Specifies the color to use when highlighting characters that have been selected with the
		 *  setSelected() method. The color is always opaque; you can't specify a
		 *  transparency value.
		 *
		 * @param hexColor          <uint (default = 0xFFFF00)> The color used for the border placed around characters that have been selected by the
		 *                            corresponding setSelected() command, expressed in hexadecimal
		 *                            format (0xRRGGBB).
		 */
		public function setSelectColor(hexColor:uint = 0xFFFF00):void;
		/**
		 * Specifies a range of characters in a TextSnapshot object to be selected or deselected.
		 *  Characters that are selected are drawn with a colored rectangle behind them, matching the
		 *  bounding box of the character. The color of the bounding box is defined by
		 *  setSelectColor().
		 *
		 * @param beginIndex        <int> Indicates the position of the first character to select.
		 *                            Valid values for beginIndex are 0 through charCount - 1.
		 *                            If beginIndex is a negative value, 0 is used.
		 * @param endIndex          <int> An integer that is 1+ the index of the last character to be
		 *                            examined. Valid values for end are 0 through charCount.
		 *                            The character indexed by the end parameter is not included in the extracted
		 *                            string. If you omit this parameter, TextSnapshot.charCount is used. If the
		 *                            value of beginIndex is less than or equal to the value of endIndex,
		 *                            beginIndex + 1 is used.
		 * @param select            <Boolean> A Boolean value that specifies whether the text should be selected (true)
		 *                            or deselected (false).
		 */
		public function setSelected(beginIndex:int, endIndex:int, select:Boolean):void;
	}
}
