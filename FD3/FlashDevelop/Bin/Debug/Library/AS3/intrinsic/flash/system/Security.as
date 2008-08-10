/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.system {
	public final  class Security {
		/**
		 * Determines how Flash Player or AIR chooses the domain to use for certain
		 *  content settings, including settings for camera and microphone
		 *  permissions, storage quotas, and storage of persistent shared objects.
		 *  You may set exactSettings to false in order
		 *  to have the SWF file use the same settings that were used in Flash Player 6.
		 */
		public static function get exactSettings():Boolean;
		public function set exactSettings(value:Boolean):void;
		/**
		 * Indicates the type of security sandbox in which the calling file is operating.
		 */
		public static function get sandboxType():String;
		/**
		 * Lets SWF files files in the identified domains access objects and variables in the
		 *  SWF file that contains the allowDomain() call.
		 */
		public static function allowDomain(... domains):void;
		/**
		 * Lets SWF files and HTML files in the identified domains access objects and variables in the calling
		 *  SWF file, which is hosted by means of the HTTPS protocol. This method is not recommended;
		 *  see "Security considerations," later in this entry.
		 */
		public static function allowInsecureDomain(... domains):void;
		/**
		 * Loads a cross-domain policy file from a location specified by the url
		 *  parameter. Adobe AIR and Flash Player use policy files to determine
		 *  whether to permit applications to load data from servers other than their own.
		 *
		 * @param url               <String> The URL location of the cross-domain policy file to be loaded.
		 */
		public static function loadPolicyFile(url:String):void;
		/**
		 * Displays the Security Settings panel in Flash Player. This method does not apply to content in
		 *  Adobe AIR; calling it in an AIR application has no effect.
		 *
		 * @param panel             <String (default = "default")> A value from the SecurityPanel class that specifies which Security Settings
		 *                            panel you want to display. If you omit this parameter, SecurityPanel.DEFAULT is used.
		 */
		public static function showSettings(panel:String = "default"):void;
		/**
		 * The file is a local file and has been trusted by the user,
		 *  using either the Flash Player Settings Manager or a FlashPlayerTrust configuration
		 *  file. The file can read from local data sources and communicate
		 *  with the Internet.
		 */
		public static const LOCAL_TRUSTED:String = "localTrusted";
		/**
		 * The file is a local file, has not been trusted by the user,
		 *  and it is not a SWF file that was published with a networking designation. In Adobe AIR,
		 *  the local file is not in the application resource directory; such files are
		 *  put in the application security sandbox. The file may
		 *  read from local data sources but may not communicate with the Internet.
		 */
		public static const LOCAL_WITH_FILE:String = "localWithFile";
		/**
		 * The file is a local file, has not been trusted by the user, and it is a SWF
		 *  file that was published with a networking designation. The file can
		 *  communicate with the Internet but cannot read from local data sources.
		 */
		public static const LOCAL_WITH_NETWORK:String = "localWithNetwork";
		/**
		 * The file is from an Internet URL and operates under domain-based sandbox rules.
		 */
		public static const REMOTE:String = "remote";
	}
}
