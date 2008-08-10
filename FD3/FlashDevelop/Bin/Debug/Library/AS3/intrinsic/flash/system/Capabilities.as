/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.system {
	public final  class Capabilities {
		/**
		 * Specifies whether access to the user's camera and microphone has
		 *  been administratively prohibited (true) or allowed (false).
		 *  The server string is AVD.
		 */
		public static function get avHardwareDisable():Boolean;
		/**
		 * Specifies whether the system supports
		 *  (true) or does not support (false) communication
		 *  with accessibility aids.
		 *  The server string is ACC.
		 */
		public static function get hasAccessibility():Boolean;
		/**
		 * Specifies whether the system has audio
		 *  capabilities. This property is always true.  The server
		 *  string is A.
		 */
		public static function get hasAudio():Boolean;
		/**
		 * Specifies whether the system can (true) or cannot (false)
		 *  encode an audio stream, such as that coming from a microphone.
		 *  The server string is AE.
		 */
		public static function get hasAudioEncoder():Boolean;
		/**
		 * Specifies whether the system supports
		 *  (true) or does not support (false)
		 *  embedded video. The server string is EV.
		 */
		public static function get hasEmbeddedVideo():Boolean;
		/**
		 * Specifies whether the system does (true)
		 *  or does not (false) have an input method editor (IME) installed.
		 *  The server string is IME.
		 */
		public static function get hasIME():Boolean;
		/**
		 * Specifies whether the system does (true)
		 *  or does not (false) have an MP3 decoder.
		 *  The server string is MP3.
		 */
		public static function get hasMP3():Boolean;
		/**
		 * Specifies whether the system does (true)
		 *  or does not (false) support printing.
		 *  The server string is PR.
		 */
		public static function get hasPrinting():Boolean;
		/**
		 * Specifies whether the system does (true) or does not (false)
		 *  support the development of screen broadcast applications to be run through Flash Media
		 *  Server.
		 *  The server string is SB.
		 */
		public static function get hasScreenBroadcast():Boolean;
		/**
		 * Specifies whether the system does (true) or does not
		 *  (false) support the playback of screen broadcast applications
		 *  that are being run through Flash Media Server.
		 *  The server string is SP.
		 */
		public static function get hasScreenPlayback():Boolean;
		/**
		 * Specifies whether the system can (true) or cannot (false)
		 *  play streaming audio.
		 *  The server string is SA.
		 */
		public static function get hasStreamingAudio():Boolean;
		/**
		 * Specifies whether the system can (true) or cannot
		 *  (false) play streaming video.
		 *  The server string is SV.
		 */
		public static function get hasStreamingVideo():Boolean;
		/**
		 * Specifies whether the system supports native SSL sockets through NetConnection
		 *  (true) or does not (false).
		 *  The server string is TLS.
		 */
		public static function get hasTLS():Boolean;
		/**
		 * Specifies whether the system can (true) or cannot
		 *  (false) encode a video stream, such as that coming
		 *  from a web camera.
		 *  The server string is VE.
		 */
		public static function get hasVideoEncoder():Boolean;
		/**
		 * Specifies whether the system is a special debugging version
		 *  (true) or an officially released version (false).
		 *  The server string is DEB. This property is set to true
		 *  when running in the debug version of Flash Player or
		 *  the AIR Debug Launcher (ADL).
		 */
		public static function get isDebugger():Boolean;
		/**
		 * Specifies the language code of the system on which the content is running. The language is
		 *  specified as a lowercase two-letter language code from ISO 639-1. For Chinese, an additional
		 *  uppercase two-letter country code from ISO 3166 distinguishes between Simplified and
		 *  Traditional Chinese. The languages codes are based on the English names of the language: for example,
		 *  hu specifies Hungarian.
		 */
		public static function get language():String;
		/**
		 * Specifies whether read access to the user's hard disk has been
		 *  administratively prohibited (true) or allowed
		 *  (false). For content in Adobe AIR, this property
		 *  applies only to content in security sandboxes other
		 *  than the application security sandbox. (Content in the application
		 *  security sandbox can always read from the file system.)
		 *  If this property is true,
		 *  Flash Player cannot read files (including the first file that
		 *  Flash Player launches with) from the user's hard disk.
		 *  If this property is true, AIR content outside of the
		 *  application security sandbox cannot read files from the user's
		 *  hard disk. For example, attempts to read a file on the user's
		 *  hard disk using load methods will fail if this property
		 *  is set to true.
		 */
		public static function get localFileReadDisable():Boolean;
		/**
		 * Specifies the manufacturer of the running version of
		 *  Flash Player or  the AIR runtime, in the format "Adobe
		 *  OSName". The value for OSName
		 *  could be "Windows", "Macintosh",
		 *  "Linux", or another operating system name. The server string is M.
		 */
		public static function get manufacturer():String;
		/**
		 * Specifies the current operating system. The os property
		 *  can return the following strings: "Windows XP", "Windows 2000",
		 *  "Windows NT", "Windows 98/ME", "Windows 95",
		 *  "Windows CE" (available only in Flash Player SDK, not in the desktop version),
		 *  "Linux", and "MacOS".
		 *  The server string is OS.
		 */
		public static function get os():String;
		/**
		 * Specifies the pixel aspect ratio of the screen. The server string
		 *  is AR.
		 */
		public static function get pixelAspectRatio():Number;
		/**
		 * Specifies the type of runtime environment. This property can have one of the following
		 *  values:
		 *  "ActiveX" for the Flash Player ActiveX control used by Microsoft Internet Explorer
		 *  "Desktop" for the Adobe AIR runtime (except for SWF content loaded by an HTML page, which
		 *  has Capabilities.playerType set to "PlugIn")
		 *  "External" for the external Flash Player
		 *  "PlugIn" for the Flash Player browser plug-in (and for SWF content loaded by
		 *  an HTML page in an AIR application)
		 *  "StandAlone" for the stand-alone Flash Player
		 */
		public static function get playerType():String;
		/**
		 * Specifies the screen color. This property can have the value
		 *  "color", "gray" (for grayscale), or
		 *  "bw" (for black and white).
		 *  The server string is COL.
		 */
		public static function get screenColor():String;
		/**
		 * Specifies the dots-per-inch (dpi) resolution of the screen, in pixels.
		 *  The server string is DP.
		 */
		public static function get screenDPI():Number;
		/**
		 * Specifies the maximum horizontal resolution of the screen.
		 *  The server string is R (which returns both the width and height of the screen).
		 *  This property does not update with a user's screen resolution and instead only indicates the resolution
		 *  at the time Flash Player or  an Adobe AIR application started.
		 *  Also, the value only specifies the main monitor.
		 */
		public static function get screenResolutionX():Number;
		/**
		 * Specifies the maximum vertical resolution of the screen.
		 *  The server string is R (which returns both the width and height of the screen).
		 *  This property does not update with a user's screen resolution and instead only indicates the resolution
		 *  at the time Flash Player or  an Adobe AIR application started.
		 *  Also, the value only specifies the main monitor.
		 */
		public static function get screenResolutionY():Number;
		/**
		 * A URL-encoded string that specifies values for each Capabilities
		 *  property.
		 */
		public static function get serverString():String;
		/**
		 * Specifies the Flash Player or Adobe® AIR
		 *  platform and version information. The format of the version number is:
		 *  platform majorVersion,minorVersion,buildNumber,internalBuildNumber.
		 *  Possible values for platform are "WIN",
		 *  "MAC", and "UNIX".
		 */
		public static function get version():String;
	}
}
