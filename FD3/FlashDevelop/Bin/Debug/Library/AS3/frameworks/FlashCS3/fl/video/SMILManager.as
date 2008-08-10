package fl.video
{
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.*;

/**
* XML examples from above without xml entitiy substitution:	 *	 * <smil>	 *     <head>	 *         <meta base="rtmp://myserver/mypgm/" />	 *         <layout>	 *             <root-layout width="240" height="180" />	 *         </layout>	 *     </head>	 *     <body>	 *         <switch>	 *             <ref src="myvideo_cable.flv" system-bitrate="128000" dur="3:00.1"/>	 *             <video src="myvideo_isdn.flv" system-bitrate="56000" dur="3:00.1"/>	 *             <video src="myvideo_mdm.flv" dur="3:00.1"/>	 *         </switch>	 *     </body>	 * </smil>	 *	 * <smil>	 *     <head>	 *         <layout>	 *             <root-layout width="240" height="180" />	 *         </layout>	 *     </head>	 *     <body>	 *         <video src="http://myserver/myvideo.flv" dur="3:00.1"/>	 *     </body>	 *	 * Precise subset of SMIL supported (more readable format):	 *	 * * smil tag - top level tag	 *     o head tag	 *         + meta tag	 *             # Only base attribute supported	 *
*/
public class SMILManager
{
		private var _owner : INCManager;
		internal var xml : XML;
		internal var xmlLoader : URLLoader;
		internal var baseURLAttr : Array;
		internal var width : int;
		internal var height : int;
		internal var videoTags : Array;
		private var _url : String;

	/**
	* constructor         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function SMILManager (owner:INCManager);
	/**
	* <p>Starts download of XML file.  Will be parsed and based		 * on that we will decide how to connect.</p>		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function connectXML (url:String) : Boolean;
	/**
	* <p>Append version parameter to URL.</p>		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function fixURL (origURL:String) : String;
	/**
	* <p>Handles load of XML.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function xmlLoadEventHandler (e:Event) : void;
	/**
	* parse head node of smil		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseHead (parentNode:XML) : void;
	/**
	* parse layout node of smil		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseLayout (parentNode:XML) : void;
	/**
	* parse body node of smil		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseBody (parentNode:XML) : void;
	/**
	* parse switch node of smil		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseSwitch (parentNode:XML) : void;
	/**
	* parse video or ref node of smil.  Returns object with		 * attribute info.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseVideo (node:XML) : Object;
	/**
	* parse time in hh:mm:ss.s or mm:ss.s format.		 * Also accepts a bare number of seconds with		 * no colons.  Returns a number of seconds.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function parseTime (timeStr:String) : Number;
	/**
	* checks for extra, unrecognized elements of the given kind		 * in parentNode and throws VideoError if any are found.		 * Ignores any nodes with different nodeKind().  Takes the		 * list of recognized elements as a parameter.		 *         * @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		internal function checkForIllegalNodes (parentNode:XML, kind:String, legalNodes:Array) : void;
}
}
