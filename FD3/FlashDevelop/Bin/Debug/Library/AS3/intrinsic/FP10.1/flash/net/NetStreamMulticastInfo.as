package flash.net
{
	public class NetStreamMulticastInfo extends Object
	{
		public function get bytesPushedFromPeers () : Number;

		public function get bytesPushedToPeers () : Number;

		public function get bytesReceivedFromIPMulticast () : Number;

		public function get bytesReceivedFromServer () : Number;

		public function get bytesRequestedByPeers () : Number;

		public function get bytesRequestedFromPeers () : Number;

		public function get fragmentsPushedFromPeers () : Number;

		public function get fragmentsPushedToPeers () : Number;

		public function get fragmentsReceivedFromIPMulticast () : Number;

		public function get fragmentsReceivedFromServer () : Number;

		public function get fragmentsRequestedByPeers () : Number;

		public function get fragmentsRequestedFromPeers () : Number;

		public function get receiveControlBytesPerSecond () : Number;

		public function get receiveDataBytesPerSecond () : Number;

		public function get receiveDataBytesPerSecondFromIPMulticast () : Number;

		public function get receiveDataBytesPerSecondFromServer () : Number;

		public function get sendControlBytesPerSecond () : Number;

		public function get sendControlBytesPerSecondToServer () : Number;

		public function get sendDataBytesPerSecond () : Number;

		public function NetStreamMulticastInfo (sendDataBytesPerSecond:Number, sendControlBytesPerSecond:Number, receiveDataBytesPerSecond:Number, receiveControlBytesPerSecond:Number, bytesPushedToPeers:Number, fragmentsPushedToPeers:Number, bytesRequestedByPeers:Number, fragmentsRequestedByPeers:Number, bytesPushedFromPeers:Number, fragmentsPushedFromPeers:Number, bytesRequestedFromPeers:Number, fragmentsRequestedFromPeers:Number, sendControlBytesPerSecondToServer:Number, receiveDataBytesPerSecondFromServer:Number, bytesReceivedFromServer:Number, fragmentsReceivedFromServer:Number, receiveDataBytesPerSecondFromIPMulticast:Number, bytesReceivedFromIPMulticast:Number, fragmentsReceivedFromIPMulticast:Number);

		public function toString () : String;
	}
}
