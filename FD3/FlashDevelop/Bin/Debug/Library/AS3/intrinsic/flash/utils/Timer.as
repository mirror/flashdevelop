package flash.utils
{
	/// The Timer class is the interface to Flash Player timers.
	public class Timer extends flash.events.EventDispatcher
	{
		/** 
		 * Dispatched whenever it has completed the number of requests set by Timer.repeatCount.
		 * @eventType flash.events.TimerEvent.TIMER_COMPLETE
		 */
		[Event(name="timerComplete", type="flash.events.TimerEvent")]

		/** 
		 * Dispatched whenever a Timer object reaches an interval specified according to the Timer.delay property.
		 * @eventType flash.events.TimerEvent.TIMER
		 */
		[Event(name="timer", type="flash.events.TimerEvent")]

		/// The delay, in milliseconds, between timer events.
		public var delay:Number;

		/// The total number of times the timer is set to run.
		public var repeatCount:int;

		/// The total number of times the timer has fired since it started at zero.
		public var currentCount:int;

		/// The timer's current state; true if the timer is running, otherwise false.
		public var running:Boolean;

		/// Constructs a new Timer object with the specified delay and repeatCount states.
		public function Timer(delay:Number, repeatCount:int=0);

		/// Starts the timer, if it is not already running.
		public function start():void;

		/// Stops the timer, if it is running, and sets the currentCount property back to 0, like the reset button of a stopwatch.
		public function reset():void;

		/// Stops the timer.
		public function stop():void;

	}

}

