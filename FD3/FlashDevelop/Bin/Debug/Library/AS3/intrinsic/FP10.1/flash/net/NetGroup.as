package flash.net
{
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.NetGroupInfo;

	public class NetGroup extends EventDispatcher
	{
		public function get estimatedMemberCount () : Number;

		public function get info () : NetGroupInfo;

		public function get localCoverageFrom () : String;

		public function get localCoverageTo () : String;

		public function get neighborCount () : Number;

		public function get receiveMode () : String;
		public function set receiveMode (mode:String) : void;

		public function get replicationStrategy () : String;
		public function set replicationStrategy (s:String) : void;

		public function addHaveObjects (startIndex:Number, endIndex:Number) : void;

		public function addMemberHint (peerID:String) : Boolean;

		public function addNeighbor (peerID:String) : Boolean;

		public function addWantObjects (startIndex:Number, endIndex:Number) : void;

		public function close () : void;

		public function convertPeerIDToGroupAddress (peerID:String) : String;

		public function denyRequestedObject (requestID:int) : void;

		public function NetGroup (connection:NetConnection, groupspec:String);

		public function post (message:Object) : String;

		public function removeHaveObjects (startIndex:Number, endIndex:Number) : void;

		public function removeWantObjects (startIndex:Number, endIndex:Number) : void;

		public function sendToAllNeighbors (message:Object) : String;

		public function sendToNearest (message:Object, groupAddress:String) : String;

		public function sendToNeighbor (message:Object, sendMode:String) : String;

		public function writeRequestedObject (requestID:int, object:Object) : void;
	}
}
