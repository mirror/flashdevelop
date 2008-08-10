/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.accessibility {
	public class AccessibilityProperties {
		/**
		 * Provides a description for this display object in the accessible presentation.
		 *  If you have a lot of information to present about the object, it is
		 *  best to choose a concise name and put most of your content in the
		 *  description property.
		 *  Applies to whole SWF files, containers, buttons, and text. The default value
		 *  is an empty string.
		 */
		public var description:String;
		/**
		 * If true, causes Flash Player to exclude child objects within this
		 *  display object from the accessible presentation.
		 *  The default is false. Applies to whole SWF files and containers.
		 */
		public var forceSimple:Boolean;
		/**
		 * Provides a name for this display object in the accessible presentation.
		 *  Applies to whole SWF files, containers, buttons, and text.  Do not confuse with
		 *  DisplayObject.name, which is unrelated. The default value
		 *  is an empty string.
		 */
		public var name:String;
		/**
		 * If true, disables the Flash Player default auto-labeling system.
		 *  Auto-labeling causes text objects inside buttons to be treated as button names,
		 *  and text objects near text fields to be treated as text field names.
		 *  The default is false. Applies only to whole SWF files.
		 */
		public var noAutoLabeling:Boolean;
		/**
		 * Indicates a keyboard shortcut associated with this display object.
		 *  Supply this string only for UI controls that you have associated with a shortcut key.
		 *  Applies to containers, buttons, and text.  The default value
		 *  is an empty string.
		 */
		public var shortcut:String;
		/**
		 * If true, excludes this display object from accessible presentation.
		 *  The default is false. Applies to whole SWF files, containers, buttons, and text.
		 */
		public var silent:Boolean;
		/**
		 * Creates a new AccessibilityProperties object.
		 */
		public function AccessibilityProperties();
	}
}
