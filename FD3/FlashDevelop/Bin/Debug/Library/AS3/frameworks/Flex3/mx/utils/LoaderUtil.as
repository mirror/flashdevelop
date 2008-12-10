package mx.utils
{
	import flash.display.LoaderInfo;
	import flash.system.Security;

	/**
	 *  The LoaderUtil class defines a utility method for use with Flex RSLs.
	 */
	public class LoaderUtil
	{
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
     *  This is typically the url of the application loading the url.
     * 
     *  @param url The url of the resource to load (may be relative).
     * 
     *  @return If <code>url</code> is already an absolute URL, then it is 
     *  returned as is. If <code>url</code> is relative, then an absolute URL is
     *  returned where <code>url</code> is relative to <code>rootURL</code>.
		 */
		public static function createAbsoluteURL (rootURL:String, url:String) : String;
	}
}
