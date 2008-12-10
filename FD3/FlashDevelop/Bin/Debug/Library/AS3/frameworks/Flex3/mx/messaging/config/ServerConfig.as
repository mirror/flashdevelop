package mx.messaging.config
{
	import flash.utils.getDefinitionByName;
	import mx.collections.ArrayCollection;
	import mx.core.mx_internal;
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.MessageAgent;
	import mx.messaging.config.LoaderConfig;
	import mx.messaging.errors.InvalidChannelError;
	import mx.messaging.errors.InvalidDestinationError;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.messages.IMessage;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	import mx.utils.ObjectUtil;

	/**
	 *  This class provides access to the server messaging configuration information. *  This class encapsulates information from the services-config.xml file on the client *  and is used by the messaging system to provide configured ChannelSets and Channels  *  to the messaging framework. *   *  <p>The XML source is provided during the compilation process. *  However, there is currently no internal restriction preventing the *  acquisition of this XML data by other means, such as network, local file *  system, or shared object at runtime.</p>
	 */
	public class ServerConfig
	{
		/**
		 *  @private     *  Channel config parsing constant.
		 */
		public static const CLASS_ATTR : String = "type";
		/**
		 *  @private     *  Channel config parsing constant.
		 */
		public static const URI_ATTR : String = "uri";
		/**
		 *  @private     *  Storage for the resourceManager getter.     *  This gets initialized on first access,     *  not at static initialization time, in order to ensure     *  that the Singleton registry has already been initialized.
		 */
		private static var _resourceManager : IResourceManager;
		/**
		 *  @private     *  The server configuration data.
		 */
		public static var serverConfigData : XML;
		/**
		 *  @private     *  Caches shared ChannelSets, keyed by strings having the format:     *  <list of comma delimited channel ids>:[true|false] - where the final      *  flag indicates whether the ChannelSet should be used for clustered     *  destinations or not.
		 */
		private static var _channelSets : Object;
		/**
		 *  @private     *  Caches shared clustered Channel instances keyed by Channel id.
		 */
		private static var _clusteredChannels : Object;
		/**
		 *  @private      *  Caches shared unclustered Channel instances keyed by Channel id.
		 */
		private static var _unclusteredChannels : Object;
		/**
		 * @private     * Keeps track of Channel endpoint uris whose configuration has been fetched      * from the server.
		 */
		private static var _configFetchedChannels : Object;

		/**
		 *  @private     *  A reference to the object which manages     *  all of the application's localized resources.     *  This is a singleton instance which implements     *  the IResourceManager interface.
		 */
		private static function get resourceManager () : IResourceManager;
		/**
		 *  The XML configuration; this value must contain the relevant portions of     *  the &lt;services&gt; tag from the services-config.xml file.
		 */
		public static function get xml () : XML;
		/**
		 *  @private
		 */
		public static function set xml (value:XML) : void;

		/**
		 *  This method ensures that the destinations specified contain identical     *  channel definitions.     *  If the channel definitions between the two destinations specified are     *  not identical this method will throw an ArgumentError.     *      *  @param   destinationA:String first destination to compare against     *  @param   destinationB:String second destination to compare channels with     *  @throw   ArgumentError if the channel definitions of the specified      *           destinations aren't identical.
		 */
		public static function checkChannelConsistency (destinationA:String, destinationB:String) : void;
		/**
		 *  Returns a shared instance of the configured Channel.     *     *  @param id The id of the desired Channel.     *      *  @param clustered True if the Channel will be used in a clustered     *                   fashion; otherwise false.     *      *  @return The Channel instance.     *      *  @throws mx.messaging.errors.InvalidChannelError If no Channel has the specified id.
		 */
		public static function getChannel (id:String, clustered:Boolean = false) : Channel;
		/**
		 *  Returns a shared ChannelSet for use with the specified destination     *  belonging to the service that handles the specified message type.     *      *  @param destinationId The target destination id.         *      *  @return The ChannelSet.     *      *  @throws mx.messaging.errors.InvalidDestinationError If the specified destination     *                                  does not have channels and the application     *                                  did not define default channels.
		 */
		public static function getChannelSet (destinationId:String) : ChannelSet;
		/**
		 *  Returns the property information for the specified destination     *     *  @param destinationId The id of the desired destination.     *      *  @return XMLList containing the &lt;property&gt; tag information.     *      *  @throws mx.messaging.errors.InvalidDestinationError If the specified destination is not found.
		 */
		public static function getProperties (destinationId:String) : XMLList;
		/**
		 *  This method returns true iff the channelset specified has channels with     *  ids or uris that match those found in the destination specified.
		 */
		static function channelSetMatchesDestinationConfig (channelSet:ChannelSet, destination:String) : Boolean;
		/**
		 * @private     * returns if the specified endpoint has been fetched already
		 */
		static function fetchedConfig (endpoint:String) : Boolean;
		/**
		 *  @private     *  This method returns a list of the channel ids for the given destination     *  configuration. If no channels exist for the destination, it returns a      *  list of default channel ids for the applcation
		 */
		static function getChannelIdList (destination:String) : Array;
		/**
		 *  @private      *  Used by the Channels to determine whether the Channel should request      *  dynamic configuration from the server for its MessageAgents.
		 */
		static function needsConfig (channel:Channel) : Boolean;
		/**
		 *  @private     *  This method updates the xml with serverConfig object returned from the     *  server during initial client connect
		 */
		static function updateServerConfigData (serverConfig:ConfigMap, endpoint:String = null) : void;
		/**
		 *  Helper method that builds a new Channel instance based on the      *  configuration for the specified id.     *       *  @param id The id for the configured Channel to build.     *      *  @return The Channel instance.     *      *  @throws mx.messaging.errors.InvalidChannelError If no configuration data for the specified     *                             id exists.
		 */
		private static function createChannel (channelId:String) : Channel;
		/**
		 * Converts the ConfigMap of properties into XML
		 */
		private static function convertToXML (config:ConfigMap, configXML:XML) : void;
		private static function getChannelIds (destinationConfig:XML) : Array;
		/**
		 * @private     * This method returns a list of default channel ids for the application
		 */
		private static function getDefaultChannelIds () : Array;
		/**
		 *  Returns the destination XML data specific to the destination and message     *  type specified. Returns null if the destination is not found.
		 */
		private static function getDestinationConfig (destinationId:String) : XML;
		/**
		 *  Helper method to look up and return a cached ChannelSet (and build and     *  cache an instance if necessary).     *      *  @param destinationConfig The configuration for the target destination.     *  @param destinatonId The id of the target destination.     *      *  @return The ChannelSet.
		 */
		private static function internalGetChannelSet (destinationConfig:XML, destinationId:String) : ChannelSet;
	}
}
