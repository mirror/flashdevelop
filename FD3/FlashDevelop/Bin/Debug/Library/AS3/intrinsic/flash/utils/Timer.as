/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package flash.utils {
	import flash.events.EventDispatcher;
	public class Timer extends EventDispatcher {
		/**
		 * The total number of times the timer has fired since it started
		 *  at zero. If the timer has been reset, only the fires since
		 *  the reset are counted.
		 */
		public function get currentCount():int;
		/**
		 * The delay, in milliseconds, between timer
		 *  events. If you set the delay interval while
		 *  the timer is running, the timer will restart
		 *  at the same repeatCount iteration.
		 */
		public function get delay():Number;
		public function set delay(value:Number):void;
		/**
		 * The total number of times the timer is set to run.
		 *  If the repeat count is set to 0, the timer continues forever
		 *  or until the stop() method is invoked or the program stops.
		 *  If the repeat count is nonzero, the timer runs the specified number of times.
		 *  If repeatCount is set to a total that is the same or less then currentCount
		 *  the timer stops and will not fire again.
		 */
		public function get repeatCount():int;
		public function set repeatCount(value:int):void;
		/**
		 * The timer's current state; true if the timer is running, otherwise false.
		 */
		public function get running():Boolean;
		/**
		 * Constructs a new Timer object with the specified delay
		 *  and repeatCount states.
		 *
		 * @param delay             <Number> The delay between timer events, in milliseconds.
		 * @param repeatCount       <int (default = 0)> Specifies the number of repetitions.
		 *                            If zero, the timer repeats infinitely.
		 *                            If nonzero, the timer runs the specified number of times and then stops.
		 */
		public function Timer(delay:Number, repeatCount:int = 0);
		/**
		 * Stops the timer, if it is running, and sets the currentCount property back to 0,
		 *  like the reset button of a stopwatch. Then, when start() is called,
		 *  the timer instance runs for the specified number of repetitions,
		 *  as set by the repeatCount value.
		 */
		public function reset():void;
		/**
		 * Starts the timer, if it is not already running.
		 */
		public function start():void;
		/**
		 * Stops the timer. When start() is called after stop(), the timer
		 *  instance runs for the remaining number of repetitions, as set by the repeatCount property.
		 */
		public function stop():void;
	}
}
