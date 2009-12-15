package flash.net
{
	import flash.utils.ByteArray;

	public class GroupSpecifier extends Object
	{
		public function get ipMulticastMemberUpdatesEnabled () : Boolean;
		public function set ipMulticastMemberUpdatesEnabled (enabled:Boolean) : void;

		public function get multicastEnabled () : Boolean;
		public function set multicastEnabled (enabled:Boolean) : void;

		public function get objectReplicationEnabled () : Boolean;
		public function set objectReplicationEnabled (enabled:Boolean) : void;

		public function get peerToPeerDisabled () : Boolean;
		public function set peerToPeerDisabled (disable:Boolean) : void;

		public function get postingEnabled () : Boolean;
		public function set postingEnabled (enabled:Boolean) : void;

		public function get routingEnabled () : Boolean;
		public function set routingEnabled (enabled:Boolean) : void;

		public function get serverChannelEnabled () : Boolean;
		public function set serverChannelEnabled (enabled:Boolean) : void;

		public function addBootstrapPeer (peerID:String) : void;

		public function addIPMulticastAddress (address:String, port:* = null, source:String = null) : void;

		public function authorizations () : String;

		public static function encodeBootstrapPeerIDSpec (peerID:String) : String;

		public static function encodeIPMulticastAddressSpec (address:String, port:* = null, source:String = null) : String;

		public static function encodePostingAuthorization (password:String) : String;

		public static function encodePublishAuthorization (password:String) : String;

		public function GroupSpecifier (name:String);

		public function groupspecWithAuthorizations () : String;

		public function groupspecWithoutAuthorizations () : String;

		public function makeUnique () : void;

		public function setPostingPassword (password:String = null, salt:String = null) : void;

		public function setPublishPassword (password:String = null, salt:String = null) : void;

		public function toString () : String;
	}
}
