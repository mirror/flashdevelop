package flash.net
{
	public class NetGroupInfo extends Object
	{
		public function get objectReplicationReceiveBytesPerSecond () : Number;

		public function get objectReplicationSendBytesPerSecond () : Number;

		public function get postingReceiveControlBytesPerSecond () : Number;

		public function get postingReceiveDataBytesPerSecond () : Number;

		public function get postingSendControlBytesPerSecond () : Number;

		public function get postingSendDataBytesPerSecond () : Number;

		public function get routingReceiveBytesPerSecond () : Number;

		public function get routingSendBytesPerSecond () : Number;

		public function NetGroupInfo (postingSendDataBytesPerSecond:Number, postingSendControlBytesPerSecond:Number, postingReceiveDataBytesPerSecond:Number, postingReceiveControlBytesPerSecond:Number, routingSendBytesPerSecond:Number, routingReceiveBytesPerSecond:Number, objectReplicationSendBytesPerSecond:Number, objectReplicationReceiveBytesPerSecond:Number);

		public function toString () : String;
	}
}
