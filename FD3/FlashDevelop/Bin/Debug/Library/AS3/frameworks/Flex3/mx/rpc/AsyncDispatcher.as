package mx.rpc
{
	import flash.events.TimerEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 *  This class provides a mechanism for dispatching a method asynchronously. *  @private
	 */
	public class AsyncDispatcher
	{
		private var _method : Function;
		private var _args : Array;
		private var _timer : Timer;

		/**
		 *  @private
		 */
		public function AsyncDispatcher (method:Function, args:Array, delay:Number);
		private function timerEventHandler (event:TimerEvent) : void;
	}
}
