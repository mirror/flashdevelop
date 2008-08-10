/**
* Connects a flash movie to the FlashDevelop program.
* @author Mika Palmu
* @version 2.0
*/

class org.flashdevelop.utils.FlashConnect {

	/**
	* Variables
	*/
	private static var messages:Array;
	private static var interval:Number;
	private static var socket:XMLSocket;
	public static var status:Number = 0;
	public static var host:String = "127.0.0.1";
	public static var port:Number = 6969;
	public static var onConnection:Function;
	public static var onReturnData:Function;
	
	/**
	* Constants
	*/
	public static var INFO:Number = 0;
	public static var DEBUG:Number = 1;
	public static var WARNING:Number = 2;
	public static var ERROR:Number = 3;
	public static var FATAL:Number = 4;
	
	/**
	* Opens the connection to the FlashDevelop program.
	*/
	public static function initialize():Void {
		messages = new Array();
		socket = new XMLSocket();
		socket.onData = FlashConnect.onReturnData;
		socket.onConnect = function(success:Boolean) {
			if (success) FlashConnect.status = 1;
			else FlashConnect.status = -1;
			FlashConnect.onConnection();
		}
		interval = setInterval(sendStack, 100);
		socket.connect(host, port);
	}
	
	/**
	* Sends all messages in message stack to FlashDevelop.
	*/
	private static function sendStack() {
		if (messages.length > 0 && status == 1) {
			var message:XML = new XML();
			var rootNode:XMLNode = message.createElement("flashconnect");
			while (messages.length != 0) {
				var msgNode = messages.shift();
				rootNode.appendChild(msgNode);
			}
			message.appendChild(rootNode);
			socket.send(message);
		}
	}
	
	/**
	* Adds a custom message to the message stack.
	*/
	public static function send(message:XMLNode):Void {
		if (messages == null) initialize();
		messages.push(message);
	}
	
	/**
	* Adds a trace command to the message stack.
	*/
	public static function trace(msg:String, state:Number):Void {
		var msgNode:XMLNode;
		msgNode = new XMLNode(1, null);
		msgNode.appendChild(new XMLNode(3, msg));
		msgNode.attributes.state = state;
		msgNode.attributes.cmd = "trace";
		msgNode.nodeName = "message";
		send(msgNode);
	}
	
}
