package mx.resources
{
	import flash.utils.describeType;
	import flash.system.ApplicationDomain;
	import mx.core.mx_internal;
	import mx.managers.ISystemManager;
	import mx.utils.StringUtil;

include "../core/Version.as"
	/**
	 *  Provides an implementation of the IResourceBundle interface.
 *  The IResourceManager and IResourceBundle interfaces work together
 *  to provide internationalization support for Flex applications.
 *
 *  <p>A Flex application typically has multiple instances of this class,
 *  all managed by a single instance of the ResourceManager class.
 *  It is possible to have ResourceBundle instances for multiple locales,
 *  one for each locale. There can be multiple ResourceBundle instances with
 *  different bundle names.</p>
 *  
 *  @see mx.resources.IResourceBundle
 *  @see mx.resources.IResourceManager
	 */
	public class ResourceBundle implements IResourceBundle
	{
		/**
		 *  @private
     *  Set by SystemManager constructor in order to make the deprecated
     *  getResourceBundle() method work with the new resource scheme
     *  in the single-locale case.
		 */
		static var locale : String;
		/**
		 *  @private
     *  Set by bootstrap loaders
     *  to allow for alternate search paths for resources
		 */
		static var backupApplicationDomain : ApplicationDomain;
		/**
		 *  @private
     *  Storage for the bundleName property.
		 */
		var _bundleName : String;
		/**
		 *  @private
     *  Storage for the content property.
		 */
		private var _content : Object;
		/**
		 *  @private
     *  Storage for the locale property.
		 */
		var _locale : String;

		/**
		 *  @copy mx.resources.IResourceBundle#bundleName
		 */
		public function get bundleName () : String;

		/**
		 *  @copy mx.resources.IResourceBundle#content
		 */
		public function get content () : Object;

		/**
		 *  @copy mx.resources.IResourceBundle#locale
		 */
		public function get locale () : String;

		/**
		 *  If you compiled your application for a single locale,
     *  this method can return a ResourceBundle when provided
     *  with a resource bundle name,
     *
     *  <p>This method has been deprecated because the Flex framework
     *  now supports having resource bundles for multiple locales
     *  in the same application.
     *  You can use the <code>getResourceBundle()</code> method
     *  of IResourceManager to get a resource bundle if you know
     *  its bundle name and locale.
     *  However, you should no longer access resources
     *  directly from a ResourceBundle.
     *  All resources should now be accessed via methods
     *  of the IResourceManager interface such as <code>getString()</code>.
     *  All classes that extend UIComponent, Formatter, or Validator
     *  have a <code>resourceManager</code> property
     *  which provides a reference to an object implementing this interface.
     *  Other classes can call <code>ResourceManager.getInstance()</code>
     *  to obtain this object.</p>
     *  
     *  @param baseName The name of the resource bundle to return.
     *  
     *  @param currentDomain The ApplicationDomain that the resource bundle is in.
     * 
     *  @return The resource bundle that matches the specified name and domain.
		 */
		public static function getResourceBundle (baseName:String, currentDomain:ApplicationDomain = null) : ResourceBundle;

		/**
		 *  @private
		 */
		private static function getClassByName (name:String, domain:ApplicationDomain) : Class;

		/**
		 *  Constructor.
     *
     *  @param locale A locale string, such as <code>"en_US"</code>.
     *
     *  @param bundleName A name that identifies this bundle,
     *  such as <code>"MyResources"</code>.
		 */
		public function ResourceBundle (locale:String = null, bundleName:String = null);

		/**
		 *  When a properties file is compiled into a resource bundle,
     *  the MXML compiler autogenerates a subclass of ResourceBundle.
     *  The subclass overrides this method to return an Object
     *  that contains key-value pairs for the bundle's resources.
     *
     *  <p>If you create your own ResourceBundle instances,
     *  you can set the key-value pairs on the <code>content</code> object.</p>
     *  
     *  @return The Object that contains key-value pairs for the bundle's resources.
		 */
		protected function getContent () : Object;

		/**
		 *  Gets a Boolean from a ResourceBundle.
     *
     *  <p>If the resource specified by the <code>key</code> parameter
     *  does not exist in this bundle, this method throws an error.</p>
     *
     *  <p>This method has been deprecated because all resources
     *  should now be accessed via methods of the IResourceManager interface.
     *  You should convert your code to instead call
     *  the <code>getBoolean()</code>method of IResourceManager.
     *  All classes that extend UIComponent, Formatter, or Validator
     *  have a <code>resourceManager</code> property
     *  that provides a reference to an object implementing this interface.
     *  Other classes can call the <code>ResourceManager.getInstance()</code>
     *  method to obtain this object.</p>
     *
     *  @param key A String identifying a resource in this ResourceBundle.
     *
     *  @param defaultValue The value to return if the resource value,
     *  after being converted to lowercase, is neither the String
     *  <code>"true"</code> nor the String <code>"false"</code>.
     *  This parameter is optional; its default value is <code>true</code>.
     *
     *  @return The value of the specified resource, as a Boolean.
		 */
		public function getBoolean (key:String, defaultValue:Boolean = true) : Boolean;

		/**
		 *  Gets a Number from a ResourceBundle.
     *
     *  <p>If the resource specified by the <code>key</code> parameter
     *  does not exist in this bundle, this method throws an error.</p>
     *
     *  <p>This method has been deprecated because all resources
     *  should now be accessed via methods of the IResourceManager interface.
     *  You should convert your code to instead call
     *  the <code>getNumber()</code>, <code>getInt()</code>,
     *  or <code>getUint()</code> method of IResourceManager.
     *  All classes that extend UIComponent, Formatter, or Validator
     *  have a <code>resourceManager</code> property
     *  that provides a reference to an object implementing this interface.
     *  Other classes can call the <code>ResourceManager.getInstance()</code>
     *  method to obtain this object.</p>
     *
     *  @param key A String identifying a resource in this ResourceBundle.
     *
     *  @return The value of the specified resource, as a Number.
		 */
		public function getNumber (key:String) : Number;

		/**
		 *  Gets a String from a ResourceBundle.
     *
     *  <p>If the resource specified by the <code>key</code> parameter
     *  does not exist in this bundle, this method throws an error.</p>
     *
     *  <p>This method has been deprecated because all resources
     *  should now be accessed via methods of the IResourceManager interface.
     *  You should convert your code to instead call
     *  the <code>getString()</code> method of IResourceManager.
     *  All classes that extend UIComponent, Formatter, or Validator
     *  have a <code>resourceManager</code> property
     *  that provides a reference to an object implementing this interface.
     *  Other classes can call the <code>ResourceManager.getInstance()</code>
     *  method to obtain this object.</p>
     *
     *  @param key A String identifying a resource in this ResourceBundle.
     *
     *  @return The value of the specified resource, as a String.
		 */
		public function getString (key:String) : String;

		/**
		 *  Gets an Array of Strings from a ResourceBundle.
     *
     *  <p>The Array is produced by assuming that the actual value
     *  of the resource is a String containing comma-separated items,
     *  such as <code>"India, China, Japan"</code>.
     *  After splitting the String at the commas, any white space
     *  before or after each item is trimmed.</p>
     *
     *  <p>If the resource specified by the <code>key</code> parameter
     *  does not exist in this bundle, this method throws an error.</p>
     *
     *  <p>This method has been deprecated because all resources
     *  should now be accessed via methods of the IResourceManager interface.
     *  You should convert your code to instead call
     *  the <code>getStringArray()</code> method of IResourceManager.
     *  All classes that extend UIComponent, Formatter, or Validator
     *  have a <code>resourceManager</code> property
     *  which provides a reference to an object implementing this interface.
     *  Other classes can call <code>ResourceManager.getInstance()</code>
     *  to obtain this object.</p>
     *
     *  @param key A String identifying a resource in this ResourceBundle.
     *
     *  @return The value of the specified resource,
     *  as an Array of Strings.
		 */
		public function getStringArray (key:String) : Array;

		/**
		 *  Gets an Object from a ResourceBundle.
     *
     *  <p>If the resource specified by the <code>key</code> parameter
     *  does not exist in this bundle, this method throws an error.</p>
     *
     *  <p>This method has been deprecated because all resources
     *  should now be accessed via methods of the IResourceManager interface.
     *  You should convert your code to instead call
     *  the <code>getObject()</code> or <code>getClass()</code> method
     *  of IResourceManager.
     *  All classes that extend UIComponent, Formatter, or Validator
     *  have a <code>resourceManager</code> property
     *  that provides a reference to an object implementing this interface.
     *  Other classes can call the <code>ResourceManager.getInstance()</code>
     *  method to obtain this object.</p>
     *
     *  @param key A String identifying a resource in this ResourceBundle.
     *
     *  @return An Object that is the value of the specified resource.
		 */
		public function getObject (key:String) : Object;

		/**
		 *  @private
		 */
		private function _getObject (key:String) : Object;
	}
}
