/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.resources {
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	public interface IResourceManager extends <a href="../../flash/events/IEventDispatcher.html">IEventDispatcher</a>  {
		/**
		 * An Array of locale Strings, such as [ "en_US" ],
		 *  which specifies one or more locales to be searched for resources.
		 */
		public function get localeChain():Array;
		public function set localeChain(value:Array):void;
		/**
		 * Adds the specified ResourceBundle to the ResourceManager
		 *  so that its resources can be accessed by ResourceManager
		 *  methods such as getString().
		 *
		 * @param resourceBundle    <IResourceBundle> The resource bundle to be added.
		 */
		public function addResourceBundle(resourceBundle:IResourceBundle):void;
		/**
		 * Searches the locales in the localeChain
		 *  for the specified resource and returns
		 *  the first resource bundle in which it is found.
		 *  If the resource isn't found, this method returns null.
		 *
		 * @param bundleName        <String> A bundle name such as "MyResources".
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @return                  <IResourceBundle> The first ResourceBundle in the localeChain
		 *                            that contains the specified resource, or null.
		 */
		public function findResourceBundleWithResource(bundleName:String, resourceName:String):IResourceBundle;
		/**
		 * Gets the value of a specified resource as a Boolean.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <Boolean> The resource value, as a Boolean,
		 *                            or false if it is not found.
		 */
		public function getBoolean(bundleName:String, resourceName:String, locale:String = null):Boolean;
		/**
		 * Returns an Array of Strings specifying the bundle names
		 *  for all ResourceBundle objects that exist in the ResourceManager
		 *  and that belong to the specified locale.
		 *
		 * @param locale            <String> A locale string such as "en_US".
		 * @return                  <Array> An Array of bundle names.
		 */
		public function getBundleNamesForLocale(locale:String):Array;
		/**
		 * Gets the value of a specified resource as a Class.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <Class> The resource value, as a Class,
		 *                            or null if it is not found.
		 */
		public function getClass(bundleName:String, resourceName:String, locale:String = null):Class;
		/**
		 * Gets the value of a specified resource as an int.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <int> The resource value, as an int,
		 *                            or 0 if it is not found.
		 */
		public function getInt(bundleName:String, resourceName:String, locale:String = null):int;
		/**
		 * Returns an Array of Strings specifying all locales for which
		 *  ResourceBundle objects exist in the ResourceManager.
		 *
		 * @return                  <Array> An Array of locale Strings.
		 */
		public function getLocales():Array;
		/**
		 * Gets the value of a specified resource as a Number.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <Number> The resource value, as a Number,
		 *                            or NaN if it is not found.
		 */
		public function getNumber(bundleName:String, resourceName:String, locale:String = null):Number;
		/**
		 * Gets the value of a specified resource as an Object.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <*> The resource value, exactly as it is stored
		 *                            in the content Object,
		 *                            or undefined if the resource is not found.
		 */
		public function getObject(bundleName:String, resourceName:String, locale:String = null):*;
		/**
		 * Returns a ResourceBundle with the specified locale
		 *  and bundleName that has been previously added
		 *  to the ResourceManager with addResourceBundle().
		 *  If no such ResourceBundle exists, this method returns null.
		 *
		 * @param locale            <String> A locale string such as "en_US".
		 * @param bundleName        <String> A bundle name such as "MyResources".
		 * @return                  <IResourceBundle> The ResourceBundle with the specified locale
		 *                            and bundleName if one exists; otherwise null.
		 */
		public function getResourceBundle(locale:String, bundleName:String):IResourceBundle;
		/**
		 * Gets the value of a specified resource as a String,
		 *  after substituting specified values for placeholders.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param parameters        <Array (default = null)> An Array of parameters that are
		 *                            substituted for the placeholders.
		 *                            Each parameter is converted to a String with the toString() method
		 *                            before being substituted.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <String> The resource value, as a String,
		 *                            or null if it is not found.
		 */
		public function getString(bundleName:String, resourceName:String, parameters:Array = null, locale:String = null):String;
		/**
		 * Gets the value of a specified resource as an Array of Strings.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <Array> The resource value, as an Array of Strings,
		 *                            or null if it is not found.
		 */
		public function getStringArray(bundleName:String, resourceName:String, locale:String = null):Array;
		/**
		 * Gets the value of a specified resource as a uint.
		 *
		 * @param bundleName        <String> The name of a resource bundle.
		 * @param resourceName      <String> The name of a resource in the resource bundle.
		 * @param locale            <String (default = null)> A specific locale to be used for the lookup,
		 *                            or null to search all locales
		 *                            in the localeChain.
		 *                            This parameter is optional and defaults to null;
		 *                            you should seldom need to specify it.
		 * @return                  <uint> The resource value, as a uint,
		 *                            or 0 if it is not found.
		 */
		public function getUint(bundleName:String, resourceName:String, locale:String = null):uint;
		/**
		 * Used by modules loaders only.
		 *
		 * @param applicationDomain <ApplicationDomain> 
		 * @param locales           <Array> 
		 * @param bundleNames       <Array> 
		 */
		public function installCompiledResourceBundles(applicationDomain:ApplicationDomain, locales:Array, bundleNames:Array):void;
		/**
		 * Begins loading a resource module containing resource bundles.
		 *
		 * @param url               <String> The URL from which to load the resource module.
		 * @param update            <Boolean (default = true)> Whether to call
		 *                            the update() method when the module finishes loading.
		 * @param applicationDomain <ApplicationDomain (default = null)> The ApplicationDomain passed to the
		 *                            load() method of the IModuleInfo class
		 *                            that loads the resource module.
		 *                            This parameter is optional and defaults to null.
		 * @param securityDomain    <SecurityDomain (default = null)> The SecurityDomain passed to the
		 *                            load() method of the IModuleInfo class
		 *                            that loads the resource module.
		 *                            This parameter is optional and defaults to null.
		 * @return                  <IEventDispatcher> An object that is associated with this particular load operation
		 *                            that dispatches ResourceEvent.PROGRESS,
		 *                            ResourceEvent.COMPLETE, and
		 *                            ResourceEvent.ERROR events.
		 */
		public function loadResourceModule(url:String, update:Boolean = true, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null):IEventDispatcher;
		/**
		 * Removes the specified ResourceBundle from the ResourceManager
		 *  so that its resources can no longer be accessed by ResourceManager
		 *  methods such as getString().
		 *
		 * @param locale            <String> A locale string such as "en_US".
		 * @param bundleName        <String> A bundle name such as "MyResources".
		 */
		public function removeResourceBundle(locale:String, bundleName:String):void;
		/**
		 * Removes all ResourceBundles for the specified locale
		 *  from the ResourceManager so that their resources
		 *  can no longer be accessed by ResourceManager methods
		 *  such as getString().
		 *
		 * @param locale            <String> A locale string such as "en_US".
		 */
		public function removeResourceBundlesForLocale(locale:String):void;
		/**
		 * This method has not yet been implemented.
		 *
		 * @param url               <String> 
		 * @param update            <Boolean (default = true)> 
		 */
		public function unloadResourceModule(url:String, update:Boolean = true):void;
		/**
		 * Dispatches a change event from the
		 *  ResourceManager.
		 */
		public function update():void;
	}
}
