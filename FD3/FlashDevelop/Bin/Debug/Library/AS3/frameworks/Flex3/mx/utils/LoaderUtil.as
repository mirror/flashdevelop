/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	import flash.display.LoaderInfo;
	public class LoaderUtil {
		/**
		 * The root URL of a cross-domain RSL contains special text
		 *  appended to the end of the URL.
		 *  This method normalizes the URL specified in the specified LoaderInfo instance
		 *  to remove the appended text, if present.
		 *  Classes accessing LoaderInfo.url should call this method
		 *  to normalize the URL before using it.
		 *
		 * @param loaderInfo        <LoaderInfo> A LoaderInfo instance.
		 * @return                  <String> A normalized LoaderInfo.url property.
		 */
		public static function normalizeURL(loaderInfo:LoaderInfo):String;
	}
}
