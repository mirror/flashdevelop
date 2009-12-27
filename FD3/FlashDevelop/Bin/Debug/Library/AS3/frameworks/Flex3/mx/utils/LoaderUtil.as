package mx.utils
{
	import flash.display.LoaderInfo;
	import flash.system.Security;

include "../core/Version.as"
	/**
	 *  The LoaderUtil class defines a utility method for use with Flex RSLs.
	 */
	public class LoaderUtil
	{
		/**
		 *   @private
     * 
     *   An array of search strings and filters. These are used in the normalizeURL
     *   method. normalizeURL is used to remove special Flash Player markup from 
     *   urls, but the array could be appended to by the user to modify urls in other
     *   ways.
     *  
     *   Each object in the array has two fields:
     * 
     *   1. searchString - the string to search the url
     *   2. filterFunction - a function that accepts an url and an index to the first
     *   occurrence of the search string in the url. The function may modify the url
     *   and return a new url. A filterFunction is only called once, for the first
     *   occurrence of where the searchString was found. If there
     *   are multiple strings in the url that need to be processed the filterFunction
     *   should handle all of them on the call. A filter function should 
     *   be defined as follows:
     * 
     *   @param url the url to process.
     *   @param index the index of the first occurrence of the seachString in the url.
     *   @return the new url.
     * 
     *   function filterFunction(url:String, index:int):String
     *
		 */
		static var urlFilters : Array;

		/**
		 *  The root URL of a cross-domain RSL contains special text 
     *  appended to the end of the URL. 
     *  This method normalizes the URL specified in the specified LoaderInfo instance 
     *  to remove the appended text, if present. 
     *  Classes accessing <code>LoaderInfo.url</code> should call this method 
     *  to normalize the URL before using it.
     *
     *  @param loaderInfo A LoaderInfo instance.
     *
     *  @return A normalized <code>LoaderInfo.url</code> property.
		 */
		public static function normalizeURL (loaderInfo:LoaderInfo) : String;

		/**
		 *  @private 
     * 
     *  Use this method when you want to load resources with relative URLs.
     * 
     *  Combine a root url with a possibly relative url to get a absolute url.
     *  Use this method to convert a relative url to an absolute URL that is 
     *  relative to a root URL.
     * 
     *  @param rootURL An url that will form the root of the absolute url.
     *  If the <code>rootURL</code> does not specify a file name it must be 
     *  terminated with a slash. For example, "http://a.com" is incorrect, it
     *  should be terminated with a slash, "http://a.com/". If the rootURL is
     *  taken from loaderInfo, it must be passed thru <code>normalizeURL</code>
     *  before being passed to this function.
     * 
     *  When loading resources relative to an application, the rootURL is 
     *  typically the loaderInfo.url of the application.
     * 
     *  @param url The url of the resource to load (may be relative).
     * 
     *  @return If <code>url</code> is already an absolute URL, then it is 
     *  returned as is. If <code>url</code> is relative, then an absolute URL is
     *  returned where <code>url</code> is relative to <code>rootURL</code>.
		 */
		public static function createAbsoluteURL (rootURL:String, url:String) : String;

		/**
		 *  @private
     * 
     *  Strip off the DYNAMIC string(s) appended to the url.
		 */
		private static function dynamicURLFilter (url:String, index:int) : String;

		/**
		 *  @private
     * 
     *  Add together the protocol plus everything after "/[[IMPORT]]/".
		 */
		private static function importURLFilter (url:String, index:int) : String;
	}
}
