/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.media {
	public class SoundLoaderContext {
		/**
		 * The number of seconds to preload a streaming sound into a buffer
		 *  before the sound starts to stream.
		 */
		public var bufferTime:Number = 1000;
		/**
		 * Specifies whether the application should try to download a cross-domain policy file from the
		 *  loaded sound's server before beginning to load the sound. This property applies to
		 *  sound that is loaded from outside
		 *  the calling file's own domain using the Sound.load() method.
		 */
		public var checkPolicyFile:Boolean = false;
		/**
		 * Creates a new sound loader context object.
		 *
		 * @param bufferTime        <Number (default = 1000)> The number of seconds to preload a streaming sound into a buffer
		 *                            before the sound starts to stream.
		 * @param checkPolicyFile   <Boolean (default = false)> Specifies whether the existence of a cross-domain policy file
		 *                            should be checked upon loading the object (true) or not.
		 */
		public function SoundLoaderContext(bufferTime:Number = 1000, checkPolicyFile:Boolean = false);
	}
}
