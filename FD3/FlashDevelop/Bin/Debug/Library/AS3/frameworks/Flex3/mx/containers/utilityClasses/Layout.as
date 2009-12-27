package mx.containers.utilityClasses
{
	import mx.core.Container;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

include "../../core/Version.as"
	/**
	 *  @private
	 */
	public class Layout
	{
		/**
		 *  @private
	 *  Used for accessing localized error messages.
		 */
		protected var resourceManager : IResourceManager;
		/**
		 *  @private
	 *  Storage for the target property.
		 */
		private var _target : Container;

		/**
		 *  The container associated with this layout.
		 */
		public function get target () : Container;
		/**
		 *  @private
		 */
		public function set target (value:Container) : void;

		/**
		 *  Constructor.
		 */
		public function Layout ();

		/**
		 *  @private
		 */
		public function measure () : void;

		/**
		 *  @private
		 */
		public function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
	}
}
