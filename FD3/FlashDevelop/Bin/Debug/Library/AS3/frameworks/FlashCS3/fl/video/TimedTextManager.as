package fl.video
{
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.*;

/**
* <p>Handles downloading and parsing Timed Text (TT) xml format	 * for fl.video.FLVPlayback. See fl.video.FLVPlaybackCaptioning	 * for more info on the subset of Timed Text supported.</p>	 * 	 * <p>When the timed text is parsed it is turned into ActionScript	 * cue points which are added to the FLVPlayback instance's list.	 * The cue points use the naming convention of beginning with the	 * prefix "fl.video.caption.", so users should not create any cue points	 * with names like this unless they want them used for captioning,	 * and users who are doing general cue point handling should	 * ignore cue points with names like this.</p>	 * 	 * <p>The ActionScript cue points created have the following	 * attributes:</p>	 * 	 * <ul>	 * 	 *   <li>name: starts with prefix "fl.video.caption." followed by	 *   a version number ("2.0" for this release) and then has some	 *   arbitrary string after that.  In practice the string is	 *   simply a series of positive integers incremented each time to	 *
*/
public class TimedTextManager
{
		internal var owner : FLVPlaybackCaptioning;
		private var flvPlayback : FLVPlayback;
		private var videoPlayerIndex : uint;
		private var limitFormatting : Boolean;
		public var xml : XML;
		public var xmlLoader : URLLoader;
		private var _url : String;
		internal var nameCounter : uint;
		internal var lastCuePoint : Object;
		internal var styleStack : Array;
		internal var definedStyles : Object;
		internal var styleCounter : uint;
		internal var whiteSpacePreserved : Boolean;
		internal var fontTagOpened : Object;
		internal var italicTagOpen : Boolean;
		internal var boldTagOpen : Boolean;
		internal static var CAPTION_LEVEL_ATTRS : Array;
		internal var xmlNamespace : Namespace;
		internal var xmlns : Namespace;
		internal var tts : Namespace;
		internal var ttp : Namespace;

	/**
	* constructor
	*/
		public function TimedTextManager (owner:FLVPlaybackCaptioning);
	/**
	* <p>Starts download of XML file.  Will be parsed and based		 * on that we will decide how to connect.</p>		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function load (url:String) : void;
	/**
	* <p>Handles load of XML.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function xmlLoadEventHandler (e:Event) : void;
	/**
	* parse head node of tt		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseHead (parentNode:XML) : void;
	/**
	* parse styling node of tt		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseStyling (parentNode:XML) : void;
	/**
	* parse body node of tt		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseBody (parentNode:XML) : void;
		internal function parseParagraph (parentNode:XML) : void;
		internal function parseSpan (parentNode:XML, cuePoint:Object) : String;
		internal function openFontTag () : String;
		internal function closeFontTags () : String;
		internal function parseStyleAttribute (xmlNode:XML, styleObj:Object) : void;
	/**
	* Extracts supported style attributes (tts:... attributes		 * in namespace http://www.w3.org/2006/04/ttaf1#styling)         * from an XMLList of attributes for a tag element.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseTTSAttributes (xmlNode:XML, styleObject:Object) : void;
		internal function getStyle () : Object;
		internal function pushStyle (styleObj:Object) : void;
		internal function popStyle () : void;
	/**
	* copies attributes from one style object to another         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function copyStyleObjectProps (tgt:Object, src:Object) : void;
	/**
	* parses color         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseColor (colorStr:String) : Object;
	/**
	* parses fontSize         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseFontSize (sizeStr:String) : String;
	/**
	* parses fontFamily         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseFontFamily (familyStr:String) : String;
	/**
	* parse time in hh:mm:ss.s or mm:ss.s format.		 * Also accepts a bare number of seconds with		 * no colons.  Returns a number of seconds.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseTimeAttribute (parentNode:XML, attr:String, req:Boolean) : Number;
	/**
	* checks for extra, unrecognized elements of the given kind		 * in parentNode and throws VideoError if any are found.		 * Ignores any nodes with different nodeKind().  Takes the		 * list of recognized elements as a parameter.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function checkForIllegalElements (parentNode:XML, legalNodes:Object) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function fixCaptionText (inText:String) : String;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function unicodeEscapeReplace (match:String, first:String, second:String, index:int, all:String) : String;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function getSpaceAttribute (node:XML) : String;
}
}
