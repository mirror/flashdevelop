/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.messaging.config {
	public class ServerConfig {
		/**
		 * The XML configuration; this value must contain the relevant portions of
		 *  the <services> tag from the services-config.xml file.
		 */
		public static function get xml():XML;
		public function set xml(value:XML):void;
		/**
		 * This method ensures that the destinations specified contain identical
		 *  channel definitions.
		 *  If the channel definitions between the two destinations specified are
		 *  not identical this method will throw an ArgumentError.
		 *
		 * @param destinationA      <String> destinationA:String first destination to compare against
		 * @param destinationB      <String> destinationB:String second destination to compare channels with
		 */
		public static function checkChannelConsistency(destinationA:String, destinationB:String):void;
		/**
		 * Returns a shared instance of the configured Channel.
		 *
		 * @param id                <String> The id of the desired Channel.
		 * @param clustered         <Boolean (default = false)> True if the Channel will be used in a clustered
		 *                            fashion; otherwise false.
		 * @return                  <Channel> The Channel instance.
		 */
		public static function getChannel(id:String, clustered:Boolean = false):Channel;
		/**
		 * Returns a shared ChannelSet for use with the specified destination
		 *  belonging to the service that handles the specified message type.
		 *
		 * @param destinationId     <String> The target destination id.
		 * @return                  <ChannelSet> The ChannelSet.
		 */
		public static function getChannelSet(destinationId:String):ChannelSet;
		/**
		 * Returns the property information for the specified destination
		 *
		 * @param destinationId     <String> The id of the desired destination.
		 * @return                  <XMLList> XMLList containing the <property> tag information.
		 */
		public static function getProperties(destinationId:String):XMLList;
	}
}
