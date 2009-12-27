package mx.formatters
{
	import flash.events.Event;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

include "../core/Version.as"
	/**
	 *  The Formatter class is the base class for all data formatters.
 *  Any subclass of Formatter must override the <code>format()</code> method.
 *
 *  @mxml
 *
 *  <p>The Formatter class defines the following tag attributes,
 *  which all of its subclasses inherit:</p>
 *  
 *  <pre>
 *  &lt;mx:<i>tagname</i>
 *    <b>Properties</b>
 *    error=""
 *  /&gt;
 *  </pre>
 *  
 *  @includeExample examples/SimpleFormatterExample.mxml
	 */
	public class Formatter
	{
		/**
		 *  @private
		 */
		private static var initialized : Boolean;
		/**
		 *  @private
	 *  Storage for the resourceManager getter.
	 *  This gets initialized on first access,
	 *  not at static initialization time, in order to ensure
	 *  that the Singleton registry has already been initialized.
		 */
		private static var _static_resourceManager : IResourceManager;
		/**
		 *  @private
	 *  Storage for the defaultInvalidFormatError property.
		 */
		private static var _defaultInvalidFormatError : String;
		/**
		 *  @private
		 */
		private static var defaultInvalidFormatErrorOverride : String;
		/**
		 *  @private
	 *  Storage for the defaultInvalidValueError property.
		 */
		private static var _defaultInvalidValueError : String;
		/**
		 *  @private
		 */
		private static var defaultInvalidValueErrorOverride : String;
		/**
		 *  Description saved by the formatter when an error occurs.
	 *  For the possible values of this property,
	 *  see the description of each formatter.
	 *  <p>Subclasses must set this value
	 *  in the <code>format()</code> method.</p>
		 */
		public var error : String;
		/**
		 *  @private
	 *  Storage for the resourceManager property.
		 */
		private var _resourceManager : IResourceManager;

		/**
		 *  @private
     *  A reference to the object which manages
     *  all of the application's localized resources.
     *  This is a singleton instance which implements
     *  the IResourceManager interface.
		 */
		private static function get static_resourceManager () : IResourceManager;

		/**
		 *  Error message for an invalid format string specified to the formatter.
	 * 
	 *  @default "Invalid format"
		 */
		public static function get defaultInvalidFormatError () : String;
		/**
		 *  @private
		 */
		public static function set defaultInvalidFormatError (value:String) : void;

		/**
		 *  Error messages for an invalid value specified to the formatter.
	 * 
	 *  @default "Invalid value"
		 */
		public static function get defaultInvalidValueError () : String;
		/**
		 *  @private
		 */
		public static function set defaultInvalidValueError (value:String) : void;

		/**
		 *  @copy mx.core.UIComponent#resourceManager
		 */
		protected function get resourceManager () : IResourceManager;

		/**
		 *  @private
		 */
		private static function initialize () : void;

		/**
		 *  @private
		 */
		private static function static_resourcesChanged () : void;

		/**
		 *  @private
		 */
		private static function static_resourceManager_changeHandler (event:Event) : void;

		/**
		 *  Constructor.
		 */
		public function Formatter ();

		/**
		 *  This method is called when a Formatter is constructed,
	 *  and again whenever the ResourceManager dispatches
	 *  a <code>"change"</code> Event to indicate
	 *  that the localized resources have changed in some way.
	 * 
	 *  <p>This event will be dispatched when you set the ResourceManager's
	 *  <code>localeChain</code> property, when a resource module
	 *  has finished loading, and when you call the ResourceManager's
	 *  <code>update()</code> method.</p>
	 *
	 *  <p>Subclasses should override this method and, after calling
	 *  <code>super.resourcesChanged()</code>, do whatever is appropriate
	 *  in response to having new resource values.</p>
		 */
		protected function resourcesChanged () : void;

		/**
		 *  Formats a value and returns a String
	 *  containing the new, formatted, value.
	 *  All subclasses must override this method to implement the formatter.
	 *
	 *  @param value Value to be formatted.
	 *
	 *  @return The formatted string.
		 */
		public function format (value:Object) : String;

		/**
		 *  @private
		 */
		private function resourceManager_changeHandler (event:Event) : void;
	}
}
