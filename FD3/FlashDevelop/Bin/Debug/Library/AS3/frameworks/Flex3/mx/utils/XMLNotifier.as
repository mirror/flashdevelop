package mx.utils
{
	import flash.utils.Dictionary;
	import mx.core.mx_internal;
	import mx.utils.IXMLNotifiable;

include "../core/Version.as"
	/**
	 *  Used for watching changes to XML and XMLList objects.
 *  Those objects are not EventDispatchers, so if multiple elements
 *  want to watch for changes they need to go through this mechanism.
 *  Call <code>watchXML()</code>, passing in the same notification
 *  function that you would pass to XML.notification.
 *  Use <code>unwatchXML()</code> to remove that notification.
 *
	 */
	public class XMLNotifier
	{
		/**
		 *  @private
	 *  XMLNotifier is a singleton.
		 */
		private static var instance : XMLNotifier;

		/**
		 *  Get the singleton instance of the XMLNotifier.
		 */
		public static function getInstance () : XMLNotifier;

		/**
		 *  @private
     *  Decorates an XML node with a notification function
	 *  that can fan out to multiple targets.
		 */
		static function initializeXMLForNotification () : Function;

		/**
		 *  Constructor.
	 *
	 *  XMLNotifier is a singleton class, so you do not use
	 *  the <code>new</code> operator to create multiple instances of it.
	 *  Instead, call the static method <code>XMLNotifider.getInstance()</code>
	 *  to get the sole instance of this class.
		 */
		public function XMLNotifier (x:XMLNotifierSingleton);

		/**
		 *  Given an XML or XMLList, add the notification function
	 *  to watch for changes.
     *
     *  @param xml XML/XMLList object to watch.
     *  @param notification Function that needs to be called.
	 *  @param optional UID for object
		 */
		public function watchXML (xml:Object, notifiable:IXMLNotifiable, uid:String = null) : void;

		/**
		 *  Given an XML or XMLList, remove the specified notification function.
	 *
	 *  @param xml XML/XMLList object to un-watch.
     *  @param notification Function notification function.
		 */
		public function unwatchXML (xml:Object, notifiable:IXMLNotifiable) : void;
	}
	/**
	 *  @private
	 */
	private class XMLNotifierSingleton
	{
		/**
		 *  Constructor.
		 */
		public function XMLNotifierSingleton ();
	}
}
