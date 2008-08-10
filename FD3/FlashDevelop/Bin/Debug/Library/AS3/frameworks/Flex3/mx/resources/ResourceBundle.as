/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.resources {
	import flash.system.ApplicationDomain;
	public class ResourceBundle implements IResourceBundle {
		/**
		 * A name that identifies this resource bundle,
		 *  such as "MyResources".
		 */
		public function get bundleName():String;
		/**
		 * An object containing key-value pairs for the resources
		 *  in this resource bundle.
		 */
		public function get content():Object;
		/**
		 * The locale for which this bundle's resources have been localized.
		 *  This is a String such as "en_US" for U.S. English.
		 */
		public function get locale():String;
		/**
		 * Constructor.
		 *
		 * @param locale            <String (default = null)> A locale string, such as "en_US".
		 * @param bundleName        <String (default = null)> A name that identifies this bundle,
		 *                            such as "MyResources".
		 */
		public function ResourceBundle(locale:String = null, bundleName:String = null);
		/**
		 * Deprecated Since 3.0: Please Use ResourceManager.getInstance().getBoolean()
		 *
		 * @param key               <String> A String identifying a resource in this ResourceBundle.
		 * @param defaultValue      <Boolean (default = true)> The value to return if the resource value,
		 *                            after being converted to lowercase, is neither the String
		 *                            "true" nor the String "false".
		 *                            This parameter is optional; its default value is true.
		 * @return                  <Boolean> The value of the specified resource, as a Boolean.
		 */
		public function getBoolean(key:String, defaultValue:Boolean = true):Boolean;
		/**
		 * When a properties file is compiled into a resource bundle,
		 *  the MXML compiler autogenerates a subclass of ResourceBundle.
		 *  The subclass overrides this method to return an Object
		 *  that contains key-value pairs for the bundle's resources.
		 *
		 * @return                  <Object> The Object that contains key-value pairs for the bundle's resources.
		 */
		protected function getContent():Object;
		/**
		 * Deprecated Since 3.0: Please Use ResourceManager.getInstance().getNumber()
		 *
		 * @param key               <String> A String identifying a resource in this ResourceBundle.
		 * @return                  <Number> The value of the specified resource, as a Number.
		 */
		public function getNumber(key:String):Number;
		/**
		 * Deprecated Since 3.0: Please Use ResourceManager.getInstance().getObject()
		 *
		 * @param key               <String> A String identifying a resource in this ResourceBundle.
		 * @return                  <Object> An Object that is the value of the specified resource.
		 */
		public function getObject(key:String):Object;
		/**
		 * Deprecated Since 3.0: Please Use ResourceManager.getInstance().getResourceBundle()
		 *
		 * @param baseName          <String> The name of the resource bundle to return.
		 * @param currentDomain     <ApplicationDomain (default = null)> The ApplicationDomain that the resource bundle is in.
		 * @return                  <ResourceBundle> The resource bundle that matches the specified name and domain.
		 */
		public static function getResourceBundle(baseName:String, currentDomain:ApplicationDomain = null):ResourceBundle;
		/**
		 * Deprecated Since 3.0: Please Use ResourceManager.getInstance().getString()
		 *
		 * @param key               <String> A String identifying a resource in this ResourceBundle.
		 * @return                  <String> The value of the specified resource, as a String.
		 */
		public function getString(key:String):String;
		/**
		 * Deprecated Since 3.0: Please Use ResourceManager.getInstance().getStringArray()
		 *
		 * @param key               <String> A String identifying a resource in this ResourceBundle.
		 * @return                  <Array> The value of the specified resource,
		 *                            as an Array of Strings.
		 */
		public function getStringArray(key:String):Array;
	}
}
